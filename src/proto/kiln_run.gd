extends RefCounted
## 가마의 병사 한 판: 챕터 5개 × (아침 5번 · 밤 5번). 병사는 밤과 챕터가 지나도 남는다.
##   아침 (뽑기 · 다시 굽기 · 합치기) → 가마 (불 올리고 열기) → 밤 (전투) → 흙 보상 → 아침 …
##   다섯째 밤에 챕터 대장. 이기면 다음 챕터 (마을 회복 · 흙 보너스 · 새 적)
## 억울하지 않은 운: 다시 굽기는 등급이 절대 내려가지 않는다 · 불 4까지는 안 깨진다 · 합치기는 운 없이 확정

const D = preload("res://src/proto/data.gd")
const Kiln = preload("res://src/proto/kiln.gd")
const Battle = preload("res://src/proto/battle.gd")

var rng := RandomNumberGenerator.new()
var kiln                         # 불 세기·확률·파편을 맡는다
var chapter := 1                 # 지금 챕터 (1부터)
var night := 1                   # 챕터 안의 날 (1~5)
var chapter_cleared := false     # 방금 챕터를 넘겼다 (화면용)
var clay := D.CLAY_START
var village_hp := D.VILLAGE_HP
var army: Array = []             # [{id, role, element, tier, star, name, equip: {} 또는 장비}]
var queue: Array = []            # 가마에 넣은 것 [{kind: "new"/"refire", role, element, id(다시 굽기)}]
var results: Array = []          # 방금 연 가마 결과 (화면용)
var state := "prep"              # prep → (가마) → night → prep … → won / lost
var last_kills := 0
var last_reward := 0
var _next_id := 1
var since := {"rare": 0, "hero": 0, "legendary": 0}   # 그 등급 이상 없이 뽑은 횟수 (천장)
var myth_shards := 0             # 전설을 뽑을 때마다 1, 3개면 다음 뽑기 신화 확정
var draws := 0                   # 지금까지 뽑은 횟수
var tickets := 0                 # 뽑기권 (1장 = 뽑기 1번, 흙 없이)
var inventory: Array = []        # 안 낀 장비 [{id, type, level}]
var last_loot := {}              # 방금 밤의 전리품 (화면용) {tickets, clay, pearls, equip: [..], chapter_clay}
var pearls := 0                  # 진주 (사냥으로 얻고 상점에서 쓴다)
var shop: Array = []             # 오늘 아침 진열 (상점 물건 이름, 산 칸은 "")
var bet_busts := 0               # 내기 꽝 횟수 (3번이면 다음 내기 대박 확정)
var last_bet := {}               # 방금 내기 결과 (화면용) {key, name, desc, ids}
var last_draw := {}              # 방금 뽑은 것 (화면용)


var meta := {}                   # 강화 나무 효과 (판 시작 때 받는다)
var chapter_time := 0.0          # 이번 챕터 밤 전투 시간 합 (초) — 시간 기록
var last_chapter_time := 0.0     # 방금 넘긴 챕터의 시간
var total_kills := 0
var nights_cleared := 0


func _init(seed_value: int, meta_effects := {}) -> void:
	rng.seed = seed_value
	kiln = Kiln.new(seed_value + 7)
	meta = meta_effects
	clay += int(meta.get("start_clay", 0.0))
	tickets += int(meta.get("start_tickets", 0.0))
	pearls += int(meta.get("start_pearls", 0.0))
	kiln.safe_bonus = int(meta.get("safe_heat", 0.0))
	kiln.shard_need = maxi(1, D.SHARDS_FOR_LEGEND - int(meta.get("shard_need", 0.0)))
	restock()


func bet_pity() -> int:
	return maxi(1, D.BET_PITY - int(meta.get("bet_pity", 0.0)))


func price(key: String) -> int:
	return maxi(1, D.SHOP_ITEMS[key]["price"] - int(meta.get("discount", 0.0)))


func chapters_cleared() -> int:
	return chapter - 1 + (1 if state == "won" else 0)


# ---------------- 자리·찾기 ----------------
func day() -> int:
	return (chapter - 1) * D.KILN_NIGHTS + night


func cap() -> int:
	return mini(D.ARMY_CAP_MAX, D.ARMY_CAP_START + (day() - 1) * D.ARMY_CAP_PER_NIGHT) + int(meta.get("cap", 0.0))


func chapter_info() -> Dictionary:
	return D.CHAPTERS[clampi(chapter, 1, D.CHAPTERS.size()) - 1]


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
	return state == "prep" and (tickets > 0 or clay >= D.CLAY_DRAW) and queue.size() < D.KILN_SLOTS and army.size() + queued_new() < cap()


static func grade_index(g: String) -> int:
	return D.GRADES.find(g)


## 다음 뽑기에서 확정되는 등급 ("" = 없음). 신화 조각이 먼저, 그다음 높은 천장부터
func pity_grade() -> String:
	if myth_shards >= D.MYTH_SHARDS:
		return "mythic"
	for g in ["legendary", "hero", "rare"]:
		if since[g] >= D.PITY[g] - 1:
			return g
	return ""


## 그 등급 확정까지 남은 뽑기 수 (이번 뽑기 포함)
func pity_left(g: String) -> int:
	return D.PITY[g] - since[g]


## 흙을 내고 무작위 병사 하나를 뽑아 가마에 넣는다. 모양은 확률표대로, 유약은 셋 중 하나.
## force_role·force_element 는 테스트·스크린샷이 정해진 장면을 만들 때만 쓴다
func draw(force_role := "", force_element := "") -> Dictionary:
	if not can_draw():
		return {}
	var paid := "ticket" if tickets > 0 else "clay"   # 뽑기권을 먼저 쓴다
	if paid == "ticket":
		tickets -= 1
	else:
		clay -= D.CLAY_DRAW
	var role := force_role
	var forced := pity_grade() if force_role == "" else ""
	var pity := false
	if force_role == "":
		var odds: Dictionary = D.draw_odds()
		var x := rng.randf()
		for r in D.KILN_ROLES:
			x -= odds[r]
			role = r
			if x < 0.0:
				break
		if forced != "" and grade_index(D.ROLE_GRADE[role]) < grade_index(forced):
			var pool: Array = D.grade_roles(forced)
			role = pool[rng.randi() % pool.size()]
			pity = true
		if forced == "mythic":
			myth_shards -= D.MYTH_SHARDS
	var element: String = force_element if force_element != "" else D.ELEMENTS[rng.randi() % D.ELEMENTS.size()]
	var g: String = D.ROLE_GRADE[role]
	for k in since:
		since[k] = 0 if grade_index(g) >= grade_index(k) else since[k] + 1
	if g == "legendary":
		myth_shards += 1
	draws += 1
	last_draw = {"kind": "new", "role": role, "element": element, "grade": g, "pity": pity, "name": soldier_name(role, element), "paid": paid}
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


## 합치기 짝: 같은 모양·같은 별, 그리고 요변은 요변끼리 (보통·상품은 서로 섞여도 된다)
static func merge_class(s: Dictionary) -> String:
	return "%s|%d|%s" % [s["role"], s["star"], "legend" if s["tier"] == "legend" else "plain"]


## 지금 합칠 수 있는 묶음 (같은 병사·같은 별 3명). 가마에 넣은 병사는 뺀다
func merge_groups() -> Array:
	var by := {}
	for s in army:
		if s["star"] >= D.MAX_STAR or is_queued(s["id"]):
			continue
		var key := merge_class(s)
		if not by.has(key):
			by[key] = []
		by[key].append(s["id"])
	var groups: Array = []
	for key in by:
		var ids: Array = by[key]
		var need := D.merge_need(soldier(ids[0])["star"])
		if ids.size() >= need:
			groups.append(ids.slice(0, need))
	return groups


## 이 병사와 합칠 수 있는 짝 수 (자기 포함) / 필요한 수
func merge_progress(s: Dictionary) -> Vector2i:
	var key := merge_class(s)
	var n := army.filter(func(o): return merge_class(o) == key and not is_queued(o["id"])).size()
	return Vector2i(n, D.merge_need(s["star"]))


## 합치기: 별 +1, 품질은 가장 좋은 것, 유약은 그 병사 것. 끼고 있던 장비는 가방으로 돌아온다
func merge(ids: Array) -> Dictionary:
	if ids.is_empty() or state != "prep":
		return {}
	var parts: Array = ids.map(func(i): return soldier(i))
	if parts.any(func(p): return p.is_empty()):
		return {}
	var a: Dictionary = parts[0]
	if a["star"] >= D.MAX_STAR or ids.size() != D.merge_need(a["star"]):
		return {}
	for p in parts:
		if merge_class(p) != merge_class(a):
			return {}
	for p in parts:
		if not p.get("equip", {}).is_empty():
			inventory.append(p["equip"])
	var best := -1
	var element: String = a["element"]
	for p in parts:
		if D.TIERS.find(p["tier"]) > best:
			best = D.TIERS.find(p["tier"])
			element = p["element"]
	army = army.filter(func(s): return not ids.has(s["id"]))
	var m := _add_soldier(a["role"], element, D.TIERS[best], a["star"] + 1)
	# 상점 강화는 합쳐진다 (한도 안에서), 전직·자리는 먼저 것
	for p in parts:
		for k in p.get("upg", {}):
			m["upg"][k] = minf(_upg_cap(k), m["upg"].get(k, 0.0) + p["upg"][k])
		if m["promo"] == "" and p.get("promo", "") != "":
			m["promo"] = p["promo"]
			m["name"] = promo_name(m["role"], m["promo"], m["element"])
	m["home"] = a.get("home", null)
	return m


func _add_soldier(role: String, element: String, tier: String, star := 1) -> Dictionary:
	var s := {"id": _next_id, "role": role, "element": element, "tier": tier, "star": star, "name": soldier_name(role, element),
		"equip": {}, "upg": {}, "promo": "", "home": null}
	_next_id += 1
	army.append(s)
	return s


# ---------------- 가마 ----------------
## 가마를 연다. 새 병사는 군대에 들어오고, 다시 구운 병사는 등급이 오르거나 그대로 (불 5 이상이면 깨질 수 있다)
func fire(bet := false) -> Array:
	results = []
	last_bet = {}
	if queue.is_empty():
		return results
	var new_ids: Array = []
	var o: Dictionary = kiln.odds()
	var guarantee: bool = kiln.guaranteed_legend()
	if guarantee:
		kiln.shards -= kiln.shard_need
	for i in queue.size():
		var q: Dictionary = queue[i]
		var rr: Dictionary = {"cracked": false, "tier": "legend"} if guarantee and i == 0 else kiln.roll(o)
		var r := {"role": q["role"], "element": q["element"], "cracked": rr["cracked"], "tier": rr["tier"],
			"lucky": guarantee and i == 0, "refire": q["kind"] == "refire", "name": soldier_name(q["role"], q["element"])}
		if q["kind"] == "new":
			if not rr["cracked"]:
				var ns := _add_soldier(q["role"], q["element"], rr["tier"])
				new_ids.append(ns["id"])
				r["id"] = ns["id"]
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
	if bet:
		_bet(new_ids)
	return results


# ---------------- 가마신과 내기 ----------------
func bet_odds() -> Array:
	return D.BET_ODDS


## 내기: 확률표대로 하나. 꽝이 BET_PITY 번이면 다음은 대박 확정
func _bet(new_ids: Array) -> void:
	var key := ""
	if bet_busts >= bet_pity():
		key = "jackpot"
		bet_busts = 0
	else:
		var x := rng.randf()
		for o in D.BET_ODDS:
			x -= o[2]
			key = o[0]
			if x < 0.0:
				break
	if new_ids.is_empty() and key != "pearls":
		key = "pearls"   # 새 병사가 없으면 진주로 대신
	var ids: Array = []
	match key:
		"jackpot":
			for id in new_ids:
				var s := soldier(id)
				if not s.is_empty():
					s["star"] = mini(D.MAX_STAR, s["star"] + 1)
					ids.append(id)
		"twin":
			var s2 := soldier(new_ids[rng.randi() % new_ids.size()])
			if army.size() < cap():
				var c := _add_soldier(s2["role"], s2["element"], s2["tier"], s2["star"])
				ids = [s2["id"], c["id"]]
			else:
				pearls += 4   # 자리가 없으면 진주로
				key = "pearls"
		"gold":
			var s3 := soldier(new_ids[rng.randi() % new_ids.size()])
			s3["tier"] = "legend"
			ids = [s3["id"]]
		"pearls":
			pearls += 4
		"bust":
			var id4: int = new_ids[rng.randi() % new_ids.size()]
			ids = [id4]
			army = army.filter(func(x): return x["id"] != id4)
			kiln.shards += 1
			bet_busts += 1
	if key == "jackpot":
		bet_busts = 0
	var row: Array = D.BET_ODDS.filter(func(o): return o[0] == key)[0]
	last_bet = {"key": key, "name": row[1], "desc": row[3], "ids": ids}


# ---------------- 밤 ----------------
func start_night():
	var b = Battle.new(rng.randi(), D.wave_plan(night, true, chapter))
	b.village_hp = village_hp
	b.village_guard = meta.get("village_guard", 0.0)
	for s in army:
		var home = s.get("home", null)
		b.add_ally(s["role"], s["element"], s["tier"], s["name"], D.STAR_MUL[s["star"]], soldier_mods(s), home if home is Vector2 else Vector2.INF)
	state = "night"
	return b


## 병사 한 명이 전투에 가져가는 배율: 장비 + 상점 강화 + 진영 시너지 + 전직
func soldier_mods(s: Dictionary) -> Dictionary:
	var m: Dictionary = D.equip_mods(s.get("equip", {}))
	for k in s.get("upg", {}):
		if k != "ticket":
			m[k] = m.get(k, 0.0) + s["upg"][k]
	var lv := faction_levels()
	for f in lv:
		var ti: int = lv[f]
		if ti < 0:
			continue
		var fd: Dictionary = D.FACTIONS[f]
		var v: float = fd["vals"][ti]
		match fd["kind"]:
			"all_atk":
				m["atk"] = m.get("atk", 0.0) + v
			_:
				if s["role"] in fd["roles"]:
					m[fd["kind"]] = m.get(fd["kind"], 0.0) + v
	if s.get("promo", "") != "":
		m["skills"] = [s["promo"]]
		m["atk"] = m.get("atk", 0.0) + D.PROMO_BONUS
		m["hp"] = m.get("hp", 0.0) + D.PROMO_BONUS
	m["star"] = s["star"]
	for k in ["atk", "hp", "cdr"]:
		if meta.has(k):
			m[k] = m.get(k, 0.0) + meta[k]
	return m


# ---------------- 진영 시너지 ----------------
## 진영마다 군대에 있는 '서로 다른' 병사 종류 수
func faction_counts() -> Dictionary:
	var c := {}
	for f in D.FACTIONS:
		var kinds := {}
		for s in army:
			if s["role"] in D.FACTIONS[f]["roles"]:
				kinds[s["role"]] = true
		c[f] = kinds.size()
	return c


## 진영마다 켜진 단계 (-1 = 아직 없음)
func faction_levels() -> Dictionary:
	var c := faction_counts()
	var out := {}
	for f in D.FACTIONS:
		var tiers: Array = D.FACTIONS[f]["tiers"]
		var ti := -1
		for i in tiers.size():
			if c[f] >= tiers[i]:
				ti = i
		out[f] = ti
	return out


# ---------------- 전직 ----------------
static func promo_name(role: String, promo: String, element: String) -> String:
	return "%s %s %s" % [D.GLAZE_NAME[element], D.PROMO_ADJ[promo], D.ROLE_NAME_KILN[role]]


## base(★3 이상, 아직 전직 안 함)에 ing(같은 진영 다른 병사)를 합쳐 전직할 수 있나
func can_promote(base_id: int, ing_id: int) -> bool:
	var a := soldier(base_id)
	var b := soldier(ing_id)
	if state != "prep" or a.is_empty() or b.is_empty() or base_id == ing_id:
		return false
	return a["star"] >= D.PROMO_STAR and a.get("promo", "") == "" and b["role"] != a["role"] \
		and D.faction_of(a["role"]) == D.faction_of(b["role"]) and not is_queued(base_id) and not is_queued(ing_id)


## base 와 전직할 수 있는 재료 병사들
func promo_partners(base_id: int) -> Array:
	return army.filter(func(o): return can_promote(base_id, o["id"])).map(func(o): return o["id"])


func promote(base_id: int, ing_id: int) -> Dictionary:
	if not can_promote(base_id, ing_id):
		return {}
	var a := soldier(base_id)
	var b := soldier(ing_id)
	if not b.get("equip", {}).is_empty():
		inventory.append(b["equip"])
	a["promo"] = b["role"]
	a["name"] = promo_name(a["role"], b["role"], a["element"])
	army = army.filter(func(o): return o["id"] != ing_id)
	return a


# ---------------- 진주 상점 ----------------
func restock() -> void:
	var keys: Array = D.SHOP_ITEMS.keys()
	shop = []
	for i in D.SHOP_SLOTS:
		shop.append(keys[rng.randi() % keys.size()])


func reroll_shop() -> bool:
	if pearls < D.SHOP_REROLL or state != "prep":
		return false
	pearls -= D.SHOP_REROLL
	restock()
	return true


static func _upg_cap(k: String) -> float:
	return 0.5 if k == "cdr" else D.UPG_MAX


## 진열 칸 slot 의 물건을 산다. 병사 강화는 soldier_id 에게 (뽑기권은 병사 필요 없음)
func buy(slot: int, soldier_id := -1) -> bool:
	if state != "prep" or slot < 0 or slot >= shop.size() or shop[slot] == "":
		return false
	var it: Dictionary = D.SHOP_ITEMS[shop[slot]]
	if pearls < price(shop[slot]):
		return false
	if it["stat"] == "ticket":
		tickets += 1
	else:
		var s := soldier(soldier_id)
		if s.is_empty():
			return false
		var cur: float = s["upg"].get(it["stat"], 0.0)
		if cur >= _upg_cap(it["stat"]):
			return false
		s["upg"][it["stat"]] = minf(_upg_cap(it["stat"]), cur + it["val"])
	pearls -= price(shop[slot])
	shop[slot] = ""
	return true


# ---------------- 자유 배치 ----------------
## 병사를 둘 자리 (전장 좌표). 둘 수 있는 곳 밖이면 안쪽으로 당긴다. null 이면 자동 대열
func set_home(id: int, pos) -> void:
	var s := soldier(id)
	if s.is_empty():
		return
	if pos == null:
		s["home"] = null
		return
	var r: Rect2 = Battle.DEPLOY
	s["home"] = Vector2(clampf(pos.x, r.position.x, r.end.x), clampf(pos.y, r.position.y, r.end.y))


func end_night(b) -> void:
	village_hp = maxf(0.0, b.village_hp)
	last_kills = b.stats["kills"]
	total_kills += last_kills
	chapter_time += b.frame / float(D.FPS)
	if b.result != "win" or village_hp <= 0.0:
		state = "lost"
		return
	# 전리품: 뽑기권 · 흙 · (챕터 3부터) 장비
	var boss_night := night >= D.KILN_NIGHTS
	nights_cleared += 1
	var tk: int = D.TICKETS_PER_NIGHT + last_kills / D.TICKET_PER_KILLS + (D.TICKETS_BOSS if boss_night else 0) + int(meta.get("night_tickets", 0.0))
	tickets += tk
	clay += D.CLAY_PER_NIGHT
	last_reward = D.CLAY_PER_NIGHT
	var got: Array = []
	if chapter >= D.EQUIP_FROM_CHAPTER:
		for i in (D.EQUIP_BOSS if boss_night else D.EQUIP_PER_NIGHT):
			got.append(_roll_equip(boss_night and i == 0))
	inventory.append_array(got)
	var pr: int = last_kills / D.PEARL_PER_KILLS + (D.PEARL_BOSS if boss_night else 0)
	pearls += pr
	restock()
	last_loot = {"tickets": tk, "clay": D.CLAY_PER_NIGHT, "pearls": pr, "equip": got, "chapter_clay": 0, "boss": boss_night}
	night += 1
	chapter_cleared = false
	if night > D.KILN_NIGHTS:
		last_chapter_time = chapter_time
		chapter_time = 0.0
		chapter += 1
		if chapter > D.CHAPTERS.size():
			chapter = D.CHAPTERS.size()
			night = D.KILN_NIGHTS
			state = "won"
			return
		night = 1
		chapter_cleared = true
		clay += D.CLAY_PER_CHAPTER
		last_loot["chapter_clay"] = D.CLAY_PER_CHAPTER
		village_hp = D.VILLAGE_HP
		state = "prep"
		return
	village_hp = minf(D.VILLAGE_HP, village_hp + D.VILLAGE_REPAIR)
	state = "prep"


# ---------------- 장비 (챕터 3부터) ----------------
func equip_unlocked() -> bool:
	return chapter >= D.EQUIP_FROM_CHAPTER


func _roll_equip(at_least_2 := false) -> Dictionary:
	var types: Array = D.EQUIPS.keys()
	var odds: Array = D.EQUIP_LEVEL_ODDS.get(mini(chapter, 5), [1.0, 0.0, 0.0])
	var x := rng.randf()
	var lv := 1
	if x >= odds[0]:
		lv = 2 if x < odds[0] + odds[1] else 3
	if at_least_2:
		lv = maxi(lv, 2)
	var item := {"id": _next_id, "type": types[rng.randi() % types.size()], "level": lv}
	_next_id += 1
	return item


static func equip_name(item: Dictionary) -> String:
	return "%s%s" % [D.EQUIPS[item["type"]]["name"], D.EQUIP_LEVEL_NAME[item["level"]]]


## 가방의 장비를 병사에게 끼운다 (끼고 있던 것은 가방으로)
func equip(soldier_id: int, item_id: int) -> bool:
	var s := soldier(soldier_id)
	var idx := -1
	for i in inventory.size():
		if inventory[i]["id"] == item_id:
			idx = i
	if s.is_empty() or idx < 0 or not equip_unlocked():
		return false
	var item: Dictionary = inventory.pop_at(idx)
	if not s.get("equip", {}).is_empty():
		inventory.append(s["equip"])
	s["equip"] = item
	return true


func unequip(soldier_id: int) -> bool:
	var s := soldier(soldier_id)
	if s.is_empty() or s.get("equip", {}).is_empty():
		return false
	inventory.append(s["equip"])
	s["equip"] = {}
	return true


## 정보창용: 이 병사가 전투에 나가면 갖는 능력치
func soldier_stats(s: Dictionary) -> Dictionary:
	var st: Dictionary = D.ROLE_STATS[s["role"]]
	var m := soldier_mods(s)
	var k: float = D.TIER_MUL[s["tier"]] * D.STAR_MUL[s["star"]]
	return {
		"hp": roundi(st["hp"] * k * (1.0 + m.get("hp", 0.0))),
		"atk": roundi(st["atk"] * k * (1.0 + m.get("atk", 0.0))),
		"aps": snappedf(60.0 / maxf(6.0, st["cd"] / (1.0 + m.get("haste", 0.0))), 0.1),
		"range": roundi(st["range"]),
		"speed": st["speed"],
		"shield": roundi(st["hp"] * k * (1.0 + m.get("hp", 0.0)) * m.get("shield", 0.0)),
		"skill_lv": D.skill_level(s["star"]),
		"skill_pow": 1.0 + m.get("skill", 0.0),
		"cdr": m.get("cdr", 0.0),
		"skills": [s["role"]] + m.get("skills", []),
	}
