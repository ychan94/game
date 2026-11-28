"""KILNBORN 효과음·음악 만들기 (절차 합성, 외부 음원 없음 → 저작권 걱정 없음)

    python3 scripts/make_audio.py          # assets/audio/ 에 .ogg 를 새로 만든다

악기 (모두 수식으로 합성):
  가야금 같은 뜯는 소리(pluck) · 대금 같은 바람 소리(flute) · 장구(덩·쿵·덕) · 북(buk)
  징(gong) · 도자기 풍경(chime) · 흙·불 소리(noise)
음계: 낮·로비 = 평조(D E G A B), 밤 전투·보스 = 계면조 느낌(E G A B D)
같은 시드면 같은 소리가 나온다. 필요: numpy, ffmpeg(libvorbis)
"""
import os
import subprocess
import sys
import tempfile
import wave

import numpy as np

SR = 32000
ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OUT = os.path.join(ROOT, "assets", "audio")
rng = np.random.default_rng(7)


# ---------------- 기본 부품 ----------------
def tt(dur):
    return np.arange(int(dur * SR)) / SR


def fade(x, a=0.003, r=0.01):
    n = len(x)
    na, nr = min(n, int(a * SR)), min(n, int(r * SR))
    if na > 0:
        x[:na] *= np.linspace(0, 1, na)
    if nr > 0:
        x[-nr:] *= np.linspace(1, 0, nr)
    return x


def fft_filter(x, lo=0.0, hi=None, soft=0.15):
    """주파수 창으로 거르기 (lo~hi Hz 를 남긴다, 가장자리는 부드럽게)"""
    n = len(x)
    X = np.fft.rfft(x)
    f = np.fft.rfftfreq(n, 1 / SR)
    m = np.ones_like(f)
    if lo > 0:
        m *= 1 / (1 + np.minimum(1e12, (lo / np.maximum(f, 1e-3)) ** (2 / soft * 0.15)))
    if hi is not None and hi > 0:
        m *= 1 / (1 + (f / hi) ** (2 / soft * 0.15))
    return np.fft.irfft(X * m, n)


def noise(dur):
    return rng.uniform(-1, 1, int(dur * SR))


def place(buf, x, at, gain=1.0):
    i = int(at * SR)
    if i >= len(buf):
        return
    j = min(len(buf), i + len(x))
    buf[i:j] += x[: j - i] * gain


def reverb(x, time=1.6, mix=0.25, damp=5000):
    n = int(time * SR)
    t = np.arange(n) / SR
    ir = rng.uniform(-1, 1, n) * np.exp(-t / (time / 6.5))
    ir = fft_filter(ir, 0, damp)
    ir[: int(0.012 * SR)] = 0  # 앞쪽 짧은 틈 (방 크기)
    ir /= np.sqrt(np.sum(ir ** 2)) + 1e-9
    L = len(x) + n
    nf = 1 << (L - 1).bit_length()
    wet = np.fft.irfft(np.fft.rfft(x, nf) * np.fft.rfft(ir, nf), nf)[: len(x) + n]
    out = np.zeros(len(x) + n)
    out[: len(x)] += x * (1 - mix)
    out += wet * mix
    return out


# ---------------- 악기 ----------------
def pluck(f, dur, amp=1.0, bright=1.0, bend=0.0):
    """가야금처럼 뜯는 소리: 배음마다 따로 사라지는 줄 소리 + 뜯는 순간의 잡음 + 늦게 오는 흔들림(농현)"""
    t = tt(dur)
    vib = 1 + 0.007 * np.sin(2 * np.pi * 5.2 * t) * np.clip((t - 0.18) * 3, 0, 1)
    if bend:
        vib *= 1 + bend * np.clip((t - 0.08) * 6, 0, 1)
    ph = 2 * np.pi * np.cumsum(f * vib) / SR
    out = np.zeros_like(t)
    for k in range(1, 14):
        fk = f * k * (1 + 0.0007 * k * k)
        if fk > SR / 2.3:
            break
        a = abs(np.sin(np.pi * k * 0.23)) / k ** (1.25 - 0.25 * bright)
        dec = 1.6 + 0.9 * (k - 1) ** 1.25 / bright
        out += a * np.exp(-dec * t) * np.sin(ph * k * (1 + 0.0007 * k * k) + k)
    pk = fft_filter(noise(0.02), 800, 5000) * np.exp(-np.arange(int(0.02 * SR)) / (0.004 * SR))
    out[: len(pk)] += pk * 0.25
    return fade(out * amp * 0.35, 0.002, 0.03)


def flute(f, dur, amp=1.0, breath=0.07):
    """대금처럼 숨이 섞인 소리: 기본음 + 약한 배음 + 걸러낸 숨소리, 뒤로 갈수록 떨림"""
    t = tt(dur)
    vib = 1 + 0.009 * np.sin(2 * np.pi * 5.0 * t) * np.clip((t - 0.15) * 2.5, 0, 1)
    ph = 2 * np.pi * np.cumsum(f * vib) / SR
    tone = np.sin(ph) + 0.28 * np.sin(2 * ph + 0.3) + 0.08 * np.sin(3 * ph)
    br = fft_filter(noise(dur), f * 0.8, f * 3.5) * breath * 3
    env = np.minimum(1, t / 0.07) * np.minimum(1, (dur - t) / 0.12)
    env = np.clip(env, 0, 1) * (1 + 0.08 * np.sin(2 * np.pi * 0.7 * t))
    return (tone * 0.32 + br) * env * amp


def drum(f0, f1, dur, decay, noise_amt=0.2, nlo=200, nhi=3000, amp=1.0):
    """가죽 북: 음높이가 떨어지는 사인 + 때리는 잡음"""
    t = tt(dur)
    f = f1 + (f0 - f1) * np.exp(-t * 28)
    body = np.sin(2 * np.pi * np.cumsum(f) / SR) * np.exp(-t / decay)
    hit = fft_filter(noise(dur), nlo, nhi) * np.exp(-t / 0.018) * noise_amt * 3
    return fade((body + hit) * amp, 0.0005, 0.01)


def janggu(kind, amp=1.0):
    if kind == "deong":   # 덩: 양손 (낮고 크게)
        return drum(190, 118, 0.55, 0.16, 0.35, 150, 2500, amp)
    if kind == "kung":    # 쿵: 왼손 북편
        return drum(160, 105, 0.45, 0.12, 0.12, 100, 1200, amp * 0.9)
    if kind == "deok":    # 덕: 열채 (높고 마른 소리)
        return drum(420, 330, 0.12, 0.03, 0.9, 1500, 7000, amp * 0.6)
    if kind == "giduk":   # 기덕: 덕 두 번
        a = janggu("deok", amp * 0.7)
        out = np.zeros(len(a) + int(0.06 * SR))
        out[: len(a)] += a * 0.6
        out[int(0.06 * SR):] += a
        return out
    raise ValueError(kind)


def buk(amp=1.0):
    return drum(95, 52, 0.9, 0.32, 0.25, 60, 900, amp)


def gong(f=110.0, dur=4.0, amp=1.0):
    """징: 낮은 어긋난 배음들이 서로 맥놀이하며 길게 운다"""
    t = tt(dur)
    out = np.zeros_like(t)
    for r, a, d in [(1.0, 1.0, 2.4), (1.003, 0.6, 2.2), (1.52, 0.45, 1.6), (2.0, 0.3, 1.2), (2.43, 0.25, 0.9), (3.1, 0.15, 0.6), (4.2, 0.08, 0.4)]:
        glide = 1 + 0.015 * np.exp(-t * 3)
        out += a * np.sin(2 * np.pi * np.cumsum(f * r * glide) / SR) * np.exp(-t / d)
    out *= np.minimum(1, t / 0.01)
    out += fft_filter(noise(dur), 300, 3000) * np.exp(-t / 0.05) * 0.3
    return fade(out * amp * 0.4, 0.001, 0.2)


def chime(f, dur=1.6, amp=1.0, partials=None):
    """도자기를 두드린 맑은 소리 (어긋난 배음)"""
    t = tt(dur)
    out = np.zeros_like(t)
    for r, a, d in partials or [(1.0, 1.0, 0.9), (2.76, 0.5, 0.45), (5.40, 0.25, 0.22), (8.93, 0.12, 0.12)]:
        if f * r < SR / 2.2:
            out += a * np.sin(2 * np.pi * f * r * t + r) * np.exp(-t / d)
    out[: int(0.004 * SR)] *= np.linspace(0, 1, int(0.004 * SR))
    return fade(out * amp * 0.4, 0.0005, 0.05)


def whoosh(dur, f0, f1, amp=1.0, q=0.5):
    """바람·불길: 걸러낸 잡음의 가운데 주파수를 f0→f1 로 옮긴다 (짧게 나눠 거른다)"""
    n = int(dur * SR)
    out = np.zeros(n)
    seg = int(0.03 * SR)
    src = noise(dur + 0.1)
    win = np.hanning(seg * 2)
    for i in range(0, n, seg):
        k = i / max(1, n)
        fc = f0 * (f1 / f0) ** k
        piece = fft_filter(src[i:i + seg * 2], fc * (1 - q), fc * (1 + q))
        piece = piece[: len(win)] * win[: len(piece)]
        place(out, piece, i / SR)
    env = np.sin(np.pi * np.clip(np.arange(n) / n, 0, 1)) ** 0.7
    return out * env * amp


def crackle(dur, rate=40, amp=1.0):
    """불티 튀는 소리: 아주 짧은 딱딱 소리를 흩뿌린다"""
    out = np.zeros(int(dur * SR))
    for _ in range(int(dur * rate)):
        c = fft_filter(noise(0.006), 1500, 9000) * np.exp(-np.arange(int(0.006 * SR)) / (0.0012 * SR))
        place(out, c, rng.uniform(0, dur), rng.uniform(0.2, 1.0))
    return out * amp


# ---------------- 음계 ----------------
PYEONG = [0, 2, 5, 7, 9]       # D E G A B (낮·로비)
GYEMYEON = [0, 3, 5, 7, 10]    # E G A B D (밤·보스)


def note(step, base, scale):
    o, i = divmod(step, len(scale))
    return base * 2 ** ((scale[i] + 12 * o) / 12)


def finish(x, peak=0.89):
    x = np.tanh(x / (np.max(np.abs(x)) + 1e-9) * 1.25)
    return x / (np.max(np.abs(x)) + 1e-9) * peak


def loop_wrap(buf, loop_len):
    """끝에 남은 울림을 앞에 더해 이음매 없이 돌게"""
    n = int(loop_len * SR)
    out = buf[:n].copy()
    tail = buf[n:]
    out[: len(tail)] += tail[: n]
    return out


# ---------------- 음악 ----------------
def music_lobby():
    """아침 가마터: 76bpm 평조, 가야금 가락 + 대금 긴 소리 + 가벼운 장구 (16마디, 돌기)"""
    bpm, bars = 76, 16
    beat = 60 / bpm
    L = bars * 4 * beat
    buf = np.zeros(int((L + 4) * SR))
    base = 293.66  # D4
    A = [(0, 4, 1), (1, 3, .5), (1.5, 2, .5), (2, 3, 2), (4, 2, 1), (5, 1, 1), (6, 0, 2), (8, 1, 1), (9, 2, .5), (9.5, 3, .5), (10, 4, 1), (11, 5, 1), (12, 4, 3)]
    A2 = A[:-1] + [(12, 2, 1), (13, 1, 1), (14, 0, 2)]
    B = [(0, 5, 1.5), (1.5, 6, .5), (2, 7, 2), (4, 6, 1), (5, 5, 1), (6, 4, 2), (8, 5, 1), (9, 4, 1), (10, 3, 1), (11, 2, 1), (12, 3, 4)]
    B2 = [(0, 7, 1), (1, 6, 1), (2, 5, 1), (3, 4, 1), (4, 5, 2), (6, 3, 2), (8, 4, 1), (9, 3, .5), (9.5, 2, .5), (10, 1, 2), (12, 0, 4)]
    for p, phrase in enumerate([A, A2, B, B2]):
        for (b, s, d) in phrase:
            at = (p * 16 + b) * beat
            place(buf, pluck(note(s, base, PYEONG), d * beat + 1.2, 0.9, 1.0, 0.012 if d >= 2 else 0), at)
            if p >= 2:   # 뒤 절반은 대금이 따라 분다 (한 옥타브 위, 작게)
                place(buf, flute(note(s + 5, base, PYEONG), d * beat * 0.95, 0.35), at)
    roots = [0, 0, 2, 3] * 4   # 마디마다 화음 뿌리 (D D G A)
    for bar in range(bars):
        r = roots[bar]
        for i, s in enumerate([r - 5, r - 2, r, r - 2] * 2):
            place(buf, pluck(note(s, base, PYEONG), beat * 0.9 + 0.6, 0.32, 0.7), (bar * 4 + i * 0.5) * beat)
        # 낮은 대금 바닥 소리 (2마디마다)
        if bar % 2 == 0:
            place(buf, flute(note(r - 10, base, PYEONG), beat * 8, 0.22, 0.04), bar * 4 * beat)
        place(buf, janggu("deong", 0.35), bar * 4 * beat)
        place(buf, janggu("deok", 0.25), (bar * 4 + 1.5) * beat)
        place(buf, janggu("kung", 0.25), (bar * 4 + 2) * beat)
        place(buf, janggu("deok", 0.2), (bar * 4 + 3) * beat)
    buf = reverb(buf, 2.2, 0.28)
    return finish(loop_wrap(buf, L), 0.8)


def music_battle():
    """밤의 싸움: 128bpm 계면조, 장구 휘모리 + 북 + 뜯는 저음 + 가야금·대금 가락 (16마디)"""
    bpm, bars = 128, 16
    beat = 60 / bpm
    L = bars * 4 * beat
    buf = np.zeros(int((L + 3) * SR))
    base = 329.63  # E4
    roots = [0, 0, -1, -2, 0, 0, 2, 1] * 2
    for bar in range(bars):
        b0 = bar * 4 * beat
        pat = [(0, "deong"), (0.75, "deok"), (1.5, "kung"), (2, "deok"), (2.5, "giduk"), (3, "kung"), (3.5, "deok")]
        for (bt, k) in pat:
            place(buf, janggu(k, 0.55), b0 + bt * beat)
        place(buf, buk(0.8), b0)
        place(buf, buk(0.5), b0 + 2 * beat)
        r = roots[bar]
        for i in range(8):
            s = r - 10 if i % 4 != 2 else r - 7
            place(buf, pluck(note(s, base, GYEMYEON), beat * 0.45, 0.65, 0.6), b0 + i * 0.5 * beat)
    M1 = [(0, 4, .5), (.5, 5, .5), (1, 6, 1), (2, 5, .5), (2.5, 4, .5), (3, 3, 1), (4, 4, 1.5), (5.5, 3, .5), (6, 2, 2),
          (8, 2, .5), (8.5, 3, .5), (9, 4, .5), (9.5, 5, .5), (10, 6, 1), (11, 7, 1), (12, 6, 1), (13, 5, 1), (14, 4, 2)]
    M2 = [(0, 7, 1), (1, 6, .5), (1.5, 5, .5), (2, 6, 2), (4, 5, .5), (4.5, 4, .5), (5, 3, 1), (6, 4, 2),
          (8, 3, .5), (8.5, 2, .5), (9, 1, 1), (10, 2, 1), (11, 3, 1), (12, 1, 2), (14, 0, 2)]
    for p, ph in enumerate([M1, M2, M1, M2]):
        for (b, s, d) in ph:
            at = (p * 16 + b) * beat
            place(buf, pluck(note(s, base, GYEMYEON), d * beat + 0.4, 0.8, 1.2, 0.02 if d >= 2 else 0), at)
            if p >= 2:
                place(buf, flute(note(s + 5, base, GYEMYEON), d * beat * 0.9, 0.4, 0.09), at)
    place(buf, gong(98, 3.5, 0.5), 0)
    place(buf, gong(98, 3.5, 0.4), 8 * 4 * beat)
    buf = reverb(buf, 1.4, 0.2)
    return finish(loop_wrap(buf, L), 0.82)


def music_boss():
    """최종 보스: 140bpm, 낮은 북이 박마다 + 징이 4마디마다 + 낮은 대금이 길게 운다 (16마디)"""
    bpm, bars = 140, 16
    beat = 60 / bpm
    L = bars * 4 * beat
    buf = np.zeros(int((L + 4) * SR))
    base = 164.81  # E3
    for bar in range(bars):
        b0 = bar * 4 * beat
        for i in range(4):
            place(buf, buk(0.9 if i == 0 else 0.6), b0 + i * beat)
        for bt in [0.5, 1.5, 2.5, 3.25, 3.5, 3.75]:
            place(buf, janggu("deok", 0.45), b0 + bt * beat)
        if bar % 4 == 0:
            place(buf, gong(82.4, 4.0, 0.8), b0)
        r = [0, 0, -1, 1][bar % 4]
        for i in range(8):
            place(buf, pluck(note(r - 5 + (0 if i % 2 == 0 else 3), base, GYEMYEON), beat * 0.4, 0.55, 0.5), b0 + i * 0.5 * beat)
    lead = [(0, 7, 3), (3, 6, 1), (4, 5, 4), (8, 4, 2), (10, 5, 1), (11, 6, 1), (12, 5, 4),
            (16, 8, 3), (19, 7, 1), (20, 6, 2), (22, 5, 2), (24, 4, 4), (28, 3, 2), (30, 2, 2)]
    for rep in range(2):
        for (b, s, d) in lead:
            at = (rep * 32 + b) * beat
            place(buf, flute(note(s, base * 2, GYEMYEON), d * beat * 0.95, 0.55, 0.1), at)
            place(buf, pluck(note(s, base * 2, GYEMYEON), 0.6, 0.35, 1.3), at)
    buf = reverb(buf, 2.0, 0.24, 3500)
    return finish(loop_wrap(buf, L), 0.85)


# ---------------- 효과음 ----------------
def mix(*parts):
    n = max(len(p) for p in parts)
    out = np.zeros(n)
    for p in parts:
        out[: len(p)] += p
    return out


def seq(items):
    """[(시각, 소리)] 를 이어 붙인다"""
    n = max(int(at * SR) + len(x) for at, x in items)
    out = np.zeros(n)
    for at, x in items:
        place(out, x, at)
    return out


def sfx_all():
    D4 = 293.66
    s = {}
    s["click"] = drum(900, 700, 0.06, 0.012, 0.5, 2000, 8000, 0.6)                     # 나무 딸깍
    s["confirm"] = seq([(0, pluck(587.3, 0.35, 0.8)), (0.07, pluck(880.0, 0.5, 0.8))])  # 두 음 뜯기
    s["deny"] = seq([(0, pluck(311.1, 0.25, 0.7, 0.6)), (0.08, pluck(277.2, 0.35, 0.7, 0.6))])
    s["clay"] = mix(drum(140, 70, 0.25, 0.06, 0.4, 100, 900), fft_filter(noise(0.12), 200, 1200) * np.exp(-tt(0.12) / 0.03) * 0.5)  # 흙덩이 철퍽
    s["kiln_load"] = mix(drum(110, 80, 0.4, 0.1, 0.2, 80, 600, 0.7), whoosh(0.5, 300, 900, 0.4))
    s["fire"] = mix(whoosh(1.4, 180, 1400, 1.0, 0.6), crackle(1.4, 60, 0.6))                # 불 지피기
    s["crackle"] = crackle(0.8, 50, 0.8)
    s["crack"] = mix(fft_filter(noise(0.05), 2000, 9000) * np.exp(-tt(0.05) / 0.008), chime(1600, 0.5, 0.6))  # 흙 껍질 깨짐
    s["reveal_common"] = chime(880, 1.0, 0.8)
    s["reveal_uncommon"] = seq([(0, chime(880, 1.0, 0.7)), (0.08, chime(1174.7, 1.0, 0.7))])
    s["reveal_rare"] = seq([(0, chime(880, 1.2, 0.7)), (0.08, chime(1174.7, 1.2, 0.7)), (0.16, chime(1318.5, 1.4, 0.8))])
    s["reveal_hero"] = seq([(0, chime(880, 1.4)), (0.07, chime(1174.7, 1.4)), (0.14, chime(1318.5, 1.4)), (0.21, chime(1760, 1.8))])
    s["reveal_legend"] = reverb(seq([(0, gong(146.8, 2.5, 0.7))] + [(0.1 + i * 0.07, chime(note(i + 5, D4, PYEONG), 1.8, 0.8)) for i in range(6)]), 1.5, 0.3)
    s["reveal_mythic"] = reverb(seq([(0, gong(110, 3.5, 1.0)), (0, whoosh(1.2, 400, 4000, 0.5))] + [(0.15 + i * 0.06, chime(note(i + 5, D4, PYEONG), 2.2, 0.8)) for i in range(10)]), 2.0, 0.35)
    s["hit"] = drum(240, 120, 0.12, 0.03, 0.6, 300, 3000, 0.7)
    s["hit_big"] = mix(drum(160, 70, 0.3, 0.07, 0.7, 150, 2500, 1.0), crackle(0.1, 80, 0.4))
    s["hurt"] = drum(300, 180, 0.1, 0.025, 0.4, 500, 2500, 0.5)
    s["arrow"] = whoosh(0.18, 2500, 5000, 0.6, 0.4)
    s["die"] = mix(fft_filter(noise(0.25), 300, 2500) * np.exp(-tt(0.25) / 0.06) * 0.7, drum(300, 90, 0.2, 0.05, 0.1))   # 도깨비 펑
    s["die_big"] = mix(buk(0.9), fft_filter(noise(0.6), 100, 1500) * np.exp(-tt(0.6) / 0.15) * 0.6)
    s["heal"] = seq([(0, chime(1318.5, 0.6, 0.5)), (0.06, chime(1760, 0.8, 0.5))])
    s["skill"] = mix(whoosh(0.4, 500, 3000, 0.7), pluck(587.3, 0.5, 0.6, 1.4, 0.05))
    s["skill_fire"] = mix(whoosh(0.5, 200, 2000, 0.9, 0.6), crackle(0.5, 80, 0.5))
    s["skill_water"] = mix(whoosh(0.55, 1500, 400, 0.8, 0.5), chime(1174.7, 0.6, 0.3))
    s["skill_earth"] = mix(buk(0.7), fft_filter(noise(0.4), 60, 600) * np.exp(-tt(0.4) / 0.12) * 0.7)
    s["combo"] = reverb(mix(gong(130.8, 2.0, 0.6), janggu("deong", 0.9), whoosh(0.8, 300, 2500, 0.6)), 1.2, 0.25)
    s["summon"] = whoosh(0.5, 200, 800, 0.6, 0.3)
    s["boss_appear"] = reverb(seq([(0, buk(1.0)), (0.25, buk(0.8)), (0.5, buk(0.9)), (0.62, buk(0.7)), (0.74, gong(73.4, 3.5, 1.0))]), 1.8, 0.3)
    s["boss_warn"] = mix(*[fft_filter(np.sin(2 * np.pi * np.cumsum(np.linspace(220, 440, int(0.5 * SR))) / SR) * 0.5, 100, 4000)])
    s["boss_slam"] = mix(buk(1.0), drum(70, 35, 0.9, 0.3, 0.5, 40, 500, 1.0), crackle(0.3, 100, 0.4))
    s["boss_rain"] = mix(whoosh(0.4, 3000, 400, 0.6), drum(120, 60, 0.4, 0.1, 0.6, 100, 2500, 0.8))
    s["boss_roar"] = mix(fft_filter(noise(1.0), 80, 700) * np.sin(np.pi * np.clip(tt(1.0) / 1.0, 0, 1)) * 0.9, drum(90, 60, 1.0, 0.5, 0.0, 0, 0, 0.6))
    s["coin"] = seq([(0, chime(2093, 0.4, 0.5)), (0.05, chime(2637, 0.5, 0.5))])
    s["star_up"] = seq([(i * 0.07, pluck(note(i + 5, D4, PYEONG), 0.6, 0.8, 1.3)) for i in range(5)] + [(0.35, chime(1760, 1.2, 0.6))])
    s["equip"] = mix(drum(800, 600, 0.12, 0.03, 0.8, 2000, 8000, 0.6), chime(1318.5, 0.4, 0.4))
    s["draft"] = seq([(0, whoosh(0.35, 800, 3000, 0.5))] + [(0.1 + i * 0.09, chime(note(i + 7, D4, PYEONG), 0.8, 0.5)) for i in range(3)])
    s["card_pick"] = seq([(0, pluck(587.3, 0.4, 0.8, 1.3)), (0.06, pluck(880, 0.4, 0.8, 1.3)), (0.12, chime(1174.7, 0.9, 0.6))])
    s["reinforce"] = reverb(seq([(0, flute(220, 0.5, 1.0, 0.12)), (0.45, flute(293.66, 0.9, 1.0, 0.12)), (0, janggu("deong", 0.8))]), 1.2, 0.25)  # 나각 부는 소리처럼
    s["win"] = reverb(seq([(0, janggu("deong", 0.8))] + [(i * 0.13, pluck(note(s2, D4, PYEONG), 0.8, 0.9, 1.2)) for i, s2 in enumerate([0, 2, 4, 5, 7])] + [(0.65, chime(1174.7, 1.5, 0.6)), (0.65, flute(587.3, 1.2, 0.6))]), 1.5, 0.3)
    s["lose"] = reverb(seq([(0, gong(73.4, 3.0, 0.8))] + [(0.1 + i * 0.25, pluck(note(s2, 329.63, GYEMYEON), 1.0, 0.8, 0.7, -0.01)) for i, s2 in enumerate([4, 3, 1, 0])]), 1.8, 0.3)
    s["chapter_clear"] = reverb(seq([(0, gong(146.8, 3.0, 0.8)), (0, janggu("deong", 1.0)), (0.3, janggu("deong", 0.8))] + [(0.3 + i * 0.1, chime(note(i + 5, D4, PYEONG), 1.6, 0.7)) for i in range(8)]), 1.8, 0.3)
    s["pause"] = pluck(440, 0.4, 0.6, 0.8)
    return s


# ---------------- 쓰기 ----------------
def write_ogg(path, x, q=4):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    pcm = (np.clip(x, -1, 1) * 32767).astype(np.int16)
    with tempfile.NamedTemporaryFile(suffix=".wav", delete=False) as f:
        tmp = f.name
    with wave.open(tmp, "wb") as w:
        w.setnchannels(1)
        w.setsampwidth(2)
        w.setframerate(SR)
        w.writeframes(pcm.tobytes())
    subprocess.run(["ffmpeg", "-y", "-loglevel", "error", "-i", tmp, "-c:a", "libvorbis", "-q:a", str(q), path], check=True)
    os.remove(tmp)


def main():
    only = sys.argv[1:]
    for name, fn in [("lobby", music_lobby), ("battle", music_battle), ("boss", music_boss)]:
        if only and name not in only and "music" not in only:
            continue
        x = fn()
        write_ogg(os.path.join(OUT, "music", name + ".ogg"), x, 5)
        print("music", name, "%.1fs" % (len(x) / SR))
    if not only or "sfx" in only:
        sounds = sfx_all()
        for name, x in sounds.items():
            x = finish(x, 0.85) if np.max(np.abs(x)) > 0 else x
            write_ogg(os.path.join(OUT, "sfx", name + ".ogg"), fade(x, 0.0005, 0.02), 4)
        print("sfx", len(sounds))
    return 0


if __name__ == "__main__":
    sys.exit(main())
