# Codex 작업 지시서 — 등급 6단계 새 병사 8종 + 챕터 적·대장

> **2026-11-29: 병사 8종 부분은 지시서 07(work/2026-11-29-스킬진영/handoff-07.md)이 대신한다. 이 지시서에서는 '챕터 적·대장' 9장만 만든다.** (불가사리는 빠짐)

- 날짜: 2026-11-28
- 작업 폴더: work/2026-11-28-다듬기/
- 지시서 번호: 06 (지시서 05 의 새 병사 4종과 같은 방식. 05 를 아직 안 했으면 05 먼저)

## 먼저 읽을 것
1. AGENTS.md
2. art/references/ — 정한 그림체
3. 이미 있는 그림 `assets/sprites/kiln/soldier_*.png`, `assets/sprites/enemy/goblin.png` — **이것과 한 벌로**
4. docs/그림-목록.md, art/sprite_list.json 의 "가마의 병사 (등급 6단계 추가 8종)" · "챕터 적·대장" 묶음
5. work/2026-11-28-다듬기/pixel_preview.png — 사용자가 요청해 Claude가 먼저 설계한 장수·신궁·처용·해치·청룡·불가사리 도트 (격자: src/game/pixel_art.gd). **이 모양과 크기(전설 40px·신화 48px 느낌)를 바탕으로 더 다듬는다**
6. work/2026-11-28-다듬기/NOTES.md

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
