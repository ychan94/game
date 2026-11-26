---
name: codex-handoff
description: 그림(스프라이트·일러스트·UI 그림·이펙트 이미지 등)이 필요한 작업을 Codex에게 넘기고, 돌아온 결과를 직접 다시 확인한 뒤에만 커밋한다. 그림을 새로 만들거나 고쳐야 할 때 사용.
---

# Codex에게 그림 작업 넘기기

그림이 필요한 작업은 직접 그리지 말고 Codex에게 넘긴다. 순서를 건너뛰지 않는다.

## 0. 넘기기 전 보호 검사 (Claude가 한다)

고쳐도 되는 범위로 정할 파일 중 이미 있는 것에 대해 돌린다.

```bash
python3 scripts/protected.py <범위의 기존 파일...>   # Windows에서 안 되면 python
```

- 아무것도 안 나오면 통과. 결과(명령과 "걸린 파일 없음")를 지시서의 "보호 검사 결과"에 적는다.
- 걸린 파일이 있으면 그 파일을 범위에서 빼거나, 넘기지 말고 사용자에게 먼저 묻는다.
- Codex는 Python을 못 쓰므로 이 검사를 Codex에게 시키지 않는다.

## 1. 지시서 쓰기

`work/<YYYY-MM-DD>-<작업>/handoff-<NN>.md` 에 `templates/handoff.md` 를 복사해 채운다.

- **먼저 읽을 것**: AGENTS.md, art/rubric.md, art/references/, 관련 작업 메모(NOTES.md)와 파일 경로.
- **목표**: 사용자가 한 말을 **고치지 말고 그대로** 따옴표 안에 붙인다. 내 해석은 그 아래 따로 적는다.
- **고쳐도 되는 범위**: 파일·폴더 경로를 하나하나 적는다. 적지 않은 곳은 손대지 않는 것이 기본.
- **보호 검사 결과**: 0단계에서 Claude가 돌린 명령과 결과.
- **하면 안 되는 일**: 범위 밖 파일 수정, PROTECTED.txt 에 적힌 파일 덮어쓰기, 저장소 Python 스크립트 실행(검사는 Claude 몫), 커밋·푸시, 기준 그림 수정, 검사 기준 완화.
- **보고 형식**: 첫 줄은 반드시 `결과: 통과` / `결과: 실패` / `결과: 못 돌림` 중 하나.

## 2. Codex 실행

파일을 만들거나 고치는 작업 (그림 작업):

```bash
codex exec --sandbox workspace-write -C "$(git rev-parse --show-toplevel)" - < work/<작업폴더>/handoff-<NN>.md | tee work/<작업폴더>/handoff-<NN>.report.md
```

읽기만 하는 작업 (시험·확인):

```bash
codex exec --sandbox read-only -C "$(git rev-parse --show-toplevel)" - < work/<작업폴더>/handoff-<NN>.md | tee work/<작업폴더>/handoff-<NN>.report.md
```

- `--sandbox workspace-write`: Codex는 저장소 폴더 안에만 쓸 수 있다. 밖으로 나가야 하면 실패로 끝난다 → 보고는 `못 돌림`.
- `--full-auto` 는 Codex CLI 0.172 에서 없어졌다. `--approve-for-me` 는 승인을 Codex가 알아서 넘기므로 쓰지 않는다.
- 옵션 오류(`unexpected argument`)가 나면 `codex exec --help` 로 현재 옵션을 확인하고, 다른 옵션으로 바꿔 돌리기 전에 사용자에게 먼저 묻는다.

`codex` 명령이 없으면: 지시서 경로를 사용자에게 알려 주고 Codex에 붙여 넣어 달라고 한 뒤, 보고를 `handoff-<NN>.report.md`로 받아 저장한다.

## 3. 받은 결과를 직접 다시 확인 (보고를 믿지 말 것)

Codex가 `통과`라고 해도 아래를 직접 한다.

1. **바뀐 파일**: `git status --porcelain`, `git diff --stat`. 고쳐도 되는 범위 밖이 바뀌었으면 되돌리지 말고 사용자에게 알린다.
2. **보호 파일**: `python3 scripts/protected.py $(git diff --name-only)` 가 비어 있어야 한다.
3. **검사**: `python3 scripts/test.py` (바뀐 파일에 맞는 단계). 그림이면 `python3 scripts/art_loop.py measure <그림들>` 로 잡티·끊긴 선.
4. **렌더**: 바뀐 그림 파일을 Read로 직접 열어 본다. 크기·투명 배경·잘림·색을 확인한다. 게임 화면에 쓰이는 그림이면 그 화면 렌더(스크린샷)도 본다.
5. 보고의 `결과`와 내 확인이 다르면 내 확인을 따르고, 차이를 사용자에게 말한다.

## 4. 커밋

3번이 모두 맞을 때만 커밋한다. 커밋 메시지에 지시서 경로와 Codex 보고 결과를 적는다.
자동 검사 통과는 재미·미술 승인이 아니다. 그림은 사용자에게 보여 주고 "검사는 통과, 미술 판단은 아직"이라고 말한다.
