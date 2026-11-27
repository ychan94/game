#!/usr/bin/env python3
"""Codex가 만든 그림 검사 (Claude가 Codex 작업 뒤에 돌린다).

    python3 scripts/check_sprites.py                 # art/sprite_list.json 의 모든 그림 검사
    python3 scripts/check_sprites.py --group "가마의 병사"
    python3 scripts/check_sprites.py --sheet <출력.png>   # 모든 그림을 4배로 키운 비교 시트도 만든다

검사: 파일 있음 · 크기 정확 · 투명 배경(타일 제외, 네 모서리 투명) · 색 수 (픽셀 아트) · 흐린 가장자리(반투명 픽셀 비율)
"""
import argparse
import json
import pathlib
import sys

from PIL import Image, ImageDraw

ROOT = pathlib.Path(__file__).resolve().parents[1]
MAX_COLORS = 24
MAX_SEMI = 0.02   # 반투명 픽셀이 2% 넘으면 '흐린 가장자리'(픽셀 아트 아님)


def check(entry):
    path = ROOT / entry["path"]
    problems = []
    if not path.exists():
        return ["없음"], None
    img = Image.open(path).convert("RGBA")
    w, h = entry["size"]
    if img.size != (w, h):
        problems.append(f"크기 {img.size[0]}×{img.size[1]} (필요 {w}×{h})")
    px = list(img.get_flattened_data() if hasattr(img, "get_flattened_data") else img.getdata())
    if not entry.get("tile"):
        corners = [img.getpixel((0, 0)), img.getpixel((img.width - 1, 0)),
                   img.getpixel((0, img.height - 1)), img.getpixel((img.width - 1, img.height - 1))]
        if any(c[3] > 10 for c in corners):
            problems.append("배경이 투명하지 않음")
        opaque = [p for p in px if p[3] > 200]
        if len(opaque) < len(px) * 0.05:
            problems.append("거의 비어 있음")
    semi = sum(1 for p in px if 20 < p[3] < 235)
    if semi > len(px) * MAX_SEMI:
        problems.append(f"흐린 가장자리 {semi * 100 // len(px)}% (픽셀 아트는 반투명이 거의 없어야)")
    colors = len({p[:3] for p in px if p[3] > 200})
    if colors > MAX_COLORS:
        problems.append(f"색 {colors}개 (최대 {MAX_COLORS})")
    return problems, img


def make_sheet(results, out):
    cell, pad = 4, 8
    rows = []
    for entry, img in results:
        if img is not None:
            rows.append((entry, img.resize((img.width * cell, img.height * cell), Image.NEAREST)))
    if not rows:
        return
    per_row = 6
    col_w = max(r[1].width for r in rows) + pad
    row_h = max(r[1].height for r in rows) + 24
    n_rows = (len(rows) + per_row - 1) // per_row
    sheet = Image.new("RGBA", (col_w * per_row + pad, row_h * n_rows + pad), (40, 36, 48, 255))
    d = ImageDraw.Draw(sheet)
    for i, (entry, big) in enumerate(rows):
        x, y = pad + (i % per_row) * col_w, pad + (i // per_row) * row_h
        sheet.alpha_composite(big, (x, y))
        d.text((x, y + big.height + 4), pathlib.Path(entry["path"]).stem, fill=(220, 220, 220, 255))
    sheet.save(out)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--group")
    ap.add_argument("--sheet")
    a = ap.parse_args()
    spec = json.loads((ROOT / "art" / "sprite_list.json").read_text(encoding="utf-8"))
    entries = [e for e in spec["files"] if not a.group or e["group"] == a.group]
    ok = missing = bad = 0
    results = []
    for e in entries:
        problems, img = check(e)
        results.append((e, img))
        if problems == ["없음"]:
            missing += 1
            print(f"  없음   {e['path']}")
        elif problems:
            bad += 1
            print(f"  문제   {e['path']}: " + " · ".join(problems))
        else:
            ok += 1
    print(f"\n그림 {len(entries)}개: 통과 {ok} · 문제 {bad} · 없음 {missing}")
    if a.sheet:
        make_sheet(results, a.sheet)
        print(f"비교 시트: {a.sheet}")
    return 0 if bad == 0 and missing == 0 else 1


if __name__ == "__main__":
    sys.exit(main())
