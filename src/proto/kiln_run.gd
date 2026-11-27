extends RefCounted
## 가마의 병사 한 판: 밤 5번. 병사는 밤이 지나도 남는다.
##   준비 (빚기 · 다시 굽기 · 합치기) → 가마 (불 올리고 열기) → 밤 (전투) → 흙 보상 → 준비 …
## 억울하지 않은 운: 다시 굽기는 등급이 절대 내려가지 않는다 · 불 4까지는 안 깨진다 · 합치기는 운 없이 확정

const D = preload("res://src/proto/data.gd")
const Kiln = preload("res://src/proto/kiln.gd")
const Battle = preload("res://src/proto/battle.gd")

var rng := RandomNumberGenerator.new()
var kiln                         # 불 세기·확률·파편을 맡는다
var night := 1
var clay := D.CLAY_START
var village_hp := D.VILLAGE_HP
var army: Array = []             # [{id, role, element, tier, star, name}]
var queue: Array = []            # 가마에 넣은 것 [{kind: "new"/"refire", role, element, id(다시 굽기)}]
var results: Array = []          # 방금 연 가마 결과 (화면용)
var state := "prep"              # prep → (가마) → night → prep … → won / lost
var last_kills := 0
var last_reward := 0
var _next_id := 1
var draws_since_epic := 0        # 귀함 없이 뽑은 횟수 (천장)
var last_draw := {}              # 방금 뽑은 것 (화면용)


func _init(seed_value: int) -> void:
	rng.seed = seed_value
	kiln = Kiln.new(seed_value + 7)


# ---------------- 자리·찾기 ----------------
func cap() -> int:
	return D.ARMY_CAP_START + (night - 1) * D.ARMY_CAP_PER_NIGHT


func soldier(id: int) -> Dictionary:
	for s in army:
		if s["id"] == id:
			return s
	return {}


func queued_new() -> int:
	return queue.filter(func(q): return q["kind"] == "new").size()


func is_queued(id: int) -> bool:
	return queue.any(func(q): return q.get("id", -1) == id)


static func soldier_name(role: String, element: String) -> String:
	return "%s %s" % [D.GLAZE_NAME[element], D.ROLE_NAME_KILN[role]]


# ---------------- 준비: 뽑기 · 다시 굽기 · 합치기 ----------------
func can_draw() -> bool:
	return state == "prep" and clay >= D.CLAY_DRAW and queue.size() < D.KILN_SLOTS and army.size() + queued_new() < cap()


## 다음 뽑기가 귀함 확정인가 (천장)
func pity_ready() -> bool:
	return draws_since_epic >= D.DRAW_PITY


## 흙을 내고 무작위 병사 하나를 뽑아 가마에 넣는다. 모양은 확률표대로, 유약은 셋 중 하나.
## force_role·force_element 는 테스트·스크린샷이 정해진 장면을 만들 때만 쓴다
func draw(force_role := "", force_element := "") -> Dictionary:
	if not can_draw():
		return {}
	clay -= D.CLAY_DRAW
	var role := force_role
	var pity := pity_ready() and force_role == ""
	if force_role != "":
		pass
	elif pity:
		var epics: Array = D.KILN_ROLES.filter(func(r): return D.ROLE_RARITY[r] == "epic")
		role = epics[rng.randi() % epics.size()]
	else:
		var odds: Dictionary = D.draw_odds()
		var x := rng.randf()
		for r in D.KILN_ROLES:
			x -= odds[r]
			role = r
			if x < 0.0:
				break
	var element: String = force_element if force_element != "" else D.ELEMENTS[rng.randi() % D.ELEMENTS.size()]
	var rar: String = D.ROLE_RARITY[role]
	draws_since_epic = 0 if rar == "epic" else draws_since_epic + 1
	last_draw = {"kind": "new", "role": role, "element": element, "rarity": rar, "pity": pity, "name": soldier_name(role, element)}
	queue.append(last_draw)
	return last_draw


func can_refire(id: int) -> bool:
	var s := soldier(id)
	return state == "prep" and not s.is_empty() and s["tier"] != "legend" and not is_queued(id) \
		and clay >= D.CLAY_REFIRE and queue.size() < D.KILN_SLOTS


func refire(id: int) -> bool:
	if not can_refire(id):
		return false
	var s := soldier(id)
	clay -= D.CLAY_REFIRE
	queue.append({"kind": "refire", "id": id, "role": s["role"], "element": s["element"]})
	return true


## 가마에서 빼기: 다시 굽기는 흙을 다 돌려주고, 뽑은 병사는 부숴서 흙 조금만 (다시 뽑기를 공짜로 못 하게)
func unqueue(index: int) -> void:
	if index < 0 or index >= queue.size():
		return
	var q: Dictionary = queue.pop_at(index)
	clay += D.CLAY_SMASH_BACK if q["kind"] == "new" else D.CLAY_REFIRE


## 합칠 수 있는 묶음: 같은 모양·별 병사 3명 (유약은 달라도 된다 — 가장 좋은 등급의 유약을 따른다)
func merge_groups() -> Array:
	var by := {}
	for s in army:
		if s["star"] >= D.MAX_STAR or is_queued(s["id"]):
			continue
		var key := "%s|%d" % [s["role"], s["star"]]
		if not by.has(key):
			by[key] = []
		by[key].append(s["id"])
	var groups: Array = []
	for key in by:
		var ids: Array = by[key]
		if ids.size() >= D.MERGE_COUNT:
			groups.append(ids.slice(0, D.MERGE_COUNT))
	return groups


## 3명을 하나로: 별 +1, 등급은 셋 중 가장 좋은 것
func merge(ids: Array) -> Dictionary:
	if ids.size() != D.MERGE_COUNT or state != "prep":
		return {}
	var parts: Array = ids.map(func(i): return soldier(i))
	if parts.any(func(p): return p.is_empty()):
		return {}
	var a: Dictionary = parts[0]
	for p in parts:
		if p["role"] != a["role"] or p["star"] != a["star"]:
			return {}
	var best := -1
	var element: String = a["element"]
	for p in parts:
		if D.TIERS.find(p["tier"]) > best:
			best = D.TIERS.find(p["tier"])
			element = p["element"]
	army = army.filter(func(s): return not ids.has(s["id"]))
	var m := _add_soldier(a["role"], element, D.TIERS[best], a["star"] + 1)
	return m


func _add_soldier(role: String, element: String, tier: String, star := 1) -> Dictionary:
	var s := {"id": _next_id, "role": role, "element": element, "tier": tier, "star": star, "name": soldier_name(role, element)}
	_next_id += 1
	army.append(s)
	return s


# ---------------- 가마 ----------------
## 가마를 연다. 새 병사는 군대에 들어오고, 다시 구운 병사는 등급이 오르거나 그대로 (불 5 이상이면 깨질 수 있다)
func fire() -> Array:
	results = []
	if queue.is_empty():
		return results
	var o: Dictionary = kiln.odds()
	var guarantee: bool = kiln.guaranteed_legend()
	if guarantee:
		kiln.shards -= D.SHARDS_FOR_LEGEND
	for i in queue.size():
		var q: Dictionary = queue[i]
		var rr: Dictionary = {"cracked": false, "tier": "legend"} if guarantee and i == 0 else kiln.roll(o)
		var r := {"role": q["role"], "element": q["element"], "cracked": rr["cracked"], "tier": rr["tier"],
			"lucky": guarantee and i == 0, "refire": q["kind"] == "refire", "name": soldier_name(q["role"], q["element"])}
		if q["kind"] == "new":
			if not rr["cracked"]:
				_add_soldier(q["role"], q["element"], rr["tier"])
		else:
			var s := soldier(q["id"])
			r["before"] = s["tier"]
			r["star"] = s["star"]
			if rr["cracked"]:
				army = army.filter(func(x): return x["id"] != q["id"])
			elif D.TIERS.find(rr["tier"]) > D.TIERS.find(s["tier"]):
				s["tier"] = rr["tier"]
			r["tier"] = s["tier"] if not rr["cracked"] else s["tier"]
		results.append(r)
	queue = []
	kiln.heat = 0
	return results


# ---------------- 밤 ----------------
func start_night():
	var b = Battle.new(rng.randi(), D.wave_plan(night, true))
	b.village_hp = village_hp
	for s in army:
		b.add_ally(s["role"], s["element"], s["tier"], s["name"], D.STAR_MUL[s["star"]])
	state = "night"
	return b


func end_night(b) -> void:
	village_hp = maxf(0.0, b.village_hp)
	last_kills = b.stats["kills"]
	if b.result != "win" or village_hp <= 0.0:
		state = "lost"
		return
	last_reward = D.CLAY_PER_NIGHT + last_kills / D.CLAY_PER_KILLS
	clay += last_reward
	night += 1
	if night > D.KILN_NIGHTS:
		state = "won"
		return
	village_hp = minf(D.VILLAGE_HP, village_hp + D.VILLAGE_REPAIR)
	state = "prep"
