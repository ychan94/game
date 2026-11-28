OpenAI Codex v0.172.0
--------
workdir: C:\Users\pc\Documents\game
model: gpt-6-astra
provider: openai
approval: never
sandbox: workspace-write [workdir, /tmp, $TMPDIR]
reasoning effort: high
reasoning summaries: none
session id: 01a21c87-bb0e-7563-a198-0077bdf18c6c
--------
user
# Codex 작업 지시서 — 등급 6단계 새 병사 8종 + 챕터 적·대장

- 날짜: 2026-11-28
- 작업 폴더: work/2026-11-28-다듬기/
- 지시서 번호: 06 (지시서 05 의 새 병사 4종과 같은 방식. 05 를 아직 안 했으면 05 먼저)

## 먼저 읽을 것
1. AGENTS.md
2. art/references/ — 정한 그림체
3. 이미 있는 그림 `assets/sprites/kiln/soldier_*.png`, `assets/sprites/enemy/goblin.png` — **이것과 한 벌로**
4. docs/그림-목록.md, art/sprite_list.json 의 "가마의 병사 (등급 6단계 추가 8종)" · "챕터 적·대장" 묶음
5. work/2026-11-28-다듬기/NOTES.md

## 목표 (사용자 말 그대로)
> "등급을 6가지 정도로 넓히자. 다른 디펜스 게임 보면 완전 최종 등급 엄청 희박한 확률로 뽑아서 진행하는 것처럼 등급을 적절히 나눠줘."
> "등급을 더 많이 만들게 되면 아마도 병사들 종류를 더 늘려야 할 거야."
> "챕터별로 난이도와 등장 몬스터를 적절히 조절해줘."

해석(참고용): 병사는 15종 · 등급 6단계 (일반 → 고급 → 희귀 → 영웅 → 전설 → 신화). **등급이 높을수록 한눈에 귀해 보여야** 한다 (실루엣이 크고 독특하게, 장식이 많게). 전설·신화 중 해치·청룡·불가사리는 사람이 아니라 짐승이다. 챕터마다 새 적 하나와 대장 하나가 나온다. 지금은 모두 임시(도형·물들인 도깨비)로 보인다. 파일을 넣으면 게임이 바로 쓴다.

## 정한 그림체 (반드시 따른다)
- 가 + 다 섞음: 형태·표정은 또렷하게, 바탕은 먹색·흙 회색조
- 병사·짐승 = 유약 바른 **도자기 인형** (매끈한 몸, 왼쪽 위 흰 광택, 발밑 받침). 유약 색: 청자(물) / 진사(불) / 흑유(땅)
- 금색·무지개 빛·등급 빛은 넣지 않는다 (등급 빛과 요변 빛은 게임이 코드로 그린다). 장수의 금빛 장식처럼 작은 장식은 괜찮다
- 적은 먹빛 남색 계열 + 노란 눈. 아군 유약 색(특히 진사 빨강)과 헷갈리지 않게
- 병사는 오른쪽, 적은 왼쪽을 본다. 투명 배경, 색 24개 이하, 흐림 없음, 외곽선 1px

## 그리는 방법 (사용자가 정한 것)
- [x] 이미지 생성 후 코드로 다듬기 (크기 맞추기·배경 투명·색 줄이기) — 사용자가 handoff-01 에서 정함 (2026-11-27)

정한 방법을 쓸 수 없으면 다른 방법으로 바꾸지 말고 `결과: 못 돌림` 으로 보고한다.

## 만들 것 (33장)

| 파일 | 크기 | 내용 |
|---|---|---|
| `assets/sprites/kiln/soldier_slinger_water.png` | 32×32 | 유약 바른 도자기 인형 (투석병, 고급 등급). 돌팔매 끈을 머리 위로 돌리는 가벼운 병사. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 청자 유약 — 비취빛 맑은 녹색. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_slinger_fire.png` | 32×32 | 유약 바른 도자기 인형 (투석병, 고급 등급). 돌팔매 끈을 머리 위로 돌리는 가벼운 병사. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_slinger_earth.png` | 32×32 | 유약 바른 도자기 인형 (투석병, 고급 등급). 돌팔매 끈을 머리 위로 돌리는 가벼운 병사. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 흑유 유약 — 검은 갈색에 기름 같은 광택. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_twin_water.png` | 32×32 | 유약 바른 도자기 인형 (쌍검무사, 희귀 등급). 양손에 짧은 칼 두 자루, 날렵한 자세. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 청자 유약 — 비취빛 맑은 녹색. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_twin_fire.png` | 32×32 | 유약 바른 도자기 인형 (쌍검무사, 희귀 등급). 양손에 짧은 칼 두 자루, 날렵한 자세. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_twin_earth.png` | 32×32 | 유약 바른 도자기 인형 (쌍검무사, 희귀 등급). 양손에 짧은 칼 두 자루, 날렵한 자세. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 흑유 유약 — 검은 갈색에 기름 같은 광택. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_general_water.png` | 32×32 | 유약 바른 도자기 인형 (장수, 영웅 등급). 투구에 금빛 장식, 갑옷, 등 뒤에 유약 색 깃발. 다른 병사보다 당당하게. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 청자 유약 — 비취빛 맑은 녹색. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_general_fire.png` | 32×32 | 유약 바른 도자기 인형 (장수, 영웅 등급). 투구에 금빛 장식, 갑옷, 등 뒤에 유약 색 깃발. 다른 병사보다 당당하게. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_general_earth.png` | 32×32 | 유약 바른 도자기 인형 (장수, 영웅 등급). 투구에 금빛 장식, 갑옷, 등 뒤에 유약 색 깃발. 다른 병사보다 당당하게. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 흑유 유약 — 검은 갈색에 기름 같은 광택. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_sniper_water.png` | 32×32 | 유약 바른 도자기 인형 (신궁, 영웅 등급). 몸보다 큰 활, 금빛 시위, 활을 당긴 자세. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 청자 유약 — 비취빛 맑은 녹색. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_sniper_fire.png` | 32×32 | 유약 바른 도자기 인형 (신궁, 영웅 등급). 몸보다 큰 활, 금빛 시위, 활을 당긴 자세. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_sniper_earth.png` | 32×32 | 유약 바른 도자기 인형 (신궁, 영웅 등급). 몸보다 큰 활, 금빛 시위, 활을 당긴 자세. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 흑유 유약 — 검은 갈색에 기름 같은 광택. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_haetae_water.png` | 32×32 | 유약 바른 도자기 인형 (해치, 전설 등급). 병사가 아니라 도자기로 빚은 수호 짐승 해치(사자 닮은 네발 짐승, 곱슬 갈기, 이마에 뿔 하나). 32×32 를 꽉 채우는 덩치. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 청자 유약 — 비취빛 맑은 녹색. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_haetae_fire.png` | 32×32 | 유약 바른 도자기 인형 (해치, 전설 등급). 병사가 아니라 도자기로 빚은 수호 짐승 해치(사자 닮은 네발 짐승, 곱슬 갈기, 이마에 뿔 하나). 32×32 를 꽉 채우는 덩치. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_haetae_earth.png` | 32×32 | 유약 바른 도자기 인형 (해치, 전설 등급). 병사가 아니라 도자기로 빚은 수호 짐승 해치(사자 닮은 네발 짐승, 곱슬 갈기, 이마에 뿔 하나). 32×32 를 꽉 채우는 덩치. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 흑유 유약 — 검은 갈색에 기름 같은 광택. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_cheoyong_water.png` | 32×32 | 유약 바른 도자기 인형 (처용, 전설 등급). 붉은 처용 탈을 쓰고 긴 소매를 휘날리며 춤추는 모습, 사모(모자). 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 청자 유약 — 비취빛 맑은 녹색. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_cheoyong_fire.png` | 32×32 | 유약 바른 도자기 인형 (처용, 전설 등급). 붉은 처용 탈을 쓰고 긴 소매를 휘날리며 춤추는 모습, 사모(모자). 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_cheoyong_earth.png` | 32×32 | 유약 바른 도자기 인형 (처용, 전설 등급). 붉은 처용 탈을 쓰고 긴 소매를 휘날리며 춤추는 모습, 사모(모자). 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 흑유 유약 — 검은 갈색에 기름 같은 광택. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_dragon_water.png` | 32×32 | 유약 바른 도자기 인형 (청룡, 신화 등급). 병사가 아니라 도자기로 빚은 용. 구불구불한 긴 몸이 떠 있고, 뿔·수염·여의주. 32×32 를 꽉 채운다. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 청자 유약 — 비취빛 맑은 녹색. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_dragon_fire.png` | 32×32 | 유약 바른 도자기 인형 (청룡, 신화 등급). 병사가 아니라 도자기로 빚은 용. 구불구불한 긴 몸이 떠 있고, 뿔·수염·여의주. 32×32 를 꽉 채운다. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_dragon_earth.png` | 32×32 | 유약 바른 도자기 인형 (청룡, 신화 등급). 병사가 아니라 도자기로 빚은 용. 구불구불한 긴 몸이 떠 있고, 뿔·수염·여의주. 32×32 를 꽉 채운다. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 흑유 유약 — 검은 갈색에 기름 같은 광택. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_bulgasari_water.png` | 32×32 | 유약 바른 도자기 인형 (불가사리, 신화 등급). 쇠를 먹는 전설의 짐승 불가사리: 곰 같은 덩치에 쇠 가시가 돋은 등, 코끼리 같은 코. 32×32 를 꽉 채운다. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 청자 유약 — 비취빛 맑은 녹색. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_bulgasari_fire.png` | 32×32 | 유약 바른 도자기 인형 (불가사리, 신화 등급). 쇠를 먹는 전설의 짐승 불가사리: 곰 같은 덩치에 쇠 가시가 돋은 등, 코끼리 같은 코. 32×32 를 꽉 채운다. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_bulgasari_earth.png` | 32×32 | 유약 바른 도자기 인형 (불가사리, 신화 등급). 쇠를 먹는 전설의 짐승 불가사리: 곰 같은 덩치에 쇠 가시가 돋은 등, 코끼리 같은 코. 32×32 를 꽉 채운다. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 흑유 유약 — 검은 갈색에 기름 같은 광택. 오른쪽을 본다. |
| `assets/sprites/enemy/fox.png` | 32×32 | 여우 요괴: 주황빛 여우 꼬리 달린 작은 요괴, 날렵. 정한 그림체(먹빛·노란 눈 계열, 진사 빨강은 대장 장식에만 조금). 왼쪽을 본다. 투명 배경. |
| `assets/sprites/enemy/armored.png` | 32×32 | 갑옷 도깨비: 먹빛 남색 도깨비에 쇠 투구와 갑옷. 정한 그림체(먹빛·노란 눈 계열, 진사 빨강은 대장 장식에만 조금). 왼쪽을 본다. 투명 배경. |
| `assets/sprites/enemy/ghost.png` | 32×32 | 원귀: 흰 소복의 반투명해 보이는 귀신 (픽셀로 표현, 실제 반투명 금지 — 밝은 회청색으로). 정한 그림체(먹빛·노란 눈 계열, 진사 빨강은 대장 장식에만 조금). 왼쪽을 본다. 투명 배경. |
| `assets/sprites/enemy/giant.png` | 48×48 | 거인 도깨비: 큰 도깨비보다 더 큰 거인, 바위 방망이. 정한 그림체(먹빛·노란 눈 계열, 진사 빨강은 대장 장식에만 조금). 왼쪽을 본다. 투명 배경. |
| `assets/sprites/enemy/chief.png` | 48×48 | 도깨비 대장: 붉은빛이 도는 큰 도깨비, 금 왕관, 큰 방망이. 정한 그림체(먹빛·노란 눈 계열, 진사 빨강은 대장 장식에만 조금). 왼쪽을 본다. 투명 배경. |
| `assets/sprites/enemy/gumiho.png` | 48×48 | 구미호: 아홉 꼬리 흰 여우, 꼬리 끝이 주황빛. 정한 그림체(먹빛·노란 눈 계열, 진사 빨강은 대장 장식에만 조금). 왼쪽을 본다. 투명 배경. |
| `assets/sprites/enemy/imugi.png` | 48×48 | 이무기: 용이 되지 못한 거대한 뱀, 비늘은 이끼 낀 청록. 정한 그림체(먹빛·노란 눈 계열, 진사 빨강은 대장 장식에만 조금). 왼쪽을 본다. 투명 배경. |
| `assets/sprites/enemy/reaper.png` | 48×48 | 저승사자: 검은 갓과 검은 도포, 창백한 얼굴. 정한 그림체(먹빛·노란 눈 계열, 진사 빨강은 대장 장식에만 조금). 왼쪽을 본다. 투명 배경. |
| `assets/sprites/enemy/king.png` | 48×48 | 도깨비 왕: 가장 큰 도깨비, 금 왕관과 붉은 도포, 금 방망이. 정한 그림체(먹빛·노란 눈 계열, 진사 빨강은 대장 장식에만 조금). 왼쪽을 본다. 투명 배경. |

## 고쳐도 되는 범위
- `assets/sprites/kiln/soldier_slinger_water.png` (새 파일)
- `assets/sprites/kiln/soldier_slinger_fire.png` (새 파일)
- `assets/sprites/kiln/soldier_slinger_earth.png` (새 파일)
- `assets/sprites/kiln/soldier_twin_water.png` (새 파일)
- `assets/sprites/kiln/soldier_twin_fire.png` (새 파일)
- `assets/sprites/kiln/soldier_twin_earth.png` (새 파일)
- `assets/sprites/kiln/soldier_general_water.png` (새 파일)
- `assets/sprites/kiln/soldier_general_fire.png` (새 파일)
- `assets/sprites/kiln/soldier_general_earth.png` (새 파일)
- `assets/sprites/kiln/soldier_sniper_water.png` (새 파일)
- `assets/sprites/kiln/soldier_sniper_fire.png` (새 파일)
- `assets/sprites/kiln/soldier_sniper_earth.png` (새 파일)
- `assets/sprites/kiln/soldier_haetae_water.png` (새 파일)
- `assets/sprites/kiln/soldier_haetae_fire.png` (새 파일)
- `assets/sprites/kiln/soldier_haetae_earth.png` (새 파일)
- `assets/sprites/kiln/soldier_cheoyong_water.png` (새 파일)
- `assets/sprites/kiln/soldier_cheoyong_fire.png` (새 파일)
- `assets/sprites/kiln/soldier_cheoyong_earth.png` (새 파일)
- `assets/sprites/kiln/soldier_dragon_water.png` (새 파일)
- `assets/sprites/kiln/soldier_dragon_fire.png` (새 파일)
- `assets/sprites/kiln/soldier_dragon_earth.png` (새 파일)
- `assets/sprites/kiln/soldier_bulgasari_water.png` (새 파일)
- `assets/sprites/kiln/soldier_bulgasari_fire.png` (새 파일)
- `assets/sprites/kiln/soldier_bulgasari_earth.png` (새 파일)
- `assets/sprites/enemy/fox.png` (새 파일)
- `assets/sprites/enemy/armored.png` (새 파일)
- `assets/sprites/enemy/ghost.png` (새 파일)
- `assets/sprites/enemy/giant.png` (새 파일)
- `assets/sprites/enemy/chief.png` (새 파일)
- `assets/sprites/enemy/gumiho.png` (새 파일)
- `assets/sprites/enemy/imugi.png` (새 파일)
- `assets/sprites/enemy/reaper.png` (새 파일)
- `assets/sprites/enemy/king.png` (새 파일)

이 목록에 없는 파일은 만들거나 고치지 않는다.

## 보호 검사 결과 (Claude가 미리 확인함)
- `python3 scripts/protected.py <위 파일들>` → 걸린 파일 없음 (모두 새 파일)
- 이 검사는 Claude가 했다. Codex는 다시 돌리지 않는다.

## 하면 안 되는 일
- 범위 밖 파일 수정·삭제 (특히 `src/`, `tests/`, `art/references/`, `art/rubric.md`, 이미 있는 `assets/sprites/`)
- 게임 코드에 그림을 연결하는 작업 (이미 되어 있다)
- 저장소의 Python 스크립트 실행 (검사는 Claude가 작업 후에 한다)
- git commit / push
- 못 했는데 했다고 보고하기

## 끝나면 이 형식으로 보고
```
결과: 통과 | 실패 | 못 돌림   ← 셋 중 하나만
바뀐 파일:
- 경로 — 무엇을
직접 확인한 것:
- 예) 크기·투명 배경·기존 그림과 나란히 놓고 비교
그리는 데 쓴 방법:
- 이미지 생성 / 코드 / 둘 다 (무엇을 어떻게)
못 한 것 / 걱정되는 것:
- …
```
- 저장소의 Python 검사를 못 돌린 것만으로는 `못 돌림`이 아니다. 검사는 Claude가 한다.

## Claude가 받은 뒤 할 일
1. `git status` — 바뀐 파일이 위 범위뿐인지
2. `python3 scripts/check_sprites.py --group "가마의 병사 (등급 6단계 추가 8종)" --sheet work/2026-11-28-다듬기/sheet-06a.png` 와 `--group "챕터 적·대장" --sheet work/2026-11-28-다듬기/sheet-06b.png`
3. 게임 화면 스크린샷 (`tests/screens_proto.gd`): 아침 카드·전투·챕터 대장
4. `python3 scripts/test.py --stage all`
5. 사용자에게 보여 주고 "검사는 통과, 미술 판단은 사용자 몫" — 허락을 받은 뒤 커밋

warning: Codex is ignoring 1 unrecognized configuration setting. Check for typos or deprecated settings.
  user (C:\Users\pc\.codex\config.toml): `computer_use.windows.always_allowed_app_ids` is ignored.
warning: Codex is ignoring 1 unrecognized configuration setting. Check for typos or deprecated settings.
  user (C:\Users\pc\.codex\config.toml): `computer_use.windows.always_allowed_app_ids` is ignored.
codex
지시서 05의 진행 상태와 기존 그림을 먼저 확인하겠습니다. 이미지 생성 스킬을 사용하고, 이번 지시서에서 허용한 파일 범위를 지키겠습니다.

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content AGENTS.md; Get-Content PROTECTED.txt; git status --porcelain; Get-Content 'C:/Users/pc/.codex/skills/.system/imagegen/SKILL.md'" in C:\Users\pc\Documents\game
 succeeded in 429ms:
# AGENTS.md

紐⑤뱺 ?먯씠?꾪듃(Claude, Codex ????洹쒖튃? ???뚯씪 ??怨녹뿉留??대떎. CLAUDE.md ?????뚯씪??遺덈윭?ㅺ린留??쒕떎.

## 媛??癒쇱? 吏??寃?

1. **理쒖떊 吏?쒓? ???뚯씪蹂대떎 ?곗꽑?쒕떎.** ?ъ슜?먭? 吏湲???붿뿉????留먯씠 ???뚯씪怨??ㅻⅤ硫??ъ슜?먯쓽 留먯쓣 ?곕Ⅴ怨? 洹??댁슜???꾨옒 "?묒뾽 硫붾え" 洹쒖튃?濡??곷뒗??
2. **?ъ슜?먭? 吏곸젒 怨좎튇 ?뚯씪? ??뼱?곗? ?딅뒗??** 怨좎튂湲??꾩뿉 `python3 scripts/protected.py <?뚯씪...>` 濡??뺤씤?쒕떎. 嫄몃━硫?諛붽? ?댁슜???쒖븞留??섍퀬 ?먮?吏 ?딅뒗?? (`PROTECTED.txt`, 留덉?留?而ㅻ컠???ъ슜?먭? ???뚯씪, ?묒뾽 ?쒖옉 ???대? 而ㅻ컠 ????蹂寃쎌씠 ?덈뜕 ?뚯씪)
   - **Codex????寃?щ? 吏곸젒 ?뚮━吏 ?딅뒗??** Claude媛 吏?쒖꽌瑜??곌린 ?꾩뿉 ?뚮━怨?寃곌낵瑜?吏?쒖꽌???곷뒗?? Codex??吏?쒖꽌??"怨좎퀜???섎뒗 踰붿쐞" 諛뽮낵 `PROTECTED.txt` ???곹엺 ?뚯씪??嫄대뱶由ъ? ?딅뒗 寃껋쑝濡???洹쒖튃??吏?⑤떎.
3. **?먮룞 寃???듦낵???щ?쨌誘몄닠 ?뱀씤???꾨땲??** ?뚯뒪?맞룸큸쨌痢≪젙???듦낵?대룄 "寃?щ뒗 ?듦낵, ?щ?쨌誘몄닠 ?먮떒? ?ъ슜??紐??대씪怨?留먰븳?? ?ㅼ뒪濡?"?щ컡??, "?덉걯??, "?꾩꽦"?대씪怨?寃곕줎 ?댁? ?딅뒗??

## ?묒뾽 硫붾え

- ?묒뾽留덈떎 ?대뜑瑜?留뚮뱺?? `work/<YYYY-MM-DD>-<?묒뾽?대쫫>/` (洹몃┝ 猷⑦봽??`work/art-<?묒뾽>/`)
- 洹??덉쓽 `NOTES.md` ???묒뾽 以??덈줈 ?뺥븳 寃껋쓣 **?좎쭨? ?ъ슜??留?洹몃?濡?* ?곷뒗??
  ```
  - 2026-11-26 "蹂댁뒪 泥대젰? 吏湲덈낫??2?좊쭔 ??떠 以?
    ??src/core/data.gd ECHO_HP 議곗젙
  ```
- ?묒뾽 ?쒖옉 ??`git status --porcelain` 寃곌낵瑜?NOTES.md ??遺숈뿬 ?붾떎 (?대? ?덈뜕 ?ъ슜??蹂寃쎌쓣 援щ텇?섎젮怨?.
- ?묒뾽 硫붾え???곸? 寃껋씠 ?щ윭 ?묒뾽??怨꾩냽 ?곗씪 洹쒖튃?대㈃, ?ъ슜?먯뿉寃?臾쇱뼱蹂??????뚯씪濡???릿??

## ??븷 ?섎늻湲?

- **洹몃┝???꾩슂???묒뾽? Codex?먭쾶 ?섍릿??* ??`.claude/skills/codex-handoff/SKILL.md`
  - 吏?쒖꽌: 癒쇱? ?쎌쓣 寃?/ 紐⑺몴(?ъ슜??留?洹몃?濡? / 怨좎퀜???섎뒗 踰붿쐞 / ?섎㈃ ???섎뒗 ??
  - Codex 蹂닿퀬 泥?以? `寃곌낵: ?듦낵` | `寃곌낵: ?ㅽ뙣` | `寃곌낵: 紐??뚮┝`
  - Claude??諛붾??뚯씪쨌蹂댄샇 ?뚯씪쨌寃??룸젋?붾? **吏곸젒 ?ㅼ떆 ?뺤씤???ㅼ뿉留?* 而ㅻ컠?쒕떎.
- 肄붾뱶쨌?뚯뒪?맞룹륫?뺤? Claude媛 吏곸젒 ?쒕떎.
- Codex??而ㅻ컠쨌?몄떆?섏? ?딅뒗??
- Codex??????μ냼??Python ?ㅽ겕由쏀듃(寃??룻뀒?ㅽ듃쨌痢≪젙)瑜??뚮━吏 ?딅뒗?? Windows??Codex ?곌린 紐⑤뱶?먯꽌??Python???????녿떎. 寃?щ뒗 Claude媛 Codex ?묒뾽 ?꾪썑???쒕떎. Codex媛 寃?щ? 紐??뚮┛ 寃껊쭔?쇰줈??`紐??뚮┝`???꾨땲??

## ?꾨줈?앺듃 援ъ“

吏湲? **1遺??쒗뿕????媛?* ??B 媛留덉쓽 蹂묒궗, A ?뚯쓣 ?덈뒗 ??(湲고쉷??鍮꾧탳 `docs/湲고쉷??鍮꾧탳.md`). 泥??붾㈃ `src/game/launcher.tscn` ?먯꽌 怨좊Ⅸ??
吏???쒗뿕??**AFTERSELF (媛??** ??蹂대쪟 (`docs/湲고쉷??md`, `src/core/`). Godot 4.7, ?꾩뿉???대젮?ㅻ낫??2D ?쎌? ?꾪듃(???32횞32).

| ?꾩튂 | ?댁슜 |
|---|---|
| `src/proto/` | 1遺??쒗뿕??洹쒖튃 (?붾㈃怨?臾닿?). `data.gd` ?섏튂 쨌 `battle.gd` 怨듭슜 ?먮룞 ?꾪닾 쨌 `kiln.gd` 媛留?쨌 `nest.gd` ?μ? |
| `src/core/` | (蹂대쪟) AFTERSELF 洹쒖튃 (?붾㈃怨?臾닿?). `data.gd` ?섏튂 쨌 `world.gd` 諛??섎굹???꾪닾 쨌 `run.gd` ?????먮쫫 쨌 `habits.gd` ?듦? 湲곕줉 쨌 `echo.gd` ?댁젣????쨌 `save.gd` ???ъ씠 ???|
| `src/game/` | ?붾㈃쨌?낅젰. `launcher` 泥??붾㈃ 쨌 `kiln_scene` 쨌 `nest_scene` 쨌 `proto_base` 怨듯넻 ?곗텧 쨌 `main` (蹂대쪟) AFTERSELF. 洹쒖튃???쎌뼱??洹몃━湲곕쭔 ?쒕떎 |
| `assets/` | 寃뚯엫???ㅼ뼱媛??洹몃┝쨌湲瑗?(湲瑗? 媛덈Т由? OFL). 洹몃┝? `assets/sprites/` ??紐⑸줉 `art/sprite_list.json`, ?ㅻ챸 `docs/洹몃┝-紐⑸줉.md`. ?뚯씪???덉쑝硫?寃뚯엫???곌퀬, ?놁쑝硫??꾪삎?쇰줈 洹몃┛??|
| `tests/` | Godot ?뚯뒪??(`test_p0.gd`, `test_p1.gd`, `test_boss.gd`), 遊? ?깅뒫 痢≪젙(`bench.gd`), ?ㅽ겕由곗꺑(`screens.gd`) |
| `art/` | 洹몃┝ 猷⑦봽??湲곗? 洹몃┝쨌湲곗???(寃뚯엫?????ㅼ뼱媛? |

- 洹쒖튃? `src/proto/`(吏湲? 쨌 `src/core/`(蹂대쪟) ?먮쭔 ?대떎. ?붾㈃ 肄붾뱶?먯꽌 洹쒖튃??諛붽씀吏 ?딅뒗??(?뚯뒪?맞룸큸???붾㈃ ?놁씠 洹쒖튃???뚮━湲??뚮Ц).
- ?섏튂(諛몃윴????`src/proto/data.gd`(吏湲? ??怨녹뿉?쒕쭔 諛붽씔??
- **洹몃━湲?痢?(HD-2D)**: ?붾㈃? 1280횞800 ?쇰줈 洹몃━怨??ㅽ뻾 以묒뿉 canvas_items 濡?諛붽퓞), ?쎌? 洹몃┝? ?먮졆?섍쾶, 鍮쎛룹븞媛쒕뒗 遺?쒕읇寃? 痢? `bg` 諛붾떏 ??`back` 洹몃┝?먃룸뮮鍮쎛룹븞媛???湲곕낯(罹먮┃?걔톃I) ??`glow` 鍮?媛???쇳빀) ??`front` ???덇컻쨌諛??됯컧쨌鍮꾨꽕??(`src/game/glow_layer.gd`, `proto_base.gd` ??`draw_layer`). ?꾪닾媛 蹂댁씪 ??湲곕낯痢듭? ?붾㈃ ?꾩껜瑜?移좏븯吏 ?딅뒗??(`draw_screen_bg`).
- **?댄럺???좊땲硫붿씠??*: `assets/sprites/fx/<?대쫫>.png` (?뺤궗媛곹삎 ?λ㈃??媛濡???以? ???덉쑝硫?`play_fx` 濡??ъ깮, ?놁쑝硫?肄붾뱶 ?④낵.
- **?듭슱?섏? ?딆? ??* (?ъ슜???붿껌): ?덉쟾 援ш컙? 諛섎뱶??蹂댄넻 ?댁긽 쨌 ?뺣쪧? ?붾㈃???レ옄濡?쨌 ?ㅽ뙣?섎㈃ ?뚰렪/議곌컖 쨌 3媛?紐⑥씠硫??뺤젙 蹂댁긽. ??洹쒖튃??源⑤뒗 蹂寃쎌? ?ъ슜?먯뿉寃?癒쇱? 臾삳뒗??
- `work/`, `reports/`, `docs/`, `scripts/`, `perf/`, `art/` ?먮뒗 `.gdignore` 媛 ?덉뼱 Godot 媛 ?쎌? ?딅뒗??

## ?ㅽ뻾 ?섍꼍

- ??臾몄꽌??`python3` 紐낅졊? Windows?먯꽌 `python3` ?????섎㈃ `python` ?쇰줈 諛붽퓭 ?ㅽ뻾?쒕떎 (媛숈? 寃?.
- Godot: `scripts/godot_cmd.py` 媛 李얜뒗??(?섍꼍 蹂??`GODOT` ??PATH ??`godot` ??Windows 湲곕낯 ?꾩튂??`*_console.exe`). 紐?李얠쑝硫??섍꼍 蹂??`GODOT` ???ㅽ뻾 ?뚯씪 寃쎈줈瑜??ｋ뒗?? Windows??李??녿뒗 ?ㅽ뻾???꾪빐 `_console.exe` 瑜??대떎.
- ?붾㈃ ?뺤씤(?ㅽ겕由곗꺑): `godot --path . --script res://tests/screens_proto.gd -- <????대뜑>` (吏???쒗뿕?먯? `screens.gd`) (?붾㈃???덈뒗 ?섍꼍?먯꽌. ?쒕쾭?먯꽌??Xvfb ?꾩슂). ?붾㈃??諛붽씀硫??ㅽ겕由곗꺑??吏곸젒 ?댁뼱 ?뺤씤?쒕떎.
- Codex??`codex exec` (Codex CLI)濡?遺瑜몃떎. git ??μ냼 ?대뜑 ?덉뿉?쒕쭔 ?ㅽ뻾?쒕떎.
  ?곌린 ?묒뾽? `--sandbox workspace-write`, ?쎄린留??섎㈃ `--sandbox read-only` (Codex CLI 0.172 湲곗?. `--full-auto` ???놁쓬).

## ?먮룞 ?뚯뒪??

| ?④퀎 | ??| ?꾩튂 |
|---|---|---|
| P0 | 源⑥?硫?寃뚯엫?????섎뒗 寃?(?쒖옉쨌?대룞쨌怨듦꺽쨌二쎌쓬?믩찓?꾨━쨌媛숈? ?쒕뱶 媛숈? 寃곌낵) | `tests/test_p0.gd` |
| P1 | 寃뚯엫 ?꾨컲. 1遺??쒗뿕??媛留??뺣쪧쨌?뚰렪 ?뺤젙쨌???곗쭚쨌癒뱀씠쨌?⑸룞 湲곗닠쨌洹좏삎) `tests/test_proto.gd` + AFTERSELF `tests/test_p1.gd` | `tests/test_proto.gd`, `tests/test_p1.gd` |
| boss | ?댁젣???섍? ?듦?쨌鍮뚮뱶瑜??곕씪 ?섎뒗吏 + 遺꾩꽍?쒕? ?쎈뒗 遊?`reader`)???щ윭 ?댁젣???섏? ?몄? ??源쇰뒗吏쨌嫄몃┛ ?쒓컙쨌?껋? 泥대젰 | `tests/test_boss.gd` ??`reports/boss/` |

```bash
python3 scripts/test.py              # 諛붾??뚯씪??留욌뒗 ?④퀎留?
python3 scripts/test.py --dry-run    # 臾댁뾿???뚮┫吏留?
python3 scripts/test.py --stage all  # ?꾨?
```

- ?뚯씪 ???④퀎 ?곌껐? `test_map.json`. ???대뜑쨌?뚯씪??留뚮뱾硫??ш린??洹쒖튃??異붽??쒕떎.
- 寃뚯엫 洹쒖튃(`src/core/*.gd`)??怨좎튂硫?boss ?④퀎媛 媛숈씠 ?덈떎: Claude媛 怨좎튇 吏곹썑(`.claude/hooks/after_edit.py`) + 而ㅻ컠 ??`.githooks/pre-commit`).
- ?뚯뒪???⑥닔??`test_` 濡??쒖옉?섍퀬, ?앷퉴吏 媛硫?`return true`. ?뺤씤? `check(議곌굔, "?ㅻ챸")`.
- 遊뉕낵 ?댁젣???섎뒗 媛숈? ?먮뇤(`echo.gd` ??`Brain`)瑜??곌퀬, ?뚮젅?댁뼱 議곗옉(?대룞쨌議곗?쨌怨듦꺽쨌援щⅤ湲?留??몃떎. 寃뚯엫 ?대? 媛믪쓣 吏곸젒 諛붽씀吏 ?딅뒗??
- ?뚯뒪?몃? ?듦낵?쒗궎?ㅺ퀬 ?뚯뒪?몃굹 遊?湲곗????먯뒯?섍쾶 怨좎튂吏 ?딅뒗?? 怨좎퀜???섎㈃ ?댁쑀瑜??ъ슜?먯뿉寃?癒쇱? 留먰븳??

## ?깅뒫 寃??

議곌굔(??120留덈━ + ?댁젣???? ?쒕뱶 42, 600?꾨젅?? 怨좎젙 ?낅젰)? `tests/bench.gd` 留????곸닔濡?怨좎젙?쒕떎. ?붾㈃ 洹몃━湲곕뒗 鍮쇨퀬 洹쒖튃 怨꾩궛留??곕떎.

1. `python3 perf/bench.py profile` ???⑥닔(?쒖뒪??蹂??꾨젅???쒓컙, 蹂묐ぉ 李얘린
2. 怨좎튂湲??? `python3 perf/bench.py baseline` ??寃곌낵 吏臾????
3. 怨좎튇 ?? `python3 perf/bench.py compare` ??諛붽씀湲??꾧낵 寃곌낵媛 媛숈?吏 (?뚭? ?뚯뒪??. ?ㅻⅤ硫??깅뒫 媛쒖꽑?쇰줈 ?몄젙?섏? ?딅뒗??
4. `python3 perf/bench.py fps --note "臾댁뾿??諛붽엥??` ??FPS ?됯퇏쨌1% ??먯쓣 媛숈? 議곌굔?먯꽌 ?ъ꽌 `perf/records.csv` ???좎쭨? ?④퍡 ?④릿?? 怨좎튂湲??꽷룻썑 ?????곕떎.

- 寃곌낵媛 ?쇰????щ씪?몄빞 ?섎뒗 蹂寃?寃뚯엫 洹쒖튃 蹂寃??대㈃ ?ъ슜?먯뿉寃?留먰븯怨?baseline ???덈줈 ??ν븳 ?댁쑀瑜?NOTES.md ???곷뒗??

## 洹몃┝ 寃??

- Codex媛 洹몃┝???ｌ쑝硫? `python3 scripts/check_sprites.py [--group ?대쫫] [--sheet 鍮꾧탳?쒗듃.png]` ???ш린쨌?щ챸 諛곌꼍쨌????24媛??댄븯)쨌?먮┛ 媛?μ옄由?
- 洹몃떎???ㅽ겕由곗꺑?쇰줈 寃뚯엫 ?붾㈃?먯꽌 吏곸젒 蹂몃떎. 洹몃┝泥??먮떒? ?ъ슜??紐?

## 洹몃┝ 猷⑦봽

??`.claude/skills/art-loop/SKILL.md`, ?꾧뎄 `scripts/art_loop.py`, 湲곕낯媛?`art/loop_config.json`

- ?뚯감留덈떎 `work/art-<?묒뾽>/round_NN/` ?ㅻ깄??
- ? ???덈뒗 寃??≫떚, ?딄릿 ??? ?ㅽ겕由쏀듃濡??곕떎.
- "AI ??? "?곕━ 洹몃┝泥댁? ?댁슱由щ뒗吏"??泥섏쓬 蹂대뒗 寃?좎옄 2紐낆씠 `art/rubric.md` ? `art/references/` 留?蹂닿퀬 梨꾩젏 ???됯퇏
- ?뚯감 ?곹븳(湲곕낯 6), 2???곗냽 ?먯닔媛 ???ㅻⅤ硫?硫덉텛怨??ъ슜?먯뿉寃?鍮꾧탳 ?쒗듃瑜?蹂댁뿬 以??

## 而ㅻ컠

- 而ㅻ컠 ?꾩뿉 `python3 scripts/test.py` 媛 ?듦낵?댁빞 ?쒕떎 (pre-commit ?낆씠 ?먮룞?쇰줈 ?뚮┝).
- 泥섏쓬 諛쏆? ??μ냼?쇰㈃ `git config core.hooksPath .githooks` 瑜???踰??ㅽ뻾?쒕떎.
- 而ㅻ컠 硫붿떆吏??臾댁뾿????諛붽엥?붿?, ?뚮┛ 寃?ъ? 寃곌낵瑜??곷뒗??
# ?ъ슜?먭? 吏곸젒 怨좎튇 ?뚯씪 / ??뼱?곕㈃ ???섎뒗 ?뚯씪 (??以꾩뿉 ?섎굹, glob 媛??
# Claude쨌Codex???ш린 ?곹엺 ?뚯씪????뼱?곗? ?딅뒗?? 怨좎퀜???섎㈃ 諛붽? ?댁슜???쒖븞留??쒕떎.
art/references/*
art/rubric.md
 M assets/sprites/enemy/goblin.png
 M assets/sprites/field/house.png
 M assets/sprites/kiln/kiln_body.png.import
 M assets/sprites/kiln/soldier_archer_earth.png.import
 M assets/sprites/kiln/soldier_archer_fire.png.import
 M assets/sprites/kiln/soldier_archer_water.png.import
 M assets/sprites/kiln/soldier_shield_earth.png.import
 M assets/sprites/kiln/soldier_shield_fire.png.import
 M assets/sprites/kiln/soldier_shield_water.png.import
 M assets/sprites/kiln/soldier_spear_earth.png.import
 M assets/sprites/kiln/soldier_spear_fire.png.import
 M assets/sprites/kiln/soldier_spear_water.png.import
 M reports/boss/history.csv
 M "work/2026-11-27-\352\267\270\353\246\274/NOTES.md"
 M "work/2026-11-27-\352\267\270\353\246\274/handoff-03.md"
?? assets/sprites/enemy/brute.png
?? assets/sprites/enemy/brute.png.import
?? assets/sprites/enemy/goblin.png.import
?? assets/sprites/enemy/imp.png
?? assets/sprites/enemy/imp.png.import
?? assets/sprites/field/battlefield.png
?? assets/sprites/field/battlefield.png.import
?? assets/sprites/field/grass_a.png
?? assets/sprites/field/grass_a.png.import
?? assets/sprites/field/grass_b.png
?? assets/sprites/field/grass_b.png.import
?? assets/sprites/field/house.png.import
?? assets/sprites/field/house_broken.png
?? assets/sprites/field/house_broken.png.import
?? assets/sprites/fx/
?? assets/sprites/kiln/soldier_axe_earth.png
?? assets/sprites/kiln/soldier_axe_earth.png.import
?? assets/sprites/kiln/soldier_axe_fire.png
?? assets/sprites/kiln/soldier_axe_fire.png.import
?? assets/sprites/kiln/soldier_axe_water.png
?? assets/sprites/kiln/soldier_axe_water.png.import
?? assets/sprites/kiln/soldier_cannon_earth.png
?? assets/sprites/kiln/soldier_cannon_earth.png.import
?? assets/sprites/kiln/soldier_cannon_fire.png
?? assets/sprites/kiln/soldier_cannon_fire.png.import
?? assets/sprites/kiln/soldier_cannon_water.png
?? assets/sprites/kiln/soldier_cannon_water.png.import
?? assets/sprites/kiln/soldier_cavalry_earth.png
?? assets/sprites/kiln/soldier_cavalry_earth.png.import
?? assets/sprites/kiln/soldier_cavalry_fire.png
?? assets/sprites/kiln/soldier_cavalry_fire.png.import
?? assets/sprites/kiln/soldier_cavalry_water.png
?? assets/sprites/kiln/soldier_cavalry_water.png.import
?? assets/sprites/kiln/soldier_healer_earth.png
?? assets/sprites/kiln/soldier_healer_earth.png.import
?? assets/sprites/kiln/soldier_healer_fire.png
?? assets/sprites/kiln/soldier_healer_fire.png.import
?? assets/sprites/kiln/soldier_healer_water.png
?? assets/sprites/kiln/soldier_healer_water.png.import
?? assets/sprites/nest/
?? reports/boss/history-local-backup.csv
?? src/proto/kiln_run.gd.uid
?? tests/sweep_kiln.gd.uid
?? tests/test_kiln_run.gd.uid
?? "work/2026-11-27-\352\267\270\353\246\274/compare-03-screens.png"
?? "work/2026-11-27-\352\267\270\353\246\274/compare-03.png"
?? "work/2026-11-27-\352\267\270\353\246\274/handoff-03-run1/"
?? "work/2026-11-27-\352\267\270\353\246\274/handoff-03-run2/"
?? "work/2026-11-27-\352\267\270\353\246\274/handoff-03.report.md"
?? "work/2026-11-27-\352\267\270\353\246\274/screens-02b/"
?? "work/2026-11-27-\352\267\270\353\246\274/screens-03-run1/"
?? "work/2026-11-27-\352\267\270\353\246\274/screens-03-run2/"
?? "work/2026-11-27-\354\213\244\352\260\220/handoff-04.report.md"
?? "work/2026-11-27-\354\213\244\352\260\220/sheet-04.png"
?? "work/2026-11-28-\353\213\244\353\223\254\352\270\260/handoff-05.report.md"
?? "work/2026-11-28-\353\213\244\353\223\254\352\270\260/handoff-06.report.md"
?? "work/2026-11-28-\353\213\244\353\223\254\352\270\260/screens-05/"
?? "work/2026-11-28-\353\213\244\353\223\254\352\270\260/sheet-05.png"
---
name: "imagegen"
description: "Generate or edit raster images when the task benefits from AI-created bitmap visuals such as photos, illustrations, textures, sprites, mockups, or transparent-background cutouts. Use when Codex should create a brand-new image, transform an existing image, or derive visual variants from references, and the output should be a bitmap asset rather than repo-native code or vector. Do not use when the task is better handled by editing existing SVG/vector/code-native assets, extending an established icon or logo system, or building the visual directly in HTML/CSS/canvas."
---

# Image Generation Skill

Generates or edits images for the current project (for example website assets, game assets, UI mockups, product mockups, wireframes, logo design, photorealistic images, or infographics).

## Top-level modes and rules

This skill has exactly two top-level modes:

- **Default built-in tool mode (preferred):** built-in `image_gen` tool for image generation, editing, and transparent-image requests. Does not require `OPENAI_API_KEY`.
- **Fallback CLI mode:** `scripts/image_gen.py` CLI. Use when the user explicitly asks for or confirms the CLI/API/model path. Requires `OPENAI_API_KEY`.

Within CLI fallback, the CLI exposes three subcommands:

- `generate`
- `edit`
- `generate-batch`

Rules:
- Use the built-in `image_gen` tool by default for normal image generation and editing requests.
- Do not switch to CLI fallback for ordinary quality, size, or file-path control.
- For transparent images, ask built-in `image_gen` for a transparent background and preserve the generated alpha.
- Never silently switch from built-in `image_gen` or CLI `gpt-image-2` to CLI `gpt-image-1.5`; ask the user first unless they explicitly requested `gpt-image-1.5`.
- The word `batch` by itself does not mean CLI fallback. If the user asks for many assets or says to batch-generate assets without explicitly asking for CLI/API/model controls, stay on the built-in path and issue one built-in call per requested asset or variant.
- If the built-in tool fails or is unavailable, tell the user the CLI fallback exists and that it requires `OPENAI_API_KEY`. Proceed only if the user explicitly asks for that fallback.
- If the user explicitly asks for CLI mode, use the bundled `scripts/image_gen.py` workflow. Do not create one-off SDK runners.
- Never modify `scripts/image_gen.py`. If something is missing, ask the user before doing anything else.

Built-in save-path policy:
- In built-in tool mode, Codex saves generated images under `$CODEX_HOME/*` by default.
- Do not describe or rely on OS temp as the default built-in destination.
- Do not describe or rely on a destination-path argument (if any) on the built-in `image_gen` tool. If a specific location is needed, generate first and then move or copy the selected output from `$CODEX_HOME/generated_images/...`.
- Save-path precedence in built-in mode:
  1. If the user names a destination, move or copy the selected output there.
  2. If the image is meant for the current project, move or copy the final selected image into the workspace before finishing.
  3. If the image is only for preview or brainstorming, render it inline; the underlying file can remain at the default `$CODEX_HOME/*` path.
- Never leave a project-referenced asset only at the default `$CODEX_HOME/*` path.
- Do not overwrite an existing asset unless the user explicitly asked for replacement; otherwise create a sibling versioned filename such as `hero-v2.png` or `item-icon-edited.png`.

Shared prompt guidance for both modes lives in `references/prompting.md` and `references/sample-prompts.md`.

Fallback-only docs/resources for CLI mode:
- `references/cli.md`
- `references/image-api.md`
- `references/codex-network.md`
- `scripts/image_gen.py`

## When to use
- Generate a new image (concept art, product shot, cover, website hero)
- Generate a new image using one or more reference images for style, composition, or mood
- Edit an existing image (inpainting, lighting or weather transformations, background replacement, object removal, compositing, transparent background)
- Produce many assets or variants for one task

## When not to use
- Extending or matching an existing SVG/vector icon set, logo system, or illustration library inside the repo
- Creating simple shapes, diagrams, wireframes, or icons that are better produced directly in SVG, HTML/CSS, or canvas
- Making a small project-local asset edit when the source file already exists in an editable native format
- Any task where the user clearly wants deterministic code-native output instead of a generated bitmap

## Decision tree

Think about two separate questions:

1. **Intent:** is this a new image or an edit of an existing image?
2. **Execution strategy:** is this one asset or many assets/variants?

Intent:
- If the user wants to modify an existing image while preserving parts of it, treat the request as **edit**.
- If the user provides images only as references for style, composition, mood, or subject guidance, treat the request as **generate**.
- If the user provides no images, treat the request as **generate**.

Built-in edit semantics:
- Built-in edit mode is for images already visible in the conversation context, such as attached images or images generated earlier in the thread.
- If the user wants to edit a local image file with the built-in tool, first load it with built-in `view_image` tool so the image is visible in the conversation context, then proceed with the built-in edit flow.
- Do not promise arbitrary filesystem-path editing through the built-in tool.
- If a local file still needs direct file-path control, masks, or other explicit CLI-only parameters, use the explicit CLI fallback only when the user asks for it.
- For edits, preserve invariants aggressively and save non-destructively by default.

Execution strategy:
- In the built-in default path, produce many assets or variants by issuing one `image_gen` call per requested asset or variant.
- In the CLI fallback path, use the CLI `generate-batch` subcommand only when the user explicitly chose CLI mode and needs many prompts/assets.
- For many distinct assets, do not use `n` as a substitute for separate prompts. `n` is for variants of one prompt; distinct assets need distinct built-in calls or distinct CLI `generate-batch` jobs.

Assume the user wants a new image unless they clearly ask to change an existing one.

## Workflow
1. Decide the top-level mode: built-in by default, including transparent-output requests; fallback CLI only if explicitly requested or confirmed.
2. Decide the intent: `generate` or `edit`.
3. Decide whether the output is preview-only or meant to be consumed by the current project.
4. Decide the execution strategy: single asset vs repeated built-in calls vs CLI `generate-batch`.
5. Collect inputs up front: prompt(s), exact text (verbatim), constraints/avoid list, and any input images.
6. For every input image, label its role explicitly:
   - reference image
   - edit target
   - supporting insert/style/compositing input
7. If the edit target is only on the local filesystem and you are staying on the built-in path, inspect it with `view_image` first so the image is available in conversation context.
8. If the user asked for a photo, illustration, sprite, product image, banner, or other explicitly raster-style asset, use `image_gen` rather than substituting SVG/HTML/CSS placeholders. If the request is for an icon, logo, or UI graphic that should match existing repo-native SVG/vector/code assets, prefer editing those directly instead.
9. Augment the prompt based on specificity:
   - If the user's prompt is already specific and detailed, normalize it into a clear spec without adding creative requirements.
   - If the user's prompt is generic, add tasteful augmentation only when it materially improves output quality.
10. Use the built-in `image_gen` tool by default.
11. For transparent-output requests, ask built-in `image_gen` for a transparent background and preserve the generated alpha channel.
12. Inspect outputs and validate: subject, style, composition, text accuracy, and invariants/avoid items.
13. Iterate with a single targeted change, then re-check.
14. For preview-only work, render the image inline; the underlying file may remain at the default `$CODEX_HOME/generated_images/...` path.
15. For project-bound work, move or copy the selected artifact into the workspace and update any consuming code or references. Never leave a project-referenced asset only at the default `$CODEX_HOME/generated_images/...` path.
16. For batches or multi-asset requests, persist every requested deliverable final in the workspace unless the user explicitly asked to keep outputs preview-only. Discarded variants do not need to be kept unless requested.
17. If the user explicitly chooses or confirms the CLI fallback, then use the fallback-only docs for model, quality, size, `input_fidelity`, masks, output format, output paths, and network setup.
18. Always report the final saved path(s) for any workspace-bound asset(s), plus the final prompt or prompt set and whether the built-in tool or fallback CLI mode was used.

## Transparent image requests

Ask built-in `image_gen` for a genuinely transparent background and preserve its alpha.

## Prompt augmentation

Reformat user prompts into a structured, production-oriented spec. Make the user's goal clearer and more actionable, but do not blindly add detail.

Treat this as prompt-shaping guidance, not a closed schema. Use only the lines that help, and add a short extra labeled line when it materially improves clarity.

### Specificity policy

Use the user's prompt specificity to decide how much augmentation is appropriate:

- If the prompt is already specific and detailed, preserve that specificity and only normalize/structure it.
- If the prompt is generic, you may add tasteful augmentation when it will materially improve the result.

Allowed augmentations:
- composition or framing hints
- polish level or intended-use hints
- practical layout guidance
- reasonable scene concreteness that supports the stated request

Not allowed augmentations:
- extra characters or objects that are not implied by the request
- brand names, slogans, palettes, or narrative beats that are not implied
- arbitrary side-specific placement unless the surrounding layout supports it

## Use-case taxonomy (exact slugs)

Classify each request into one of these buckets and keep the slug consistent across prompts and references.

Generate:
- photorealistic-natural ??candid/editorial lifestyle scenes with real texture and natural lighting.
- product-mockup ??product/packaging shots, catalog imagery, merch concepts.
- ui-mockup ??app/web interface mockups and wireframes; specify the desired fidelity.
- infographic-diagram ??diagrams/infographics with structured layout and text.
- scientific-educational ??classroom explainers, scientific diagrams, and learning visuals with required labels and accuracy constraints.
- ads-marketing ??campaign concepts and ad creatives with audience, brand position, scene, and exact tagline/copy.
- productivity-visual ??slide, chart, workflow, and data-heavy business visuals.
- logo-brand ??logo/mark exploration, vector-friendly.
- illustration-story ??comics, children?셲 book art, narrative scenes.
- stylized-concept ??style-driven concept art, 3D/stylized renders.
- historical-scene ??period-accurate/world-knowledge scenes.

Edit:
- text-localization ??translate/replace in-image text, preserve layout.
- identity-preserve ??try-on, person-in-scene; lock face/body/pose.
- precise-object-edit ??remove/replace a specific element (including interior swaps).
- lighting-weather ??time-of-day/season/atmosphere changes only.
- background-extraction ??transparent background / clean cutout. Ask built-in `image_gen` for actual transparency.
- style-transfer ??apply reference style while changing subject/scene.
- compositing ??multi-image insert/merge with matched lighting/perspective.
- sketch-to-render ??drawing/line art to photoreal render.

## Shared prompt schema

Use the following labeled spec as shared prompt scaffolding for both top-level modes:

```text
Use case: <taxonomy slug>
Asset type: <where the asset will be used>
Primary request: <user's main prompt>
Input images: <Image 1: role; Image 2: role> (optional)
Scene/backdrop: <environment>
Subject: <main subject>
Style/medium: <photo/illustration/3D/etc>
Composition/framing: <wide/close/top-down; placement>
Lighting/mood: <lighting + mood>
Color palette: <palette notes>
Materials/textures: <surface details>
Text (verbatim): "<exact text>"
Constraints: <must keep/must avoid>
Avoid: <negative constraints>
```

Notes:
- `Asset type` and `Input images` are prompt scaffolding, not dedicated CLI flags.
- `Scene/backdrop` refers to the visual setting. It is not the same as the fallback CLI `background` parameter, which controls output transparency behavior.
- Fallback-only execution notes such as `Quality:`, `Input fidelity:`, masks, output format, and output paths belong in the CLI path only. Do not treat them as built-in `image_gen` tool arguments.

Augmentation rules:
- Keep it short.
- Add only the details needed to improve the prompt materially.
- For edits, explicitly list invariants (`change only X; keep Y unchanged`).
- If any critical detail is missing and blocks success, ask a question; otherwise proceed.

## Examples

### Generation example (hero image)
```text
Use case: product-mockup
Asset type: landing page hero
Primary request: a minimal hero image of a ceramic coffee mug
Style/medium: clean product photography
Composition/framing: wide composition with usable negative space for page copy if needed
Lighting/mood: soft studio lighting
Constraints: no logos, no text, no watermark
```

### Edit example (invariants)
```text
Use case: precise-object-edit
Asset type: product photo background replacement
Primary request: replace only the background with a warm sunset gradient
Constraints: change only the background; keep the product and its edges unchanged; no text; no watermark
```

## Prompting best practices
- Structure prompt as scene/backdrop -> subject -> details -> constraints.
- Include intended use (ad, UI mock, infographic) to set the mode and polish level.
- Use camera/composition language for photorealism.
- Only use SVG/vector stand-ins when the user explicitly asked for vector output or a non-image placeholder.
- Quote exact text and specify typography + placement.
- For tricky words, spell them letter-by-letter and require verbatim rendering.
- For multi-image inputs, reference images by index and describe how they should be used.
- For edits, repeat invariants every iteration to reduce drift.
- Iterate with single-change follow-ups.
- If the prompt is generic, add only the extra detail that will materially help.
- If the prompt is already detailed, normalize it instead of expanding it.
- For CLI fallback only, see `references/cli.md` and `references/image-api.md` for model, `quality`, `input_fidelity`, masks, output format, and output-path guidance.
- For transparent images, ask built-in `image_gen` for actual transparency and preserve its alpha.

More principles shared by both modes: `references/prompting.md`.
Copy/paste specs shared by both modes: `references/sample-prompts.md`.

## Guidance by asset type
Asset-type templates (website assets, game assets, wireframes, logo) are consolidated in `references/sample-prompts.md`.

## gpt-image-2 guidance for CLI fallback

The fallback CLI defaults to `gpt-image-2`.

- Use `gpt-image-2` for new CLI/API workflows unless the user confirms a different model.
- CLI `gpt-image-2` does not support `background=transparent`; ask before using `gpt-image-1.5` unless the user explicitly requested that model.
- `gpt-image-2` always uses high fidelity for image inputs; do not set `input_fidelity` with this model.
- `gpt-image-2` supports `quality` values `low`, `medium`, `high`, and `auto`.
- Use `quality low` for fast drafts, thumbnails, and quick iterations. Use `medium`, `high`, or `auto` for final assets, dense text, diagrams, identity-sensitive edits, or high-resolution outputs.
- Square images are typically fastest to generate. Use `1024x1024` for fast square drafts.
- If the user asks for 4K-style output, use `3840x2160` for landscape or `2160x3840` for portrait.
- `gpt-image-2` size may be `auto` or `WIDTHxHEIGHT` if all constraints hold: max edge `<= 3840px`, both edges multiples of `16px`, long-to-short ratio `<= 3:1`, total pixels between `655,360` and `8,294,400`.

Popular `gpt-image-2` sizes:
- `1024x1024` square
- `1536x1024` landscape
- `1024x1536` portrait
- `2048x2048` 2K square
- `2048x1152` 2K landscape
- `3840x2160` 4K landscape
- `2160x3840` 4K portrait
- `auto`

## Fallback CLI mode only

### Temp and output conventions
These conventions apply only to the CLI fallback. They do not describe built-in `image_gen` output behavior.
- Use `tmp/imagegen/` for intermediate files (for example JSONL batches); delete them when done.
- Write final artifacts under `output/imagegen/`.
- Use `--out` or `--out-dir` to control output paths; keep filenames stable and descriptive.

### Dependencies
Prefer `uv` for dependency management in this repo.

Required Python package:
```bash
uv pip install openai
```

Optional for image inspection and downscaling:
```bash
uv pip install pillow
```

Portability note:
- If you are using the installed skill outside this repo, install dependencies into that environment with its package manager.
- In uv-managed environments, `uv pip install ...` remains the preferred path.

### Environment
- `OPENAI_API_KEY` must be set for live API calls.
- Do not ask the user for `OPENAI_API_KEY` when using the built-in `image_gen` tool.
- Never ask the user to paste the full key in chat. Ask them to set it locally and confirm when ready.

If the key is missing, give the user these steps:
1. Create an API key in the OpenAI platform UI: https://platform.openai.com/api-keys
2. Set `OPENAI_API_KEY` as an environment variable in their system.
3. Offer to guide them through setting the environment variable for their OS/shell if needed.

If installation is not possible in this environment, tell the user which dependency is missing and how to install it into their active environment.

### Script-mode notes
- CLI commands + examples: `references/cli.md`
- API parameter quick reference: `references/image-api.md`
- Network approvals / sandbox settings for CLI mode: `references/codex-network.md`

## Reference map
- `references/prompting.md`: shared prompting principles for both modes.
- `references/sample-prompts.md`: shared copy/paste prompt recipes for both modes.
- `references/cli.md`: fallback-only CLI usage via `scripts/image_gen.py`.
- `references/image-api.md`: fallback-only API/CLI parameter reference.
- `references/codex-network.md`: fallback-only network/sandbox troubleshooting for CLI mode.
- `scripts/image_gen.py`: fallback-only CLI implementation. Use only when the user explicitly chooses or confirms CLI mode.

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-ChildItem 'work/2026-11-28-다듬기'; Get-ChildItem art/references; Get-ChildItem assets/sprites/kiln/soldier_*.png; Get-Content 'work/2026-11-28-다듬기/NOTES.md'" in C:\Users\pc\Documents\game
 succeeded in 382ms:


    디렉터리: C:\Users\pc\Documents\game\work\2026-11-28-다듬기


Mode                 LastWriteTime         Length Name                                                                 
----                 -------------         ------ ----                                                                 
d-----        2026-11-27   오후 6:53                screens-05                                                           
-a----        2026-11-27   오후 6:33           9594 handoff-05.md                                                        
-a----        2026-11-27   오후 6:51         430761 handoff-05.report.md                                                 
-a----        2026-11-27   오후 7:22          17387 handoff-06.md                                                        
-a----        2026-11-27   오후 7:23              0 handoff-06.report.md                                                 
-a----        2026-11-27   오후 7:22           5646 NOTES.md                                                             
-a----        2026-11-27   오후 6:51          10174 sheet-05.png                                                         


    디렉터리: C:\Users\pc\Documents\game\art\references


Mode                 LastWriteTime         Length Name                                                                 
----                 -------------         ------ ----                                                                 
-a----        2026-11-27   오후 2:58            988 creature_shield_water.png                                            
-a----        2026-11-27   오후 2:58           1083 goblin.png                                                           
-a----        2026-11-27   오후 2:58           1169 house.png                                                            
-a----        2026-11-26  오후 11:56            194 README.md                                                            
-a----        2026-11-27   오후 2:58          36952 sheet.png                                                            
-a----        2026-11-27   오후 2:58           1112 soldier_archer_water.png                                             
-a----        2026-11-27   오후 2:58            800 soldier_shield_earth.png                                             
-a----        2026-11-27   오후 2:58            797 soldier_spear_fire.png                                               


    디렉터리: C:\Users\pc\Documents\game\assets\sprites\kiln


Mode                 LastWriteTime         Length Name                                                                 
----                 -------------         ------ ----                                                                 
-a----        2026-11-27   오후 3:30            456 soldier_archer_earth.png                                             
-a----        2026-11-27   오후 3:30            438 soldier_archer_fire.png                                              
-a----        2026-11-27   오후 3:30            473 soldier_archer_water.png                                             
-a----        2026-11-27   오후 6:47            393 soldier_axe_earth.png                                                
-a----        2026-11-27   오후 6:47            412 soldier_axe_fire.png                                                 
-a----        2026-11-27   오후 6:47            418 soldier_axe_water.png                                                
-a----        2026-11-27   오후 6:50            458 soldier_cannon_earth.png                                             
-a----        2026-11-27   오후 6:50            465 soldier_cannon_fire.png                                              
-a----        2026-11-27   오후 6:50            469 soldier_cannon_water.png                                             
-a----        2026-11-27   오후 6:47            353 soldier_cavalry_earth.png                                            
-a----        2026-11-27   오후 6:47            368 soldier_cavalry_fire.png                                             
-a----        2026-11-27   오후 6:47            375 soldier_cavalry_water.png                                            
-a----        2026-11-27   오후 6:50            393 soldier_healer_earth.png                                             
-a----        2026-11-27   오후 6:50            406 soldier_healer_fire.png                                              
-a----        2026-11-27   오후 6:50            412 soldier_healer_water.png                                             
-a----        2026-11-27   오후 3:30            420 soldier_shield_earth.png                                             
-a----        2026-11-27   오후 3:30            435 soldier_shield_fire.png                                              
-a----        2026-11-27   오후 3:30            449 soldier_shield_water.png                                             
-a----        2026-11-27   오후 3:30            426 soldier_spear_earth.png                                              
-a----        2026-11-27   오후 3:30            407 soldier_spear_fire.png                                               
-a----        2026-11-27   오후 3:30            449 soldier_spear_water.png                                              
# 2026-11-28 ?ㅻ벉湲?(?쇳빐 ?レ옄쨌?ш굅由?룸쭏?꽷룸같寃?

## ?묒뾽 ?쒖옉 ??git status --porcelain
(蹂寃??놁쓬)

## ?ъ슜??留?(洹몃?濡?
- "?꾩쭅源뚯? ?댁깋?? ?곕?吏 ?쒖떆???댁깋?섍퀬 吏湲?蹂묒궗?ㅼ씠 ?꾧묠鍮꾨? ?몄떇?섎뒗 ?ъ젙嫄곕━??吏㏃븘. ?꾩쭅源뚯? 諛곌꼍???먮굦?????닿퀬, 吏묐룄 ?덈Т 4媛쒓? ?묎쾶 ?덉뼱."
  ???쇳빐 ?レ옄: 媛숈? ???고??????レ옄濡??⑹퀜 而ㅼ?寃? 援듭? 湲瑗는룰렇由쇱옄쨌?щЪ?? ???쇳빐 湲덈튆
  ???ш굅由? 蹂묒궗媛 ?꾧묠鍮꾨? ?뚯븘梨꾨뒗 嫄곕━ ?섎┝ (洹좏삎 ?ㅼ떆)
  ??留덉쓣: ?쇱そ 留덉쓣 援ъ뿭, 吏?2諛걔룹뾿媛덈젮 紐⑥쓬쨌?댁옣, ?쇳빐???곕씪 ?곌린쨌遺?
  ??諛곌꼍: ??媛?μ옄由?룸컮?꽷룰만 ?먭뎅 (肄붾뱶), 吏?쒖꽌 04 ??留덉쓣 洹몃┝ 異붽?
- "洹몃━怨??꾩쭅源뚯? 蹂묒궗 戮묐뒗 諛⑸쾿??萸붽? ?댁깋?섍퀬 ?룰컝由щ뒗 寃?媛숈븘.蹂묒궗 戮묐뒗 寃껊룄 洹몃깷 ?쒕뜡 戮묎린濡??섎뒗寃??섏쓣 寃?媛숈븘. 蹂묒궗 醫낅쪟??媛?닔??醫 ??留롮븘????寃?媛숈븘."
  ????븷쨌?좎빟 怨좊Ⅴ湲?????숈쑝濡??쒕뜡 戮묎린 (?뺣쪧? ?붾㈃???レ옄, 泥쒖옣 = ?듭슱?섏? ?딆? ???좎?)
  ??蹂묒궗 醫낅쪟 ?섎┝ (??븷 異붽?), 遺? ???섎┝
- 洹쒖튃 蹂寃? 留덉쓣 ?댁옣 ??VILLAGE_LINE 112 (?볦? 留덉쓣 援ъ뿭), 蹂묒궗 ?몄떇 嫄곕━ ALLY_AGGRO 210 / 已볥뒗 ?쒓퀎 ALLY_LEASH 170, 沅곸닔 ?ш굅由?160??00. P1 ?듦낵.
- 戮묎린 ?ㅺ퀎 (???ъ슜??留먯뿉 ?곕쫫):
  ????3 = 戮묎린 1踰???媛留덉뿉 ?ㅼ뼱媛?(?깃툒? ?ъ쟾??媛留?遺덉씠 ?뺥븿). 5踰?戮묎린 踰꾪듉
  ??蹂묒궗 7醫? ?뷀븿 60% 李쎈퀝쨌沅곸닔쨌諛⑺뙣蹂?/ ?쒕Ь 28% ?꾨겮蹂뫢룰린留덈퀝 / 洹??12% 臾대떦쨌?붿감. ?좎빟 3媛吏 媛?33%
  ???듭슱?섏? ?딆? ?? ?뺣쪧?쒕? ?붾㈃??洹몃?濡? 洹??泥쒖옣 6踰?(7踰덉㎏ ?뺤젙), 戮묒? 蹂묒궗 遺?섎㈃ ??1留??뚮젮以?(怨듭쭨 ?ㅼ떆 戮묎린 留됱쓬)
  ???⑹튂湲곕뒗 ?좎빟???щ씪??媛숈? 紐⑥뼇쨌蹂?3紐낆씠硫?媛??(臾댁옉?꾨씪 媛숈? ?좎빟 3紐낆쓣 紐⑥쑝湲??덈Т ?대젮?뚯꽌). ?좎빟? ?깃툒??媛??醫뗭? 蹂묒궗 寃?
  ???먮━ 9 + 諛ㅻ쭏??2, 媛留?8移? 泥섏쓬 ??24
- 洹좏삎 (遊?8?? ?덉쟾??遺?4): ?꾧묠鍮?媛꾧꺽 44??6, 紐곕젮?ㅺ린 10+諛ㅻ쭏??4, 諛ㅻ쭏??泥대젰 +45%, ???泥대젰 2400쨌怨듦꺽 42
  ???덉쟾??5/8 ?? ?꾨컯??遺?7) 6/8 ?? 留덉?留?諛ㅼ뿉 留덉쓣 泥대젰??源롮씤?? 1~3踰덉㎏ 諛ㅼ? ?꾩쭅 ?ъ슫 ??(?ㅼ쓬??議곗젙)
- 踰꾧렇 ?섏젙: ?댁씪 ?뚮룄媛 諛?대궦 ?곸쓣 ?ㅼ떆 留욏? ?붾㈃ ?앷퉴吏 ?뚭퀬 媛??寃?(?뚮룄 ?섎굹?????섎굹瑜???踰덈쭔)
- ??μ? 諛由ъ? ?딆쓬 (諛湲걔룸뒓?ㅼ쭚怨?嫄몄쓬??留욌퉬寃??곸썝??硫덉텛??寃?, 臾대떦 ?뚮났? 諛곗쑉??35%留?(?꾩꽕 臾대떦?????怨듦꺽????吏?곕뜕 寃?
- 洹몃┝: ??蹂묒궗 12??吏?쒖꽌 handoff-05.md. 吏?쒖꽌 04 諛곌꼍 ?ㅻ챸??留덉쓣 援ъ뿭 0~112px 濡?怨좎묠

## 2026-11-28 ?깃툒쨌梨뺥꽣쨌?쒗넗由ъ뼹 (git status: 蹂寃??놁쓬)
- "????愿쒖갖湲??쒕뜲, 吏湲??깃툒???덈Т 紐?媛??녿뒗 寃?媛숈븘. ?깃툒??6媛吏 ?뺣룄濡??볧엳?? ?ㅻⅨ ?뷀렂??寃뚯엫 蹂대㈃ ?꾩쟾 理쒖쥌 ?깃툒 ?꾩껌 ?щ컯???뺣쪧濡?戮묒븘??吏꾪뻾?섎뒗 寃껋쿂???깃툒???곸젅???섎닠以? 洹몃━怨??좎빟???щ씪???⑹튌 ???덈뒗 嫄?醫뗭? 寃?媛숈븘. 洹몃━怨?蹂묒궗蹂꾨줈 蹂??깃툒???щ━??嫄??뚮젮二쇰뒗 ?쒗넗由ъ뼹???ｌ뼱?볦쑝硫?醫뗪쿋??"
- "?깃툒????留롮씠 留뚮뱾寃??섎㈃ ?꾨쭏??蹂묒궗??醫낅쪟瑜????섎젮????嫄곗빞. 嫄곌린??留욎떠??吏꾪뻾?????덇쾶 ?먭??댁쨾."
- "洹몃━怨?諛ㅼ쓣 5踰?蹂대궡怨??섎㈃ ?ㅼ쓬 梨뺥꽣濡??섏뼱媛?꾨줉 ?댁쨾. 梨뺥꽣蹂꾨줈 ?꾩묠 5踰? 諛?5踰??섏뼱媛硫?梨뺥꽣媛 媛곴컖 ?섏뼱媛?꾨줉 ?댁＜怨? 梨뺥꽣蹂꾨줈 ?쒖씠?꾩? ?깆옣 紐ъ뒪?곕? ?곸젅??議곗젅?댁쨾."
  ??洹??12%쨌泥쒖옣 6踰? ?좎빟 ?щ씪???⑹튂湲? ?ъ슜???뱀씤 ("????愿쒖갖湲??쒕뜲")
- ?깃툒 6?④퀎 (data.gd GRADES): ?쇰컲 52% 쨌 怨좉툒 27% 쨌 ?ш? 13% 쨌 ?곸썒 6% 쨌 ?꾩꽕 1.8% 쨌 ?좏솕 0.2%
  ??蹂묒궗 7醫???15醫?(?깃툒留덈떎 2~3醫?. ?덈줈: ?ъ꽍蹂?怨좉툒) ?띻?臾댁궗(?ш?) ?μ닔쨌?좉턿(?곸썒) ?댁튂쨌泥섏슜(?꾩꽕) 泥?！쨌遺덇??щ━(?좏솕)
  ???듭슱?섏? ?딆? ?? 泥쒖옣 ?ш???8踰?쨌 ?곸썒??30踰?쨌 ?꾩꽕??90踰? ?꾩꽕 戮묒쓣 ?뚮쭏???좏솕 議곌컖 1 ??3媛쒕㈃ ?좏솕 ?뺤젙
- 蹂??щ━湲??쒗넗由ъ뼹: 泥섏쓬 ??踰덉뵫 (戮묎린 ??媛留???蹂??щ━湲????먮━ 苑?李?, ?붾㈃ ?대몼寃?+ ?꾨? 怨?諛앷쾶 + ?붿궡??
  移대뱶???⑹튂湲?吏꾪뻾 2/3, 怨좊Ⅸ 蹂묒궗??"蹂??щ━湲? 李쎈퀝 ??3紐????끸쁾 (吏湲?n/3)", ? 踰꾪듉 = 蹂꽷룸벑湲??덈궡
- 梨뺥꽣 5媛?(?꾩묠 5踰댟룸갇 5踰? ?ㅼ꽢吏?諛????: 留덉쓣 ?닿?(?꾧묠鍮???? ???ъ슦怨????ъ슦 ?붽눼 / 援щ??? ?ъ슦 遺由?
  ???덇컻 ??媛묒샆 ?꾧묠鍮?/ ?대Т湲? 媛묒샆) ???쇱쓬 怨좉컻(?먭? / ??뱀궗?? ?먭? 遺由? ???꾧묠鍮???嫄곗씤 / ?꾧묠鍮??? ???꾧묠鍮?遺由?
  ??梨뺥꽣 ?섍린硫?留덉쓣 ?꾩쟾 蹂듦뎄 + ??12, 蹂묒궗 ?먮━ 理쒕? 18
- 洹좏삎 (遊??덉쟾??遺?4, 6??: 梨뺥꽣 1? 6/6 ?섍?, ?됯퇏 梨뺥꽣 3?먯꽌 硫덉땄 (梨뺥꽣 3 ???諛?, ?앷퉴吏 源???0
  ??洹좏삎 寃?щ? "諛?5踰?3~5/6 ?? ?먯꽌 "梨뺥꽣 1 4/6 ?댁긽 쨌 ?앷퉴吏 0 쨌 ?됯퇏 梨뺥꽣 2~4" 濡?諛붽퓞 (寃뚯엫 援ъ“媛 梨뺥꽣濡?諛붾뚯뼱?? ?ъ슜?먯뿉寃?蹂닿퀬)
  ???⑥? 臾몄젣: 諛ㅻ쭏??'?꾩듅 ?꾨땲硫??꾪뙣' (留덉쓣 160 洹몃?濡??????諛ㅼ뿉 ??踰덉뿉 0). ?ㅼ쓬??議곗젙
- 1遺??쒗뿕??????test_proto)? ?덉쟾 ?뚮룄 洹몃?濡?
- 洹몃┝: ??蹂묒궗 24??+ ??9??紐⑸줉쨌吏?쒖꽌 handoff-06.md



exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -Encoding UTF8 'C:/Users/pc/.codex/skills/.system/imagegen/SKILL.md' | Select-Object -First 145; Get-Content -Encoding UTF8 'work/2026-11-28-다듬기/NOTES.md'; Get-Content -Encoding UTF8 art/references/README.md; rg -n '결과:|그리는 데|이미지 생성|못 한|통과|실패' 'work/2026-11-28-다듬기/handoff-05.report.md' | Select-Object -Last 18; rg -n '등급 6단계|챕터 적|slinger|king.png' 'docs/그림-목록.md' art/sprite_list.json" in C:\Users\pc\Documents\game
 succeeded in 503ms:
---
name: "imagegen"
description: "Generate or edit raster images when the task benefits from AI-created bitmap visuals such as photos, illustrations, textures, sprites, mockups, or transparent-background cutouts. Use when Codex should create a brand-new image, transform an existing image, or derive visual variants from references, and the output should be a bitmap asset rather than repo-native code or vector. Do not use when the task is better handled by editing existing SVG/vector/code-native assets, extending an established icon or logo system, or building the visual directly in HTML/CSS/canvas."
---

# Image Generation Skill

Generates or edits images for the current project (for example website assets, game assets, UI mockups, product mockups, wireframes, logo design, photorealistic images, or infographics).

## Top-level modes and rules

This skill has exactly two top-level modes:

- **Default built-in tool mode (preferred):** built-in `image_gen` tool for image generation, editing, and transparent-image requests. Does not require `OPENAI_API_KEY`.
- **Fallback CLI mode:** `scripts/image_gen.py` CLI. Use when the user explicitly asks for or confirms the CLI/API/model path. Requires `OPENAI_API_KEY`.

Within CLI fallback, the CLI exposes three subcommands:

- `generate`
- `edit`
- `generate-batch`

Rules:
- Use the built-in `image_gen` tool by default for normal image generation and editing requests.
- Do not switch to CLI fallback for ordinary quality, size, or file-path control.
- For transparent images, ask built-in `image_gen` for a transparent background and preserve the generated alpha.
- Never silently switch from built-in `image_gen` or CLI `gpt-image-2` to CLI `gpt-image-1.5`; ask the user first unless they explicitly requested `gpt-image-1.5`.
- The word `batch` by itself does not mean CLI fallback. If the user asks for many assets or says to batch-generate assets without explicitly asking for CLI/API/model controls, stay on the built-in path and issue one built-in call per requested asset or variant.
- If the built-in tool fails or is unavailable, tell the user the CLI fallback exists and that it requires `OPENAI_API_KEY`. Proceed only if the user explicitly asks for that fallback.
- If the user explicitly asks for CLI mode, use the bundled `scripts/image_gen.py` workflow. Do not create one-off SDK runners.
- Never modify `scripts/image_gen.py`. If something is missing, ask the user before doing anything else.

Built-in save-path policy:
- In built-in tool mode, Codex saves generated images under `$CODEX_HOME/*` by default.
- Do not describe or rely on OS temp as the default built-in destination.
- Do not describe or rely on a destination-path argument (if any) on the built-in `image_gen` tool. If a specific location is needed, generate first and then move or copy the selected output from `$CODEX_HOME/generated_images/...`.
- Save-path precedence in built-in mode:
  1. If the user names a destination, move or copy the selected output there.
  2. If the image is meant for the current project, move or copy the final selected image into the workspace before finishing.
  3. If the image is only for preview or brainstorming, render it inline; the underlying file can remain at the default `$CODEX_HOME/*` path.
- Never leave a project-referenced asset only at the default `$CODEX_HOME/*` path.
- Do not overwrite an existing asset unless the user explicitly asked for replacement; otherwise create a sibling versioned filename such as `hero-v2.png` or `item-icon-edited.png`.

Shared prompt guidance for both modes lives in `references/prompting.md` and `references/sample-prompts.md`.

Fallback-only docs/resources for CLI mode:
- `references/cli.md`
- `references/image-api.md`
- `references/codex-network.md`
- `scripts/image_gen.py`

## When to use
- Generate a new image (concept art, product shot, cover, website hero)
- Generate a new image using one or more reference images for style, composition, or mood
- Edit an existing image (inpainting, lighting or weather transformations, background replacement, object removal, compositing, transparent background)
- Produce many assets or variants for one task

## When not to use
- Extending or matching an existing SVG/vector icon set, logo system, or illustration library inside the repo
- Creating simple shapes, diagrams, wireframes, or icons that are better produced directly in SVG, HTML/CSS, or canvas
- Making a small project-local asset edit when the source file already exists in an editable native format
- Any task where the user clearly wants deterministic code-native output instead of a generated bitmap

## Decision tree

Think about two separate questions:

1. **Intent:** is this a new image or an edit of an existing image?
2. **Execution strategy:** is this one asset or many assets/variants?

Intent:
- If the user wants to modify an existing image while preserving parts of it, treat the request as **edit**.
- If the user provides images only as references for style, composition, mood, or subject guidance, treat the request as **generate**.
- If the user provides no images, treat the request as **generate**.

Built-in edit semantics:
- Built-in edit mode is for images already visible in the conversation context, such as attached images or images generated earlier in the thread.
- If the user wants to edit a local image file with the built-in tool, first load it with built-in `view_image` tool so the image is visible in the conversation context, then proceed with the built-in edit flow.
- Do not promise arbitrary filesystem-path editing through the built-in tool.
- If a local file still needs direct file-path control, masks, or other explicit CLI-only parameters, use the explicit CLI fallback only when the user asks for it.
- For edits, preserve invariants aggressively and save non-destructively by default.

Execution strategy:
- In the built-in default path, produce many assets or variants by issuing one `image_gen` call per requested asset or variant.
- In the CLI fallback path, use the CLI `generate-batch` subcommand only when the user explicitly chose CLI mode and needs many prompts/assets.
- For many distinct assets, do not use `n` as a substitute for separate prompts. `n` is for variants of one prompt; distinct assets need distinct built-in calls or distinct CLI `generate-batch` jobs.

Assume the user wants a new image unless they clearly ask to change an existing one.

## Workflow
1. Decide the top-level mode: built-in by default, including transparent-output requests; fallback CLI only if explicitly requested or confirmed.
2. Decide the intent: `generate` or `edit`.
3. Decide whether the output is preview-only or meant to be consumed by the current project.
4. Decide the execution strategy: single asset vs repeated built-in calls vs CLI `generate-batch`.
5. Collect inputs up front: prompt(s), exact text (verbatim), constraints/avoid list, and any input images.
6. For every input image, label its role explicitly:
   - reference image
   - edit target
   - supporting insert/style/compositing input
7. If the edit target is only on the local filesystem and you are staying on the built-in path, inspect it with `view_image` first so the image is available in conversation context.
8. If the user asked for a photo, illustration, sprite, product image, banner, or other explicitly raster-style asset, use `image_gen` rather than substituting SVG/HTML/CSS placeholders. If the request is for an icon, logo, or UI graphic that should match existing repo-native SVG/vector/code assets, prefer editing those directly instead.
9. Augment the prompt based on specificity:
   - If the user's prompt is already specific and detailed, normalize it into a clear spec without adding creative requirements.
   - If the user's prompt is generic, add tasteful augmentation only when it materially improves output quality.
10. Use the built-in `image_gen` tool by default.
11. For transparent-output requests, ask built-in `image_gen` for a transparent background and preserve the generated alpha channel.
12. Inspect outputs and validate: subject, style, composition, text accuracy, and invariants/avoid items.
13. Iterate with a single targeted change, then re-check.
14. For preview-only work, render the image inline; the underlying file may remain at the default `$CODEX_HOME/generated_images/...` path.
15. For project-bound work, move or copy the selected artifact into the workspace and update any consuming code or references. Never leave a project-referenced asset only at the default `$CODEX_HOME/generated_images/...` path.
16. For batches or multi-asset requests, persist every requested deliverable final in the workspace unless the user explicitly asked to keep outputs preview-only. Discarded variants do not need to be kept unless requested.
17. If the user explicitly chooses or confirms the CLI fallback, then use the fallback-only docs for model, quality, size, `input_fidelity`, masks, output format, output paths, and network setup.
18. Always report the final saved path(s) for any workspace-bound asset(s), plus the final prompt or prompt set and whether the built-in tool or fallback CLI mode was used.

## Transparent image requests

Ask built-in `image_gen` for a genuinely transparent background and preserve its alpha.

## Prompt augmentation

Reformat user prompts into a structured, production-oriented spec. Make the user's goal clearer and more actionable, but do not blindly add detail.

Treat this as prompt-shaping guidance, not a closed schema. Use only the lines that help, and add a short extra labeled line when it materially improves clarity.

### Specificity policy

Use the user's prompt specificity to decide how much augmentation is appropriate:

- If the prompt is already specific and detailed, preserve that specificity and only normalize/structure it.
- If the prompt is generic, you may add tasteful augmentation when it will materially improve the result.

Allowed augmentations:
- composition or framing hints
- polish level or intended-use hints
- practical layout guidance
- reasonable scene concreteness that supports the stated request

Not allowed augmentations:
- extra characters or objects that are not implied by the request
- brand names, slogans, palettes, or narrative beats that are not implied
- arbitrary side-specific placement unless the surrounding layout supports it

## Use-case taxonomy (exact slugs)

Classify each request into one of these buckets and keep the slug consistent across prompts and references.
# 2026-11-28 다듬기 (피해 숫자·사거리·마을·배경)

## 작업 시작 때 git status --porcelain
(변경 없음)

## 사용자 말 (그대로)
- "아직까지 어색해. 데미지 표시도 어색하고 지금 병사들이 도깨비를 인식하는 사정거리도 짧아. 아직까지 배경도 느낌이 안 살고, 집도 너무 4개가 작게 있어."
  → 피해 숫자: 같은 적 연타는 한 숫자로 합쳐 커지게, 굵은 글꼴·그림자·포물선, 큰 피해 금빛
  → 사거리: 병사가 도깨비를 알아채는 거리 늘림 (균형 다시)
  → 마을: 왼쪽 마을 구역, 집 2배·엇갈려 모음·담장, 피해에 따라 연기·불
  → 배경: 숲 가장자리·바위·길 자국 (코드), 지시서 04 에 마을 그림 추가
- "그리고 아직까지 병사 뽑는 방법이 뭔가 어색하고 헷갈리는 것 같아.병사 뽑는 것도 그냥 랜덤 뽑기로 하는게 나을 것 같아. 병사 종류랑 갯수도 좀 더 많아야 할 것 같아."
  → 역할·유약 고르기 대신 흙으로 랜덤 뽑기 (확률은 화면에 숫자, 천장 = 억울하지 않은 운 유지)
  → 병사 종류 늘림 (역할 추가), 부대 수 늘림
- 규칙 변경: 마을 담장 선 VILLAGE_LINE 112 (넓은 마을 구역), 병사 인식 거리 ALLY_AGGRO 210 / 쫓는 한계 ALLY_LEASH 170, 궁수 사거리 160→200. P1 통과.
- 뽑기 설계 (위 사용자 말에 따름):
  → 흙 3 = 뽑기 1번 → 가마에 들어감 (등급은 여전히 가마 불이 정함). 5번 뽑기 버튼
  → 병사 7종: 흔함 60% 창병·궁수·방패병 / 드묾 28% 도끼병·기마병 / 귀함 12% 무당·화차. 유약 3가지 각 33%
  → 억울하지 않은 운: 확률표를 화면에 그대로, 귀함 천장 6번 (7번째 확정), 뽑은 병사 부수면 흙 1만 돌려줌 (공짜 다시 뽑기 막음)
  → 합치기는 유약이 달라도 같은 모양·별 3명이면 가능 (무작위라 같은 유약 3명을 모으기 너무 어려워서). 유약은 등급이 가장 좋은 병사 것
  → 자리 9 + 밤마다 2, 가마 8칸, 처음 흙 24
- 균형 (봇 8판, 안전파 불 4): 도깨비 간격 44→26, 몰려오기 10+밤마다 4, 밤마다 체력 +45%, 대장 체력 2400·공격 42
  → 안전파 5/8 승, 도박파(불 7) 6/8 승. 마지막 밤에 마을 체력이 깎인다. 1~3번째 밤은 아직 쉬운 편 (다음에 조정)
- 버그 수정: 해일 파도가 밀어낸 적을 다시 맞혀 화면 끝까지 끌고 가던 것 (파도 하나는 적 하나를 한 번만)
- 대장은 밀리지 않음 (밀기·느려짐과 걸음이 맞비겨 영원히 멈추던 것), 무당 회복은 배율의 35%만 (전설 무당이 대장 공격을 다 지우던 것)
- 그림: 새 병사 12장 지시서 handoff-05.md. 지시서 04 배경 설명을 마을 구역 0~112px 로 고침

## 2026-11-28 등급·챕터·튜토리얼 (git status: 변경 없음)
- "둘 다 괜찮긴 한데, 지금 등급이 너무 몇 개 없는 것 같아. 등급을 6가지 정도로 넓히자. 다른 디펜스 게임 보면 완전 최종 등급 엄청 희박한 확률로 뽑아서 진행하는 것처럼 등급을 적절히 나눠줘. 그리고 유약이 달라도 합칠 수 있는 건 좋은 것 같아. 그리고 병사별로 별 등급을 올리는 걸 알려주는 튜토리얼도 넣어놓으면 좋겠어."
- "등급을 더 많이 만들게 되면 아마도 병사들 종류를 더 늘려야 할 거야. 거기에 맞춰서 진행할 수 있게 점검해줘."
- "그리고 밤을 5번 보내고 나면 다음 챕터로 넘어가도록 해줘. 챕터별로 아침 5번, 밤 5번 넘어가면 챕터가 각각 넘어가도록 해주고, 챕터별로 난이도와 등장 몬스터를 적절히 조절해줘."
  → 귀함 12%·천장 6번, 유약 달라도 합치기: 사용자 승인 ("둘 다 괜찮긴 한데")
- 등급 6단계 (data.gd GRADES): 일반 52% · 고급 27% · 희귀 13% · 영웅 6% · 전설 1.8% · 신화 0.2%
  → 병사 7종 → 15종 (등급마다 2~3종). 새로: 투석병(고급) 쌍검무사(희귀) 장수·신궁(영웅) 해치·처용(전설) 청룡·불가사리(신화)
  → 억울하지 않은 운: 천장 희귀↑ 8번 · 영웅↑ 30번 · 전설↑ 90번, 전설 뽑을 때마다 신화 조각 1 → 3개면 신화 확정
- 별 올리기 튜토리얼: 처음 한 번씩 (뽑기 → 가마 → 별 올리기 → 자리 꽉 참), 화면 어둡게 + 누를 곳 밝게 + 화살표.
  카드에 합치기 진행 2/3, 고른 병사에 "별 올리기: 창병 ★ 3명 → ★★ (지금 n/3)", ? 버튼 = 별·등급 안내
- 챕터 5개 (아침 5번·밤 5번, 다섯째 밤 대장): 마을 어귀(도깨비 대장) → 여우골 숲(여우 요괴 / 구미호, 여우 부름)
  → 안개 늪(갑옷 도깨비 / 이무기, 갑옷) → 얼음 고개(원귀 / 저승사자, 원귀 부름) → 도깨비 성(거인 / 도깨비 왕, 큰 도깨비 부름)
  → 챕터 넘기면 마을 완전 복구 + 흙 12, 병사 자리 최대 18
- 균형 (봇 안전파 불 4, 6판): 챕터 1은 6/6 넘김, 평균 챕터 3에서 멈춤 (챕터 3 대장 밤), 끝까지 깬 판 0
  → 균형 검사를 "밤 5번 3~5/6 승" 에서 "챕터 1 4/6 이상 · 끝까지 0 · 평균 챕터 2~4" 로 바꿈 (게임 구조가 챕터로 바뀌어서. 사용자에게 보고)
  → 남은 문제: 밤마다 '완승 아니면 완패' (마을 160 그대로 → 대장 밤에 한 번에 0). 다음에 조정
- 1분 시험판 한 판(test_proto)은 예전 파도 그대로
- 그림: 새 병사 24장 + 적 9장 목록·지시서 handoff-06.md
# 기준 그림

우리 그림체를 대표하는 그림을 이 폴더에 넣어 주세요 (png/jpg, 3~8장 권장).
검토자는 이 그림들과 `art/rubric.md`만 보고 채점합니다.
107:5. 사용자에게 보여 주고 "검사는 통과, 미술 판단은 사용자 몫" — 허락을 받은 뒤 커밋
114:이미지 생성 스킬을 사용해 기존 병사와 기준 그림을 먼저 확인하겠습니다. 생성한 그림을 픽셀 단위로 다듬어 지정된 새 PNG 12장만 추가하겠습니다.
692:- 규칙 변경: 마을 담장 선 VILLAGE_LINE 112 (넓은 마을 구역), 병사 인식 거리 ALLY_AGGRO 210 / 쫓는 한계 ALLY_LEASH 170, 궁수 사거리 160→200. P1 통과.
1070:3. **자동 검사 통과는 재미·미술 승인이 아니다.** 테스트·봇·측정이 통과해도 "검사는 통과, 재미·미술 판단은 사용자 몫"이라고 말한다. 스스로 "재밌다", "예쁘다", "완성"이라고 결론 내지 않는다.
1087:  - Codex 보고 첫 줄: `결과: 통과` | `결과: 실패` | `결과: 못 돌림`
1111:- **억울하지 않은 운** (사용자 요청): 안전 구간은 반드시 보통 이상 · 확률은 화면에 숫자로 · 실패하면 파편/조각 · 3개 모이면 확정 보상. 이 규칙을 깨는 변경은 사용자에게 먼저 묻는다.
1140:- 테스트를 통과시키려고 테스트나 봇 기준을 느슨하게 고치지 않는다. 고쳐야 하면 이유를 사용자에게 먼저 말한다.
1169:- 커밋 전에 `python3 scripts/test.py` 가 통과해야 한다 (pre-commit 훅이 자동으로 돌림).
2021:결과: 통과
2034:그리는 데 쓴 방법:
2035:- **둘 다**: 내장 이미지 생성으로 원본 제작 후, 코드로 축소·투명 처리·기존 유약 팔레트 적용·픽셀 정리.
2037:못 한 것 / 걱정되는 것:
2040:- 자체 규격 확인은 통과했으며, **미술 판단은 사용자 몫입니다.**
2043:결과: 통과
2056:그리는 데 쓴 방법:
2057:- **둘 다**: 내장 이미지 생성으로 원본 제작 후, 코드로 축소·투명 처리·기존 유약 팔레트 적용·픽셀 정리.
2059:못 한 것 / 걱정되는 것:
2062:- 자체 규격 확인은 통과했으며, **미술 판단은 사용자 몫입니다.**
docs/그림-목록.md:52:### 가마의 병사 — 등급 6단계 추가 8종 (24장) · 챕터 적·대장 (9장) — 지시서 `work/2026-11-28-다듬기/handoff-06.md`
docs/그림-목록.md:56:| `kiln/soldier_{slinger,twin,general,sniper,haetae,cheoyong,dragon,bulgasari}_{water,fire,earth}.png` | 32×32 ×24 | 투석병(고급) · 쌍검무사(희귀) · 장수·신궁(영웅) · 해치·처용(전설) · 청룡·불가사리(신화). 해치·청룡·불가사리는 짐승 |
art/sprite_list.json:556:      "path": "assets/sprites/kiln/soldier_slinger_water.png",
art/sprite_list.json:561:      "group": "가마의 병사 (등급 6단계 추가 8종)",
art/sprite_list.json:565:      "path": "assets/sprites/kiln/soldier_slinger_fire.png",
art/sprite_list.json:570:      "group": "가마의 병사 (등급 6단계 추가 8종)",
art/sprite_list.json:574:      "path": "assets/sprites/kiln/soldier_slinger_earth.png",
art/sprite_list.json:579:      "group": "가마의 병사 (등급 6단계 추가 8종)",
art/sprite_list.json:588:      "group": "가마의 병사 (등급 6단계 추가 8종)",
art/sprite_list.json:597:      "group": "가마의 병사 (등급 6단계 추가 8종)",
art/sprite_list.json:606:      "group": "가마의 병사 (등급 6단계 추가 8종)",
art/sprite_list.json:615:      "group": "가마의 병사 (등급 6단계 추가 8종)",
art/sprite_list.json:624:      "group": "가마의 병사 (등급 6단계 추가 8종)",
art/sprite_list.json:633:      "group": "가마의 병사 (등급 6단계 추가 8종)",
art/sprite_list.json:642:      "group": "가마의 병사 (등급 6단계 추가 8종)",
art/sprite_list.json:651:      "group": "가마의 병사 (등급 6단계 추가 8종)",
art/sprite_list.json:660:      "group": "가마의 병사 (등급 6단계 추가 8종)",
art/sprite_list.json:669:      "group": "가마의 병사 (등급 6단계 추가 8종)",
art/sprite_list.json:678:      "group": "가마의 병사 (등급 6단계 추가 8종)",
art/sprite_list.json:687:      "group": "가마의 병사 (등급 6단계 추가 8종)",
art/sprite_list.json:696:      "group": "가마의 병사 (등급 6단계 추가 8종)",
art/sprite_list.json:705:      "group": "가마의 병사 (등급 6단계 추가 8종)",
art/sprite_list.json:714:      "group": "가마의 병사 (등급 6단계 추가 8종)",
art/sprite_list.json:723:      "group": "가마의 병사 (등급 6단계 추가 8종)",
art/sprite_list.json:732:      "group": "가마의 병사 (등급 6단계 추가 8종)",
art/sprite_list.json:741:      "group": "가마의 병사 (등급 6단계 추가 8종)",
art/sprite_list.json:750:      "group": "가마의 병사 (등급 6단계 추가 8종)",
art/sprite_list.json:759:      "group": "가마의 병사 (등급 6단계 추가 8종)",
art/sprite_list.json:768:      "group": "가마의 병사 (등급 6단계 추가 8종)",
art/sprite_list.json:777:      "group": "챕터 적·대장",
art/sprite_list.json:786:      "group": "챕터 적·대장",
art/sprite_list.json:795:      "group": "챕터 적·대장",
art/sprite_list.json:804:      "group": "챕터 적·대장",
art/sprite_list.json:813:      "group": "챕터 적·대장",
art/sprite_list.json:822:      "group": "챕터 적·대장",
art/sprite_list.json:831:      "group": "챕터 적·대장",
art/sprite_list.json:840:      "group": "챕터 적·대장",
art/sprite_list.json:844:      "path": "assets/sprites/enemy/king.png",
art/sprite_list.json:849:      "group": "챕터 적·대장",

codex
지시서 05의 병사 12장과 완료 보고가 있어 06을 진행합니다. 기존 유약 팔레트와 굽 모양을 맞추고, 전설·신화는 짐승의 몸집과 고유 실루엣으로 구분하겠습니다. 이번 지시서는 PNG 33장만 허용하므로 NOTES.md와 보고서 파일은 수정하지 않습니다.

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -Encoding UTF8 'docs/그림-목록.md' | Select-Object -First 65; Get-Content -Encoding UTF8 art/sprite_list.json | Select-Object -Skip 550; Get-Content -Encoding UTF8 PROTECTED.txt; Get-Content -Encoding UTF8 'C:/Users/pc/.codex/skills/.system/imagegen/references/sample-prompts.md' | Select-String -Pattern 'sprite|game' -Context 3,12" in C:\Users\pc\Documents\game
 succeeded in 513ms:
# 그림 목록 (1분 시험판)

> 기계가 읽는 목록: `art/sprite_list.json` · 검사: `python3 scripts/check_sprites.py`
> 그림을 `assets/sprites/...` 에 넣으면 게임이 바로 그 그림을 쓴다. 없는 그림은 지금처럼 도형으로 그린다.

## 순서

1. ✅ **그림체 시안 3개** (`handoff-01.md`) → 섞은 시안 (`handoff-01b.md`) → **섞은 그림체로 결정**
2. 고른 시안을 기준 그림(`art/references/`)으로 둔다 — 보호 폴더라 **사용자 허락 뒤에** 넣는다
3. **가마의 병사 그림 10장** (`handoff-02.md`)
4. **알을 품는 성 그림 12장 + 공통 7장** (`handoff-03.md`)
5. 매번 Claude가 `check_sprites.py` 와 게임 스크린샷으로 확인하고, 사용자에게 보여 준 뒤 커밋한다

## 정한 그림체: 가 + 다 섞음 (2026-11-27 사용자 승인)

> 사용자: "그림체는 "가"가 창병이라던지, 한옥, 도깨비를 더 잘 표현한 것 같아. 그런데 "다"도 색상은 이후에 어떤게 들어가는 지에 따라서 잘 사용할 수도 있을 것 같아." → 섞은 시안(`art/style/mix`)에 "이전보다 결과가 좋은 것 같아. 이대로 해서 한 번 진행해보자."

| 무엇 | 어떻게 |
|---|---|
| 형태·디테일·표정 | 가 처럼 — 32×32 에서도 한눈에 |
| 바탕 | 다 처럼 — 먹색·흙 회색조, 차분하게 |
| 강한 색 | **유약·기운에만** (청자 = 물, 진사 = 불, 흑유 = 땅). 색이 곧 게임 정보 |
| 금색 | 요변·전설 같은 특별한 것에만 |
| 병사 | 유약 바른 **도자기 인형** — 매끈한 몸, 흰 광택, 발밑 받침 |
| 도깨비 | 먹빛 남색·회청색 + 노란 눈 (진사 빨강 금지 → 아군과 구분) |

## 그림체 후보 (시안에서 비교했던 것)

| 이름 | 느낌 | 외곽선 | 색 |
|---|---|---|---|
| **가. 따뜻한 흙** | 한국 전통(도자기·한옥·도깨비)을 차분하고 따뜻하게 | 진한 갈색 1px | 흙색·먹색 바탕 + 유약/기운 색 |
| **나. 밝은 동화** | 귀엽고 또렷하게, 장난감 같은 느낌 | 검정 1px, 굵은 실루엣 | 채도 높은 색 |
| **다. 수묵 픽셀** | 먹으로 그린 듯한 흑백 + 포인트 색 | 먹색, 굵기 변화 | 거의 흑백 + 청자 초록·진사 빨강·금색만 |

## 전체 목록 (29장)

### 가마의 병사 (10장)

| 파일 | 크기 | 내용 |
|---|---|---|
| `kiln/soldier_{spear,archer,shield}_{water,fire,earth}.png` | 32×32 ×9 | 유약 바른 도자기 인형 병사 (받침·광택). 모양 = 창병/궁수/방패병, 유약 = 청자(비취빛 녹색)/진사(구리빛 빨강)/흑유(검은 갈색). 오른쪽을 본다 |
| `kiln/kiln_body.png` | 160×160 | 전통 장작 가마 앞모습. 가운데 문 자리와 아궁이는 어둡게 비움 (문·불길은 게임이 그림) |

### 가마의 병사 — 새 병사 4종 (12장, 지시서 `work/2026-11-28-다듬기/handoff-05.md`)

뽑기로 나오는 병사가 7종이 되면서 추가 (2026-11-28). 그림이 없으면 비슷한 병사 그림 + 코드 소품으로 임시 표시.

| 파일 | 크기 | 내용 |
|---|---|---|
| `kiln/soldier_{axe,cavalry,healer,cannon}_{water,fire,earth}.png` | 32×32 ×12 | 도끼병(드묾) · 기마병(드묾, 흙 말에 탐) · 무당(귀함, 방울·오색 천) · 화차(귀함, 신기전 수레 + 병사). 기존 병사 9장과 한 벌 |

### 가마의 병사 — 등급 6단계 추가 8종 (24장) · 챕터 적·대장 (9장) — 지시서 `work/2026-11-28-다듬기/handoff-06.md`

| 파일 | 크기 | 내용 |
|---|---|---|
| `kiln/soldier_{slinger,twin,general,sniper,haetae,cheoyong,dragon,bulgasari}_{water,fire,earth}.png` | 32×32 ×24 | 투석병(고급) · 쌍검무사(희귀) · 장수·신궁(영웅) · 해치·처용(전설) · 청룡·불가사리(신화). 해치·청룡·불가사리는 짐승 |
| `enemy/{fox,armored,ghost}.png` | 32×32 | 챕터 2·3·4 새 적: 여우 요괴 · 갑옷 도깨비 · 원귀 |
| `enemy/{giant,chief,gumiho,imugi,reaper,king}.png` | 48×48 | 거인 도깨비(챕터 5) · 대장: 도깨비 대장 · 구미호 · 이무기 · 저승사자 · 도깨비 왕 |

### 알을 품는 성 (12장)

| 파일 | 크기 | 내용 |
|---|---|---|
| `nest/creature_{spear,archer,shield}_{fire,water,earth}.png` | 32×32 ×9 | 괴수 새끼 9종: 불꽃 도마뱀·물살 수달·가시 고슴도치 / 불씨 박쥐·물방울 해파리·돌팔매 원숭이 / 용암 두꺼비·조개 거북·바위 거북. 오른쪽을 본다 |
| `nest/egg_{spear,archer,shield}.png` | 32×40 ×3 | 뾰족 돌기 알 / 길쭉한 알 / 넓적한 알. **밝은 흰색으로만** (게임이 기운 색으로 물들임) |
      ],
      "group": "가마의 병사 (새 병사 4종)",
      "what": "유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(화차). 바퀴 달린 나무 수레(화차)에 신기전 통이 여러 개 꽂혀 있고 옆에 병사 하나. 수레 나무는 흙빛, 병사와 통 끝에 유약. 몸 전체에 흑유 유약 — 검은 갈색에 기름 같은 광택. 오른쪽을 본다."
    },
    {
      "path": "assets/sprites/kiln/soldier_slinger_water.png",
      "size": [
        32,
        32
      ],
      "group": "가마의 병사 (등급 6단계 추가 8종)",
      "what": "유약 바른 도자기 인형 (투석병, 고급 등급). 돌팔매 끈을 머리 위로 돌리는 가벼운 병사. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 청자 유약 — 비취빛 맑은 녹색. 오른쪽을 본다."
    },
    {
      "path": "assets/sprites/kiln/soldier_slinger_fire.png",
      "size": [
        32,
        32
      ],
      "group": "가마의 병사 (등급 6단계 추가 8종)",
      "what": "유약 바른 도자기 인형 (투석병, 고급 등급). 돌팔매 끈을 머리 위로 돌리는 가벼운 병사. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다."
    },
    {
      "path": "assets/sprites/kiln/soldier_slinger_earth.png",
      "size": [
        32,
        32
      ],
      "group": "가마의 병사 (등급 6단계 추가 8종)",
      "what": "유약 바른 도자기 인형 (투석병, 고급 등급). 돌팔매 끈을 머리 위로 돌리는 가벼운 병사. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 흑유 유약 — 검은 갈색에 기름 같은 광택. 오른쪽을 본다."
    },
    {
      "path": "assets/sprites/kiln/soldier_twin_water.png",
      "size": [
        32,
        32
      ],
      "group": "가마의 병사 (등급 6단계 추가 8종)",
      "what": "유약 바른 도자기 인형 (쌍검무사, 희귀 등급). 양손에 짧은 칼 두 자루, 날렵한 자세. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 청자 유약 — 비취빛 맑은 녹색. 오른쪽을 본다."
    },
    {
      "path": "assets/sprites/kiln/soldier_twin_fire.png",
      "size": [
        32,
        32
      ],
      "group": "가마의 병사 (등급 6단계 추가 8종)",
      "what": "유약 바른 도자기 인형 (쌍검무사, 희귀 등급). 양손에 짧은 칼 두 자루, 날렵한 자세. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다."
    },
    {
      "path": "assets/sprites/kiln/soldier_twin_earth.png",
      "size": [
        32,
        32
      ],
      "group": "가마의 병사 (등급 6단계 추가 8종)",
      "what": "유약 바른 도자기 인형 (쌍검무사, 희귀 등급). 양손에 짧은 칼 두 자루, 날렵한 자세. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 흑유 유약 — 검은 갈색에 기름 같은 광택. 오른쪽을 본다."
    },
    {
      "path": "assets/sprites/kiln/soldier_general_water.png",
      "size": [
        32,
        32
      ],
      "group": "가마의 병사 (등급 6단계 추가 8종)",
      "what": "유약 바른 도자기 인형 (장수, 영웅 등급). 투구에 금빛 장식, 갑옷, 등 뒤에 유약 색 깃발. 다른 병사보다 당당하게. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 청자 유약 — 비취빛 맑은 녹색. 오른쪽을 본다."
    },
    {
      "path": "assets/sprites/kiln/soldier_general_fire.png",
      "size": [
        32,
        32
      ],
      "group": "가마의 병사 (등급 6단계 추가 8종)",
      "what": "유약 바른 도자기 인형 (장수, 영웅 등급). 투구에 금빛 장식, 갑옷, 등 뒤에 유약 색 깃발. 다른 병사보다 당당하게. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다."
    },
    {
      "path": "assets/sprites/kiln/soldier_general_earth.png",
      "size": [
        32,
        32
      ],
      "group": "가마의 병사 (등급 6단계 추가 8종)",
      "what": "유약 바른 도자기 인형 (장수, 영웅 등급). 투구에 금빛 장식, 갑옷, 등 뒤에 유약 색 깃발. 다른 병사보다 당당하게. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 흑유 유약 — 검은 갈색에 기름 같은 광택. 오른쪽을 본다."
    },
    {
      "path": "assets/sprites/kiln/soldier_sniper_water.png",
      "size": [
        32,
        32
      ],
      "group": "가마의 병사 (등급 6단계 추가 8종)",
      "what": "유약 바른 도자기 인형 (신궁, 영웅 등급). 몸보다 큰 활, 금빛 시위, 활을 당긴 자세. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 청자 유약 — 비취빛 맑은 녹색. 오른쪽을 본다."
    },
    {
      "path": "assets/sprites/kiln/soldier_sniper_fire.png",
      "size": [
        32,
        32
      ],
      "group": "가마의 병사 (등급 6단계 추가 8종)",
      "what": "유약 바른 도자기 인형 (신궁, 영웅 등급). 몸보다 큰 활, 금빛 시위, 활을 당긴 자세. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다."
    },
    {
      "path": "assets/sprites/kiln/soldier_sniper_earth.png",
      "size": [
        32,
        32
      ],
      "group": "가마의 병사 (등급 6단계 추가 8종)",
      "what": "유약 바른 도자기 인형 (신궁, 영웅 등급). 몸보다 큰 활, 금빛 시위, 활을 당긴 자세. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 흑유 유약 — 검은 갈색에 기름 같은 광택. 오른쪽을 본다."
    },
    {
      "path": "assets/sprites/kiln/soldier_haetae_water.png",
      "size": [
        32,
        32
      ],
      "group": "가마의 병사 (등급 6단계 추가 8종)",
      "what": "유약 바른 도자기 인형 (해치, 전설 등급). 병사가 아니라 도자기로 빚은 수호 짐승 해치(사자 닮은 네발 짐승, 곱슬 갈기, 이마에 뿔 하나). 32×32 를 꽉 채우는 덩치. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 청자 유약 — 비취빛 맑은 녹색. 오른쪽을 본다."
    },
    {
      "path": "assets/sprites/kiln/soldier_haetae_fire.png",
      "size": [
        32,
        32
      ],
      "group": "가마의 병사 (등급 6단계 추가 8종)",
      "what": "유약 바른 도자기 인형 (해치, 전설 등급). 병사가 아니라 도자기로 빚은 수호 짐승 해치(사자 닮은 네발 짐승, 곱슬 갈기, 이마에 뿔 하나). 32×32 를 꽉 채우는 덩치. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다."
    },
    {
      "path": "assets/sprites/kiln/soldier_haetae_earth.png",
      "size": [
        32,
        32
      ],
      "group": "가마의 병사 (등급 6단계 추가 8종)",
      "what": "유약 바른 도자기 인형 (해치, 전설 등급). 병사가 아니라 도자기로 빚은 수호 짐승 해치(사자 닮은 네발 짐승, 곱슬 갈기, 이마에 뿔 하나). 32×32 를 꽉 채우는 덩치. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 흑유 유약 — 검은 갈색에 기름 같은 광택. 오른쪽을 본다."
    },
    {
      "path": "assets/sprites/kiln/soldier_cheoyong_water.png",
      "size": [
        32,
        32
      ],
      "group": "가마의 병사 (등급 6단계 추가 8종)",
      "what": "유약 바른 도자기 인형 (처용, 전설 등급). 붉은 처용 탈을 쓰고 긴 소매를 휘날리며 춤추는 모습, 사모(모자). 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 청자 유약 — 비취빛 맑은 녹색. 오른쪽을 본다."
    },
    {
      "path": "assets/sprites/kiln/soldier_cheoyong_fire.png",
      "size": [
        32,
        32
      ],
      "group": "가마의 병사 (등급 6단계 추가 8종)",
      "what": "유약 바른 도자기 인형 (처용, 전설 등급). 붉은 처용 탈을 쓰고 긴 소매를 휘날리며 춤추는 모습, 사모(모자). 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다."
    },
    {
      "path": "assets/sprites/kiln/soldier_cheoyong_earth.png",
      "size": [
        32,
        32
      ],
      "group": "가마의 병사 (등급 6단계 추가 8종)",
      "what": "유약 바른 도자기 인형 (처용, 전설 등급). 붉은 처용 탈을 쓰고 긴 소매를 휘날리며 춤추는 모습, 사모(모자). 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 흑유 유약 — 검은 갈색에 기름 같은 광택. 오른쪽을 본다."
    },
    {
      "path": "assets/sprites/kiln/soldier_dragon_water.png",
      "size": [
        32,
        32
      ],
      "group": "가마의 병사 (등급 6단계 추가 8종)",
      "what": "유약 바른 도자기 인형 (청룡, 신화 등급). 병사가 아니라 도자기로 빚은 용. 구불구불한 긴 몸이 떠 있고, 뿔·수염·여의주. 32×32 를 꽉 채운다. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 청자 유약 — 비취빛 맑은 녹색. 오른쪽을 본다."
    },
    {
      "path": "assets/sprites/kiln/soldier_dragon_fire.png",
      "size": [
        32,
        32
      ],
      "group": "가마의 병사 (등급 6단계 추가 8종)",
      "what": "유약 바른 도자기 인형 (청룡, 신화 등급). 병사가 아니라 도자기로 빚은 용. 구불구불한 긴 몸이 떠 있고, 뿔·수염·여의주. 32×32 를 꽉 채운다. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다."
    },
    {
      "path": "assets/sprites/kiln/soldier_dragon_earth.png",
      "size": [
        32,
        32
      ],
      "group": "가마의 병사 (등급 6단계 추가 8종)",
      "what": "유약 바른 도자기 인형 (청룡, 신화 등급). 병사가 아니라 도자기로 빚은 용. 구불구불한 긴 몸이 떠 있고, 뿔·수염·여의주. 32×32 를 꽉 채운다. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 흑유 유약 — 검은 갈색에 기름 같은 광택. 오른쪽을 본다."
    },
    {
      "path": "assets/sprites/kiln/soldier_bulgasari_water.png",
      "size": [
        32,
        32
      ],
      "group": "가마의 병사 (등급 6단계 추가 8종)",
      "what": "유약 바른 도자기 인형 (불가사리, 신화 등급). 쇠를 먹는 전설의 짐승 불가사리: 곰 같은 덩치에 쇠 가시가 돋은 등, 코끼리 같은 코. 32×32 를 꽉 채운다. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 청자 유약 — 비취빛 맑은 녹색. 오른쪽을 본다."
    },
    {
      "path": "assets/sprites/kiln/soldier_bulgasari_fire.png",
      "size": [
        32,
        32
      ],
      "group": "가마의 병사 (등급 6단계 추가 8종)",
      "what": "유약 바른 도자기 인형 (불가사리, 신화 등급). 쇠를 먹는 전설의 짐승 불가사리: 곰 같은 덩치에 쇠 가시가 돋은 등, 코끼리 같은 코. 32×32 를 꽉 채운다. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다."
    },
    {
      "path": "assets/sprites/kiln/soldier_bulgasari_earth.png",
      "size": [
        32,
        32
      ],
      "group": "가마의 병사 (등급 6단계 추가 8종)",
      "what": "유약 바른 도자기 인형 (불가사리, 신화 등급). 쇠를 먹는 전설의 짐승 불가사리: 곰 같은 덩치에 쇠 가시가 돋은 등, 코끼리 같은 코. 32×32 를 꽉 채운다. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 흑유 유약 — 검은 갈색에 기름 같은 광택. 오른쪽을 본다."
    },
    {
      "path": "assets/sprites/enemy/fox.png",
      "size": [
        32,
        32
      ],
      "group": "챕터 적·대장",
      "what": "여우 요괴: 주황빛 여우 꼬리 달린 작은 요괴, 날렵. 정한 그림체(먹빛·노란 눈 계열, 진사 빨강은 대장 장식에만 조금). 왼쪽을 본다. 투명 배경."
    },
    {
      "path": "assets/sprites/enemy/armored.png",
      "size": [
        32,
        32
      ],
      "group": "챕터 적·대장",
      "what": "갑옷 도깨비: 먹빛 남색 도깨비에 쇠 투구와 갑옷. 정한 그림체(먹빛·노란 눈 계열, 진사 빨강은 대장 장식에만 조금). 왼쪽을 본다. 투명 배경."
    },
    {
      "path": "assets/sprites/enemy/ghost.png",
      "size": [
        32,
        32
      ],
      "group": "챕터 적·대장",
      "what": "원귀: 흰 소복의 반투명해 보이는 귀신 (픽셀로 표현, 실제 반투명 금지 — 밝은 회청색으로). 정한 그림체(먹빛·노란 눈 계열, 진사 빨강은 대장 장식에만 조금). 왼쪽을 본다. 투명 배경."
    },
    {
      "path": "assets/sprites/enemy/giant.png",
      "size": [
        48,
        48
      ],
      "group": "챕터 적·대장",
      "what": "거인 도깨비: 큰 도깨비보다 더 큰 거인, 바위 방망이. 정한 그림체(먹빛·노란 눈 계열, 진사 빨강은 대장 장식에만 조금). 왼쪽을 본다. 투명 배경."
    },
    {
      "path": "assets/sprites/enemy/chief.png",
      "size": [
        48,
        48
      ],
      "group": "챕터 적·대장",
      "what": "도깨비 대장: 붉은빛이 도는 큰 도깨비, 금 왕관, 큰 방망이. 정한 그림체(먹빛·노란 눈 계열, 진사 빨강은 대장 장식에만 조금). 왼쪽을 본다. 투명 배경."
    },
    {
      "path": "assets/sprites/enemy/gumiho.png",
      "size": [
        48,
        48
      ],
      "group": "챕터 적·대장",
      "what": "구미호: 아홉 꼬리 흰 여우, 꼬리 끝이 주황빛. 정한 그림체(먹빛·노란 눈 계열, 진사 빨강은 대장 장식에만 조금). 왼쪽을 본다. 투명 배경."
    },
    {
      "path": "assets/sprites/enemy/imugi.png",
      "size": [
        48,
        48
      ],
      "group": "챕터 적·대장",
      "what": "이무기: 용이 되지 못한 거대한 뱀, 비늘은 이끼 낀 청록. 정한 그림체(먹빛·노란 눈 계열, 진사 빨강은 대장 장식에만 조금). 왼쪽을 본다. 투명 배경."
    },
    {
      "path": "assets/sprites/enemy/reaper.png",
      "size": [
        48,
        48
      ],
      "group": "챕터 적·대장",
      "what": "저승사자: 검은 갓과 검은 도포, 창백한 얼굴. 정한 그림체(먹빛·노란 눈 계열, 진사 빨강은 대장 장식에만 조금). 왼쪽을 본다. 투명 배경."
    },
    {
      "path": "assets/sprites/enemy/king.png",
      "size": [
        48,
        48
      ],
      "group": "챕터 적·대장",
      "what": "도깨비 왕: 가장 큰 도깨비, 금 왕관과 붉은 도포, 금 방망이. 정한 그림체(먹빛·노란 눈 계열, 진사 빨강은 대장 장식에만 조금). 왼쪽을 본다. 투명 배경."
    }
  ],
  "정한 그림체 (2026-11-27, 사용자 승인)": [
    "기준 그림: art/references/ (= art/style/mix 시안)",
    "형태·디테일·표정은 '가'처럼 — 32×32 에서도 무엇인지 한눈에",
    "바탕은 '다'처럼 먹색·흙 회색조로 차분하게, 강한 색은 유약·기운에만 (청자 비취 초록 / 진사 구리 빨강 / 흑유 검은 갈색 + 기름 광택)",
    "금색은 요변·전설 같은 특별한 것에만",
    "병사는 유약 바른 도자기 인형 (매끈한 몸, 흰 광택, 발밑 받침)",
    "도깨비 무리는 먹빛 남색·회청색 + 노란 눈 (진사 빨강 금지)",
    "외곽선 1px 진한 먹갈색, 전체 팔레트는 기준 그림을 따른다"
  ]
}
# 사용자가 직접 고친 파일 / 덮어쓰면 안 되는 파일 (한 줄에 하나, glob 가능)
# Claude·Codex는 여기 적힌 파일을 덮어쓰지 않는다. 고쳐야 하면 바꿀 내용을 제안만 한다.
art/references/*
art/rubric.md

  Constraints: no text; no logos; no watermark
  ```
  
> ### Game assets template
  ```
  Use case: stylized-concept
> Asset type: <game environment concept art / game character concept / game UI icon / tileable game texture>
  Primary request: <biome/scene/character/icon/material>
  Scene/backdrop: <location + set dressing> (if applicable)
  Subject: <main focal element(s)>
  Style/medium: <realistic/stylized>; <concept art / character render / UI icon / texture>
  Composition/framing: <wide/establishing/top-down>; <camera angle>; <focal point placement>
  Lighting/mood: <time of day>; <mood>; <volumetric/fog/etc>
  Constraints: no logos or trademarks; no watermark
  ```
  
> ### Game assets example: environment concept art
  ```
  Use case: stylized-concept
> Asset type: game environment concept art
  Primary request: cavernous hangar interior with tall support beams and drifting fog
  Scene/backdrop: industrial hangar interior, deep scale, light haze
  Subject: compact shuttle parked near the center
  Style/medium: cinematic concept art, industrial realism
  Composition/framing: wide-angle, low-angle
  Lighting/mood: volumetric light rays cutting through fog
  Constraints: no logos or trademarks; no watermark
  ```
  
> ### Game assets example: character concept
  ```
  Use case: stylized-concept
> Asset type: game character concept
  Primary request: desert scout character with layered travel gear
  Subject: long coat, satchel, practical travel clothing
  Style/medium: character render; stylized realism
  Composition/framing: neutral hero pose on a simple backdrop
  Constraints: no logos or trademarks; no watermark
  ```
  
> ### Game assets example: UI icon
  ```
  Use case: stylized-concept
> Asset type: game UI icon
  Primary request: round shield icon with a subtle rune pattern
> Style/medium: painted game UI icon
  Composition/framing: centered icon; generous padding; clear silhouette
  Constraints: no text; no background scene elements; no logos or trademarks; no watermark
  ```
  
> ### Game assets example: tileable texture
  ```
  Use case: stylized-concept
> Asset type: tileable game texture
  Primary request: worn sandstone blocks
  Style/medium: seamless tileable texture; PBR-ish look
  Scene/backdrop: neutral lighting reference only
  Constraints: seamless edges; no obvious focal elements; no text; no logos or trademarks; no watermark
  ```
  
  ### Wireframe template
  ```
  Use case: ui-mockup
  Asset type: website wireframe
  Primary request: <page or flow to sketch>
  Style/medium: low-fi grayscale wireframe



mcp: node_repl/js started
mcp: node_repl/js (failed)
codex
투석병·쌍검무사·신궁 원본이 생성됐습니다. 축소할 때 돌팔매 끈, 칼 두 자루, 큰 활이 남도록 확인하고, 유약 색은 기존 병사의 색으로 맞추겠습니다.

codex
해치와 청룡은 각각 네발 수호수와 뿔·수염·여의주가 있는 용으로 생성됐습니다. 전설·신화의 큰 몸집을 유지하면서 32×32에서 작은 장식이 잡티처럼 남지 않도록 정리하겠습니다.

mcp: node_repl/js started
mcp: node_repl/js (completed)
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -Encoding UTF8 'work/2026-11-28-다듬기/handoff-05.report.md' | Select-Object -Skip 1700 -First 80" in C:\Users\pc\Documents\game
 succeeded in 366ms:
13 ...AAADDADDAA.AEAEAGAADDADDADA..
14 ....ADDDADDDA.AEEEEEAGAAEAAEA...
15 ...ADDBDADDA...AEEEGAEAEEAEAA...
16 ...AADDDDAA....AEAEAGGGEEGEEA...
17 .....AADDCDAAA..AEEEHHHHHHHAA...
18 .....AADDDADAEAAAEEAEEHIAEA.....
19 ....AAAAADAAAAAAEAHHEEAAHHA.....
20 ...ADDDDDA...AA.AEEAEA.AAEEAA...
21 ...ADDDDDDA..AAAEAAEAEAAEAEAA...
22 ...AAADADAA..AAEAGGAEAAAAAGEEA..
23 ...ADDA.ADA....AAAAAA..AEAAAEA..
24 ...ADDA.ADDA...AEAAEA..AEEEEA...
25 ...AAAAAAAAAAAAAAEEAAAAAAEEAA...
26 ..AIIIIIIIIIIIIIIIIIIIIIIIIIIA..
27 ...AAAAAAAAAAAAAAAAAAAAAAAAAA...
28 ................................
29 ................................
30 ................................
31 ................................
A=282322
B=466F59
C=F2F1E7
D=6B9878
E=706258
F=3A3733
G=929187
H=4D4942
I=304B42

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Add-Type -AssemblyName System.Drawing
function Color([string]$h){[System.Drawing.ColorTranslator]::FromHtml("#"+$h)}
foreach($e in @('"'water','fire','earth')){
"'$path=Join-Path $PWD "assets/sprites/kiln/soldier_healer_$e.png"
$original=[System.Drawing.Bitmap]::FromFile($path);$b=New-Object System.Drawing.Bitmap $original;$original.Dispose()
$dark=Color '"'282322';"'$gray=Color '"'929187';"'$base=Color '"'4D4942'
foreach("'$p in @(@(22,11),@(20,13),@(24,13))){$cx=$p[0];$cy=$p[1];for($dy=-1;$dy -le 1;$dy++){for($dx=-1;$dx -le 1;$dx++){$b.SetPixel(($cx+$dx),($cy+$dy),$dark)}};$b.SetPixel($cx,$cy,$gray)}
$b.SetPixel(22,14,$dark);$b.SetPixel(22,15,$base)
$b.SetPixel(15,14,$dark)
$cloth=@('"'A84438','3C515E','B9BAAD','3A3733','96846A')
for("'$i=0;$i -lt 5;$i++){for($y=21;$y -le (23+($i%2));$y++){$b.SetPixel((11+$i),$y,(Color $cloth[$i]))}}
for($x=9;$x -le 16;$x++){$b.SetPixel($x,26,$base)}
$b.Save($path,[System.Drawing.Imaging.ImageFormat]::Png);$b.Dispose()
}
foreach($e in @('"'water','fire','earth')){
"'$path=Join-Path $PWD "assets/sprites/kiln/soldier_cannon_$e.png"
$original=[System.Drawing.Bitmap]::FromFile($path);$b=New-Object System.Drawing.Bitmap $original;$original.Dispose()
$dark=Color '"'282322';"'$wood=Color '"'706258';"'$hub=Color '"'929187'
foreach("'$cx in @(17,26)){
$rows=@('"'.OOO.','OWWWO','OWHWO','OWWWO','.OOO.')
for("'$dy=0;$dy -lt 5;$dy++){for($dx=0;$dx -lt 5;$dx++){$ch=$rows[$dy][$dx];if($ch -ne '"'.'){"'$c=$dark;if($ch -eq '"'W'){"'$c=$wood};if($ch -eq '"'H'){"'$c=$hub};$b.SetPixel(($cx+$dx-2),(21+$dy),$c)}}}
$b.SetPixel(10,14,$dark)
$b.Save($path,[System.Drawing.Imaging.ImageFormat]::Png);$b.Dispose()
}' in C:\Users\pc\Documents\game
 exited 1 in 155ms:
�� ���� �Ǵ� ���� ���ǿ� �ݴ� '}'�� �����ϴ�.
    + CategoryInfo          : ParserError: (:) [], ParentContainsErrorRecordException
    + FullyQualifiedErrorId : MissingEndCurlyBrace
 

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Add-Type -AssemblyName System.Drawing
$out=New-Object System.Drawing.Bitmap 784,1080
$g=[System.Drawing.Graphics]::FromImage($out)
$g.Clear([System.Drawing.Color]::FromArgb(104,104,104))
$g.InterpolationMode='"'NearestNeighbor'
"'$g.PixelOffsetMode='"'Half'
"'$font=New-Object System.Drawing.Font '"'Arial',10
"'$kinds=@('"'spear','archer','shield','axe','cavalry','healer','cannon')
"'$es=@('"'water','fire','earth')
for("'$row=0;$row -lt 7;$row++){for($col=0;$col -lt 3;$col++){
$name="soldier_$($kinds[$row])_$($es[$col]).png"
$b=[System.Drawing.Bitmap]::FromFile((Join-Path $PWD "assets/sprites/kiln/$name"))
$x=$col*256;$y=$row*152
$g.DrawImage($b,$x,$y,128,128)
$g.DrawImage($b,($x+150),($y+60),32,32)
$g.DrawString(($kinds[$row]+'"' '+"'$es[$col]),$font,[System.Drawing.Brushes]::White,$x,($y+130))
$b.Dispose()
}}
$m=New-Object System.IO.MemoryStream

codex
챕터 일반 적 3종도 생성됐습니다. 여우는 주황 꼬리, 갑옷 도깨비는 쇠 투구와 갑옷, 원귀는 흰 소복으로 구분했습니다. 적의 몸은 먹빛 남색을 중심으로 맞추고, 원귀도 실제 반투명 픽셀 없이 처리하겠습니다.

context compacted
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'git status --porcelain' in C:\Users\pc\Documents\game
 succeeded in 232ms:
 M assets/sprites/enemy/goblin.png
 M assets/sprites/field/house.png
 M assets/sprites/kiln/kiln_body.png.import
 M assets/sprites/kiln/soldier_archer_earth.png.import
 M assets/sprites/kiln/soldier_archer_fire.png.import
 M assets/sprites/kiln/soldier_archer_water.png.import
 M assets/sprites/kiln/soldier_shield_earth.png.import
 M assets/sprites/kiln/soldier_shield_fire.png.import
 M assets/sprites/kiln/soldier_shield_water.png.import
 M assets/sprites/kiln/soldier_spear_earth.png.import
 M assets/sprites/kiln/soldier_spear_fire.png.import
 M assets/sprites/kiln/soldier_spear_water.png.import
 M reports/boss/history.csv
 M "work/2026-11-27-\352\267\270\353\246\274/NOTES.md"
 M "work/2026-11-27-\352\267\270\353\246\274/handoff-03.md"
?? assets/sprites/enemy/brute.png
?? assets/sprites/enemy/brute.png.import
?? assets/sprites/enemy/goblin.png.import
?? assets/sprites/enemy/imp.png
?? assets/sprites/enemy/imp.png.import
?? assets/sprites/field/battlefield.png
?? assets/sprites/field/battlefield.png.import
?? assets/sprites/field/grass_a.png
?? assets/sprites/field/grass_a.png.import
?? assets/sprites/field/grass_b.png
?? assets/sprites/field/grass_b.png.import
?? assets/sprites/field/house.png.import
?? assets/sprites/field/house_broken.png
?? assets/sprites/field/house_broken.png.import
?? assets/sprites/fx/
?? assets/sprites/kiln/soldier_axe_earth.png
?? assets/sprites/kiln/soldier_axe_earth.png.import
?? assets/sprites/kiln/soldier_axe_fire.png
?? assets/sprites/kiln/soldier_axe_fire.png.import
?? assets/sprites/kiln/soldier_axe_water.png
?? assets/sprites/kiln/soldier_axe_water.png.import
?? assets/sprites/kiln/soldier_cannon_earth.png
?? assets/sprites/kiln/soldier_cannon_earth.png.import
?? assets/sprites/kiln/soldier_cannon_fire.png
?? assets/sprites/kiln/soldier_cannon_fire.png.import
?? assets/sprites/kiln/soldier_cannon_water.png
?? assets/sprites/kiln/soldier_cannon_water.png.import
?? assets/sprites/kiln/soldier_cavalry_earth.png
?? assets/sprites/kiln/soldier_cavalry_earth.png.import
?? assets/sprites/kiln/soldier_cavalry_fire.png
?? assets/sprites/kiln/soldier_cavalry_fire.png.import
?? assets/sprites/kiln/soldier_cavalry_water.png
?? assets/sprites/kiln/soldier_cavalry_water.png.import
?? assets/sprites/kiln/soldier_healer_earth.png
?? assets/sprites/kiln/soldier_healer_earth.png.import
?? assets/sprites/kiln/soldier_healer_fire.png
?? assets/sprites/kiln/soldier_healer_fire.png.import
?? assets/sprites/kiln/soldier_healer_water.png
?? assets/sprites/kiln/soldier_healer_water.png.import
?? assets/sprites/nest/
?? reports/boss/history-local-backup.csv
?? src/proto/kiln_run.gd.uid
?? tests/sweep_kiln.gd.uid
?? tests/test_kiln_run.gd.uid
?? "work/2026-11-27-\352\267\270\353\246\274/compare-03-screens.png"
?? "work/2026-11-27-\352\267\270\353\246\274/compare-03.png"
?? "work/2026-11-27-\352\267\270\353\246\274/handoff-03-run1/"
?? "work/2026-11-27-\352\267\270\353\246\274/handoff-03-run2/"
?? "work/2026-11-27-\352\267\270\353\246\274/handoff-03.report.md"
?? "work/2026-11-27-\352\267\270\353\246\274/screens-02b/"
?? "work/2026-11-27-\352\267\270\353\246\274/screens-03-run1/"
?? "work/2026-11-27-\352\267\270\353\246\274/screens-03-run2/"
?? "work/2026-11-27-\354\213\244\352\260\220/handoff-04.report.md"
?? "work/2026-11-27-\354\213\244\352\260\220/sheet-04.png"
?? "work/2026-11-28-\353\213\244\353\223\254\352\270\260/handoff-05.report.md"
?? "work/2026-11-28-\353\213\244\353\223\254\352\270\260/handoff-06.report.md"
?? "work/2026-11-28-\353\213\244\353\223\254\352\270\260/screens-05/"
?? "work/2026-11-28-\353\213\244\353\223\254\352\270\260/sheet-05.png"

codex
원본 생성은 끝났고, 이제 실제 32×32·48×48로 줄여 기존 그림의 색에 맞추겠습니다. 구미호는 꼬리가 아홉 개로 분명히 보이도록 한 번 더 수정하고 있습니다.

mcp: node_repl/js started
mcp: node_repl/js (completed)
mcp: node_repl/js started
mcp: node_repl/js (completed)
mcp: node_repl/js started
mcp: node_repl/js (completed)
codex
축소본을 기존 도끼병·기병·도깨비와 나란히 확인했습니다. 무기와 짐승 형태는 구분되지만, 일부 병사의 작은 명암이 복잡하게 보여 색을 더 묶고 있습니다. 구미호는 아홉 꼬리가 보이는 원본으로 수정했습니다.

mcp: node_repl/js started
mcp: node_repl/js (failed)
mcp: node_repl/js started
mcp: node_repl/js (completed)
mcp: node_repl/js started
mcp: node_repl/js (completed)
mcp: node_repl/js started
mcp: node_repl/js (completed)
mcp: node_repl/js started
mcp: node_repl/js (completed)
mcp: node_repl/js started
mcp: node_repl/js (completed)
mcp: node_repl/js started
mcp: node_repl/js (failed)
codex
병사 24장의 청자·진사·흑유 변형을 확인했습니다. 마지막으로 축소하면서 사라진 적의 노란 눈과 신궁의 금빛 시위를 보정한 뒤, 지정된 33개 경로에만 저장하고 크기·색 수·투명도를 확인하겠습니다.

mcp: node_repl/js started
mcp: node_repl/js (completed)
mcp: node_repl/js started
mcp: node_repl/js (completed)
mcp: node_repl/js started
mcp: node_repl/js (completed)
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'git status --porcelain --untracked-files=all -- assets/sprites/kiln/soldier_slinger* assets/sprites/kiln/soldier_twin* assets/sprites/kiln/soldier_general* assets/sprites/kiln/soldier_sniper* assets/sprites/kiln/soldier_haetae* assets/sprites/kiln/soldier_cheoyong* assets/sprites/kiln/soldier_dragon* assets/sprites/kiln/soldier_bulgasari* assets/sprites/enemy/fox.png assets/sprites/enemy/armored.png assets/sprites/enemy/ghost.png assets/sprites/enemy/giant.png assets/sprites/enemy/chief.png assets/sprites/enemy/gumiho.png assets/sprites/enemy/imugi.png assets/sprites/enemy/reaper.png assets/sprites/enemy/king.png' in C:\Users\pc\Documents\game
 succeeded in 333ms:
?? assets/sprites/enemy/armored.png
?? assets/sprites/enemy/chief.png
?? assets/sprites/enemy/fox.png
?? assets/sprites/enemy/ghost.png
?? assets/sprites/enemy/giant.png
?? assets/sprites/enemy/gumiho.png
?? assets/sprites/enemy/imugi.png
?? assets/sprites/enemy/king.png
?? assets/sprites/enemy/reaper.png
?? assets/sprites/kiln/soldier_bulgasari_earth.png
?? assets/sprites/kiln/soldier_bulgasari_fire.png
?? assets/sprites/kiln/soldier_bulgasari_water.png
?? assets/sprites/kiln/soldier_cheoyong_earth.png
?? assets/sprites/kiln/soldier_cheoyong_fire.png
?? assets/sprites/kiln/soldier_cheoyong_water.png
?? assets/sprites/kiln/soldier_dragon_earth.png
?? assets/sprites/kiln/soldier_dragon_fire.png
?? assets/sprites/kiln/soldier_dragon_water.png
?? assets/sprites/kiln/soldier_general_earth.png
?? assets/sprites/kiln/soldier_general_fire.png
?? assets/sprites/kiln/soldier_general_water.png
?? assets/sprites/kiln/soldier_haetae_earth.png
?? assets/sprites/kiln/soldier_haetae_fire.png
?? assets/sprites/kiln/soldier_haetae_water.png
?? assets/sprites/kiln/soldier_slinger_earth.png
?? assets/sprites/kiln/soldier_slinger_fire.png
?? assets/sprites/kiln/soldier_slinger_water.png
?? assets/sprites/kiln/soldier_sniper_earth.png
?? assets/sprites/kiln/soldier_sniper_fire.png
?? assets/sprites/kiln/soldier_sniper_water.png
?? assets/sprites/kiln/soldier_twin_earth.png
?? assets/sprites/kiln/soldier_twin_fire.png
?? assets/sprites/kiln/soldier_twin_water.png

mcp: node_repl/js started
mcp: node_repl/js (completed)
codex
결과: 통과

바뀐 파일:
- `assets/sprites/kiln/soldier_{slinger,twin,general,sniper,haetae,cheoyong,dragon,bulgasari}_{water,fire,earth}.png` — 병사·짐승 24장 추가.
- `assets/sprites/enemy/{fox,armored,ghost,giant,chief,gumiho,imugi,reaper,king}.png` — 적·대장 9장 추가.

직접 확인한 것:
- 33장 모두 지정 크기, 투명 배경, 반투명 픽셀 없음, 색상 6~16개.
- 병사마다 흰 광택 2픽셀, 구미호 꼬리 끝 9개 확인.
- 저장된 그림을 기존 그림과 나란히 비교.
- 기존 스프라이트 파일 변경 없음.

그리는 데 쓴 방법:
- **둘 다** — 이미지 생성 후 JavaScript로 축소·색상 정리·유약 변형·픽셀 보정.

못 한 것 / 걱정되는 것:
- 게임 화면 확인과 저장소 Python 검사는 Claude의 후속 작업으로 남겼습니다.
- 파일 형식 검사는 통과, 재미·미술 판단은 사용자 몫입니다.
tokens used
123,503
결과: 통과

바뀐 파일:
- `assets/sprites/kiln/soldier_{slinger,twin,general,sniper,haetae,cheoyong,dragon,bulgasari}_{water,fire,earth}.png` — 병사·짐승 24장 추가.
- `assets/sprites/enemy/{fox,armored,ghost,giant,chief,gumiho,imugi,reaper,king}.png` — 적·대장 9장 추가.

직접 확인한 것:
- 33장 모두 지정 크기, 투명 배경, 반투명 픽셀 없음, 색상 6~16개.
- 병사마다 흰 광택 2픽셀, 구미호 꼬리 끝 9개 확인.
- 저장된 그림을 기존 그림과 나란히 비교.
- 기존 스프라이트 파일 변경 없음.

그리는 데 쓴 방법:
- **둘 다** — 이미지 생성 후 JavaScript로 축소·색상 정리·유약 변형·픽셀 보정.

못 한 것 / 걱정되는 것:
- 게임 화면 확인과 저장소 Python 검사는 Claude의 후속 작업으로 남겼습니다.
- 파일 형식 검사는 통과, 재미·미술 판단은 사용자 몫입니다.
