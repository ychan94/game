"""보스 봇: 플레이어 조작(이동·공격·구르기)만 쓰고, 화면에 보이는 정보(observe)만 읽는다.

결과: 보스마다 깼는지, 걸린 시간(초), 잃은 체력 → reports/boss/
"""
import csv
import datetime as dt
import json
import math
import pathlib
import sys

ROOT = pathlib.Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))

from sim.game import BOSSES, FPS, World  # noqa: E402

SEEDS = (1, 2, 3)
TIME_LIMIT_S = 180


def decide(obs):
    px, py, _ = obs["player"]
    move, attack, dodge = (0.0, 0.0), False, False
    b = obs["boss"]

    # 가까운 투사체·잡몹 피하기
    for qx, qy, vx, vy in obs["projectiles"]:
        if math.hypot(qx - px, qy - py) < 50 and (px - qx) * vx + (py - qy) * vy > 0:
            return {"move": (-vy, vx), "attack": False, "dodge": obs["dodge_ready"]}
    near = [(ex, ey) for ex, ey in obs["enemies"] if math.hypot(ex - px, ey - py) < 60]
    if near and obs["attack_ready"]:
        attack = True

    if b is None:
        return {"move": move, "attack": attack, "dodge": dodge}
    dx, dy = b["x"] - px, b["y"] - py
    d = math.hypot(dx, dy) or 1.0
    if b["state"] == "telegraph" and b["target"]:
        # 예고된 돌진 선에서 옆으로 비켜서기
        tx, ty = b["target"]
        lx, ly = tx - b["x"], ty - b["y"]
        side = 1 if (lx * (py - b["y"]) - ly * (px - b["x"])) >= 0 else -1
        ln = math.hypot(lx, ly) or 1.0
        move = (-ly / ln * side, lx / ln * side)
    elif b["state"] == "dash":
        move = (-dy / d, dx / d)
        dodge = d < 60 and obs["dodge_ready"]  # 너무 일찍 구르면 무적이 끝난 뒤 맞는다
    elif b["state"] == "recover":
        # 공격 사거리(약 80) 안, 몸이 닿는 거리(46) 밖에서 때린다
        danger = any(math.hypot(qx - px, qy - py) < 90 for qx, qy, _, _ in obs["projectiles"])
        if danger:
            move = (-dx / d, -dy / d)  # 탄막이 지나갈 때까지 물러선다
        elif d > 70:
            move = (dx / d, dy / d)
        elif d < 58:
            move = (-dx / d, -dy / d)
        attack = attack or (d < 78 and obs["attack_ready"])
    else:  # idle: 공격 사거리 끝(60~75)에 붙어 돌면서 때린다
        if d > 75:
            move = (dx / d, dy / d)
        elif d < 60:
            move = (-dx / d, -dy / d)
        else:
            move = (-dy / d, dx / d)
    if b["state"] != "dash" and d < 78 and obs["attack_ready"]:
        attack = True  # 사거리 안이면 어느 상태든 때린다
    return {"move": move, "attack": attack, "dodge": dodge}


def fight(boss, seed):
    w = World(seed=seed, scene=f"boss:{boss}")
    start_hp = w.player.hp
    while not w.done and w.frame < TIME_LIMIT_S * FPS:
        w.step(decide(w.observe()))
    return {
        "boss": boss, "seed": seed,
        "cleared": w.result == "win",
        "time_s": round(w.frame / FPS, 2),
        "hp_lost": start_hp - max(w.player.hp, 0),
        "result": w.result or "timeout",
    }


def main():
    rows = [fight(b, s) for b in BOSSES for s in SEEDS]
    stamp = dt.datetime.now().strftime("%Y-%m-%d_%H%M%S")
    out = ROOT / "reports" / "boss"
    out.mkdir(parents=True, exist_ok=True)
    (out / f"{stamp}.json").write_text(json.dumps(rows, ensure_ascii=False, indent=2), encoding="utf-8")
    hist = out / "history.csv"
    new = not hist.exists()
    with hist.open("a", newline="", encoding="utf-8") as f:
        wr = csv.writer(f)
        if new:
            wr.writerow(["datetime", "boss", "seed", "cleared", "time_s", "hp_lost"])
        for r in rows:
            wr.writerow([stamp, r["boss"], r["seed"], r["cleared"], r["time_s"], r["hp_lost"]])
    for r in rows:
        mark = "깸" if r["cleared"] else "못 깸"
        print(f"  {r['boss']:<12} seed={r['seed']}  {mark:<4} {r['time_s']:>6}초  잃은 체력 {r['hp_lost']}")
    failed = [r for r in rows if not r["cleared"]]
    print(f"  기록: reports/boss/{stamp}.json")
    return 1 if failed else 0


if __name__ == "__main__":
    sys.exit(main())
