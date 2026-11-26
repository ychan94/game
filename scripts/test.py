#!/usr/bin/env python3
"""바뀐 파일에 맞는 테스트 단계만 골라 돌린다.

    python3 scripts/test.py              # 바뀐 파일 기준 (커밋 안 된 것 + 새 파일)
    python3 scripts/test.py --staged     # 커밋하려고 올린 파일 기준 (pre-commit 훅이 씀)
    python3 scripts/test.py --stage p0   # 단계 직접 지정 (p0, p1, boss, all)
    python3 scripts/test.py --dry-run    # 무엇을 돌릴지만 보여 준다

단계: p0 = 깨지면 게임이 안 되는 것 / p1 = 게임 전반 / boss = 어제의 나(따라 하기 검사 + 보스전)
Godot 로 화면 없이 돌린다 (scripts/godot_cmd.py 가 Godot 를 찾는다. 못 찾으면 환경 변수 GODOT).
"""
import argparse
import fnmatch
import csv
import datetime as dt
import json
import pathlib
import subprocess
import sys
import time

ROOT = pathlib.Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))
import godot_cmd  # noqa: E402

ORDER = ["p0", "p1", "boss"]


def git(*args):
    r = subprocess.run(["git", *args], cwd=ROOT, capture_output=True, text=True, encoding="utf-8", errors="replace")
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
    cfg = json.loads((ROOT / "test_map.json").read_text(encoding="utf-8"))
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


def write_boss_report(rows):
    stamp = dt.datetime.now().strftime("%Y-%m-%d_%H%M%S")
    out = ROOT / "reports" / "boss"
    out.mkdir(parents=True, exist_ok=True)
    (out / f"{stamp}.json").write_text(json.dumps(rows, ensure_ascii=False, indent=2), encoding="utf-8")
    hist = out / "history.csv"
    new = not hist.exists()
    with hist.open("a", newline="", encoding="utf-8") as f:
        wr = csv.writer(f)
        if new:
            wr.writerow(["datetime", "boss", "seed", "cleared", "time_s", "hp_lost", "echo_hp_left"])
        for r in rows:
            wr.writerow([stamp, r["boss"], r["seed"], r["cleared"], r["time_s"], r["hp_lost"], r.get("echo_hp_left", "")])
    for r in rows:
        mark = "깸" if r["cleared"] else "못 깸"
        print(f"  {r['boss']:<14} seed={r['seed']}  {mark:<4} {r['time_s']:>6}초  잃은 체력 {r['hp_lost']}")
    print(f"  기록: reports/boss/{stamp}.json")


def run_stage(stage, record=True):
    t = time.time()
    print(f"\n[{stage}] 시작")
    code, lines, results = godot_cmd.run_script("res://tests/run_tests.gd", [stage])
    for line in lines:
        print(line)
    if stage == "boss" and results and record:
        write_boss_report(results)
    ok = code == 0
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
    results = {s: run_stage(s, record=not a.staged) for s in stages}  # 커밋 전 검사는 기록을 남기지 않는다
    print("\n결과: " + "  ".join(f"{s}={'통과' if v else '실패'}" for s, v in results.items()))
    return 0 if all(results.values()) else 1


if __name__ == "__main__":
    sys.exit(main())
