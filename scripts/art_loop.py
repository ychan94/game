#!/usr/bin/env python3
"""그림 작업 루프 도구. 회차 관리·스냅샷·자동 측정·검토 점수·멈춤 판단.

    python3 scripts/art_loop.py start  <작업> --max-rounds 6 --patience 2
    python3 scripts/art_loop.py snap   <작업> <그림 파일...>      # 이번 회차 스냅샷 + 자동 측정
    python3 scripts/art_loop.py score  <작업> <검토자> <점수.json> # {"ai_tell": 1~10, "style_fit": 1~10, "comment": "..."}
    python3 scripts/art_loop.py status <작업>                      # 계속/멈춤 판단 + 비교 시트

작업 폴더: work/art-<작업>/  (loop.json, NOTES.md, round_01/ ...)
점수: ai_tell 은 높을수록 AI 티가 덜 남, style_fit 은 높을수록 우리 그림체와 어울림.
"""
import argparse
import datetime as dt
import json
import pathlib
import shutil
import sys
from collections import deque

import numpy as np
from PIL import Image, ImageDraw

ROOT = pathlib.Path(__file__).resolve().parents[1]
CFG = json.loads((ROOT / "art" / "loop_config.json").read_text(encoding="utf-8"))


# ---------------- 셀 수 있는 것: 스크립트로 잰다 ----------------
def ink_mask(img):
    """선/색이 칠해진 픽셀. 투명도가 있으면 알파, 없으면 밝기 기준."""
    a = np.asarray(img.convert("RGBA"), dtype=np.int16)
    if (a[..., 3] < 250).mean() > 0.01:
        return a[..., 3] > CFG["alpha_threshold"]
    lum = 0.299 * a[..., 0] + 0.587 * a[..., 1] + 0.114 * a[..., 2]
    return lum < CFG["ink_threshold"]


def components(mask):
    h, w = mask.shape
    label = np.zeros((h, w), dtype=np.int32)
    sizes, cur = [0], 0
    ys, xs = np.nonzero(mask)
    for y0, x0 in zip(ys, xs):
        if label[y0, x0]:
            continue
        cur += 1
        label[y0, x0] = cur
        q, n = deque([(y0, x0)]), 0
        while q:
            y, x = q.popleft()
            n += 1
            for yy in (y - 1, y, y + 1):
                for xx in (x - 1, x, x + 1):
                    if 0 <= yy < h and 0 <= xx < w and mask[yy, xx] and not label[yy, xx]:
                        label[yy, xx] = cur
                        q.append((yy, xx))
        sizes.append(n)
    return label, sizes


def thin(mask):
    """Zhang-Suen 세선화 (선을 1픽셀 뼈대로)."""
    m = np.pad(mask.astype(np.uint8), 1)
    while True:
        changed = False
        for step in (0, 1):
            P = [np.roll(np.roll(m, -dy, 0), -dx, 1) for dy, dx in
                 ((-1, 0), (-1, 1), (0, 1), (1, 1), (1, 0), (1, -1), (0, -1), (-1, -1))]
            B = sum(P)
            A = sum(((P[i] == 0) & (P[(i + 1) % 8] == 1)).astype(np.uint8) for i in range(8))
            if step == 0:
                c = (P[0] * P[2] * P[4] == 0) & (P[2] * P[4] * P[6] == 0)
            else:
                c = (P[0] * P[2] * P[6] == 0) & (P[0] * P[4] * P[6] == 0)
            rm = (m == 1) & (B >= 2) & (B <= 6) & (A == 1) & c
            if rm.any():
                m[rm] = 0
                changed = True
        if not changed:
            return m[1:-1, 1:-1].astype(bool)


def measure(path):
    img = Image.open(path)
    mask = ink_mask(img)
    label, sizes = components(mask)
    speck = [i for i, s in enumerate(sizes) if i and s < CFG["speck_max_px"]]
    # 끊긴 선: 뼈대 끝점끼리 가까운데(gap 이하) 서로 다른 덩어리에 속한 쌍
    sk = thin(mask)
    nb = sum(np.roll(np.roll(np.pad(sk, 1), dy, 0), dx, 1)[1:-1, 1:-1].astype(int)
             for dy in (-1, 0, 1) for dx in (-1, 0, 1) if dy or dx)
    ey, ex = np.nonzero(sk & (nb == 1))
    big = {i for i, s in enumerate(sizes) if i and s >= CFG["speck_max_px"]}
    pts = [(y, x, label[y, x]) for y, x in zip(ey, ex) if label[y, x] in big]
    gap = CFG["break_gap_px"]
    breaks, used = 0, set()
    for i, (y1, x1, l1) in enumerate(pts):
        if i in used:
            continue
        for j in range(i + 1, len(pts)):
            y2, x2, l2 = pts[j]
            if j not in used and l1 != l2 and abs(y1 - y2) <= gap and abs(x1 - x2) <= gap:
                breaks += 1
                used |= {i, j}
                break
    return {"speckles": len(speck), "broken_lines": breaks, "size": list(img.size)}


# ---------------- 루프 상태 ----------------
def task_dir(task):
    return ROOT / "work" / f"art-{task}"


def load(task):
    p = task_dir(task) / "loop.json"
    if not p.exists():
        sys.exit(f"루프가 없습니다: {task}. 먼저 start 하세요.")
    return json.loads(p.read_text(encoding="utf-8"))


def save(task, st):
    (task_dir(task) / "loop.json").write_text(json.dumps(st, ensure_ascii=False, indent=2), encoding="utf-8")


def cmd_start(a):
    d = task_dir(a.task)
    d.mkdir(parents=True, exist_ok=True)
    st = {"task": a.task, "started": dt.date.today().isoformat(),
          "max_rounds": a.max_rounds, "patience": a.patience, "min_gain": a.min_gain, "rounds": []}
    save(a.task, st)
    notes = d / "NOTES.md"
    if not notes.exists():
        notes.write_text(f"# art-{a.task} 작업 메모\n\n## 목표 (사용자 말 그대로)\n\n## 작업 중 새로 정한 것\n", encoding="utf-8")
    print(f"루프 시작: {d.relative_to(ROOT)}  (최대 {a.max_rounds}회, {a.patience}회 연속 안 오르면 멈춤)")


def cmd_snap(a):
    st = load(a.task)
    n = len(st["rounds"]) + 1
    if n > st["max_rounds"]:
        sys.exit(f"회차 상한({st['max_rounds']}) 도달. status 로 결과를 사용자에게 보여 주세요.")
    rd = task_dir(a.task) / f"round_{n:02d}"
    rd.mkdir()
    files = {}
    for f in a.files:
        src = pathlib.Path(f)
        shutil.copy2(src, rd / src.name)
        files[src.name] = measure(rd / src.name)
    tot = {k: sum(v[k] for v in files.values()) for k in ("speckles", "broken_lines")}
    st["rounds"].append({"round": n, "time": dt.datetime.now().isoformat(timespec="minutes"),
                         "files": files, "metrics": tot, "reviews": {}})
    save(a.task, st)
    print(f"{n}회차 스냅샷: {rd.relative_to(ROOT)}  잡티 {tot['speckles']} / 끊긴 선 {tot['broken_lines']}")


def cmd_score(a):
    st = load(a.task)
    if not st["rounds"]:
        sys.exit("스냅샷이 없습니다.")
    data = json.loads(pathlib.Path(a.file).read_text(encoding="utf-8"))
    for k in ("ai_tell", "style_fit"):
        if not 1 <= float(data[k]) <= 10:
            sys.exit(f"{k} 는 1~10 이어야 합니다.")
    st["rounds"][-1]["reviews"][a.reviewer] = data
    save(a.task, st)
    print(f"{st['rounds'][-1]['round']}회차 검토 {a.reviewer}: AI 티 {data['ai_tell']} / 그림체 {data['style_fit']}")


def round_score(r):
    rv = list(r["reviews"].values())
    if len(rv) < 2:
        return None
    return sum((float(x["ai_tell"]) + float(x["style_fit"])) / 2 for x in rv) / len(rv)


def contact_sheet(task, st):
    rows = []
    for r in st["rounds"]:
        rd = task_dir(task) / f"round_{r['round']:02d}"
        ims = [Image.open(rd / f).convert("RGB") for f in r["files"]]
        rows.append((r, ims))
    th = 220
    width = max(sum(int(im.width * th / im.height) + 8 for im in ims) for _, ims in rows) + 260
    sheet = Image.new("RGB", (width, (th + 16) * len(rows)), "white")
    dr = ImageDraw.Draw(sheet)
    for i, (r, ims) in enumerate(rows):
        y = i * (th + 16) + 8
        s = round_score(r)
        dr.text((8, y), f"round {r['round']}\nscore {s:.2f}" if s is not None else f"round {r['round']}\nscore -", fill="black")
        dr.text((8, y + 40), f"speck {r['metrics']['speckles']}\nbreak {r['metrics']['broken_lines']}", fill="gray")
        x = 260
        for im in ims:
            t = im.resize((int(im.width * th / im.height), th))
            sheet.paste(t, (x, y))
            x += t.width + 8
    out = task_dir(task) / "rounds_sheet.png"
    sheet.save(out)
    return out


def cmd_status(a):
    st = load(a.task)
    best, best_round, stale = None, None, 0
    print(f"{'회차':<5}{'잡티':>6}{'끊긴선':>8}{'검토평균':>10}  검토자")
    for r in st["rounds"]:
        s = round_score(r)
        names = ", ".join(r["reviews"]) or "-"
        print(f"{r['round']:<5}{r['metrics']['speckles']:>6}{r['metrics']['broken_lines']:>8}"
              f"{(f'{s:.2f}' if s is not None else '-'):>10}  {names}")
        if s is None:
            continue
        if best is None or s >= best + st["min_gain"]:
            best, best_round, stale = s, r["round"], 0
        else:
            stale += 1
    last = st["rounds"][-1] if st["rounds"] else None
    if last and round_score(last) is None:
        decision = "검토 대기 (처음 보는 검토자 2명 점수가 필요)"
    elif last and last["round"] >= st["max_rounds"]:
        decision = "멈춤: 회차 상한"
    elif stale >= st["patience"]:
        decision = f"멈춤: {stale}회 연속 점수가 안 오름"
    else:
        decision = "계속"
    if st["rounds"]:
        print(f"\n비교 시트: {contact_sheet(a.task, st).relative_to(ROOT)}")
    scored = [(round_score(r), r["round"]) for r in st["rounds"] if round_score(r) is not None]
    if scored:
        s, n = max(scored)
        print(f"최고 점수: {n}회차 ({s:.2f})  ※ {st['min_gain']}점 이상 올라야 '올랐다'로 친다")
    print(f"판단: {decision}")
    return 0


def main():
    ap = argparse.ArgumentParser()
    sub = ap.add_subparsers(dest="cmd", required=True)
    p = sub.add_parser("start"); p.add_argument("task")
    p.add_argument("--max-rounds", type=int, default=CFG["max_rounds"])
    p.add_argument("--patience", type=int, default=CFG["patience"])
    p.add_argument("--min-gain", type=float, default=CFG["min_gain"])
    p = sub.add_parser("snap"); p.add_argument("task"); p.add_argument("files", nargs="+")
    p = sub.add_parser("score"); p.add_argument("task"); p.add_argument("reviewer"); p.add_argument("file")
    p = sub.add_parser("status"); p.add_argument("task")
    p = sub.add_parser("measure"); p.add_argument("files", nargs="+")
    a = ap.parse_args()
    if a.cmd == "measure":
        for f in a.files:
            print(f, measure(f))
        return 0
    return {"start": cmd_start, "snap": cmd_snap, "score": cmd_score, "status": cmd_status}[a.cmd](a) or 0


if __name__ == "__main__":
    sys.exit(main())
