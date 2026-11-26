---
name: art-loop
description: 그림 작업을 회차 루프로 반복 개선한다. 회차마다 스냅샷, 잡티·끊긴 선 자동 측정, 처음 보는 검토자 2명의 "AI 티"·"그림체 어울림" 채점 평균, 회차 상한과 점수 정체 시 멈춤. 그림을 여러 번 다듬어야 할 때 사용.
---

# 그림 루프

도구: `scripts/art_loop.py`, 기본값: `art/loop_config.json` (상한 6회, 2회 연속 0.3점 넘게 안 오르면 멈춤).

## 시작

```bash
python3 scripts/art_loop.py start <작업> [--max-rounds N --patience K]
```
`work/art-<작업>/NOTES.md` 의 "목표"에 사용자 말을 그대로 적는다.
`art/references/` 에 기준 그림이 없으면 시작하지 말고 사용자에게 달라고 한다.

## 한 회차

1. **만들기**: `codex-handoff` 스킬로 Codex에게 넘긴다. 2회차부터는 지난 회차의 측정값과 검토 코멘트를 지시서 "해석" 칸에 붙인다 (목표 문장은 그대로 둔다).
2. **확인**: codex-handoff 3단계(바뀐 파일·보호 파일·검사·렌더)를 그대로 한다.
3. **스냅샷 + 자동 측정**:
   ```bash
   python3 scripts/art_loop.py snap <작업> <그림 파일...>
   ```
4. **검토 2명 (매 회차 새로)**: Agent 도구로 general-purpose 에이전트 2개를 **새로** 띄운다 (fork 금지, 이전 회차 검토자 재사용 금지). 각자에게 주는 것은 아래뿐이다.
   - `art/rubric.md` 경로, `art/references/` 경로, `work/art-<작업>/round_NN/` 경로
   - "이 세 곳만 읽고, rubric.md의 답하는 형식(JSON)으로만 답하라. 다른 파일·이전 회차·git 기록은 보지 마라."
   
   목표 문장, 내 의견, 이전 점수, 다른 검토자 답은 주지 않는다.
   답을 각각 파일로 저장해 기록한다:
   ```bash
   python3 scripts/art_loop.py score <작업> A <A답.json>
   python3 scripts/art_loop.py score <작업> B <B답.json>
   ```
5. **판단**:
   ```bash
   python3 scripts/art_loop.py status <작업>
   ```
   - `계속` → 다음 회차
   - `멈춤: …` → 루프를 끝내고 사용자에게 보여 준다

## 멈추면 사용자에게 보여 줄 것

- `work/art-<작업>/rounds_sheet.png` (회차별 비교 시트) — Read로 열어 확인한 뒤 경로 전달
- 회차별 표(잡티·끊긴 선·검토 평균), 최고 점수 회차, 멈춘 이유
- 검토자 코멘트 요약
- "자동 측정과 검토 점수는 참고일 뿐, 미술 승인은 사용자가 한다"는 한 줄

사용자가 고르기 전에는 어느 회차도 최종본으로 커밋하지 않는다 (스냅샷 기록 커밋은 괜찮다).
