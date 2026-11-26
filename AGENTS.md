# AGENTS.md

모든 에이전트(Claude, Codex 등)의 규칙은 이 파일 한 곳에만 쓴다. CLAUDE.md 는 이 파일을 불러오기만 한다.

## 가장 먼저 지킬 것

1. **최신 지시가 이 파일보다 우선한다.** 사용자가 지금 대화에서 한 말이 이 파일과 다르면 사용자의 말을 따르고, 그 내용을 아래 "작업 메모" 규칙대로 적는다.
2. **사용자가 직접 고친 파일은 덮어쓰지 않는다.** 고치기 전에 `python3 scripts/protected.py <파일...>` 로 확인한다. 걸리면 바꿀 내용을 제안만 하고 손대지 않는다. (`PROTECTED.txt`, 마지막 커밋을 사용자가 한 파일, 작업 시작 때 이미 커밋 안 된 변경이 있던 파일)
   - **Codex는 이 검사를 직접 돌리지 않는다.** Claude가 지시서를 쓰기 전에 돌리고 결과를 지시서에 적는다. Codex는 지시서의 "고쳐도 되는 범위" 밖과 `PROTECTED.txt` 에 적힌 파일을 건드리지 않는 것으로 이 규칙을 지킨다.
3. **자동 검사 통과는 재미·미술 승인이 아니다.** 테스트·봇·측정이 통과해도 "검사는 통과, 재미·미술 판단은 사용자 몫"이라고 말한다. 스스로 "재밌다", "예쁘다", "완성"이라고 결론 내지 않는다.

## 작업 메모

- 작업마다 폴더를 만든다: `work/<YYYY-MM-DD>-<작업이름>/` (그림 루프는 `work/art-<작업>/`)
- 그 안의 `NOTES.md` 에 작업 중 새로 정한 것을 **날짜와 사용자 말 그대로** 적는다.
  ```
  - 2026-11-26 "보스 체력은 지금보다 2할만 낮춰 줘"
    → sim/game.py BOSSES 체력 조정
  ```
- 작업 시작 때 `git status --porcelain` 결과를 NOTES.md 에 붙여 둔다 (이미 있던 사용자 변경을 구분하려고).
- 작업 메모에 적은 것이 여러 작업에 계속 쓰일 규칙이면, 사용자에게 물어본 뒤 이 파일로 옮긴다.

## 역할 나누기

- **그림이 필요한 작업은 Codex에게 넘긴다** → `.claude/skills/codex-handoff/SKILL.md`
  - 지시서: 먼저 읽을 것 / 목표(사용자 말 그대로) / 고쳐도 되는 범위 / 하면 안 되는 일
  - Codex 보고 첫 줄: `결과: 통과` | `결과: 실패` | `결과: 못 돌림`
  - Claude는 바뀐 파일·보호 파일·검사·렌더를 **직접 다시 확인한 뒤에만** 커밋한다.
- 코드·테스트·측정은 Claude가 직접 한다.
- Codex는 커밋·푸시하지 않는다.
- Codex는 이 저장소의 Python 스크립트(검사·테스트·측정)를 돌리지 않는다. Windows의 Codex 쓰기 모드에서는 Python을 쓸 수 없다. 검사는 Claude가 Codex 작업 전후에 한다. Codex가 검사를 못 돌린 것만으로는 `못 돌림`이 아니다.

## 실행 환경

- 이 문서의 `python3` 명령은 Windows에서 `python3` 이 안 되면 `python` 으로 바꿔 실행한다 (같은 것).
- Codex는 `codex exec` (Codex CLI)로 부른다. git 저장소 폴더 안에서만 실행한다.
  쓰기 작업은 `--sandbox workspace-write`, 읽기만 하면 `--sandbox read-only` (Codex CLI 0.172 기준. `--full-auto` 는 없음).

## 자동 테스트

| 단계 | 뜻 | 위치 |
|---|---|---|
| P0 | 깨지면 게임이 안 되는 것 (시작·이동·공격·죽음·같은 시드 같은 결과) | `tests/p0/` |
| P1 | 게임 전반 (패턴·잡몹·구르기 등) | `tests/p1/` |
| boss | 보스마다 봇이 플레이어 조작만으로 화면 없이 싸움 → 깼는지·걸린 시간·잃은 체력 | `tests/bosses/boss_bot.py` → `reports/boss/` |

```bash
python3 scripts/test.py              # 바뀐 파일에 맞는 단계만
python3 scripts/test.py --dry-run    # 무엇을 돌릴지만
python3 scripts/test.py --stage all  # 전부
```

- 파일 → 단계 연결은 `test_map.json`. 새 폴더·파일을 만들면 여기에 규칙을 추가한다.
- 전투 코드(`sim/combat.py`, `sim/game.py`)를 고치면 보스 봇이 같이 돈다: Claude가 고친 직후(`.claude/hooks/after_edit.py`) + 커밋 전(`.githooks/pre-commit`).
- 보스 봇은 `observe()`(화면에 보이는 정보)만 읽고 `step(inputs)`(이동·공격·구르기)만 쓴다. 게임 내부 값을 직접 바꾸지 않는다.
- 테스트를 통과시키려고 테스트나 봇 기준을 느슨하게 고치지 않는다. 고쳐야 하면 이유를 사용자에게 먼저 말한다.

## 성능 검사

조건(장면 `max_enemies`, 시드 42, 적 400, 600프레임, 고정 입력)은 `perf/bench.py` 맨 위 상수로 고정한다.

1. `python3 perf/bench.py profile` — 함수(시스템)별 프레임 시간, 병목 찾기
2. 고치기 전: `python3 perf/bench.py baseline` — 결과 지문 저장
3. 고친 뒤: `python3 perf/bench.py compare` — 바꾸기 전과 결과가 같은지 (회귀 테스트). 다르면 성능 개선으로 인정하지 않는다.
4. `python3 perf/bench.py fps --note "무엇을 바꿨나"` — FPS 평균·1% 저점을 같은 조건에서 재서 `perf/records.csv` 에 날짜와 함께 남긴다. 고치기 전·후 둘 다 잰다.

- 결과가 일부러 달라져야 하는 변경(게임 규칙 변경)이면 사용자에게 말하고 baseline 을 새로 저장한 이유를 NOTES.md 에 적는다.

## 그림 루프

→ `.claude/skills/art-loop/SKILL.md`, 도구 `scripts/art_loop.py`, 기본값 `art/loop_config.json`

- 회차마다 `work/art-<작업>/round_NN/` 스냅샷
- 셀 수 있는 것(잡티, 끊긴 선)은 스크립트로 잰다.
- "AI 티"와 "우리 그림체와 어울리는지"는 처음 보는 검토자 2명이 `art/rubric.md` 와 `art/references/` 만 보고 채점 → 평균
- 회차 상한(기본 6), 2회 연속 점수가 안 오르면 멈추고 사용자에게 비교 시트를 보여 준다.

## 커밋

- 커밋 전에 `python3 scripts/test.py` 가 통과해야 한다 (pre-commit 훅이 자동으로 돌림).
- 처음 받은 저장소라면 `git config core.hooksPath .githooks` 를 한 번 실행한다.
- 커밋 메시지에 무엇을 왜 바꿨는지, 돌린 검사와 결과를 적는다.

## 실제 게임으로 바꿀 때

`sim/` 은 세팅이 돌아가는지 확인하려고 넣은 예시 게임이다. 실제 게임으로 바꿀 때는 `sim/game.py` 맨 위에 적힌 공개 API(`World`, `step`, `observe`, `state_hash`, `SYSTEMS`)를 실제 게임에 맞춰 연결하고, `test_map.json` 의 전투 코드 경로와 `.claude/hooks/after_edit.py` 의 `COMBAT` 를 실제 경로로 바꾼다.
