# Codex 작업 지시서 — 높은 등급 병사 8종(같은 체형) + 스킬 이펙트 17장

- 날짜: 2026-11-29
- 작업 폴더: work/2026-11-29-스킬진영/
- 지시서 번호: 07 (지시서 06 의 "가마의 병사 (등급 6단계 추가 8종)" 부분을 이 지시서가 대신한다. 06 의 챕터 적·대장은 그대로)

## 먼저 읽을 것
1. AGENTS.md
2. art/references/ — 정한 그림체
3. `assets/sprites/kiln/soldier_spear_*.png` 등 일반 병사 9장 — **체형·크기·받침·광택을 그대로** 맞춘다
4. `work/2026-11-28-다듬기/pixel_preview.png` — 사용자 요청으로 Claude가 만든 기준 도트 (일반 병사 몸에 머리 장식·무기만 바꿈). **이 디자인을 다듬는다**
5. docs/그림-목록.md, art/sprite_list.json 의 "가마의 병사 (등급 6단계 추가 8종)" · "스킬 이펙트" 묶음
6. work/2026-11-29-스킬진영/NOTES.md

## 목표 (사용자 말 그대로)
> "첨부한 사진의 유닛을 보면 어떻게 생겼는지 유닛별로 확실히 보이면서 촌스럽지 않고 이상한 느낌도 안 드는데, 지금 영웅 등급부터 신화까지 병사와 유닛들 생김새가 너무 이상해. 되게 이질적이야. 외형이랑 움직임을 꼭 체크해서 수정해줘."
> "스킬 이펙트도 좋은 에셋을 사용해서 화려하게 잘 수정해주고"
> "신화 등급에 청룡, 백호, 주작, 현무로 구성되도록 수정해줘."

해석(참고용): 사용자가 보여 준 예시는 **모든 유닛이 같은 크기·같은 비율**이라 한 벌로 보인다. 높은 등급도 일반 병사와 **같은 몸**에, 투구·무기·장식만 화려하게. 짐승 모양·큰 그림 금지. 신화는 사신(청룡·백호·주작·현무)을 상징하는 장수.

## 정한 그림체 (반드시 따른다)
- 일반 병사와 같은 32×32 도자기 인형 체형 (얼굴 회색, 받침, 왼쪽 위 흰 광택)
- 유약 색: 청자(물) / 진사(불) / 흑유(땅) — 몸·투구 등 큰 면에
- 금색은 장식에만 조금. 등급 빛·요변 빛은 게임이 코드로 그린다 (그림에 넣지 않는다)
- 오른쪽을 본다. 투명 배경, 색 24개 이하, 흐림 없음, 외곽선 1px
- 스킬 이펙트: 64×64 장면 8개를 가로 한 줄 (512×64), 빛나는 부분은 밝게, 32색 이하

## 그리는 방법 (사용자가 정한 것)
- [x] 이미지 생성 후 코드로 다듬기 (크기 맞추기·배경 투명·색 줄이기) — 사용자가 handoff-01 에서 정함 (2026-11-27)

정한 방법을 쓸 수 없으면 다른 방법으로 바꾸지 말고 `결과: 못 돌림` 으로 보고한다.

## 만들 것 (47장)

| 파일 | 크기 | 내용 |
|---|---|---|
| `assets/sprites/kiln/soldier_slinger_water.png` | 32×32 | 유약 바른 도자기 인형 (투석병, 고급 등급). 돌팔매 끈을 머리 위로 돌리는 가벼운 병사. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 청자 유약 — 비취빛 맑은 녹색. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_slinger_fire.png` | 32×32 | 유약 바른 도자기 인형 (투석병, 고급 등급). 돌팔매 끈을 머리 위로 돌리는 가벼운 병사. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_slinger_earth.png` | 32×32 | 유약 바른 도자기 인형 (투석병, 고급 등급). 돌팔매 끈을 머리 위로 돌리는 가벼운 병사. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 흑유 유약 — 검은 갈색에 기름 같은 광택. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_twin_water.png` | 32×32 | 유약 바른 도자기 인형 (쌍검무사, 희귀 등급). 양손에 짧은 칼 두 자루, 날렵한 자세. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 청자 유약 — 비취빛 맑은 녹색. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_twin_fire.png` | 32×32 | 유약 바른 도자기 인형 (쌍검무사, 희귀 등급). 양손에 짧은 칼 두 자루, 날렵한 자세. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_twin_earth.png` | 32×32 | 유약 바른 도자기 인형 (쌍검무사, 희귀 등급). 양손에 짧은 칼 두 자루, 날렵한 자세. 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침(굽). 몸 전체에 흑유 유약 — 검은 갈색에 기름 같은 광택. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_general_water.png` | 32×32 | 유약 바른 도자기 인형 병사 (장수, 영웅 등급). **일반 병사와 똑같은 체형·크기** (창병 그림의 얼굴·몸·받침 그대로, 32×32). 등급은 머리 장식·무기로만: 붉은 술 달린 쇠 투구, 금 테, 어깨 갑옷, 등 뒤 유약 색 망토, 오른손에 치켜든 칼. 몸 전체에 청자 유약 — 비취빛 맑은 녹색. 오른쪽을 본다. 참고 도트: work/2026-11-28-다듬기/pixel_preview.png |
| `assets/sprites/kiln/soldier_general_fire.png` | 32×32 | 유약 바른 도자기 인형 병사 (장수, 영웅 등급). **일반 병사와 똑같은 체형·크기** (창병 그림의 얼굴·몸·받침 그대로, 32×32). 등급은 머리 장식·무기로만: 붉은 술 달린 쇠 투구, 금 테, 어깨 갑옷, 등 뒤 유약 색 망토, 오른손에 치켜든 칼. 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다. 참고 도트: work/2026-11-28-다듬기/pixel_preview.png |
| `assets/sprites/kiln/soldier_general_earth.png` | 32×32 | 유약 바른 도자기 인형 병사 (장수, 영웅 등급). **일반 병사와 똑같은 체형·크기** (창병 그림의 얼굴·몸·받침 그대로, 32×32). 등급은 머리 장식·무기로만: 붉은 술 달린 쇠 투구, 금 테, 어깨 갑옷, 등 뒤 유약 색 망토, 오른손에 치켜든 칼. 몸 전체에 흑유 유약 — 검은 갈색에 기름 같은 광택. 오른쪽을 본다. 참고 도트: work/2026-11-28-다듬기/pixel_preview.png |
| `assets/sprites/kiln/soldier_sniper_water.png` | 32×32 | 유약 바른 도자기 인형 병사 (신궁, 영웅 등급). **일반 병사와 똑같은 체형·크기** (창병 그림의 얼굴·몸·받침 그대로, 32×32). 등급은 머리 장식·무기로만: 흰 깃 꽂은 검은 갓, 금빛 시위의 큰 활, 등에 화살통. 몸 전체에 청자 유약 — 비취빛 맑은 녹색. 오른쪽을 본다. 참고 도트: work/2026-11-28-다듬기/pixel_preview.png |
| `assets/sprites/kiln/soldier_sniper_fire.png` | 32×32 | 유약 바른 도자기 인형 병사 (신궁, 영웅 등급). **일반 병사와 똑같은 체형·크기** (창병 그림의 얼굴·몸·받침 그대로, 32×32). 등급은 머리 장식·무기로만: 흰 깃 꽂은 검은 갓, 금빛 시위의 큰 활, 등에 화살통. 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다. 참고 도트: work/2026-11-28-다듬기/pixel_preview.png |
| `assets/sprites/kiln/soldier_sniper_earth.png` | 32×32 | 유약 바른 도자기 인형 병사 (신궁, 영웅 등급). **일반 병사와 똑같은 체형·크기** (창병 그림의 얼굴·몸·받침 그대로, 32×32). 등급은 머리 장식·무기로만: 흰 깃 꽂은 검은 갓, 금빛 시위의 큰 활, 등에 화살통. 몸 전체에 흑유 유약 — 검은 갈색에 기름 같은 광택. 오른쪽을 본다. 참고 도트: work/2026-11-28-다듬기/pixel_preview.png |
| `assets/sprites/kiln/soldier_haetae_water.png` | 32×32 | 유약 바른 도자기 인형 병사 (해치, 전설 등급). **일반 병사와 똑같은 체형·크기** (창병 그림의 얼굴·몸·받침 그대로, 32×32). 등급은 머리 장식·무기로만: 해치 탈 투구(곱슬 갈기·금눈·이마에 뿔 하나)를 쓴 수호장, 방울 목걸이, 불꽃 날 언월도. 몸 전체에 청자 유약 — 비취빛 맑은 녹색. 오른쪽을 본다. 참고 도트: work/2026-11-28-다듬기/pixel_preview.png |
| `assets/sprites/kiln/soldier_haetae_fire.png` | 32×32 | 유약 바른 도자기 인형 병사 (해치, 전설 등급). **일반 병사와 똑같은 체형·크기** (창병 그림의 얼굴·몸·받침 그대로, 32×32). 등급은 머리 장식·무기로만: 해치 탈 투구(곱슬 갈기·금눈·이마에 뿔 하나)를 쓴 수호장, 방울 목걸이, 불꽃 날 언월도. 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다. 참고 도트: work/2026-11-28-다듬기/pixel_preview.png |
| `assets/sprites/kiln/soldier_haetae_earth.png` | 32×32 | 유약 바른 도자기 인형 병사 (해치, 전설 등급). **일반 병사와 똑같은 체형·크기** (창병 그림의 얼굴·몸·받침 그대로, 32×32). 등급은 머리 장식·무기로만: 해치 탈 투구(곱슬 갈기·금눈·이마에 뿔 하나)를 쓴 수호장, 방울 목걸이, 불꽃 날 언월도. 몸 전체에 흑유 유약 — 검은 갈색에 기름 같은 광택. 오른쪽을 본다. 참고 도트: work/2026-11-28-다듬기/pixel_preview.png |
| `assets/sprites/kiln/soldier_cheoyong_water.png` | 32×32 | 유약 바른 도자기 인형 병사 (처용, 전설 등급). **일반 병사와 똑같은 체형·크기** (창병 그림의 얼굴·몸·받침 그대로, 32×32). 등급은 머리 장식·무기로만: 모란·복숭아 꽂은 사모, 커다란 붉은 처용 탈, 색동 소매 끝 흰 한삼을 휘날림. 몸 전체에 청자 유약 — 비취빛 맑은 녹색. 오른쪽을 본다. 참고 도트: work/2026-11-28-다듬기/pixel_preview.png |
| `assets/sprites/kiln/soldier_cheoyong_fire.png` | 32×32 | 유약 바른 도자기 인형 병사 (처용, 전설 등급). **일반 병사와 똑같은 체형·크기** (창병 그림의 얼굴·몸·받침 그대로, 32×32). 등급은 머리 장식·무기로만: 모란·복숭아 꽂은 사모, 커다란 붉은 처용 탈, 색동 소매 끝 흰 한삼을 휘날림. 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다. 참고 도트: work/2026-11-28-다듬기/pixel_preview.png |
| `assets/sprites/kiln/soldier_cheoyong_earth.png` | 32×32 | 유약 바른 도자기 인형 병사 (처용, 전설 등급). **일반 병사와 똑같은 체형·크기** (창병 그림의 얼굴·몸·받침 그대로, 32×32). 등급은 머리 장식·무기로만: 모란·복숭아 꽂은 사모, 커다란 붉은 처용 탈, 색동 소매 끝 흰 한삼을 휘날림. 몸 전체에 흑유 유약 — 검은 갈색에 기름 같은 광택. 오른쪽을 본다. 참고 도트: work/2026-11-28-다듬기/pixel_preview.png |
| `assets/sprites/kiln/soldier_dragon_water.png` | 32×32 | 유약 바른 도자기 인형 병사 (청룡, 신화 등급). **일반 병사와 똑같은 체형·크기** (창병 그림의 얼굴·몸·받침 그대로, 32×32). 등급은 머리 장식·무기로만: 용 투구(금 사슴뿔·흰 수염), 청룡언월도(초승달 날). 몸 전체에 청자 유약 — 비취빛 맑은 녹색. 오른쪽을 본다. 참고 도트: work/2026-11-28-다듬기/pixel_preview.png |
| `assets/sprites/kiln/soldier_dragon_fire.png` | 32×32 | 유약 바른 도자기 인형 병사 (청룡, 신화 등급). **일반 병사와 똑같은 체형·크기** (창병 그림의 얼굴·몸·받침 그대로, 32×32). 등급은 머리 장식·무기로만: 용 투구(금 사슴뿔·흰 수염), 청룡언월도(초승달 날). 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다. 참고 도트: work/2026-11-28-다듬기/pixel_preview.png |
| `assets/sprites/kiln/soldier_dragon_earth.png` | 32×32 | 유약 바른 도자기 인형 병사 (청룡, 신화 등급). **일반 병사와 똑같은 체형·크기** (창병 그림의 얼굴·몸·받침 그대로, 32×32). 등급은 머리 장식·무기로만: 용 투구(금 사슴뿔·흰 수염), 청룡언월도(초승달 날). 몸 전체에 흑유 유약 — 검은 갈색에 기름 같은 광택. 오른쪽을 본다. 참고 도트: work/2026-11-28-다듬기/pixel_preview.png |
| `assets/sprites/kiln/soldier_baekho_water.png` | 32×32 | 유약 바른 도자기 인형 병사 (백호, 신화 등급). **일반 병사와 똑같은 체형·크기** (창병 그림의 얼굴·몸·받침 그대로, 32×32). 등급은 머리 장식·무기로만: 흰 범 가죽 두건(귀·유약 색 줄무늬·금눈), 어깨 범 가죽, 양손 범 발톱. 몸 전체에 청자 유약 — 비취빛 맑은 녹색. 오른쪽을 본다. 참고 도트: work/2026-11-28-다듬기/pixel_preview.png |
| `assets/sprites/kiln/soldier_baekho_fire.png` | 32×32 | 유약 바른 도자기 인형 병사 (백호, 신화 등급). **일반 병사와 똑같은 체형·크기** (창병 그림의 얼굴·몸·받침 그대로, 32×32). 등급은 머리 장식·무기로만: 흰 범 가죽 두건(귀·유약 색 줄무늬·금눈), 어깨 범 가죽, 양손 범 발톱. 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다. 참고 도트: work/2026-11-28-다듬기/pixel_preview.png |
| `assets/sprites/kiln/soldier_baekho_earth.png` | 32×32 | 유약 바른 도자기 인형 병사 (백호, 신화 등급). **일반 병사와 똑같은 체형·크기** (창병 그림의 얼굴·몸·받침 그대로, 32×32). 등급은 머리 장식·무기로만: 흰 범 가죽 두건(귀·유약 색 줄무늬·금눈), 어깨 범 가죽, 양손 범 발톱. 몸 전체에 흑유 유약 — 검은 갈색에 기름 같은 광택. 오른쪽을 본다. 참고 도트: work/2026-11-28-다듬기/pixel_preview.png |
| `assets/sprites/kiln/soldier_jujak_water.png` | 32×32 | 유약 바른 도자기 인형 병사 (주작, 신화 등급). **일반 병사와 똑같은 체형·크기** (창병 그림의 얼굴·몸·받침 그대로, 32×32). 등급은 머리 장식·무기로만: 봉황 깃 관(주황·빨강·금), 금 머리띠, 등의 작은 불꽃 날개, 불꽃 부채. 몸 전체에 청자 유약 — 비취빛 맑은 녹색. 오른쪽을 본다. 참고 도트: work/2026-11-28-다듬기/pixel_preview.png |
| `assets/sprites/kiln/soldier_jujak_fire.png` | 32×32 | 유약 바른 도자기 인형 병사 (주작, 신화 등급). **일반 병사와 똑같은 체형·크기** (창병 그림의 얼굴·몸·받침 그대로, 32×32). 등급은 머리 장식·무기로만: 봉황 깃 관(주황·빨강·금), 금 머리띠, 등의 작은 불꽃 날개, 불꽃 부채. 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다. 참고 도트: work/2026-11-28-다듬기/pixel_preview.png |
| `assets/sprites/kiln/soldier_jujak_earth.png` | 32×32 | 유약 바른 도자기 인형 병사 (주작, 신화 등급). **일반 병사와 똑같은 체형·크기** (창병 그림의 얼굴·몸·받침 그대로, 32×32). 등급은 머리 장식·무기로만: 봉황 깃 관(주황·빨강·금), 금 머리띠, 등의 작은 불꽃 날개, 불꽃 부채. 몸 전체에 흑유 유약 — 검은 갈색에 기름 같은 광택. 오른쪽을 본다. 참고 도트: work/2026-11-28-다듬기/pixel_preview.png |
| `assets/sprites/kiln/soldier_hyeonmu_water.png` | 32×32 | 유약 바른 도자기 인형 병사 (현무, 신화 등급). **일반 병사와 똑같은 체형·크기** (창병 그림의 얼굴·몸·받침 그대로, 32×32). 등급은 머리 장식·무기로만: 등딱지 투구, 육각 무늬 거북 방패, 검은 뱀이 감긴 지팡이. 몸 전체에 청자 유약 — 비취빛 맑은 녹색. 오른쪽을 본다. 참고 도트: work/2026-11-28-다듬기/pixel_preview.png |
| `assets/sprites/kiln/soldier_hyeonmu_fire.png` | 32×32 | 유약 바른 도자기 인형 병사 (현무, 신화 등급). **일반 병사와 똑같은 체형·크기** (창병 그림의 얼굴·몸·받침 그대로, 32×32). 등급은 머리 장식·무기로만: 등딱지 투구, 육각 무늬 거북 방패, 검은 뱀이 감긴 지팡이. 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다. 참고 도트: work/2026-11-28-다듬기/pixel_preview.png |
| `assets/sprites/kiln/soldier_hyeonmu_earth.png` | 32×32 | 유약 바른 도자기 인형 병사 (현무, 신화 등급). **일반 병사와 똑같은 체형·크기** (창병 그림의 얼굴·몸·받침 그대로, 32×32). 등급은 머리 장식·무기로만: 등딱지 투구, 육각 무늬 거북 방패, 검은 뱀이 감긴 지팡이. 몸 전체에 흑유 유약 — 검은 갈색에 기름 같은 광택. 오른쪽을 본다. 참고 도트: work/2026-11-28-다듬기/pixel_preview.png |
| `assets/sprites/fx/skill_spear.png` | 512×64 | 돌격 찌르기: 앞으로 뻗는 날카로운 빛줄기와 충격. 8장면 (64×64 정사각형을 가로 한 줄, 전체 512×64). 투명 배경, 빛나는 부분은 밝게 (게임이 빛을 더하는 방식으로 겹쳐 그림). 오른쪽을 향함. 병사 발밑 가운데 기준 |
| `assets/sprites/fx/skill_archer.png` | 512×64 | 연사: 화살 여러 발이 부채꼴로 퍼지는 빛 궤적. 8장면 (64×64 정사각형을 가로 한 줄, 전체 512×64). 투명 배경, 빛나는 부분은 밝게 (게임이 빛을 더하는 방식으로 겹쳐 그림). 오른쪽을 향함. 병사 발밑 가운데 기준 |
| `assets/sprites/fx/skill_shield.png` | 512×64 | 방패 벽: 둥근 방패 모양 빛 장막이 펼쳐짐. 8장면 (64×64 정사각형을 가로 한 줄, 전체 512×64). 투명 배경, 빛나는 부분은 밝게 (게임이 빛을 더하는 방식으로 겹쳐 그림). 오른쪽을 향함. 병사 발밑 가운데 기준 |
| `assets/sprites/fx/skill_axe.png` | 512×64 | 회오리 베기: 몸을 도는 원형 칼바람. 8장면 (64×64 정사각형을 가로 한 줄, 전체 512×64). 투명 배경, 빛나는 부분은 밝게 (게임이 빛을 더하는 방식으로 겹쳐 그림). 오른쪽을 향함. 병사 발밑 가운데 기준 |
| `assets/sprites/fx/skill_cavalry.png` | 512×64 | 돌파: 앞으로 길게 그어지는 질주 잔상과 흙먼지. 8장면 (64×64 정사각형을 가로 한 줄, 전체 512×64). 투명 배경, 빛나는 부분은 밝게 (게임이 빛을 더하는 방식으로 겹쳐 그림). 오른쪽을 향함. 병사 발밑 가운데 기준 |
| `assets/sprites/fx/skill_slinger.png` | 512×64 | 바윗돌: 큰 돌이 날아가 부서지는 충격과 파편. 8장면 (64×64 정사각형을 가로 한 줄, 전체 512×64). 투명 배경, 빛나는 부분은 밝게 (게임이 빛을 더하는 방식으로 겹쳐 그림). 오른쪽을 향함. 병사 발밑 가운데 기준 |
| `assets/sprites/fx/skill_healer.png` | 512×64 | 큰 굿: 오색 천과 방울 빛이 위로 피어오름 (초록 회복빛). 8장면 (64×64 정사각형을 가로 한 줄, 전체 512×64). 투명 배경, 빛나는 부분은 밝게 (게임이 빛을 더하는 방식으로 겹쳐 그림). 오른쪽을 향함. 병사 발밑 가운데 기준 |
| `assets/sprites/fx/skill_cannon.png` | 512×64 | 신기전 일제 사격: 불꼬리 로켓 발사 섬광. 8장면 (64×64 정사각형을 가로 한 줄, 전체 512×64). 투명 배경, 빛나는 부분은 밝게 (게임이 빛을 더하는 방식으로 겹쳐 그림). 오른쪽을 향함. 병사 발밑 가운데 기준 |
| `assets/sprites/fx/skill_twin.png` | 512×64 | 칼춤: X자 칼빛이 여러 번 번쩍. 8장면 (64×64 정사각형을 가로 한 줄, 전체 512×64). 투명 배경, 빛나는 부분은 밝게 (게임이 빛을 더하는 방식으로 겹쳐 그림). 오른쪽을 향함. 병사 발밑 가운데 기준 |
| `assets/sprites/fx/skill_general.png` | 512×64 | 진군의 북: 북소리 충격파 고리 + 붉은 기세. 8장면 (64×64 정사각형을 가로 한 줄, 전체 512×64). 투명 배경, 빛나는 부분은 밝게 (게임이 빛을 더하는 방식으로 겹쳐 그림). 오른쪽을 향함. 병사 발밑 가운데 기준 |
| `assets/sprites/fx/skill_sniper.png` | 512×64 | 관통 화살: 한 줄로 길게 꿰뚫는 금빛 화살 궤적. 8장면 (64×64 정사각형을 가로 한 줄, 전체 512×64). 투명 배경, 빛나는 부분은 밝게 (게임이 빛을 더하는 방식으로 겹쳐 그림). 오른쪽을 향함. 병사 발밑 가운데 기준 |
| `assets/sprites/fx/skill_haetae.png` | 512×64 | 화염 숨결: 앞으로 뿜어지는 불꽃 부채꼴. 8장면 (64×64 정사각형을 가로 한 줄, 전체 512×64). 투명 배경, 빛나는 부분은 밝게 (게임이 빛을 더하는 방식으로 겹쳐 그림). 오른쪽을 향함. 병사 발밑 가운데 기준 |
| `assets/sprites/fx/skill_cheoyong.png` | 512×64 | 역신 쫓는 춤: 소매 회오리 + 별 모양 기절 빛. 8장면 (64×64 정사각형을 가로 한 줄, 전체 512×64). 투명 배경, 빛나는 부분은 밝게 (게임이 빛을 더하는 방식으로 겹쳐 그림). 오른쪽을 향함. 병사 발밑 가운데 기준 |
| `assets/sprites/fx/skill_dragon.png` | 512×64 | 용오름: 아래에서 솟구치는 물기둥과 용 모양 물보라. 8장면 (64×64 정사각형을 가로 한 줄, 전체 512×64). 투명 배경, 빛나는 부분은 밝게 (게임이 빛을 더하는 방식으로 겹쳐 그림). 오른쪽을 향함. 병사 발밑 가운데 기준 |
| `assets/sprites/fx/skill_baekho.png` | 512×64 | 범의 포효: 흰 번개 발톱 세 줄 + 포효 충격파. 8장면 (64×64 정사각형을 가로 한 줄, 전체 512×64). 투명 배경, 빛나는 부분은 밝게 (게임이 빛을 더하는 방식으로 겹쳐 그림). 오른쪽을 향함. 병사 발밑 가운데 기준 |
| `assets/sprites/fx/skill_jujak.png` | 512×64 | 불새 강림: 하늘에서 떨어지는 불꽃 깃털. 8장면 (64×64 정사각형을 가로 한 줄, 전체 512×64). 투명 배경, 빛나는 부분은 밝게 (게임이 빛을 더하는 방식으로 겹쳐 그림). 오른쪽을 향함. 병사 발밑 가운데 기준 |
| `assets/sprites/fx/skill_hyeonmu.png` | 512×64 | 거북 등딱지: 육각 무늬 보호막이 둥글게 덮임. 8장면 (64×64 정사각형을 가로 한 줄, 전체 512×64). 투명 배경, 빛나는 부분은 밝게 (게임이 빛을 더하는 방식으로 겹쳐 그림). 오른쪽을 향함. 병사 발밑 가운데 기준 |

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
- `assets/sprites/kiln/soldier_baekho_water.png` (새 파일)
- `assets/sprites/kiln/soldier_baekho_fire.png` (새 파일)
- `assets/sprites/kiln/soldier_baekho_earth.png` (새 파일)
- `assets/sprites/kiln/soldier_jujak_water.png` (새 파일)
- `assets/sprites/kiln/soldier_jujak_fire.png` (새 파일)
- `assets/sprites/kiln/soldier_jujak_earth.png` (새 파일)
- `assets/sprites/kiln/soldier_hyeonmu_water.png` (새 파일)
- `assets/sprites/kiln/soldier_hyeonmu_fire.png` (새 파일)
- `assets/sprites/kiln/soldier_hyeonmu_earth.png` (새 파일)
- `assets/sprites/fx/skill_spear.png` (새 파일)
- `assets/sprites/fx/skill_archer.png` (새 파일)
- `assets/sprites/fx/skill_shield.png` (새 파일)
- `assets/sprites/fx/skill_axe.png` (새 파일)
- `assets/sprites/fx/skill_cavalry.png` (새 파일)
- `assets/sprites/fx/skill_slinger.png` (새 파일)
- `assets/sprites/fx/skill_healer.png` (새 파일)
- `assets/sprites/fx/skill_cannon.png` (새 파일)
- `assets/sprites/fx/skill_twin.png` (새 파일)
- `assets/sprites/fx/skill_general.png` (새 파일)
- `assets/sprites/fx/skill_sniper.png` (새 파일)
- `assets/sprites/fx/skill_haetae.png` (새 파일)
- `assets/sprites/fx/skill_cheoyong.png` (새 파일)
- `assets/sprites/fx/skill_dragon.png` (새 파일)
- `assets/sprites/fx/skill_baekho.png` (새 파일)
- `assets/sprites/fx/skill_jujak.png` (새 파일)
- `assets/sprites/fx/skill_hyeonmu.png` (새 파일)

이 목록에 없는 파일은 만들거나 고치지 않는다.

## 보호 검사 결과 (Claude가 미리 확인함)
- `python3 scripts/protected.py <위 파일들>` → 걸린 파일 없음 (모두 새 파일)
- 이 검사는 Claude가 했다. Codex는 다시 돌리지 않는다.

## 하면 안 되는 일
- 범위 밖 파일 수정·삭제 (특히 `src/`, `tests/`, `art/references/`, `art/rubric.md`, 이미 있는 `assets/sprites/`)
- 게임 코드에 그림을 연결하는 작업 (이미 되어 있다: 파일이 있으면 도트 대신 쓰고, 스킬 때 `fx/skill_<역할>.png` 를 재생)
- 저장소의 Python 스크립트 실행 (검사는 Claude가 작업 후에 한다)
- git commit / push
- 못 했는데 했다고 보고하기

## 끝나면 이 형식으로 보고
```
결과: 통과 | 실패 | 못 돌림   ← 셋 중 하나만
바뀐 파일:
- 경로 — 무엇을
직접 확인한 것:
- 예) 일반 병사 9장과 나란히 놓고 크기·체형 비교, 이펙트 장면 수
그리는 데 쓴 방법:
- 이미지 생성 / 코드 / 둘 다 (무엇을 어떻게)
못 한 것 / 걱정되는 것:
- …
```
- 저장소의 Python 검사를 못 돌린 것만으로는 `못 돌림`이 아니다. 검사는 Claude가 한다.

## Claude가 받은 뒤 할 일
1. `git status` — 바뀐 파일이 위 범위뿐인지
2. `python3 scripts/check_sprites.py --group "가마의 병사 (등급 6단계 추가 8종)" --sheet work/2026-11-29-스킬진영/sheet-07a.png` · `--group "스킬 이펙트" --sheet work/2026-11-29-스킬진영/sheet-07b.png`
3. 게임 화면 스크린샷: 아침 카드·전투·스킬 순간
4. `python3 scripts/test.py --stage all`
5. 사용자에게 보여 주고 "검사는 통과, 미술 판단은 사용자 몫" — 허락을 받은 뒤 커밋
