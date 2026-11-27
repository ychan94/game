extends RefCounted
## B 가마의 병사: 빚기(모양=역할, 유약=속성) → 불 올리기 → 가마 열기.
## 억울함 방지: 불 4까지는 절대 안 깨지고, 깨지면 파편, 파편 3개면 다음 굽기에서 요변 1개 확정.

const D = preload("res://src/proto/data.gd")

var rng := RandomNumberGenerator.new()
var slots: Array = []      # [{"role", "element"}]
var heat := 0
var shards := 0            # 판을 다시 해도 남는다 (시험판에서는 실행하는 동안)
var results: Array = []    # 가마를 연 결과 [{"role","element","tier","cracked","name","lucky"}]


func _init(seed_value: int) -> void:
	rng.seed = seed_value
	reset_slots()


func reset_slots() -> void:
	slots = []
	var roles := ["shield", "spear", "spear", "archer", "archer"]
	for i in D.KILN_SLOTS:
		slots.append({"role": roles[i], "element": D.ELEMENTS[i % 3]})
	heat = 0
	results = []


func cycle_role(i: int) -> void:
	var r: String = slots[i]["role"]
	slots[i]["role"] = D.ROLES[(D.ROLES.find(r) + 1) % D.ROLES.size()]


func cycle_element(i: int) -> void:
	var e: String = slots[i]["element"]
	slots[i]["element"] = D.ELEMENTS[(D.ELEMENTS.find(e) + 1) % D.ELEMENTS.size()]


func heat_up() -> void:
	heat = mini(heat + 1, D.KILN_MAX_HEAT)


func odds() -> Dictionary:
	return D.kiln_odds(heat)


func guaranteed_legend() -> bool:
	return shards >= D.SHARDS_FOR_LEGEND


## 가마 열기: 병사마다 깨짐 → 요변 → 상품 순서로 굴린다
func open() -> Array:
	var o := odds()
	results = []
	var use_guarantee := guaranteed_legend()
	if use_guarantee:
		shards -= D.SHARDS_FOR_LEGEND
	for i in slots.size():
		var s: Dictionary = slots[i]
		var r := {"role": s["role"], "element": s["element"], "tier": "normal", "cracked": false, "lucky": false}
		if use_guarantee and i == 0:
			r["tier"] = "legend"
			r["lucky"] = true  # 파편으로 확정된 요변
		else:
			var rr := roll(o)
			r["cracked"] = rr["cracked"]
			r["tier"] = rr["tier"]
		r["name"] = "%s %s" % [D.GLAZE_NAME[r["element"]], D.ROLE_NAME_KILN[r["role"]]]
		results.append(r)
	return results


## 병사 한 명 굽기: 깨짐 → 요변 → 상품 순서. 깨지면 파편 +1
func roll(o: Dictionary) -> Dictionary:
	if rng.randf() < o["crack"]:
		shards += 1
		return {"cracked": true, "tier": "normal"}
	if rng.randf() < o["legend"]:
		return {"cracked": false, "tier": "legend"}
	if rng.randf() < o["fine"]:
		return {"cracked": false, "tier": "fine"}
	return {"cracked": false, "tier": "normal"}


func make_battle(seed_value: int):
	var Battle = load("res://src/proto/battle.gd")
	var b = Battle.new(seed_value)
	for r in results:
		if not r["cracked"]:
			b.add_ally(r["role"], r["element"], r["tier"], r["name"])
	return b
