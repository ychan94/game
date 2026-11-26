#!/usr/bin/env python3
"""Claude가 파일을 고친 직후 실행. 게임 규칙(src/core/)이면 boss 단계(어제의 나 검사 + 보스전)를 바로 돌려 결과를 Claude에게 알린다."""
import json
import os
import pathlib
import subprocess
import sys

ROOT = pathlib.Path(__file__).resolve().parents[2]
COMBAT_DIR = "src/core/"

sys.stdout.reconfigure(encoding="utf-8")
sys.stderr.reconfigure(encoding="utf-8")
data = json.loads(sys.stdin.buffer.read())
path = data.get("tool_input", {}).get("file_path", "")
try:
    rel = str(pathlib.Path(path).resolve().relative_to(ROOT))
except ValueError:
    sys.exit(0)
rel = rel.replace("\\", "/")
if not (rel.startswith(COMBAT_DIR) and rel.endswith(".gd")):
    sys.exit(0)
r = subprocess.run([sys.executable, str(ROOT / "scripts/test.py"), "--stage", "boss"], cwd=ROOT, env={**os.environ, "PYTHONUTF8": "1"}, capture_output=True, text=True, encoding="utf-8", errors="replace")
if r.returncode != 0:
    print(f"전투 코드({rel})가 바뀌어 boss 단계를 돌렸는데 실패했습니다:\n{r.stdout}", file=sys.stderr)
    sys.exit(2)  # Claude에게 알림
print(f"boss 단계 통과 ({rel} 변경)\n{r.stdout[-1500:]}")
