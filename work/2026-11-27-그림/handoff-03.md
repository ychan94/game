# Codex 작업 지시서 — 알을 품는 성 그림 12장 + 공통 7장

- 날짜: 2026-11-27 (그림체가 정해진 뒤에 넘긴다)
- 작업 폴더: work/2026-11-27-그림/
- 지시서 번호: 03

## 먼저 읽을 것
1. AGENTS.md
2. **art/references/ — 사용자가 고른 그림체 시안(가+다 섞음). 이 그림체를 그대로 따른다** (없으면 시작하지 말고 `결과: 못 돌림`)
3. docs/그림-목록.md 의 공통 규칙
4. art/sprite_list.json (그림마다 크기와 설명)

## 목표 (사용자 말 그대로)
> "지금보니까 체험판이라기에 너무 디자인이 아쉬워. codex를 통해 이미지나 외형 디자인이 어느 정도 되야 느낌이 있을 것 같아."

해석(참고용): 고른 그림체로 괴수 9장·알 3장, 그리고 두 시험판이 같이 쓰는 도깨비 3장·들판 4장을 그린다.

## 정한 그림체 (반드시 따른다)
- 기준 그림: `art/references/` (= 사용자가 고른 `art/style/mix` 시안). 팔레트도 기준 그림을 따른다
- 형태·디테일·표정: 32×32 에서도 무엇인지 한눈에 (가 시안처럼)
- 바탕은 먹색·흙 회색조로 차분하게, **강한 색은 유약·기운에만**: 청자 비취 초록(물) / 진사 구리 빨강(불) / 흑유 검은 갈색 + 기름 광택(땅)
- 금색은 쓰지 않는다 (요변·전설 빛은 게임이 그린다)
- 병사는 **유약 바른 도자기 인형**: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침
- 도깨비 무리는 **먹빛 남색·회청색 + 노란 눈** (진사 빨강 금지 — 아군과 구분)

## 그리는 방법 (사용자가 정한 것)
- [ ] 이미지 생성 기능(image_gen)으로 그린다
- [ ] 코드로 직접 그린다
- [x] 이미지 생성 후 코드로 다듬기 (크기 맞추기·배경 투명·색 줄이기) — 사용자가 handoff-01 에서 정함 (2026-11-27)

정한 방법을 쓸 수 없으면 다른 방법으로 바꾸지 말고 `결과: 못 돌림` 으로 보고한다.

## 만들 것 (19장)

| 파일 | 크기 | 내용 |
|---|---|---|
| `assets/sprites/nest/creature_spear_fire.png` | 32×32 | '불꽃 도마뱀' — 귀엽고 작은 괴수 새끼. 공격형(뾰족함). 오른쪽을 본다. 몸 바탕은 차분하게, 기운 색(불=진사 빨강, 물=청자 초록, 땅=흑유 검갈)이 가장 눈에 띄게. |
| `assets/sprites/nest/creature_spear_water.png` | 32×32 | '물살 수달' — 귀엽고 작은 괴수 새끼. 공격형(뾰족함). 오른쪽을 본다. 몸 바탕은 차분하게, 기운 색(불=진사 빨강, 물=청자 초록, 땅=흑유 검갈)이 가장 눈에 띄게. |
| `assets/sprites/nest/creature_spear_earth.png` | 32×32 | '가시 고슴도치' — 귀엽고 작은 괴수 새끼. 공격형(뾰족함). 오른쪽을 본다. 몸 바탕은 차분하게, 기운 색(불=진사 빨강, 물=청자 초록, 땅=흑유 검갈)이 가장 눈에 띄게. |
| `assets/sprites/nest/creature_archer_fire.png` | 32×32 | '불씨 박쥐' — 귀엽고 작은 괴수 새끼. 원거리형(떠다니거나 던짐). 오른쪽을 본다. 몸 바탕은 차분하게, 기운 색(불=진사 빨강, 물=청자 초록, 땅=흑유 검갈)이 가장 눈에 띄게. |
| `assets/sprites/nest/creature_archer_water.png` | 32×32 | '물방울 해파리' — 귀엽고 작은 괴수 새끼. 원거리형(떠다니거나 던짐). 오른쪽을 본다. 몸 바탕은 차분하게, 기운 색(불=진사 빨강, 물=청자 초록, 땅=흑유 검갈)이 가장 눈에 띄게. |
| `assets/sprites/nest/creature_archer_earth.png` | 32×32 | '돌팔매 원숭이' — 귀엽고 작은 괴수 새끼. 원거리형(떠다니거나 던짐). 오른쪽을 본다. 몸 바탕은 차분하게, 기운 색(불=진사 빨강, 물=청자 초록, 땅=흑유 검갈)이 가장 눈에 띄게. |
| `assets/sprites/nest/creature_shield_fire.png` | 32×32 | '용암 두꺼비' — 귀엽고 작은 괴수 새끼. 수비형(등딱지·단단함). 오른쪽을 본다. 몸 바탕은 차분하게, 기운 색(불=진사 빨강, 물=청자 초록, 땅=흑유 검갈)이 가장 눈에 띄게. |
| `assets/sprites/nest/creature_shield_water.png` | 32×32 | '조개 거북' — 귀엽고 작은 괴수 새끼. 수비형(등딱지·단단함). 오른쪽을 본다. 몸 바탕은 차분하게, 기운 색(불=진사 빨강, 물=청자 초록, 땅=흑유 검갈)이 가장 눈에 띄게. |
| `assets/sprites/nest/creature_shield_earth.png` | 32×32 | '바위 거북' — 귀엽고 작은 괴수 새끼. 수비형(등딱지·단단함). 오른쪽을 본다. 몸 바탕은 차분하게, 기운 색(불=진사 빨강, 물=청자 초록, 땅=흑유 검갈)이 가장 눈에 띄게. |
| `assets/sprites/nest/egg_spear.png` | 32×40 | 겉에 작은 뾰족 돌기가 있는 알. 아주 밝은 흰색/연회색으로만 칠한다 (게임이 기운 색으로 물들인다). 금은 그리지 않는다. |
| `assets/sprites/nest/egg_archer.png` | 32×40 | 길쭉하고 가는 알. 아주 밝은 흰색/연회색으로만 칠한다 (게임이 기운 색으로 물들인다). 금은 그리지 않는다. |
| `assets/sprites/nest/egg_shield.png` | 32×40 | 둥글고 넓적한 알. 아주 밝은 흰색/연회색으로만 칠한다 (게임이 기운 색으로 물들인다). 금은 그리지 않는다. |
| `assets/sprites/enemy/goblin.png` | 32×32 | 한국 도깨비. 먹빛 남색·회청색 피부, 노란 눈, 뿔, 헝클어진 머리 (진사 빨강은 쓰지 않는다 — 아군과 구분). 왼쪽을 본다. |
| `assets/sprites/enemy/imp.png` | 32×32 | 도깨비불. 창백한 푸른 불꽃 모양의 작은 정령, 노란 눈만 있다 (청자 초록과 헷갈리지 않게 차가운 푸른색). 왼쪽을 본다. |
| `assets/sprites/enemy/brute.png` | 48×48 | 큰 도깨비. goblin 과 같은 먹빛 남색 피부·노란 눈, 덩치 크고 도깨비 방망이를 든다. 왼쪽을 본다. |
| `assets/sprites/field/grass_a.png` | 32×32 | 밤의 풀밭 바닥 타일. 사방으로 이어 붙여도 이음새가 안 보여야 한다. 어둡고 차분하게 (캐릭터가 잘 보이도록). |
| `assets/sprites/field/grass_b.png` | 32×32 | grass_a 와 거의 같고 풀 무늬만 조금 다른 타일 (번갈아 깐다). |
| `assets/sprites/field/house.png` | 32×32 | 작은 초가집 또는 한옥 (지켜야 할 마을). 창에 불빛. |
| `assets/sprites/field/house_broken.png` | 32×32 | house 가 부서지고 불이 꺼진 모습. |

공통 규칙: PNG · 정확한 크기 · 투명 배경(바닥 타일만 꽉 채움) · 흐리게 다듬지 않은 픽셀 아트 · 한 장에 색 24개 이하 · 외곽선 1px · 캐릭터 가운데, 발은 아래에서 3~5px 위 · 아군은 오른쪽, 적은 왼쪽을 본다 · 요변/전설 빛·반짝임·맞을 때 번쩍임은 그리지 않는다(게임이 그림)

같은 종류끼리(예: 병사 9장, 괴수 9장) **키·덩치·외곽선 굵기·빛 방향(왼쪽 위)을 맞춘다.** 나란히 놓았을 때 한 세트로 보여야 한다.

## 고쳐도 되는 범위
- `assets/sprites/nest/creature_spear_fire.png` (새 파일)
- `assets/sprites/nest/creature_spear_water.png` (새 파일)
- `assets/sprites/nest/creature_spear_earth.png` (새 파일)
- `assets/sprites/nest/creature_archer_fire.png` (새 파일)
- `assets/sprites/nest/creature_archer_water.png` (새 파일)
- `assets/sprites/nest/creature_archer_earth.png` (새 파일)
- `assets/sprites/nest/creature_shield_fire.png` (새 파일)
- `assets/sprites/nest/creature_shield_water.png` (새 파일)
- `assets/sprites/nest/creature_shield_earth.png` (새 파일)
- `assets/sprites/nest/egg_spear.png` (새 파일)
- `assets/sprites/nest/egg_archer.png` (새 파일)
- `assets/sprites/nest/egg_shield.png` (새 파일)
- `assets/sprites/enemy/goblin.png` (이미 있는 임시 기준 그림 — 사용자 허락으로 새로 그려 덮어쓴다)
- `assets/sprites/enemy/imp.png` (새 파일)
- `assets/sprites/enemy/brute.png` (새 파일)
- `assets/sprites/field/grass_a.png` (새 파일)
- `assets/sprites/field/grass_b.png` (새 파일)
- `assets/sprites/field/house.png` (이미 있는 임시 기준 그림 — 사용자 허락으로 새로 그려 덮어쓴다)
- `assets/sprites/field/house_broken.png` (새 파일)

이 목록에 없는 파일은 만들거나 고치지 않는다.

## 보호 검사 결과 (Claude가 미리 확인함)
- `python3 scripts/protected.py <위 파일들>` → 걸린 파일 없음 (모두 새 파일)
- 2026-11-27 다시 확인: `python scripts/protected.py <위 19개>` → 걸린 파일 없음. goblin.png·house.png 는 클라우드 Claude가 넣은 임시 그림이고, 사용자가 "assets/sprites/enemy/goblin.png 와 field/house.png 는 지금 기준 그림을 넣어 둔 거라 Codex가 새로 그려도 돼." 라고 허락함
- 이 검사는 Claude가 했다. Codex는 다시 돌리지 않는다.

## 하면 안 되는 일
- 범위 밖 파일 수정·삭제 (특히 `src/`, `tests/`, `art/references/`, `art/rubric.md`)
- 게임 코드에 그림을 연결하는 작업 (이미 되어 있다 — 파일만 넣으면 게임이 쓴다)
- 저장소의 Python 스크립트 실행 (검사는 Claude가 작업 후에 한다)
- git commit / push
- 못 했는데 했다고 보고하기

## 끝나면 이 형식으로 보고
```
결과: 통과 | 실패 | 못 돌림   ← 셋 중 하나만
바뀐 파일:
- 경로 — 무엇을
직접 확인한 것:
- 예) 크기·투명 배경을 눈으로 확인
그리는 데 쓴 방법:
- 이미지 생성 / 코드 / 둘 다 (무엇을 어떻게)
못 한 것 / 걱정되는 것:
- …
```
- 통과: 목표대로 만들었다 / 실패: 만들었지만 목표에 못 미친다 (이유) / 못 돌림: 도구·권한·파일이 없어 작업 자체를 못 했다 (무엇이 없었는지)
- 저장소의 Python 검사를 못 돌린 것만으로는 `못 돌림`이 아니다. 검사는 Claude가 한다.

## Claude가 받은 뒤 할 일
1. `git status` — 바뀐 파일이 위 범위뿐인지
2. `python3 scripts/check_sprites.py --group "알을 품는 성" --group "공통 (적)" --sheet <작업폴더>/sheet-03.png` (그룹마다 한 번씩) — 크기·투명·색 수·흐림
3. `godot --path . --script res://tests/screens_proto.gd -- <폴더>` 로 게임 화면에 들어간 모습을 찍어 직접 열어 보기
4. `python3 scripts/test.py --stage all`
5. 사용자에게 비교 시트와 게임 화면을 보여 주고 "검사는 통과, 미술 판단은 사용자 몫" — 허락을 받은 뒤 커밋
