extends SceneTree
## 화면 없이 테스트를 돌린다.
##   godot --headless --path . --script res://tests/run_tests.gd -- p0|p1|boss
## 각 테스트 함수는 끝까지 가면 true 를 돌려준다. 중간에 스크립트 오류가 나면 null → 실패로 센다.

const SUITES := {
	"p0": ["res://tests/test_p0.gd"],
	"p1": ["res://tests/test_p1.gd", "res://tests/test_proto.gd", "res://tests/test_kiln_run.gd"],
	"boss": ["res://tests/test_boss.gd"],
}


func _init() -> void:
	var args := OS.get_cmdline_user_args()
	var stage: String = args[0] if args.size() > 0 else "p0"
	var ok := 0
	var fail := 0
	for path in SUITES.get(stage, []):
		var script = load(path)
		if script == null or not script.can_instantiate():
			# 테스트 파일을 해석하지 못하면 (문법 오류 등) 멈추지 말고 실패로 센다
			fail += 1
			print("  실패: %s — 테스트 파일을 불러오지 못함 (문법 오류?)" % path.get_file())
			continue
		var suite = script.new()
		for m in suite.get_method_list():
			var name: String = m["name"]
			if not name.begins_with("test_"):
				continue
			suite.failures = []
			var r = suite.call(name)
			if r == true and suite.failures.is_empty():
				ok += 1
			else:
				fail += 1
				print("  실패: %s::%s" % [path.get_file(), name])
				for f in suite.failures:
					print("    - " + f)
				if r != true:
					print("    - 끝까지 실행되지 않음 (스크립트 오류)")
	print("  %d개 통과, %d개 실패" % [ok, fail])
	quit(0 if fail == 0 and ok > 0 else 1)
