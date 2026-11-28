# Codex 작업 지시서 — 도깨비 12종 움직임 시트 (걷기·공격·맞음)

- 날짜: 2026-12-01
- 작업 폴더: work/2026-12-01-모션외형/
- 지시서 번호: 12

## 먼저 읽을 것
1. AGENTS.md
2. art/references/ — 정한 그림체
3. **work/2026-12-01-모션외형/sheet-spec.md — 움직임 시트 공통 규격 (칸 순서·크기·유약 열쇠색·별 단계·병사별 특징). 반드시 이대로**
4. work/2026-12-01-모션외형/NOTES.md — 사용자 말
5. work/2026-11-30-UI그림/handoff-08.md 의 "AI 티 없애기" 10가지 — 여기서도 똑같이 지킨다
6. 지금 그림: `assets/sprites/kiln/soldier_*.png` (병사 32×32 한 장), `assets/sprites/enemy/*.png` (도깨비)

## 목표 (사용자 말 그대로)
> "병사랑 도깨비들이 그림그려진 상태 그대로 왔다갔다 움직임으로 걸어오는 걸 표현해뒀더라고. 그렇게 하면 안 되. 확실하게 걷는 모션이 등장하도록 걷는 모션들을 확실하게 만들어서 넣어줘."

해석(참고용): 지금 도깨비는 한 장 그림을 통통 튀기며 옮긴다. 진짜 걸음(다리가 번갈아 움직임)이 보이는 12칸 시트를 만든다. 디자인·색은 지금 그림을 지킨다. 왼쪽을 본다.
- 도깨비불(imp)·원귀(ghost)는 다리 대신 둥실 떠서 불꽃·옷자락이 흔들리는 '걷기'
- 이무기는 뱀처럼 몸이 물결치는 '걷기', 구미호는 네 발 + 아홉 꼬리가 흔들림

## 그리는 방법 (사용자가 정한 것)
- [x] 이미지 생성 후 코드로 다듬기 (크기 맞추기·배경 투명·색 줄이기) — 사용자가 handoff-01 에서 정함
- 칸마다 따로 생성하지 말고, **한 동작의 칸들을 한 번에** 생성하거나 첫 칸을 기준으로 다음 칸을 고쳐 그려 **같은 인물이 움직이는 것**처럼 보이게 한다 (칸마다 얼굴·옷·크기가 바뀌면 실패)
- 다듬기: 팔레트로 색 강제 맞추기, 외톨이 점 지우기, 칸 경계 넘는 점 지우기, 발 위치 맞추기(아래에서 4px), 1배로 줄여 실루엣 확인
- 움직임 확인용으로 칸을 차례로 넘기는 **GIF 미리보기**를 작업 폴더에 남긴다 (`work/2026-12-01-모션외형/preview-<NN>/<이름>.gif`)

정한 방법을 쓸 수 없으면 다른 방법으로 바꾸지 말고 `결과: 못 돌림` 으로 보고한다.

## 만들 것 (12장)
| 파일 | 크기 | 내용 |
|---|---|---|
| `assets/sprites/enemy/goblin_sheet.png` | 768×64 | 도깨비 — 지금 `enemy/goblin.png` 그대로의 모습에 움직임 12칸 |
| `assets/sprites/enemy/imp_sheet.png` | 768×64 | 도깨비불 — 지금 `enemy/imp.png` 그대로의 모습에 움직임 12칸 |
| `assets/sprites/enemy/fox_sheet.png` | 768×64 | 여우 요괴 — 지금 `enemy/fox.png` 그대로의 모습에 움직임 12칸 |
| `assets/sprites/enemy/armored_sheet.png` | 768×64 | 갑옷 도깨비 — 지금 `enemy/armored.png` 그대로의 모습에 움직임 12칸 |
| `assets/sprites/enemy/ghost_sheet.png` | 768×64 | 원귀 — 지금 `enemy/ghost.png` 그대로의 모습에 움직임 12칸 |
| `assets/sprites/enemy/brute_sheet.png` | 1152×96 | 덩치 도깨비 — 지금 `enemy/brute.png` 그대로의 모습에 움직임 12칸 |
| `assets/sprites/enemy/giant_sheet.png` | 1152×96 | 거인 도깨비 — 지금 `enemy/giant.png` 그대로의 모습에 움직임 12칸 |
| `assets/sprites/enemy/chief_sheet.png` | 1152×96 | 도깨비 대장 — 지금 `enemy/chief.png` 그대로의 모습에 움직임 12칸 |
| `assets/sprites/enemy/gumiho_sheet.png` | 1152×96 | 구미호 — 지금 `enemy/gumiho.png` 그대로의 모습에 움직임 12칸 |
| `assets/sprites/enemy/imugi_sheet.png` | 1152×96 | 이무기 — 지금 `enemy/imugi.png` 그대로의 모습에 움직임 12칸 |
| `assets/sprites/enemy/reaper_sheet.png` | 1152×96 | 저승사자 — 지금 `enemy/reaper.png` 그대로의 모습에 움직임 12칸 |
| `assets/sprites/enemy/king_sheet.png` | 1152×96 | 도깨비 왕 — 지금 `enemy/king.png` 그대로의 모습에 움직임 12칸 |

- 비교 시트: `work/2026-12-01-모션외형/sheet-12.png` — 줄 = 도깨비, 칸 = 12칸 전부 (2배)

## 고쳐도 되는 범위
- `assets/sprites/enemy/goblin_sheet.png` (새 파일)
- `assets/sprites/enemy/imp_sheet.png` (새 파일)
- `assets/sprites/enemy/fox_sheet.png` (새 파일)
- `assets/sprites/enemy/armored_sheet.png` (새 파일)
- `assets/sprites/enemy/ghost_sheet.png` (새 파일)
- `assets/sprites/enemy/brute_sheet.png` (새 파일)
- `assets/sprites/enemy/giant_sheet.png` (새 파일)
- `assets/sprites/enemy/chief_sheet.png` (새 파일)
- `assets/sprites/enemy/gumiho_sheet.png` (새 파일)
- `assets/sprites/enemy/imugi_sheet.png` (새 파일)
- `assets/sprites/enemy/reaper_sheet.png` (새 파일)
- `assets/sprites/enemy/king_sheet.png` (새 파일)
- `work/2026-12-01-모션외형/preview-12/`, `work/2026-12-01-모션외형/sheet-12.png`, `work/2026-12-01-모션외형/handoff-12.report.md`

이 목록에 없는 파일은 만들거나 고치지 않는다.

## 보호 검사 결과 (Claude가 미리 확인함)
- `python3 scripts/protected.py <위 파일들>` → 걸린 파일 없음 (모두 새 파일)

## Claude가 받은 뒤 할 일
1. `git status` — 범위 밖 변경 확인
2. `python3 scripts/check_sprites.py` + 칸 수·크기·발 위치 직접 잼
3. 게임 스크린샷으로 걷기·공격·별 5단계 확인 (유약 3색으로 바꿔 칠해지는지)
4. 사용자에게 보여 주고 커밋

## 하면 안 되는 일
- 범위 밖 파일 수정·삭제 (기존 `assets/sprites/kiln/*`, `assets/sprites/enemy/<종류>.png` 는 **고치지 않는다** — 게임이 새 시트가 없을 때 쓴다)
- 게임 코드 수정 (Claude가 이미 시트를 읽게 해 두었다)
- 저장소 Python 스크립트 실행, git commit / push, 기준 그림 수정, 못 했는데 했다고 보고하기

## 끝나면 이 형식으로 보고
```
결과: 통과 | 실패 | 못 돌림
바뀐 파일:
- 경로 — 무엇을
직접 확인한 것: (칸 수·크기·발 위치·투명 배경·색 수·GIF 로 본 걸음)
그리는 데 쓴 방법:
못 한 것 / 걱정되는 것:
```
