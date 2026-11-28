# Codex 작업 지시서 — 병사 6종(전설·신화) × 별 5 움직임 시트

- 날짜: 2026-12-01
- 작업 폴더: work/2026-12-01-모션외형/
- 지시서 번호: 15

## 먼저 읽을 것
1. AGENTS.md
2. art/references/ — 정한 그림체
3. **work/2026-12-01-모션외형/sheet-spec.md — 움직임 시트 공통 규격 (칸 순서·크기·유약 열쇠색·별 단계·병사별 특징). 반드시 이대로**
4. work/2026-12-01-모션외형/NOTES.md — 사용자 말
5. work/2026-11-30-UI그림/handoff-08.md 의 "AI 티 없애기" 10가지 — 여기서도 똑같이 지킨다
6. 지금 그림: `assets/sprites/kiln/soldier_*.png` (병사 32×32 한 장), `assets/sprites/enemy/*.png` (도깨비)

## 목표 (사용자 말 그대로)
> "병사랑 도깨비들이 그림그려진 상태 그대로 왔다갔다 움직임으로 걸어오는 걸 표현해뒀더라고. 그렇게 하면 안 되. 확실하게 걷는 모션이 등장하도록 걷는 모션들을 확실하게 만들어서 넣어줘."
> "병사들이 정확히 어떻게 생긴건지 구분이 잘 안 간다고 해. 아무래도 좀 더 디테일하게 외형을 작업해줘야 할 것 같아. 어떤 병사인지, 어떤 유닛인지 이름듣고 볼 때 확실히 맞네 생각이 들정도로 디자인해줘. 전부다 그렇게 적용해야 할 것 같아."
> "별이 오를때마다 외형도 같이 변해야 해. 그래서 별 1개부터 별 5개까지 전부 외형이 다르도록 디자인해줘."

해석(참고용): 지금 병사는 32×32 한 장을 통통 튀기며 옮긴다. 이제 64×64 칸 12개짜리 움직임 시트로 바꾼다. 병사마다 별 1~5 다섯 장. 유약 부분은 자홍 열쇠색으로 칠해 게임이 청자·진사·흑유로 바꿔 칠한다 (sheet-spec.md).

## 그리는 방법 (사용자가 정한 것)
- [x] 이미지 생성 후 코드로 다듬기 (크기 맞추기·배경 투명·색 줄이기) — 사용자가 handoff-01 에서 정함
- 칸마다 따로 생성하지 말고, **한 동작의 칸들을 한 번에** 생성하거나 첫 칸을 기준으로 다음 칸을 고쳐 그려 **같은 인물이 움직이는 것**처럼 보이게 한다 (칸마다 얼굴·옷·크기가 바뀌면 실패)
- 다듬기: 팔레트로 색 강제 맞추기, 외톨이 점 지우기, 칸 경계 넘는 점 지우기, 발 위치 맞추기(아래에서 4px), 1배로 줄여 실루엣 확인
- 움직임 확인용으로 칸을 차례로 넘기는 **GIF 미리보기**를 작업 폴더에 남긴다 (`work/2026-12-01-모션외형/preview-<NN>/<이름>.gif`)

정한 방법을 쓸 수 없으면 다른 방법으로 바꾸지 말고 `결과: 못 돌림` 으로 보고한다.

## 만들 것 (30장) — 병사 6종 × 별 5
| 파일 | 크기 | 내용 |
|---|---|---|
| `assets/sprites/unit/haetae_s1.png` | 768×64 | 해치 ★1 |
| `assets/sprites/unit/haetae_s2.png` | 768×64 | 해치 ★2 |
| `assets/sprites/unit/haetae_s3.png` | 768×64 | 해치 ★3 |
| `assets/sprites/unit/haetae_s4.png` | 768×64 | 해치 ★4 |
| `assets/sprites/unit/haetae_s5.png` | 768×64 | 해치 ★5 |
| `assets/sprites/unit/cheoyong_s1.png` | 768×64 | 처용 ★1 |
| `assets/sprites/unit/cheoyong_s2.png` | 768×64 | 처용 ★2 |
| `assets/sprites/unit/cheoyong_s3.png` | 768×64 | 처용 ★3 |
| `assets/sprites/unit/cheoyong_s4.png` | 768×64 | 처용 ★4 |
| `assets/sprites/unit/cheoyong_s5.png` | 768×64 | 처용 ★5 |
| `assets/sprites/unit/dragon_s1.png` | 768×64 | 청룡 ★1 |
| `assets/sprites/unit/dragon_s2.png` | 768×64 | 청룡 ★2 |
| `assets/sprites/unit/dragon_s3.png` | 768×64 | 청룡 ★3 |
| `assets/sprites/unit/dragon_s4.png` | 768×64 | 청룡 ★4 |
| `assets/sprites/unit/dragon_s5.png` | 768×64 | 청룡 ★5 |
| `assets/sprites/unit/baekho_s1.png` | 768×64 | 백호 ★1 |
| `assets/sprites/unit/baekho_s2.png` | 768×64 | 백호 ★2 |
| `assets/sprites/unit/baekho_s3.png` | 768×64 | 백호 ★3 |
| `assets/sprites/unit/baekho_s4.png` | 768×64 | 백호 ★4 |
| `assets/sprites/unit/baekho_s5.png` | 768×64 | 백호 ★5 |
| `assets/sprites/unit/jujak_s1.png` | 768×64 | 주작 ★1 |
| `assets/sprites/unit/jujak_s2.png` | 768×64 | 주작 ★2 |
| `assets/sprites/unit/jujak_s3.png` | 768×64 | 주작 ★3 |
| `assets/sprites/unit/jujak_s4.png` | 768×64 | 주작 ★4 |
| `assets/sprites/unit/jujak_s5.png` | 768×64 | 주작 ★5 |
| `assets/sprites/unit/hyeonmu_s1.png` | 768×64 | 현무 ★1 |
| `assets/sprites/unit/hyeonmu_s2.png` | 768×64 | 현무 ★2 |
| `assets/sprites/unit/hyeonmu_s3.png` | 768×64 | 현무 ★3 |
| `assets/sprites/unit/hyeonmu_s4.png` | 768×64 | 현무 ★4 |
| `assets/sprites/unit/hyeonmu_s5.png` | 768×64 | 현무 ★5 |

- 각 병사의 "한눈에 보일 것"과 별 단계 표는 sheet-spec.md 를 따른다
- 다 만들면 한 장 비교 시트를 남긴다: `work/2026-12-01-모션외형/sheet-15.png` — 줄 = 병사, 칸 = ★1~★5 의 '서 있기 첫 칸'을 4배로 키워서 (유약 열쇠색 그대로)

## 고쳐도 되는 범위
- `assets/sprites/unit/haetae_s1.png` ~ `haetae_s5.png` (새 파일)
- `assets/sprites/unit/cheoyong_s1.png` ~ `cheoyong_s5.png` (새 파일)
- `assets/sprites/unit/dragon_s1.png` ~ `dragon_s5.png` (새 파일)
- `assets/sprites/unit/baekho_s1.png` ~ `baekho_s5.png` (새 파일)
- `assets/sprites/unit/jujak_s1.png` ~ `jujak_s5.png` (새 파일)
- `assets/sprites/unit/hyeonmu_s1.png` ~ `hyeonmu_s5.png` (새 파일)
- `work/2026-12-01-모션외형/preview-15/` (GIF 미리보기), `work/2026-12-01-모션외형/sheet-15.png`, `work/2026-12-01-모션외형/handoff-15.report.md`

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
