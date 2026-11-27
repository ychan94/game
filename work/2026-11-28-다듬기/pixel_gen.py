#!/usr/bin/env python3
"""새 병사 6종(장수·신궁·해치·처용·청룡·불가사리)의 32×32 도트를 격자로 설계하고
src/game/pixel_art.gd (게임이 그림 파일이 없을 때 쓰는 도트) 와 미리보기 PNG 를 만든다.

    python3 work/2026-11-28-다듬기/pixel_gen.py [미리보기.png]

글자 = 색: . 투명 o 윤곽 L/G/D 유약 밝음/기본/어둠 w 흰 광택 f 얼굴(회색) F 얼굴 밝음
          p/P 받침 b/B 나무 y/Y 금 k 검정 r/R 붉은 탈 m/M 쇠 c 크림 n 불꽃
"""
import sys, pathlib
W = H = 32
SPR = {}


class Grid:
    def __init__(s, w=32, h=32):
        s.w, s.h = w, h
        s.g = [["."] * w for _ in range(h)]

    def px(s, x, y, c):
        if 0 <= x < s.w and 0 <= y < s.h:
            s.g[y][x] = c

    def rect(s, x0, y0, x1, y1, c):
        for y in range(y0, y1 + 1):
            for x in range(x0, x1 + 1):
                s.px(x, y, c)

    def ell(s, cx, cy, rx, ry, c):
        for y in range(s.h):
            for x in range(s.w):
                if ((x - cx) / (rx + 0.5)) ** 2 + ((y - cy) / (ry + 0.5)) ** 2 <= 1.0:
                    s.px(x, y, c)

    def line(s, x0, y0, x1, y1, c):
        dx, dy = abs(x1 - x0), -abs(y1 - y0)
        sx, sy = (1 if x0 < x1 else -1), (1 if y0 < y1 else -1)
        e = dx + dy
        while True:
            s.px(x0, y0, c)
            if x0 == x1 and y0 == y1:
                break
            e2 = 2 * e
            if e2 >= dy:
                e += dy; x0 += sx
            if e2 <= dx:
                e += dx; y0 += sy

    def outline(s):
        add = []
        for y in range(s.h):
            for x in range(s.w):
                if s.g[y][x] != ".":
                    continue
                for dx, dy in ((1, 0), (-1, 0), (0, 1), (0, -1)):
                    xx, yy = x + dx, y + dy
                    if 0 <= xx < s.w and 0 <= yy < s.h and s.g[yy][xx] not in ".o":
                        add.append((x, y)); break
        for x, y in add:
            s.g[y][x] = "o"

    def shade_bottom(s, ch="G", to="D"):
        """윤곽 바로 위(아래쪽 가장자리) 유약 칸을 어둡게 — 둥근 도자기 느낌"""
        for y in range(s.h - 1):
            for x in range(s.w):
                if s.g[y][x] == ch and s.g[y + 1][x] in ".o":
                    s.g[y][x] = to

    def shade_top(s, ch="G", to="L"):
        for y in range(1, s.h):
            for x in range(s.w):
                if s.g[y][x] == ch and s.g[y - 1][x] in ".o":
                    s.g[y][x] = to

    def light(s, ch="G"):
        """왼쪽 위에서 오는 빛: 왼쪽·위 가장자리는 밝게, 오른쪽·아래 가장자리는 어둡게"""
        lit, dark = [], []
        for y in range(s.h):
            for x in range(s.w):
                if s.g[y][x] != ch:
                    continue
                up = s.g[y - 1][x] if y > 0 else "."
                lf = s.g[y][x - 1] if x > 0 else "."
                dn = s.g[y + 1][x] if y < s.h - 1 else "."
                rt = s.g[y][x + 1] if x < s.w - 1 else "."
                if up in ".o" or lf in ".o":
                    lit.append((x, y))
                elif dn in ".o" or rt in ".o":
                    dark.append((x, y))
        for x, y in lit:
            s.g[y][x] = "L"
        for x, y in dark:
            s.g[y][x] = "D"

    def curl(s, cx, cy, c="D", hi="L"):
        """갈기·구름 소용돌이 한 개 (3×3 고리 + 밝은 점)"""
        for dx, dy in ((-1, 0), (-1, -1), (0, -1), (1, -1), (1, 0), (1, 1), (0, 1)):
            s.px(cx + dx, cy + dy, c)
        s.px(cx, cy, hi)

    def rows(s):
        return ["".join(r) for r in s.g]


def pedestal(g, x0=10, x1=20, y=26):
    g.rect(x0 + 1, y, x1 - 1, y, "P")
    g.rect(x0, y + 1, x1, y + 1, "p")


def doll_body(g, robe_dark=True):
    # 옷자락(아래로 퍼짐) + 몸통
    for i, y in enumerate(range(17, 25)):
        g.rect(12 - i // 3, y, 18 + i // 3, y, "G")
    g.rect(12, 24, 14, 25, "D"); g.rect(16, 24, 18, 25, "D")
    g.px(15, 25, ".")
    g.rect(13, 14, 17, 17, "G")


# ---------- 장수: 쇠 투구·금 장식·어깨 갑옷·허리띠, 등 뒤 깃발, 오른손 칼 ----------
def general():
    g = Grid()
    # 깃발 (등 뒤 왼쪽)
    g.line(8, 2, 8, 25, "b")
    g.rect(2, 3, 7, 8, "G"); g.rect(2, 3, 7, 3, "L")
    g.px(1, 4, "G"); g.px(1, 7, "G"); g.rect(4, 5, 5, 6, "y")
    doll_body(g)
    g.rect(11, 19, 19, 19, "y")              # 금 허리띠
    g.px(15, 19, "Y")
    # 갑옷 비늘 줄
    for y in (21, 23):
        for x in range(12, 19, 2):
            g.px(x, y, "D")
    # 어깨 갑옷
    g.rect(10, 13, 13, 15, "m"); g.rect(17, 13, 20, 15, "m")
    g.rect(10, 13, 13, 13, "M"); g.rect(17, 13, 20, 13, "M")
    g.rect(13, 14, 17, 18, "G"); g.px(13, 15, "w")
    # 얼굴
    g.rect(12, 9, 18, 12, "f"); g.rect(12, 9, 18, 9, "F")
    g.px(17, 10, "k"); g.px(18, 12, "k")      # 눈·수염 끝
    g.rect(15, 12, 17, 12, "k")              # 수염
    # 투구
    g.ell(15, 6, 4, 3, "m"); g.rect(11, 8, 19, 8, "y")
    g.rect(12, 4, 14, 5, "M")
    g.line(15, 1, 15, 3, "y"); g.px(14, 1, "y"); g.px(16, 0, "L"); g.px(17, 0, "L")   # 금 술·깃
    # 칼 (오른손)
    g.rect(20, 16, 21, 17, "f")              # 손
    g.line(22, 6, 22, 15, "M"); g.px(22, 5, "w")
    g.rect(21, 16, 23, 16, "y"); g.px(22, 17, "b"); g.px(22, 18, "y")
    pedestal(g)
    g.outline()
    g.shade_bottom()
    return g


# ---------- 신궁: 검은 갓, 몸보다 큰 활(금빛 시위), 등에 화살통, 당긴 화살 ----------
def sniper():
    g = Grid()
    # 화살통 (등)
    g.rect(9, 12, 10, 20, "b"); g.rect(9, 12, 10, 12, "B")
    g.px(8, 10, "w"); g.px(10, 10, "w"); g.px(9, 11, "M"); g.px(11, 11, "w")
    doll_body(g)
    g.rect(12, 18, 18, 18, "D")
    g.px(13, 14, "w")
    # 얼굴
    g.rect(12, 9, 18, 12, "f"); g.rect(12, 9, 18, 9, "F")
    g.px(17, 10, "k")
    # 갓
    g.rect(9, 8, 21, 8, "k"); g.rect(13, 4, 17, 7, "k"); g.rect(13, 7, 17, 7, "y")
    g.px(19, 9, "k"); g.px(19, 10, "k")      # 갓끈
    # 큰 활 (오른쪽 호)
    import math
    pts = []
    for y in range(2, 27):
        t = (y - 14) / 12.0
        x = int(round(27 - 4 * (t * t)))
        pts.append((x, y))
    for x, y in pts:
        g.px(x, y, "b")
        g.px(x - 1, y, "B") if abs(y - 14) < 9 else None
    g.px(23, 2, "y"); g.px(23, 26, "y")
    g.line(23, 3, 20, 14, "y"); g.line(20, 14, 23, 25, "y")   # 당긴 시위
    # 화살
    g.line(17, 14, 29, 14, "M"); g.px(30, 14, "w"); g.px(29, 13, "w"); g.px(29, 15, "w")
    g.px(18, 13, "L"); g.px(18, 15, "L")     # 깃
    g.rect(18, 15, 20, 16, "f")              # 손
    pedestal(g)
    g.outline()
    g.shade_bottom()
    return g


# ---------- 처용: 붉은 처용 탈, 사모, 너울대는 긴 소매로 춤 ----------
def cheoyong():
    g = Grid()
    # 긴 소매: 왼쪽은 아래로 휘날리고, 오른쪽은 위로 들어 춤춘다
    for k in range(4):   # 왼쪽 소매: 아래로 넓게 흘러내림
        g.line(12, 14 + k, 5 - k // 2, 18 + k, "G" if k < 3 else "L")
    g.rect(2, 21, 5, 22, "L"); g.px(3, 23, "L")
    for k in range(4):   # 오른쪽 소매: 위로 들어 휘날림
        g.line(18, 13 + k, 25, 7 + k, "G" if k < 3 else "L")
    g.rect(25, 5, 27, 7, "L"); g.px(28, 5, "L")
    doll_body(g)
    g.rect(12, 18, 18, 18, "y")
    g.px(13, 14, "w")
    # 큰 탈
    g.ell(15, 9, 4, 4, "r")
    g.rect(12, 7, 14, 7, "k"); g.rect(16, 7, 18, 7, "k")        # 짙은 눈썹
    g.px(13, 8, "c"); g.px(17, 8, "c")                          # 눈
    g.px(14, 10, "R"); g.px(16, 10, "R")                        # 볼
    g.rect(13, 11, 17, 11, "c"); g.px(15, 11, "k")              # 웃는 이
    g.px(12, 6, "R"); g.px(18, 6, "R")
    # 사모 (검은 모자 + 양 날개)
    g.rect(12, 2, 18, 4, "k"); g.rect(13, 1, 17, 1, "k")
    g.rect(8, 3, 11, 3, "k"); g.rect(19, 3, 22, 3, "k")
    g.px(14, 2, "y"); g.px(16, 2, "y")                          # 꽃 장식
    g.px(15, 1, "n")
    pedestal(g)
    g.outline()
    g.shade_bottom()
    return g


# ---------- 해치: 곱슬 갈기의 네발 수호 짐승, 이마에 뿔 하나, 방울 목걸이 ----------
def haetae():
    g = Grid()
    g.ell(13, 18, 9, 5, "G")                  # 몸
    for x in (6, 10, 16, 20):                 # 다리
        g.rect(x, 22, x + 2, 26, "G")
        g.rect(x, 26, x + 2, 26, "D")
    g.ell(23, 12, 6, 6, "D")                  # 갈기 (뒤)
    for (x, y) in ((17, 7), (18, 16), (23, 5), (28, 8), (16, 11), (27, 17)):
        g.ell(x, y, 1, 1, "D")
    g.ell(24, 13, 4, 4, "G")                  # 얼굴
    g.rect(26, 15, 29, 17, "G")               # 주둥이
    g.rect(26, 17, 29, 17, "c"); g.px(27, 17, "w"); g.px(29, 17, "w")   # 이빨
    g.px(29, 15, "k")                         # 코
    g.rect(25, 12, 26, 12, "y"); g.px(26, 11, "k")                       # 눈 (금빛 + 검은 동공)
    g.line(23, 9, 25, 4, "y"); g.px(25, 3, "w")                          # 뿔 하나
    g.rect(19, 18, 22, 18, "y"); g.px(20, 19, "Y"); g.px(21, 19, "y")    # 방울 목걸이
    # 꼬리 (위로 말려 올라간 불꽃 모양)
    g.line(4, 17, 2, 13, "G"); g.line(2, 13, 4, 10, "G"); g.px(5, 10, "L"); g.px(4, 9, "L"); g.px(3, 9, "n")
    # 몸 무늬 (비늘 소용돌이)
    for x in (8, 12, 16):
        g.px(x, 17, "L"); g.px(x + 1, 18, "L")
    g.px(7, 15, "w")
    g.rect(5, 27, 25, 27, "p"); g.rect(6, 28, 24, 28, "P") if False else None
    g.outline()
    g.shade_bottom()
    g.shade_top("G", "L")
    return g


# ---------- 청룡: 구름 위에 떠 있는 구불구불한 용, 뿔·수염·등지느러미, 여의주 ----------
def dragon():
    g = Grid()
    import math
    path = []
    for i in range(0, 46):
        t = i / 45.0
        x = 3 + t * 20
        y = 17 + math.sin(t * math.pi * 2.2 + 0.6) * 5
        path.append((x, y, 2.6 - 0.9 * (1 - t) ** 2))
    for x, y, r in path:
        g.ell(round(x), round(y), max(1, round(r)), max(1, round(r)), "G")
    for x, y, r in path[::4]:                 # 배 (밝게)
        g.px(round(x), round(y + r - 0.5), "c")
    for x, y, r in path[2::5]:                # 등지느러미
        g.px(round(x), round(y - r - 1), "D")
    # 머리
    g.ell(25, 9, 3, 3, "G"); g.rect(27, 9, 30, 11, "G")
    g.rect(28, 11, 30, 11, "c"); g.px(29, 12, "w")
    g.px(26, 8, "y"); g.px(27, 8, "k")       # 눈
    g.line(23, 6, 21, 2, "y"); g.line(25, 6, 24, 2, "y")              # 두 뿔
    g.line(30, 10, 31, 13, "w")               # 수염
    g.line(24, 12, 22, 15, "w")
    g.px(22, 8, "D"); g.px(21, 9, "D")       # 갈기
    # 발톱
    g.px(9, 22, "y"); g.px(10, 23, "y"); g.px(18, 20, "y")
    # 여의주
    g.ell(28, 19, 2, 2, "c"); g.px(27, 18, "w")
    # 구름 받침
    for (x, y, r) in ((6, 27, 3), (11, 26, 3), (16, 27, 3), (21, 26, 3), (25, 27, 2)):
        g.ell(x, y, r, 2, "P")
    g.rect(4, 28, 26, 28, "p")
    g.outline()
    g.shade_bottom()
    g.shade_top("G", "L")
    return g


# ---------- 불가사리: 쇠를 먹는 덩치 짐승 — 곰 몸, 코끼리 코, 등에 쇠 가시 ----------
def bulgasari():
    g = Grid()
    g.ell(13, 17, 10, 7, "G")                 # 몸
    for x in (5, 10, 15, 20):
        g.rect(x, 22, x + 3, 26, "G"); g.rect(x, 26, x + 3, 26, "D")
        g.px(x, 26, "M"); g.px(x + 3, 26, "M")   # 쇠 발톱
    g.ell(24, 13, 5, 5, "G")                  # 머리
    g.rect(27, 14, 29, 20, "G"); g.px(30, 20, "G"); g.px(30, 19, "L")   # 코 (아래로 말림)
    g.px(26, 12, "y"); g.px(25, 12, "k")       # 눈
    g.line(25, 17, 23, 20, "c"); g.px(23, 20, "w")                       # 엄니
    g.px(21, 9, "D"); g.px(22, 8, "D")        # 귀
    # 등의 쇠 가시
    for (x, y) in ((6, 10), (10, 8), (14, 8), (18, 9), (21, 7)):
        g.line(x, y + 2, x, y - 2, "m"); g.px(x, y - 3, "M"); g.px(x - 1, y + 1, "m"); g.px(x + 1, y + 1, "m")
    # 쇠 비늘 무늬
    for x in range(6, 21, 4):
        g.px(x, 16, "m"); g.px(x + 1, 17, "M")
    g.px(6, 13, "w")
    g.rect(3, 27, 27, 27, "p")
    g.outline()
    g.shade_bottom()
    g.shade_top("G", "L")
    return g


# ===================== 높은 등급은 더 크게·더 화려하게 (전설 40×40, 신화 48×48) =====================
import math


def stone_base(g, x0, x1, y):
    g.rect(x0 + 2, y, x1 - 2, y, "P")
    g.rect(x0, y + 1, x1, y + 2, "p")
    for x in range(x0 + 2, x1 - 1, 4):
        g.px(x, y + 2, "m")


# ---------- 처용 (전설): 모란·복숭아 꽂은 사모, 큰 붉은 탈, 색동 한삼을 휘날리며 춤 ----------
def cheoyong():
    g = Grid(40, 40)
    # 한삼 (긴 흰 소매): 왼쪽은 아래로 크게 휘돌고, 오른쪽은 하늘로 뿌린다
    for i in range(22):
        t = i / 21.0
        x = 15 - 13 * t + math.sin(t * 3.0) * 2
        y = 19 + 14 * t - math.sin(t * 3.1) * 3
        g.ell(round(x), round(y), 1, 1, "c")
    for i in range(22):
        t = i / 21.0
        x = 25 + 12 * t + math.sin(t * 2.6) * 1.5
        y = 17 - 14 * t + math.sin(t * 3.4) * 2
        g.ell(round(x), round(y), 1, 1, "c")
    for k, c in enumerate(("r", "y", "G", "L")):          # 색동 (소매 시작)
        g.rect(13 - k, 18 + k, 14 - k, 19 + k, c)
        g.rect(25 + k, 16 - k, 26 + k, 17 - k, c)
    # 도포 (넓게 퍼지는 옷자락) + 금 테두리
    for i, y in enumerate(range(22, 35)):
        g.rect(15 - i // 2, y, 25 + i // 2, y, "G")
    g.rect(16, 16, 24, 22, "G")
    g.rect(9, 34, 31, 34, "y")
    g.line(20, 23, 20, 33, "Y")
    g.rect(15, 22, 25, 22, "y"); g.px(20, 22, "c")      # 금 띠 + 옥
    # 큰 탈
    g.ell(20, 11, 6, 6, "r")
    for y in range(6, 18):                                 # 오른쪽 아래 그늘
        for x in range(20, 27):
            if g.g[y][x] == "r" and (x - 20) + (y - 11) > 6:
                g.px(x, y, "R")
    g.rect(15, 8, 18, 8, "k"); g.rect(21, 8, 24, 8, "k")   # 굵은 눈썹
    g.rect(16, 9, 17, 10, "c"); g.px(17, 10, "k")          # 눈
    g.rect(22, 9, 23, 10, "c"); g.px(23, 10, "k")
    g.rect(19, 10, 21, 13, "R"); g.px(19, 12, "r")        # 큰 코
    g.rect(16, 15, 24, 15, "c"); g.px(18, 15, "k"); g.px(22, 15, "k")   # 웃는 이
    g.px(14, 12, "y"); g.px(26, 12, "y")                   # 금 귀고리
    g.px(14, 13, "y"); g.px(26, 13, "y")
    # 사모 + 모란·복숭아
    g.rect(15, 2, 25, 5, "k"); g.rect(16, 1, 24, 1, "k")
    g.rect(9, 4, 14, 4, "k"); g.rect(26, 4, 31, 4, "k")
    g.ell(17, 1, 1, 1, "n"); g.px(17, 1, "y")               # 모란
    g.ell(23, 1, 1, 1, "r"); g.px(23, 0, "c")               # 복숭아
    g.px(20, 0, "G"); g.px(19, 1, "L"); g.px(21, 1, "L")    # 잎
    stone_base(g, 11, 29, 35)
    g.outline()
    g.light("G")
    return g


# ---------- 해치 (전설): 곱슬 갈기 두른 수호 짐승, 금 뿔·방울 목걸이, 불꽃 꼬리, 비늘 ----------
def haetae():
    g = Grid(40, 40)
    g.ell(17, 25, 11, 7, "G")                               # 몸
    g.ell(26, 22, 6, 7, "G")                                # 앞가슴 (당당하게)
    for x, top in ((7, 28), (13, 29), (24, 28), (30, 27)):  # 다리
        g.rect(x, top, x + 3, 35, "G")
        g.rect(x - 1, 35, x + 4, 35, "D")
        g.px(x, 35, "y"); g.px(x + 3, 35, "y")              # 금 발톱
        g.curl(x + 1, top + 3, "D", "L")                     # 다리 곱슬털
    # 갈기: 머리 둘레 소용돌이
    g.ell(30, 13, 8, 8, "D")
    for a in range(0, 360, 40):
        r = math.radians(a)
        g.curl(round(30 + math.cos(r) * 8), round(13 + math.sin(r) * 8), "D", "L")
    g.ell(31, 14, 5, 5, "G")                                # 얼굴
    g.rect(33, 16, 38, 19, "G")                             # 주둥이
    g.rect(34, 19, 38, 19, "c"); g.px(35, 20, "w"); g.px(37, 20, "w")   # 송곳니
    g.px(38, 16, "k"); g.rect(36, 15, 37, 15, "D")          # 코
    g.rect(32, 12, 34, 13, "y"); g.px(34, 12, "k"); g.px(32, 11, "k")   # 매서운 금눈
    g.line(29, 8, 31, 1, "y"); g.px(30, 3, "Y"); g.px(31, 0, "w")       # 뿔 하나
    g.rect(22, 21, 27, 21, "y")                             # 방울 목걸이
    for x in (23, 26):
        g.ell(x, 23, 1, 1, "y"); g.px(x, 24, "Y")
    # 불꽃 꼬리 (위로 말려 오른다)
    g.line(6, 23, 3, 18, "G"); g.line(3, 18, 4, 13, "G"); g.line(4, 13, 7, 10, "G")
    g.curl(4, 12, "D", "n"); g.curl(7, 9, "D", "n"); g.px(8, 7, "n"); g.px(6, 7, "y")
    # 비늘 무늬
    for x in range(9, 24, 4):
        for y in (22, 26):
            g.px(x, y, "L"); g.px(x + 1, y + 1, "L")
    stone_base(g, 4, 36, 36)
    g.outline()
    g.light("G")
    return g


# ---------- 청룡 (신화): 구름을 타고 오르는 용, 금 뿔·긴 수염·휘날리는 갈기, 발에 여의주 ----------
def dragon():
    g = Grid(48, 48)
    path = []
    for i in range(80):
        t = i / 79.0
        x = 4 + t * 32 + math.sin(t * 6.0) * 3
        y = 40 - t * 26 + math.sin(t * 7.0 + 0.5) * 6
        path.append((x, y, 1.2 + 2.6 * math.sin(min(1.0, t * 1.3) * math.pi * 0.5)))
    for x, y, r in path:
        g.ell(round(x), round(y), round(r), round(r), "G")
    for x, y, r in path[6::6]:                              # 배 비늘 (크림 줄)
        g.px(round(x + r * 0.5), round(y + r * 0.6), "c")
        g.px(round(x + r * 0.5) - 1, round(y + r * 0.6), "c")
    for x, y, r in path[3::5]:                              # 등지느러미
        g.line(round(x), round(y - r), round(x - 1), round(y - r - 2), "D")
    # 머리
    hx, hy = 38, 12
    g.ell(hx, hy, 4, 4, "G"); g.rect(hx + 2, hy, hx + 8, hy + 3, "G")
    g.rect(hx + 3, hy + 3, hx + 8, hy + 3, "c"); g.px(hx + 4, hy + 4, "w"); g.px(hx + 7, hy + 4, "w")
    g.px(hx + 8, hy, "k")
    g.rect(hx + 1, hy - 1, hx + 2, hy - 1, "y"); g.px(hx + 2, hy - 1, "k")   # 눈
    # 금 뿔 (사슴뿔처럼 갈라짐)
    g.line(hx - 1, hy - 4, hx - 4, hy - 11, "y"); g.line(hx - 3, hy - 8, hx - 6, hy - 9, "y")
    g.line(hx + 1, hy - 4, hx + 1, hy - 11, "y"); g.line(hx + 1, hy - 8, hx + 3, hy - 10, "y")
    # 갈기 (뒤로 휘날림)
    for k in range(5):
        g.line(hx - 3, hy - 2 + k * 2, hx - 9 - k, hy - 4 + k * 3, "L" if k % 2 else "D")
    # 긴 수염
    g.line(hx + 8, hy + 2, hx + 9, hy + 8, "w"); g.px(hx + 8, hy + 9, "w")
    g.line(hx + 4, hy + 4, hx + 2, hy + 10, "w"); g.px(hx + 3, hy + 11, "w")
    # 앞발 + 여의주
    g.line(28, 22, 33, 26, "G"); g.px(34, 26, "y"); g.px(34, 27, "y"); g.px(33, 28, "y")
    g.ell(36, 29, 2, 2, "c"); g.px(35, 28, "w")
    g.line(14, 33, 18, 37, "G"); g.px(19, 37, "y"); g.px(18, 38, "y")
    # 구름
    for (x, y) in ((6, 43), (12, 42), (18, 43), (24, 42), (30, 43), (36, 44)):
        g.ell(x, y, 3, 2, "P"); g.curl(x, y - 1, "p", "w")
    g.rect(4, 45, 40, 45, "p")
    g.outline()
    g.light("G")
    return g


# ---------- 불가사리 (신화): 쇠를 먹고 자라는 거대한 짐승 — 쇠 갑판·가시, 불타는 눈, 말린 코, 엄니 ----------
def bulgasari():
    g = Grid(48, 48)
    g.ell(20, 29, 15, 10, "G")                              # 몸
    g.ell(30, 26, 8, 9, "G")                                # 어깨 (불룩)
    for x in (8, 15, 26, 33):                               # 굵은 다리
        g.rect(x, 33, x + 5, 42, "G")
        g.rect(x - 1, 42, x + 6, 42, "D")
        for k in range(0, 6, 2):
            g.px(x + k, 43, "M")                             # 쇠 발톱
    # 머리
    g.ell(39, 24, 6, 6, "G")
    g.rect(42, 26, 45, 34, "G"); g.rect(44, 34, 46, 35, "G"); g.px(46, 33, "L")   # 말린 코
    g.rect(37, 22, 39, 23, "n"); g.px(39, 22, "y"); g.px(38, 21, "k")          # 불타는 눈
    g.line(40, 29, 37, 34, "c"); g.px(36, 35, "w")                             # 엄니
    g.line(41, 29, 39, 33, "c")
    g.ell(34, 18, 2, 2, "D")                                # 귀
    # 등의 쇠 갑판 (리벳) + 쇠 가시
    for i, x in enumerate(range(7, 34, 6)):
        top = 20 - round(math.sin((x - 5) / 30 * math.pi) * 3)
        g.rect(x, top, x + 4, top + 3, "m"); g.rect(x, top, x + 4, top, "M")
        g.px(x + 1, top + 2, "M"); g.px(x + 3, top + 2, "M")
        g.line(x + 2, top - 1, x + 2, top - 6, "m"); g.px(x + 2, top - 7, "M")
        g.px(x + 1, top - 2, "m"); g.px(x + 3, top - 2, "m")
    # 배 쇠 비늘
    for x in range(10, 30, 4):
        g.px(x, 34, "m"); g.px(x + 1, 35, "M")
    # 쇳덩이를 문 흔적 (입가 쇳조각)
    g.px(43, 32, "M"); g.px(41, 34, "m")
    stone_base(g, 5, 44, 44)
    g.outline()
    g.light("G")
    return g


# ---------- 백호 (신화): 흰 범 — 흰 몸에 유약 색 줄무늬, 이마 무늬, 금눈, 송곳니 ----------
def baekho():
    g = Grid(48, 48)
    g.line(8, 30, 4, 22, "c"); g.line(9, 30, 5, 22, "c"); g.line(4, 22, 6, 14, "c"); g.line(5, 22, 7, 14, "c")   # 꼬리
    for (x, y) in ((5, 25), (5, 19), (6, 16)):
        g.px(x, y, "D"); g.px(x + 1, y, "D")
    g.ell(20, 30, 13, 7, "c")                                 # 몸
    g.ell(31, 27, 6, 7, "c")                                  # 가슴
    for x, top in ((9, 33), (15, 34), (27, 33), (33, 32)):   # 다리
        g.rect(x, top, x + 3, 41, "c"); g.rect(x - 1, 41, x + 4, 42, "c")
        g.px(x, 42, "o"); g.px(x + 2, 42, "o")              # 발가락 금
    g.ell(37, 21, 6, 6, "c")                                  # 머리
    g.rect(40, 22, 45, 26, "c")                               # 주둥이
    g.line(33, 16, 34, 12, "c"); g.px(33, 13, "c"); g.px(34, 14, "R")   # 귀
    g.line(39, 16, 40, 12, "c"); g.px(40, 13, "c"); g.px(40, 14, "R")
    g.px(45, 22, "k"); g.rect(41, 26, 45, 26, "R"); g.px(42, 27, "w"); g.px(44, 27, "w")   # 코·입·송곳니
    g.rect(38, 19, 40, 20, "y"); g.px(40, 19, "k")            # 금눈
    for (x0, y0) in ((35, 15), (37, 15), (39, 16)):           # 이마 줄무늬
        g.line(x0, y0, x0, y0 + 2, "D")
    for x in range(10, 31, 4):                                # 몸 줄무늬 (유약 색)
        g.line(x, 24, x + 1, 28, "D"); g.line(x + 1, 28, x, 31, "D")
    g.line(30, 23, 31, 26, "D"); g.line(34, 26, 35, 29, "D")
    g.px(12, 26, "w"); g.px(30, 22, "w")
    stone_base(g, 6, 44, 43)
    g.outline()
    g.shade_bottom("c", "P")
    return g


# ---------- 주작 (신화): 불꽃 날개를 펼치고 솟구치는 붉은 새, 날개깃 끝은 유약 색, 긴 꼬리깃 ----------
def jujak():
    g = Grid(48, 48)
    for k in range(14):                                       # 왼쪽 큰 날개 (위로 펼침, 깃이 촘촘히)
        ex, ey = 4 + k * 1.5, 4 + k
        g.line(22, 25, round(ex), round(ey), "r" if (k // 2) % 2 else "n")
    for k in range(0, 14, 2):                                 # 날개깃 끝 (유약 색)
        ex, ey = 4 + k * 1.5, 4 + k
        g.px(round(ex), round(ey), "G"); g.px(round(ex) + 1, round(ey), "L"); g.px(round(ex), round(ey) + 1, "G")
    for k in range(9):                                        # 오른쪽 날개 (뒤)
        g.line(26, 22, 36 + k, 6 + k, "R" if (k // 2) % 2 else "r")
    for k in range(0, 9, 2):
        g.px(36 + k, 6 + k, "G")
    g.ell(24, 26, 5, 7, "r")                                  # 몸
    g.ell(23, 28, 3, 4, "n")                                  # 가슴 불빛
    g.ell(30, 16, 3, 3, "r")                                  # 머리
    g.line(28, 22, 29, 18, "r"); g.line(27, 22, 28, 18, "r")  # 목
    g.rect(33, 16, 35, 16, "y"); g.px(36, 17, "y")            # 부리
    g.px(31, 15, "y"); g.px(32, 15, "k")                      # 눈
    g.line(29, 13, 27, 8, "n"); g.line(30, 13, 30, 7, "y"); g.line(31, 13, 33, 8, "n")   # 볏
    for k, c in enumerate(("n", "r", "y")):                   # 긴 꼬리깃 (아래로 흐름)
        x1, y1 = 6 + k * 7, 44 - k
        g.line(22, 32, x1, y1, c); g.line(23, 32, x1 + 1, y1, c)
        g.ell(x1, y1, 1, 1, "G"); g.px(x1, y1, "y")
    g.line(25, 32, 24, 37, "y"); g.line(27, 32, 28, 37, "y")  # 발
    for (x, y) in ((10, 20), (16, 14), (40, 26), (34, 30), (14, 30)):   # 불티
        g.px(x, y, "n"); g.px(x, y - 1, "y")
    g.outline()
    return g


# ---------- 현무 (신화): 유약 등딱지의 거북을 검은 뱀이 휘감고, 뱀 머리가 높이 솟는다 ----------
def hyeonmu():
    g = Grid(48, 48)
    for x, top in ((8, 35), (15, 37), (28, 37), (35, 35)):   # 다리
        g.rect(x, top, x + 4, 41, "f"); g.rect(x - 1, 41, x + 5, 41, "F")
    g.ell(42, 32, 4, 3, "f"); g.rect(44, 31, 46, 33, "f")     # 거북 머리
    g.px(44, 31, "y"); g.px(45, 31, "k"); g.px(46, 33, "o")
    g.ell(23, 29, 16, 10, "G")                                # 등딱지
    g.rect(8, 36, 38, 37, "F")                                # 배딱지 테
    for (cx, cy) in ((15, 26), (23, 23), (31, 26), (19, 32), (27, 32)):   # 육각 무늬
        for dx, dy in ((-3, 0), (-2, -2), (2, -2), (3, 0), (2, 2), (-2, 2)):
            g.px(cx + dx, cy + dy, "D")
        g.px(cx, cy, "L")
    # 검은 뱀: 등딱지를 한 바퀴 감고 위로 솟는다
    import math as _m
    for i in range(60):
        t = i / 59.0
        a = _m.pi * (1.1 + 1.6 * t)
        x = 23 + _m.cos(a) * 15 * (1 - 0.15 * t)
        y = 27 + _m.sin(a) * 8 * (1 - 0.15 * t)
        g.ell(round(x), round(y), 1, 1, "k")
    for i in range(18):
        t = i / 17.0
        g.ell(round(36 - t * 4 + _m.sin(t * 4) * 2), round(22 - t * 14), 1, 1, "k")
    g.ell(33, 7, 3, 2, "k"); g.rect(35, 7, 37, 8, "k")        # 뱀 머리
    g.px(34, 6, "y"); g.line(38, 8, 40, 9, "r"); g.px(41, 8, "r")   # 눈·혀
    for i in range(0, 60, 6):                                 # 뱀 비늘 빛
        t = i / 59.0
        a = _m.pi * (1.1 + 1.6 * t)
        g.px(round(23 + _m.cos(a) * 15 * (1 - 0.15 * t)), round(27 + _m.sin(a) * 8 * (1 - 0.15 * t)) - 1, "M")
    stone_base(g, 5, 46, 42)
    g.outline()
    g.light("G")
    return g


# ===================== 2026-11-29 사용자: "영웅 등급부터 신화까지 ... 생김새가 너무 이상해. 되게 이질적이야" =====================
# → 크기·체형을 일반 병사와 똑같이 (32×32, 창병 그림의 얼굴·몸·받침을 그대로 쓴다). 등급은 머리 장식·무기·빛으로만 나타낸다.
def base_doll():
    from PIL import Image
    root = pathlib.Path(__file__).resolve().parents[2]
    im = Image.open(root / "assets/sprites/kiln/soldier_spear_fire.png").convert("RGBA")
    M = {"282322": "o", "cd6851": "L", "a84438": "G", "67332e": "D", "f2f1e7": "w", "706258": "b", "929187": "f", "b9baad": "F"}
    g = Grid()
    for y in range(32):
        for x in range(32):
            px = im.getpixel((x, y))
            if px[3] >= 128:
                g.g[y][x] = M.get("%02x%02x%02x" % px[:3], "o")
    for y in range(0, 14):            # 갓(모자) 지우기
        for x in range(32):
            g.g[y][x] = "."
    for y in range(32):               # 창 지우기 (오른쪽 기둥)
        for x in range(20, 32):
            g.g[y][x] = "."
    g.rect(19, 17, 19, 20, "G"); g.px(20, 19, "f")     # 오른손
    return g


def finish(g):
    g.outline()
    return g


def general():       # 장수: 붉은 술 달린 쇠 투구, 어깨 갑옷, 등 뒤 망토, 치켜든 칼
    g = base_doll()
    g.rect(5, 17, 7, 25, "D"); g.rect(5, 17, 5, 25, "G")                 # 망토
    g.ell(14, 11, 4, 3, "m"); g.rect(11, 9, 13, 10, "M")                 # 투구
    g.rect(9, 13, 19, 13, "y"); g.px(14, 7, "y")                          # 금 테·꼭지
    g.line(14, 6, 13, 3, "r"); g.line(15, 6, 15, 3, "r"); g.px(12, 3, "R") # 붉은 술
    g.rect(8, 17, 10, 18, "m"); g.rect(17, 17, 19, 18, "m"); g.px(8, 17, "M"); g.px(17, 17, "M")
    g.line(21, 8, 21, 17, "M"); g.px(21, 7, "w"); g.rect(20, 18, 22, 18, "y"); g.px(21, 19, "b")   # 칼
    return finish(g)


def sniper():        # 신궁: 깃 꽂은 검은 갓, 금빛 큰 활, 등의 화살통
    g = base_doll()
    g.rect(5, 15, 6, 22, "b"); g.px(4, 13, "w"); g.px(6, 13, "w"); g.px(5, 14, "M")   # 화살통
    g.rect(8, 13, 20, 13, "k"); g.rect(11, 9, 17, 12, "k"); g.rect(11, 12, 17, 12, "y")   # 갓
    g.line(16, 9, 19, 5, "w"); g.line(17, 9, 20, 6, "L")                  # 깃
    for y in range(6, 27):                                                # 큰 활
        t = (y - 16) / 10.0
        g.px(int(round(25 - 3 * t * t)), y, "b")
    g.px(22, 6, "y"); g.px(22, 26, "y")
    g.line(22, 7, 21, 16, "y"); g.line(21, 16, 22, 25, "y")               # 시위
    g.line(14, 19, 27, 19, "M"); g.px(28, 19, "w"); g.px(27, 18, "w"); g.px(27, 20, "w")   # 화살
    return finish(g)


def haetae():        # 해치 (전설): 해치 탈 투구 — 곱슬 갈기·금눈·뿔 하나, 불꽃 언월도
    g = base_doll()
    g.ell(14, 10, 5, 4, "D")                                              # 갈기
    for (x, y) in ((9, 8), (10, 12), (19, 8), (18, 12), (14, 5)):
        g.curl(x, y, "D", "L")
    g.ell(14, 10, 3, 3, "G"); g.rect(12, 12, 16, 13, "G")                # 해치 얼굴
    g.px(12, 9, "y"); g.px(16, 9, "y"); g.rect(13, 13, 15, 13, "w")      # 금눈·이빨
    g.line(14, 6, 14, 2, "y"); g.px(14, 1, "w")                           # 뿔
    g.rect(11, 17, 17, 17, "y"); g.px(14, 18, "Y")                        # 방울 목걸이
    g.line(22, 4, 22, 26, "b")                                            # 언월도 자루
    g.line(23, 3, 25, 6, "n"); g.line(23, 4, 24, 8, "y"); g.line(22, 2, 23, 3, "n"); g.px(25, 7, "n")   # 불꽃 날
    return finish(g)


def cheoyong():      # 처용 (전설): 꽃 꽂은 사모, 커다란 붉은 탈, 색동 한삼을 휘날림
    g = base_doll()
    g.ell(14, 11, 4, 5, "r")                                              # 탈
    g.rect(11, 9, 13, 9, "k"); g.rect(15, 9, 17, 9, "k")                  # 눈썹
    g.px(12, 10, "c"); g.px(16, 10, "c"); g.px(14, 12, "R")              # 눈·코
    g.rect(12, 14, 16, 14, "c"); g.px(14, 14, "k")                        # 웃는 이
    g.px(10, 12, "y"); g.px(18, 12, "y")                                  # 귀고리
    g.rect(10, 4, 18, 6, "k"); g.rect(6, 5, 9, 5, "k"); g.rect(19, 5, 22, 5, "k")   # 사모
    g.px(12, 3, "n"); g.px(13, 3, "y"); g.px(16, 3, "r")                  # 모란·복숭아
    for k in range(3):                                                    # 오른쪽 한삼 (위로)
        g.line(19, 18 + k, 25, 11 + k, "c")
    g.rect(19, 17, 20, 18, "r"); g.px(21, 16, "y")                        # 색동
    for k in range(2):                                                    # 왼쪽 한삼 (아래로)
        g.line(8, 18 + k, 4, 25 + k, "c")
    g.px(8, 18, "G")
    return finish(g)


def dragon():        # 청룡 (신화): 용 투구 — 금 사슴뿔·수염, 청룡언월도
    g = base_doll()
    g.ell(14, 10, 4, 3, "G"); g.rect(10, 12, 18, 13, "G"); g.rect(10, 13, 18, 13, "y")   # 용 투구
    g.px(12, 9, "L"); g.px(16, 10, "y")                                   # 용 눈
    g.line(11, 8, 9, 3, "y"); g.px(8, 4, "y"); g.line(17, 8, 19, 3, "y"); g.px(20, 4, "y")   # 뿔
    g.line(18, 12, 21, 14, "w"); g.line(10, 12, 7, 14, "w")               # 수염
    g.line(22, 6, 22, 26, "b"); g.px(22, 13, "G"); g.px(22, 14, "G")      # 자루 (용 감은 매듭)
    for y in range(1, 8):                                                 # 언월도 날 (초승달)
        w2 = 3 - abs(y - 4) // 2
        g.rect(23, y, 23 + w2, y, "M")
    g.px(23, 1, "w"); g.px(25, 3, "w"); g.px(22, 6, "G")
    return finish(g)


def baekho():        # 백호 (신화): 흰 범 가죽 두건(귀·줄무늬), 양손 범 발톱
    g = base_doll()
    g.ell(14, 10, 5, 4, "c"); g.rect(9, 12, 19, 13, "c")                 # 범 두건
    g.px(10, 6, "c"); g.px(11, 5, "c"); g.px(18, 6, "c"); g.px(17, 5, "c")   # 귀
    g.px(11, 6, "R"); g.px(17, 6, "R")
    for x in (12, 14, 16):                                                # 이마 줄무늬 (유약 색)
        g.line(x, 7, x, 9, "D")
    g.px(10, 11, "D"); g.px(18, 11, "D")
    g.px(12, 10, "y"); g.px(16, 10, "y")                                  # 범 눈
    g.rect(8, 17, 19, 17, "c"); g.px(10, 17, "D"); g.px(14, 17, "D"); g.px(18, 17, "D")   # 어깨 가죽
    g.line(21, 15, 24, 12, "M"); g.line(21, 17, 25, 15, "M"); g.line(21, 19, 24, 19, "M")   # 오른손 발톱
    g.line(7, 19, 4, 16, "M"); g.line(7, 20, 3, 19, "M")                  # 왼손 발톱
    return finish(g)


def jujak():         # 주작 (신화): 봉황 깃 관, 등의 작은 불꽃 날개, 불꽃 부채
    g = base_doll()
    for k, c in enumerate(("n", "r", "y", "r", "n")):                    # 깃 관 (부채꼴)
        g.line(14, 11, 10 + k * 2, 3 + abs(k - 2), c)
    g.rect(10, 12, 18, 13, "y")                                           # 금 머리띠
    g.px(14, 12, "r")
    for k in range(4):                                                    # 등 날개
        g.line(9, 18, 3 + k, 12 + k * 2, "r" if k % 2 else "n")
    g.ell(23, 15, 3, 3, "n"); g.ell(23, 15, 1, 1, "y"); g.line(21, 18, 20, 19, "b")   # 불꽃 부채
    g.px(25, 12, "y"); g.px(26, 14, "y")
    return finish(g)


def hyeonmu():       # 현무 (신화): 등딱지 투구, 육각 거북 방패, 검은 뱀이 감긴 지팡이
    g = base_doll()
    g.ell(14, 11, 4, 3, "D"); g.rect(10, 13, 18, 13, "L")                # 등딱지 투구
    g.px(12, 10, "L"); g.px(16, 10, "L"); g.px(14, 9, "L")
    g.line(6, 5, 6, 26, "b")                                              # 지팡이
    import math as _m
    for y in range(6, 24):                                                # 감긴 뱀
        g.px(6 + int(round(_m.sin(y * 0.7) * 2)), y, "k")
    g.ell(6, 5, 1, 1, "k"); g.px(7, 4, "y"); g.px(8, 5, "r")             # 뱀 머리·혀
    g.ell(21, 21, 4, 5, "G")                                              # 거북 방패
    for (cx, cy) in ((21, 19), (20, 23), (23, 22)):
        for dx, dy in ((-1, -1), (1, -1), (-1, 1), (1, 1)):
            g.px(cx + dx, cy + dy, "D")
    g.px(21, 18, "L"); g.px(19, 20, "L")
    return finish(g)


SPR = {"general": general(), "sniper": sniper(), "cheoyong": cheoyong(),
       "haetae": haetae(), "dragon": dragon(), "baekho": baekho(), "jujak": jujak(), "hyeonmu": hyeonmu()}

GLAZE = {
    "fire": {"L": "cd6851", "G": "a84438", "D": "67332e"},
    "water": {"L": "a6c5a3", "G": "6b9878", "D": "466f59"},
    "earth": {"L": "6b5f50", "G": "494039", "D": "302c2a"},
}
COMMON = {"o": "282322", "w": "f2f1e7", "f": "929187", "F": "b9baad", "p": "929187", "P": "b9baad",
          "b": "8a6a48", "B": "5a4430", "y": "e8c35a", "Y": "a8862e", "k": "141012", "r": "b8463a", "R": "7a2a24",
          "m": "6f6c66", "M": "c9c4b8", "c": "f2e6c8", "n": "ff9a3c"}


def write_gd(path):
    out = ['extends RefCounted',
           '## 새 병사 도트 (32×32). work/2026-11-28-다듬기/pixel_gen.py 가 만든다 — 직접 고치지 말 것.',
           '## Codex 그림(assets/sprites/kiln/soldier_<역할>_<유약>.png)이 오면 그 그림이 먼저 쓰인다.',
           '', 'const COMMON := {']
    out += ['\t"%s": Color("%s"),' % (k, v) for k, v in COMMON.items()]
    out += ['}', '', 'const GLAZE := {']
    for el, p in GLAZE.items():
        out.append('\t"%s": {%s},' % (el, ", ".join('"%s": Color("%s")' % (k, v) for k, v in p.items())))
    out += ['}', '', 'const MAPS := {']
    for name, g in SPR.items():
        out.append('\t"%s": [' % name)
        out += ['\t\t"%s",' % r for r in g.rows()]
        out.append('\t],')
    out += ['}', '', '',
            'static func make(role: String, element: String) -> ImageTexture:',
            '\tif not MAPS.has(role):',
            '\t\treturn null',
            '\tvar rows: Array = MAPS[role]',
            '\tvar img := Image.create(rows[0].length(), rows.size(), false, Image.FORMAT_RGBA8)',
            '\tvar gl: Dictionary = GLAZE.get(element, GLAZE["fire"])',
            '\tfor y in rows.size():',
            '\t\tvar r: String = rows[y]',
            '\t\tfor x in r.length():',
            '\t\t\tvar ch := r[x]',
            '\t\t\tif ch == ".":',
            '\t\t\t\tcontinue',
            '\t\t\tvar c: Color = gl[ch] if gl.has(ch) else COMMON.get(ch, Color.MAGENTA)',
            '\t\t\timg.set_pixel(x, y, c)',
            '\treturn ImageTexture.create_from_image(img)', '']
    pathlib.Path(path).write_text("\n".join(out), encoding="utf-8")


def preview(path):
    from PIL import Image, ImageDraw
    S = 5
    sheet = Image.new("RGBA", (len(SPR) * (48 * S + 12) + 12, 3 * (48 * S + 12) + 12), (32, 28, 40, 255))  # 유약 3줄
    for j, (el, gp) in enumerate(GLAZE.items()):
        for i, (name, g) in enumerate(SPR.items()):
            im = Image.new("RGBA", (g.w, g.h))
            for y, r in enumerate(g.rows()):
                for x, ch in enumerate(r):
                    if ch != ".":
                        h = gp.get(ch, COMMON.get(ch, "ff00ff"))
                        im.putpixel((x, y), tuple(int(h[k:k + 2], 16) for k in (0, 2, 4)) + (255,))
            sheet.alpha_composite(im.resize((g.w * S, g.h * S), Image.NEAREST), (12 + i * (48 * S + 12) + (48 - g.w) * S // 2, 12 + j * (48 * S + 12) + (48 - g.h) * S))
    sheet.save(path)


if __name__ == "__main__":
    root = pathlib.Path(__file__).resolve().parents[2]
    write_gd(root / "src/game/pixel_art.gd")
    if len(sys.argv) > 1:
        preview(sys.argv[1])
    print("ok")
