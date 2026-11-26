#!/usr/bin/env python3
"""Claude가 파일을 고친 직후 실행. 전투 코드면 보스 봇 전투를 바로 돌려 결과를 Claude에게 알린다."""
import json
import os
import pathlib
import subprocess
import sys

ROOT = pathlib.Path(__file__).resolve().parents[2]
COMBAT = ("sim/combat.py", "sim/game.py")

sys.stdout.reconfigure(encoding="utf-8")
sys.stderr.reconfigure(encoding="utf-8")
data = json.loads(sys.stdin.buffer.read())
path = data.get("tool_input", {}).get("file_path", "")
try:
    rel = str(pathlib.Path(path).resolve().relative_to(ROOT))
except ValueError:
    sys.exit(0)
if rel not in COMBAT:
    sys.exit(0)
r = subprocess.run([sys.executable, str(ROOT / "tests/bosses/boss_bot.py")], cwd=ROOT, env={**os.environ, "PYTHONUTF8": "1"}, capture_output=True, text=True, encoding="utf-8", errors="replace")
if r.returncode != 0:
    print(f"전투 코드({rel})가 바뀌어 보스 봇을 돌렸는데 못 깬 보스가 있습니다:\n{r.stdout}", file=sys.stderr)
    sys.exit(2)  # Claude에게 알림
print(f"보스 봇 통과 ({rel} 변경)\n{r.stdout}")
