#!/usr/bin/env python3
"""사용자가 직접 고친 파일인지 확인한다. 걸린 파일만 출력한다 (없으면 아무것도 안 나옴).

    python3 scripts/protected.py <파일...>

보호 대상:
  1) PROTECTED.txt 에 적힌 경로(glob)
  2) 마지막 커밋이 Claude/Codex 표시(Co-Authored-By: Claude, [codex]) 없이 된 파일 = 사용자가 직접 고친 것
  3) 지금 커밋 안 된 변경이 있는데, 이번 작업에서 내가 만든 변경이 아닌 것 → 이건 스크립트가 알 수 없으니
     작업 시작 때 `git status` 를 work/<작업>/NOTES.md 에 적어 두고 비교한다.
"""
import fnmatch
import pathlib
import subprocess
import sys

ROOT = pathlib.Path(__file__).resolve().parents[1]
AGENT_MARKS = ("Co-Authored-By: Claude", "[codex]")


def patterns():
    p = ROOT / "PROTECTED.txt"
    if not p.exists():
        return []
    return [l.strip() for l in p.read_text(encoding="utf-8").splitlines() if l.strip() and not l.startswith("#")]


def last_commit_by_user(path):
    r = subprocess.run(["git", "log", "-1", "--format=%B", "--", path], cwd=ROOT, capture_output=True, text=True, encoding="utf-8", errors="replace")
    body = r.stdout.strip()
    return bool(body) and not any(m in body for m in AGENT_MARKS)


def main(files):
    pats = patterns()
    hit = 0
    for f in files:
        why = None
        if any(fnmatch.fnmatch(f, p) for p in pats):
            why = "PROTECTED.txt"
        elif last_commit_by_user(f):
            why = "마지막 커밋을 사용자가 직접 함"
        if why:
            hit += 1
            print(f"{f}\t({why})")
    return 1 if hit else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
