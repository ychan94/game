extends RefCounted
## A 알을 품는 성: 알 3개를 하나씩 먹이고(속성 기울이기) 데우고(위험) 깨운다.
## 억울함 방지: 처음 두 번은 절대 안 터지고, 터지면 껍질 조각, 조각 3개면 다음 알은 전설까지 안전.

const D = preload("res://src/proto/data.gd")

var rng := RandomNumberGenerator.new()
var eggs: Array = []        # [{"role", "hint", "food", "warmth", "state"("wait"/"warming"/"hatched"/"burst"), "creature"}]
var current := 0
var shells := 0             # 실행하는 동안 남는다
var safe_egg := false       # 이번 알은 전설까지 안 터진다
var hostiles: Array = []    # 터진 알에서 나온 폭주 괴수 (밤에 적으로 나온다)


func _init(seed_value: int) -> void:
	rng.seed = seed_value
	new_clutch()


func new_clutch() -> void:
	eggs = []
	hostiles = []
	current = 0
	for i in D.NEST_EGGS:
		eggs.append({"role": D.ROLES[rng.randi_range(0, 2)], "hint": D.ELEMENTS[rng.randi_range(0, 2)],
			"food": "", "warmth": 0, "state": "wait", "creature": {}})
	_begin_egg()


func _begin_egg() -> void:
	safe_egg = false
	if current < eggs.size():
		eggs[current]["state"] = "warming"
		if shells >= D.SHARDS_FOR_LEGEND:
			shells -= D.SHARDS_FOR_LEGEND
			safe_egg = true


func egg() -> Dictionary:
	return eggs[current] if current < eggs.size() else {}


func done() -> bool:
	return current >= eggs.size()


func feed(element: String) -> void:
	if not done():
		eggs[current]["food"] = element


func tier_for(warmth: int) -> String:
	if warmth >= D.NEST_LEGEND_AT:
		return "legend"
	if warmth >= D.NEST_FINE_AT:
		return "fine"
	return "normal"


func burst_chance() -> float:
	if done():
		return 0.0
	var w: int = eggs[current]["warmth"]
	if safe_egg and w < D.NEST_LEGEND_AT:
		return 0.0
	return D.nest_burst_chance(w)


## 한 번 더 데운다. 터지면 "burst", 아니면 "ok"
func warm() -> String:
	if done():
		return ""
	var e: Dictionary = eggs[current]
	if rng.randf() < burst_chance():
		e["state"] = "burst"
		shells += 1
		var c := _creature(e, tier_for(e["warmth"]))
		hostiles.append(c)
		e["creature"] = c
		current += 1
		_begin_egg()
		return "burst"
	e["warmth"] += 1
	return "ok"


## 지금 온기로 깨운다
func hatch() -> Dictionary:
	if done():
		return {}
	var e: Dictionary = eggs[current]
	var tier := tier_for(e["warmth"])
	var lucky := false
	if tier != "legend" and rng.randf() < D.NEST_LUCKY:
		tier = D.TIERS[D.TIERS.find(tier) + 1]
		lucky = true
	var c := _creature(e, tier)
	c["lucky"] = lucky
	e["creature"] = c
	e["state"] = "hatched"
	current += 1
	_begin_egg()
	return c


func _creature(e: Dictionary, tier: String) -> Dictionary:
	var element: String = e["hint"]
	if e["food"] != "":
		element = e["food"] if rng.randf() < D.FOOD_TILT else e["hint"]
	return {"role": e["role"], "element": element, "tier": tier,
		"name": D.CREATURE_NAME[e["role"]][element]}


func make_battle(seed_value: int):
	var Battle = load("res://src/proto/battle.gd")
	var b = Battle.new(seed_value)
	for e in eggs:
		if e["state"] == "hatched":
			var c: Dictionary = e["creature"]
			b.add_ally(c["role"], c["element"], c["tier"], c["name"], D.NEST_STAT_MUL)
	# 터진 알의 폭주 괴수는 4초마다 하나씩 적으로 나온다
	var f := 240
	for h in hostiles:
		var s: Dictionary = D.ROLE_STATS[h["role"]]
		var m: float = D.TIER_MUL[h["tier"]] * D.NEST_STAT_MUL * 0.8
		b.spawn_queue.append([f, "hostile", {"name": "폭주 " + h["name"], "hp": s["hp"] * m, "atk": s["atk"] * m,
			"speed": 0.6, "range": minf(s["range"], 110.0), "cd": s["cd"], "village": 15.0, "radius": 11.0, "element": h["element"]}])
		f += 240
	b.spawn_queue.sort_custom(func(a, c): return a[0] < c[0])
	return b
