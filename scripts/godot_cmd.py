"""Godot 실행 파일 찾기 + 화면 없이 스크립트 돌리기 (test.py, perf/bench.py 가 함께 쓴다).

찾는 순서: 환경 변수 GODOT → PATH 의 godot / godot4 → Windows 기본 위치의 *console*.exe
"""
import glob
import json
import os
import pathlib
import shutil
import subprocess
import sys

ROOT = pathlib.Path(__file__).resolve().parents[1]


def find_godot():
    env = os.environ.get("GODOT")
    if env and pathlib.Path(env).exists():
        return env
    for name in ("godot", "godot4", "Godot"):
        p = shutil.which(name)
        if p:
            return p
    if sys.platform == "win32":
        home = pathlib.Path.home()
        pats = [str(home / "**" / "Godot_v4*_console.exe"), "C:/Godot/**/Godot_v4*_console.exe",
                "C:/Program Files/Godot/**/Godot_v4*_console.exe"]
        for pat in pats:
            hits = sorted(glob.glob(pat, recursive=True))
            if hits:
                return hits[-1]
    return None


def run_script(script, args=(), capture=True):
    """res://... 스크립트를 화면 없이 돌린다. (종료 코드, 출력 줄들, RESULT_JSON 목록)"""
    godot = find_godot()
    if not godot:
        print("Godot 를 찾지 못했습니다. 환경 변수 GODOT 에 Godot 실행 파일(Windows는 *_console.exe) 경로를 넣어 주세요.")
        return 3, [], []
    env = {**os.environ, "PYTHONUTF8": "1"}
    if not (ROOT / ".godot").exists():
        subprocess.run([godot, "--headless", "--path", str(ROOT), "--import"], cwd=ROOT,
                       capture_output=True, env=env, timeout=600)
    r = subprocess.run([godot, "--headless", "--path", str(ROOT), "--script", script, "--", *args], cwd=ROOT,
                       capture_output=True, text=True, encoding="utf-8", errors="replace", env=env, timeout=1800)
    lines = (r.stdout + r.stderr).splitlines()
    results, shown = [], []
    for line in lines:
        if line.startswith("RESULT_JSON:"):
            results.append(json.loads(line[len("RESULT_JSON:"):]))
        elif not line.startswith("Godot Engine") and line.strip():
            shown.append(line)
    return r.returncode, shown, results
