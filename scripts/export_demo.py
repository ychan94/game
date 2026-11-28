"""데모 빌드 만들기: python3 scripts/export_demo.py [windows|web|all]

먼저 Godot 편집기에서 '편집기 → 내보내기 템플릿 관리'로 4.7.2 템플릿을 내려받아 둔다.
결과는 build/ 폴더 (git 에 안 올림).
"""
import os
import subprocess
import sys

sys.path.insert(0, os.path.dirname(__file__))
from godot_cmd import find_godot  # noqa: E402

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PRESETS = {"windows": ("Windows", "build/windows/KILNBORN-demo.exe"), "web": ("Web", "build/web/index.html")}


def main():
    which = sys.argv[1] if len(sys.argv) > 1 else "windows"
    targets = list(PRESETS) if which == "all" else [which]
    godot = find_godot()
    if not godot:
        print("Godot 를 못 찾았습니다 (환경 변수 GODOT 에 실행 파일 경로를 넣어 주세요)")
        return 1
    rc = 0
    for t in targets:
        name, out = PRESETS[t]
        os.makedirs(os.path.join(ROOT, os.path.dirname(out)), exist_ok=True)
        print(f"[{name}] 내보내는 중 → {out}")
        r = subprocess.run([godot, "--headless", "--path", ROOT, "--export-release", name, out])
        if r.returncode != 0 or not os.path.exists(os.path.join(ROOT, out)):
            print(f"[{name}] 실패 — 내보내기 템플릿이 설치됐는지 확인해 주세요")
            rc = 1
        else:
            print(f"[{name}] 완료")
    return rc


if __name__ == "__main__":
    sys.exit(main())
