extends RefCounted
## 판 사이에 남는 것: 어제의 나(메아리 1명) + 기억 도감(회수한 능력).
## path 가 비어 있으면 메모리에만 둔다 (테스트용).

var path := ""
var data := {"echo": {}, "codex": []}


func _init(file_path := "") -> void:
	path = file_path
	if path != "" and FileAccess.file_exists(path):
		var f := FileAccess.open(path, FileAccess.READ)
		var parsed = JSON.parse_string(f.get_as_text())
		if parsed is Dictionary:
			data.merge(parsed, true)


func echo() -> Dictionary:
	return data["echo"]


func store_echo(profile: Dictionary) -> void:
	data["echo"] = profile
	_write()


func codex() -> Array:
	return data["codex"]


func add_codex(ability: String) -> void:
	if not data["codex"].has(ability):
		data["codex"].append(ability)
	_write()


func _write() -> void:
	if path == "":
		return
	var f := FileAccess.open(path, FileAccess.WRITE)
	f.store_string(JSON.stringify(data, "  "))
