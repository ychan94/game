#!/usr/bin/env python3
"""성능 측정판: 적이 가장 많은 장면(120마리 + 어제의 나)을 시드 고정으로 재현한다.
실제 측정은 Godot 의 tests/bench.gd 가 하고, 여기서는 기록·비교만 한다.

    python3 perf/bench.py profile              # 함수(시스템)별 프레임 시간 → 병목 찾기
    python3 perf/bench.py baseline             # 고치기 전: 결과 지문 저장
    python3 perf/bench.py compare              # 고친 뒤: 지문이 같은지 비교 (회귀 테스트)
    python3 perf/bench.py fps --note "무엇을 바꿨나"   # 규칙 계산 FPS 평균·1% 저점 → perf/records.csv

조건(장면·시드·적 수·프레임 수·입력)은 tests/bench.gd 맨 위 상수로 고정한다.
※ 화면 그리기는 빼고 '규칙 계산'만 잰다. 그리기 성능은 실제 게임 창에서 따로 본다.
"""
import argparse
import csv
import datetime as dt
import json
import pathlib
import platform
import statistics
import subprocess
import sys

ROOT = pathlib.Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))
import godot_cmd  # noqa: E402

BASELINE = ROOT / "perf" / "baselines" / "max_enemies-seed42.json"
RECORDS = ROOT / "perf" / "records.csv"


def bench(mode):
    code, lines, results = godot_cmd.run_script("res://tests/bench.gd", [mode])
    if code != 0 or not results:
        print("\n".join(lines[-20:]))
        sys.exit("측정 실패")
    return results[0]


def fps_stats(frame_ms):
    avg = 1000 / statistics.mean(frame_ms)
    worst = sorted(frame_ms, reverse=True)[: max(1, len(frame_ms) // 100)]
    return avg, 1000 / statistics.mean(worst)


def commit():
    r = subprocess.run(["git", "rev-parse", "--short", "HEAD"], cwd=ROOT, capture_output=True, text=True, encoding="utf-8")
    dirty = subprocess.run(["git", "status", "--porcelain", "src"], cwd=ROOT, capture_output=True, text=True, encoding="utf-8").stdout
    return (r.stdout.strip() or "none") + ("+수정중" if dirty.strip() else "")


def cmd_profile(_):
    r = bench("profile")
    sysd = r["systems"]
    total = sum(v["total_ms"] for v in sysd.values())
    print(f"시드 {r['seed']} / 적 {sum(r['enemies'].values())} + 어제의 나 / {r['frames']}프레임")
    print(f"{'함수':<22}{'평균 ms':>10}{'최대 ms':>10}{'비중':>8}")
    for n, v in sorted(sysd.items(), key=lambda kv: -kv[1]["total_ms"]):
        print(f"{n:<22}{v['avg_ms']:>10.3f}{v['max_ms']:>10.3f}{v['total_ms'] / total:>8.0%}")
    print(f"\n병목: {max(sysd, key=lambda n: sysd[n]['total_ms'])}")


def cmd_baseline(_):
    r = bench("run")
    BASELINE.parent.mkdir(parents=True, exist_ok=True)
    BASELINE.write_text(json.dumps({"saved": dt.datetime.now().isoformat(timespec="seconds"), "commit": commit(),
                                    "hashes": r["hashes"]}, indent=1), encoding="utf-8")
    print(f"기준 저장: {BASELINE.relative_to(ROOT)} ({len(r['hashes'])}개 지점)")


def cmd_compare(_):
    if not BASELINE.exists():
        print("기준이 없습니다. 고치기 전에 `python3 perf/bench.py baseline` 을 먼저 돌리세요.")
        return 2
    base = json.loads(BASELINE.read_text(encoding="utf-8"))["hashes"]
    now = bench("run")["hashes"]
    for (f, h0, n0), (_, h1, n1) in zip(base, now):
        if h0 != h1:
            print(f"회귀 실패: {f}프레임부터 결과가 다릅니다 (남은 적 {n0} → {n1})")
            return 1
    print(f"회귀 통과: {len(now)}개 지점 모두 같음")
    return 0


def cmd_fps(a):
    runs = [fps_stats(bench("run")["frame_ms"]) for _ in range(a.repeat)]
    avg = statistics.median(r[0] for r in runs)
    low = statistics.median(r[1] for r in runs)
    new = not RECORDS.exists()
    with RECORDS.open("a", newline="", encoding="utf-8") as f:
        wr = csv.writer(f)
        if new:
            wr.writerow(["date", "commit", "scene", "seed", "frames", "repeat", "fps_avg", "fps_1pct_low", "machine", "note"])
        wr.writerow([dt.datetime.now().isoformat(timespec="minutes"), commit(), "max_enemies", 42, 600, a.repeat,
                     f"{avg:.1f}", f"{low:.1f}", platform.node(), a.note])
    print(f"규칙 계산 FPS 평균 {avg:.1f} / 1% 저점 {low:.1f}  (같은 조건 {a.repeat}회 중앙값) → perf/records.csv")


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
