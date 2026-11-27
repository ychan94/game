extends SceneTree
## 가마의 병사 균형 훑어보기 (테스트 아님): 봇이 몇 챕터까지 가나.
##   godot --headless --path . --script res://tests/sweep_kiln.gd -- <최대 챕터> <판 수>
func _init():
	var T = load("res://tests/test_kiln_run.gd").new()
	var args := OS.get_cmdline_user_args()
	var maxc: int = int(args[0]) if args.size() > 0 else 5
	var n: int = int(args[1]) if args.size() > 1 else 8
	for heat in [4]:
		var reach := {}
		var lines := []
		for s in n:
			var r: Dictionary = T.play(500 + s, heat, maxc)
			var key := "%s%d" % [r["state"].substr(0, 1), r["chapter"]]
			reach[key] = reach.get(key, 0) + 1
			var hp: Array = r["hp"]
			var tail: Array = hp.slice(maxi(0, hp.size() - 5))
			lines.append("%s ch%d.%d army%d stars%d hp%s" % [r["state"], r["chapter"], r["night"], r["army"], r["stars"], tail])
		print("heat ", heat, " ", reach)
		for l in lines:
			print("   ", l)
	quit()
