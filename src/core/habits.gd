extends RefCounted
## 플레이어 습관 기록기. 기획서의 4가지 습관 + 주력 기술만 잰다.
##   구르기(얼마나 자주, 위험할 때 구르는지) / 거리 / 주력 기술 / 도는 방향

var combat_frames := 0
var dodges := 0
var reactive_dodges := 0
var attacks := 0
var dist_sum := 0.0
var dist_n := 0
var circle_sum := 0.0
var circle_n := 0
var ability_uses := {}
var _last_pos = null


func sample(world) -> void:
	var p = world.player
	if p == null or not p.alive:
		return
	var foe = world.nearest_foe(p)
	if foe == null:
		_last_pos = null
		return
	combat_frames += 1
	if combat_frames % 10 == 0:
		dist_sum += p.pos.distance_to(foe.pos)
		dist_n += 1
	if _last_pos != null:
		var v: Vector2 = p.pos - _last_pos
		if v.length() > 0.5:
			var r: Vector2 = p.pos - foe.pos
			circle_sum += signf(r.cross(v))
			circle_n += 1
	_last_pos = p.pos


func on_dodge(threatened: bool) -> void:
	dodges += 1
	if threatened:
		reactive_dodges += 1


func on_attack() -> void:
	attacks += 1


func on_ability(id: String) -> void:
	ability_uses[id] = ability_uses.get(id, 0) + 1


func summary(abilities: Array) -> Dictionary:
	var minutes := maxf(combat_frames / 3600.0, 0.25)
	var main := ""
	var best := 0
	for id in abilities:
		var n: int = ability_uses.get(id, 0)
		if n > best:
			best = n
			main = id
	return {
		"dodge_per_min": dodges / minutes,
		"dodge_reactive": float(reactive_dodges) / maxf(dodges, 1),
		"pref_distance": dist_sum / dist_n if dist_n > 0 else 100.0,
		"circle": circle_sum / circle_n if circle_n > 0 else 0.0,
		"attack_per_min": attacks / minutes,
		"main_ability": main,
		"combat_seconds": combat_frames / 60.0,
	}
