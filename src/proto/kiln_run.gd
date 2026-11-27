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


# ---------------- 준비: 빚기 · 다시 굽기 · 합치기 ----------------
func can_craft() -> bool:
	return state == "prep" and clay >= D.CLAY_CRAFT and queue.size() < D.KILN_SLOTS and army.size() + queued_new() < cap()


func craft(role: String, element: String) -> bool:
	if not can_craft():
		return false
	clay -= D.CLAY_CRAFT
	queue.append({"kind": "new", "role": role, "element": element})
	return true


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


## 가마에서 빼기 (흙을 돌려준다)
func unqueue(index: int) -> void:
	if index < 0 or index >= queue.size():
		return
	var q: Dictionary = queue.pop_at(index)
	clay += D.CLAY_CRAFT if q["kind"] == "new" else D.CLAY_REFIRE


## 합칠 수 있는 묶음: 같은 모양·유약·별 병사 3명 (가마에 넣은 병사는 뺀다)
func merge_groups() -> Array:
	var by := {}
	for s in army:
		if s["star"] >= D.MAX_STAR or is_queued(s["id"]):
			continue
		var key := "%s|%s|%d" % [s["role"], s["element"], s["star"]]
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
		if p["role"] != a["role"] or p["element"] != a["element"] or p["star"] != a["star"]:
			return {}
	var best := 0
	for p in parts:
		best = maxi(best, D.TIERS.find(p["tier"]))
	army = army.filter(func(s): return not ids.has(s["id"]))
	var m := _add_soldier(a["role"], a["element"], D.TIERS[best], a["star"] + 1)
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
	var b = Battle.new(rng.randi(), D.wave_plan(night))
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
