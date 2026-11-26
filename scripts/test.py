#!/usr/bin/env python3
"""바뀐 파일에 맞는 테스트 단계만 골라 돌린다.

    python3 scripts/test.py              # 바뀐 파일 기준 (커밋 안 된 것 + 새 파일)
    python3 scripts/test.py --staged     # 커밋하려고 올린 파일 기준 (pre-commit 훅이 씀)
    python3 scripts/test.py --stage p0   # 단계 직접 지정 (p0, p1, boss, all)
    python3 scripts/test.py --dry-run    # 무엇을 돌릴지만 보여 준다

단계: p0 = 깨지면 게임이 안 되는 것 / p1 = 게임 전반 / boss = 보스 봇 전투
"""
import argparse
import fnmatch
import importlib.util
import json
import pathlib
import subprocess
import sys
import time
import traceback

ROOT = pathlib.Path(__file__).resolve().parents[1]
ORDER = ["p0", "p1", "boss"]


def git(*args):
    r = subprocess.run(["git", *args], cwd=ROOT, capture_output=True, text=True)
    return [l for l in r.stdout.splitlines() if l.strip()] if r.returncode == 0 else []


def changed_files(staged):
    if staged:
        return git("diff", "--cached", "--name-only")
    files = set(git("diff", "--name-only", "HEAD")) | set(git("diff", "--name-only", "--cached"))
    files |= set(git("ls-files", "--others", "--exclude-standard"))
    if not git("rev-parse", "HEAD"):  # 첫 커밋 전이면 전부
        files |= set(git("ls-files", "--others", "--exclude-standard", "--cached"))
    return sorted(files)


def pick_stages(files):
    cfg = json.loads((ROOT / "test_map.json").read_text())
    stages, why = set(), {}
    for f in files:
        hit = None
        for rule in cfg["rules"]:
            if fnmatch.fnmatch(f, rule["glob"]):
                hit = rule["stages"]
                break  # 위에 있는 규칙이 먼저
        if hit is None:
            hit = cfg["default"]
        for s in hit:
            stages.add(s)
            why.setdefault(s, []).append(f)
    return [s for s in ORDER if s in stages], why


def run_pytests(folder):
    sys.path.insert(0, str(ROOT))
    ok = fail = 0
    for path in sorted((ROOT / "tests" / folder).glob("test_*.py")):
        spec = importlib.util.spec_from_file_location(path.stem, path)
        mod = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(mod)
        for name in sorted(n for n in dir(mod) if n.startswith("test_")):
            try:
                getattr(mod, name)()
                ok += 1
            except Exception:
                fail += 1
                print(f"  실패: {path.name}::{name}")
                traceback.print_exc(limit=2)
    print(f"  {ok}개 통과, {fail}개 실패")
    return fail == 0


def run_stage(stage):
    t = time.time()
    print(f"\n[{stage}] 시작")
    if stage in ("p0", "p1"):
        ok = run_pytests(stage)
    else:
        ok = subprocess.run([sys.executable, str(ROOT / "tests/bosses/boss_bot.py")], cwd=ROOT).returncode == 0
    print(f"[{stage}] {'통과' if ok else '실패'} ({time.time() - t:.1f}초)")
    return ok


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--stage", choices=ORDER + ["all"])
    ap.add_argument("--staged", action="store_true")
    ap.add_argument("--dry-run", action="store_true")
    a = ap.parse_args()

    if a.stage:
        stages = ORDER if a.stage == "all" else [a.stage]
        print(f"지정한 단계: {', '.join(stages)}")
    else:
        files = changed_files(a.staged)
        stages, why = pick_stages(files)
        print(f"바뀐 파일 {len(files)}개 → 돌릴 단계: {', '.join(stages) or '없음'}")
        for s in stages:
            print(f"  {s}: {', '.join(why[s][:5])}{' …' if len(why[s]) > 5 else ''}")
    if a.dry_run or not stages:
        return 0
    results = {s: run_stage(s) for s in stages}
    print("\n결과: " + "  ".join(f"{s}={'통과' if v else '실패'}" for s, v in results.items()))
    return 0 if all(results.values()) else 1


if __name__ == "__main__":
    sys.exit(main())
