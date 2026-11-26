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
    → src/core/data.gd ECHO_HP 조정
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

## 프로젝트 구조

게임: **AFTERSELF (가제)** — 기획서 `docs/기획서.md`. Godot 4.7, 위에서 내려다보는 2D 픽셀 아트(타일 32×32).

| 위치 | 내용 |
|---|---|
| `src/core/` | 게임 규칙 (화면과 무관). `data.gd` 수치 · `world.gd` 방 하나의 전투 · `run.gd` 한 판 흐름 · `habits.gd` 습관 기록 · `echo.gd` 어제의 나 · `save.gd` 판 사이 저장 |
| `src/game/` | 화면·입력 (`main.tscn`). 규칙을 읽어서 그리기만 한다 |
| `assets/` | 게임에 들어가는 그림·글꼴 (글꼴: 갈무리, OFL) |
| `tests/` | Godot 테스트 (`test_p0.gd`, `test_p1.gd`, `test_boss.gd`), 봇, 성능 측정(`bench.gd`), 스크린샷(`screens.gd`) |
| `art/` | 그림 루프용 기준 그림·기준표 (게임에 안 들어감) |

- 규칙은 `src/core/` 에만 쓴다. 화면 코드에서 규칙을 바꾸지 않는다 (테스트·봇이 화면 없이 규칙을 돌리기 때문).
- 수치(밸런스)는 `src/core/data.gd` 한 곳에서만 바꾼다.
- `work/`, `reports/`, `docs/`, `scripts/`, `perf/`, `art/` 에는 `.gdignore` 가 있어 Godot 가 읽지 않는다.

## 실행 환경

- 이 문서의 `python3` 명령은 Windows에서 `python3` 이 안 되면 `python` 으로 바꿔 실행한다 (같은 것).
- Godot: `scripts/godot_cmd.py` 가 찾는다 (환경 변수 `GODOT` → PATH 의 `godot` → Windows 기본 위치의 `*_console.exe`). 못 찾으면 환경 변수 `GODOT` 에 실행 파일 경로를 넣는다. Windows는 창 없는 실행을 위해 `_console.exe` 를 쓴다.
- 화면 확인(스크린샷): `godot --path . --script res://tests/screens.gd -- <저장 폴더>` (화면이 있는 환경에서. 서버에서는 Xvfb 필요). 화면을 바꾸면 스크린샷을 직접 열어 확인한다.
- Codex는 `codex exec` (Codex CLI)로 부른다. git 저장소 폴더 안에서만 실행한다.
  쓰기 작업은 `--sandbox workspace-write`, 읽기만 하면 `--sandbox read-only` (Codex CLI 0.172 기준. `--full-auto` 는 없음).

## 자동 테스트

| 단계 | 뜻 | 위치 |
|---|---|---|
| P0 | 깨지면 게임이 안 되는 것 (시작·이동·공격·죽음→메아리·같은 시드 같은 결과) | `tests/test_p0.gd` |
| P1 | 게임 전반 (능력 8개·적 패턴·보상·분석표·메아리 약점·봇 한 판) | `tests/test_p1.gd` |
| boss | 어제의 나가 습관·빌드를 따라 하는지 + 분석표를 읽는 봇(`reader`)이 여러 어제의 나와 싸움 → 깼는지·걸린 시간·잃은 체력 | `tests/test_boss.gd` → `reports/boss/` |

```bash
python3 scripts/test.py              # 바뀐 파일에 맞는 단계만
python3 scripts/test.py --dry-run    # 무엇을 돌릴지만
python3 scripts/test.py --stage all  # 전부
```

- 파일 → 단계 연결은 `test_map.json`. 새 폴더·파일을 만들면 여기에 규칙을 추가한다.
- 게임 규칙(`src/core/*.gd`)을 고치면 boss 단계가 같이 돈다: Claude가 고친 직후(`.claude/hooks/after_edit.py`) + 커밋 전(`.githooks/pre-commit`).
- 테스트 함수는 `test_` 로 시작하고, 끝까지 가면 `return true`. 확인은 `check(조건, "설명")`.
- 봇과 어제의 나는 같은 두뇌(`echo.gd` 의 `Brain`)를 쓰고, 플레이어 조작(이동·조준·공격·구르기)만 낸다. 게임 내부 값을 직접 바꾸지 않는다.
- 테스트를 통과시키려고 테스트나 봇 기준을 느슨하게 고치지 않는다. 고쳐야 하면 이유를 사용자에게 먼저 말한다.

## 성능 검사

조건(적 120마리 + 어제의 나, 시드 42, 600프레임, 고정 입력)은 `tests/bench.gd` 맨 위 상수로 고정한다. 화면 그리기는 빼고 규칙 계산만 잰다.

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
