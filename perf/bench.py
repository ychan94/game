#!/usr/bin/env python3
"""성능 측정판: 적이 제일 많은 장면을 시드 고정으로 재현한다.

    python3 perf/bench.py profile              # 함수(시스템)별 프레임 시간 → 병목 찾기
    python3 perf/bench.py baseline             # 고치기 전: 결과 지문 저장
    python3 perf/bench.py compare              # 고친 뒤: 지문이 같은지 비교 (회귀 테스트)
    python3 perf/bench.py fps --note "무엇을 바꿨나"   # FPS 평균·1% 저점 → perf/records.csv

조건(장면·시드·적 수·프레임 수·입력)은 아래 상수로 고정한다. 바꾸면 이전 기록과 비교할 수 없다.
"""
import argparse
import csv
import datetime as dt
import json
import math
import pathlib
import platform
import statistics
import subprocess
import sys
import time

ROOT = pathlib.Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from sim.game import World  # noqa: E402

SCENE, SEED, ENEMIES, FRAMES, WARMUP = "max_enemies", 42, 400, 600, 30
HASH_EVERY = 30
BASELINE = ROOT / "perf" / "baselines" / f"{SCENE}-seed{SEED}-n{ENEMIES}.json"
RECORDS = ROOT / "perf" / "records.csv"


def scripted_input(frame):
    """사람 손 대신 고정된 입력: 원을 그리며 이동, 일정 간격으로 공격·구르기."""
    a = frame * 0.05
    return {"move": (math.cos(a), math.sin(a)), "attack": frame % 15 == 0, "dodge": frame % 120 == 0}


def run(profile=False):
    w = World(seed=SEED, scene=SCENE, enemy_count=ENEMIES)
    sys_time = {n: [] for n in World.SYSTEMS}
    frame_ms, hashes = [], []
    for f in range(FRAMES):
        w.inputs = scripted_input(f)
        t0 = time.perf_counter()
        if profile:
            for n in World.SYSTEMS:
                s = time.perf_counter()
                getattr(w, n)()
                sys_time[n].append((time.perf_counter() - s) * 1000)
            w.frame += 1
        else:
            w.step(scripted_input(f))
        frame_ms.append((time.perf_counter() - t0) * 1000)
        if f % HASH_EVERY == 0:
            hashes.append([f, w.state_hash(), len(w.enemies)])
    return frame_ms[WARMUP:], sys_time, hashes


def fps_stats(frame_ms):
    avg_fps = 1000 / statistics.mean(frame_ms)
    worst = sorted(frame_ms, reverse=True)[: max(1, len(frame_ms) // 100)]
    low1 = 1000 / statistics.mean(worst)
    return avg_fps, low1


def cmd_profile(_):
    frame_ms, sys_time, _ = run(profile=True)
    total = sum(sum(v) for v in sys_time.values())
    print(f"장면 {SCENE} / 시드 {SEED} / 적 {ENEMIES} / {FRAMES}프레임")
    print(f"{'함수':<22}{'평균 ms':>10}{'최대 ms':>10}{'비중':>8}")
    for n, v in sorted(sys_time.items(), key=lambda kv: -sum(kv[1])):
        print(f"{n:<22}{statistics.mean(v):>10.3f}{max(v):>10.3f}{sum(v) / total:>8.0%}")
    top = max(sys_time, key=lambda n: sum(sys_time[n]))
    print(f"\n병목: {top}")


def cmd_baseline(_):
    _, _, hashes = run()
    BASELINE.parent.mkdir(parents=True, exist_ok=True)
    BASELINE.write_text(json.dumps({"saved": dt.datetime.now().isoformat(timespec="seconds"),
                                    "commit": commit(), "hashes": hashes}, indent=1), encoding="utf-8")
    print(f"기준 저장: {BASELINE.relative_to(ROOT)} ({len(hashes)}개 지점)")


def cmd_compare(_):
    if not BASELINE.exists():
        print("기준이 없습니다. 고치기 전에 `python3 perf/bench.py baseline`을 먼저 돌리세요.")
        return 2
    base = json.loads(BASELINE.read_text(encoding="utf-8"))["hashes"]
    _, _, now = run()
    for (f, h0, n0), (_, h1, n1) in zip(base, now):
        if h0 != h1:
            print(f"회귀 실패: {f}프레임부터 결과가 다릅니다 (적 수 {n0} → {n1})")
            return 1
    print(f"회귀 통과: {len(now)}개 지점 모두 같음")
    return 0


def cmd_fps(a):
    runs = [fps_stats(run()[0]) for _ in range(a.repeat)]
    avg = statistics.median(r[0] for r in runs)
    low = statistics.median(r[1] for r in runs)
    new = not RECORDS.exists()
    with RECORDS.open("a", newline="", encoding="utf-8") as f:
        wr = csv.writer(f)
        if new:
            wr.writerow(["date", "commit", "scene", "seed", "enemies", "frames", "repeat",
                         "fps_avg", "fps_1pct_low", "machine", "note"])
        wr.writerow([dt.datetime.now().isoformat(timespec="minutes"), commit(), SCENE, SEED, ENEMIES,
                     FRAMES, a.repeat, f"{avg:.1f}", f"{low:.1f}", platform.node(), a.note])
    print(f"FPS 평균 {avg:.1f} / 1% 저점 {low:.1f}  (같은 조건 {a.repeat}회 중앙값) → perf/records.csv")


def commit():
    r = subprocess.run(["git", "rev-parse", "--short", "HEAD"], cwd=ROOT, capture_output=True, text=True, encoding="utf-8", errors="replace")
    dirty = subprocess.run(["git", "status", "--porcelain", "sim"], cwd=ROOT, capture_output=True, text=True, encoding="utf-8", errors="replace").stdout
    return (r.stdout.strip() or "none") + ("+수정중" if dirty.strip() else "")


def main():
    ap = argparse.ArgumentParser()
    sub = ap.add_subparsers(dest="cmd", required=True)
    sub.add_parser("profile")
    sub.add_parser("baseline")
    sub.add_parser("compare")
    p = sub.add_parser("fps")
    p.add_argument("--repeat", type=int, default=3)
    p.add_argument("--note", default="")
    a = ap.parse_args()
    return {"profile": cmd_profile, "baseline": cmd_baseline, "compare": cmd_compare, "fps": cmd_fps}[a.cmd](a) or 0


if __name__ == "__main__":
    sys.exit(main())
