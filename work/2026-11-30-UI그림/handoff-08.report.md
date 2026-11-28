OpenAI Codex v0.172.0
--------
workdir: C:\Users\pc\Documents\game
model: gpt-6-astra
provider: openai
approval: never
sandbox: workspace-write [workdir, /tmp, $TMPDIR]
reasoning effort: high
reasoning summaries: none
session id: 01a21fdd-4bf0-7523-bd11-b4f8ef3b8757
--------
user
# Codex 작업 지시서 — UI 그림 (아이콘 14 · 창·버튼·카드 틀 7 · 상인 1)

- 날짜: 2026-11-30
- 작업 폴더: work/2026-11-30-UI그림/
- 지시서 번호: 08

## 먼저 읽을 것
1. AGENTS.md
2. art/references/ — 정한 그림체 (가 + 다: 흙·먹색 바탕, 유약 색은 포인트)
3. `assets/sprites/kiln/soldier_*.png` — 병사 도자기 인형 (상인은 이 인형과 같은 그림체)
4. `work/2026-11-30-UI그림/ref_lobby.png`, `ref_gacha.png`, `ref_shop.png`, `ref_clear.png`, `ref_tactics.png` — 지금 게임 화면 (코드로 그린 임시 UI). **이 자리에 들어갈 그림**이다
5. UI 시안: claude.ai 아티팩트 "가마의 병사 UI 개편 시안" — 색과 배치의 방향 (옻칠 바탕 · 청동 테두리 · 금박)
6. docs/그림-목록.md, art/sprite_list.json 의 "UI" 묶음

## 목표 (사용자 말 그대로)
> "UI 그림(아이콘, 패널 장식, 상인 그림)도 Codex 지시서로 만들어줘. 좀 더 세련되고 AI가 만든 것 같지 않도록 실제 전문 디자이너가 한 것처럼 자연스럽게 만들어줘."

## AI 티 없애기 — 전문 픽셀 UI 디자이너처럼 (반드시 지킨다)
사용자가 가장 신경 쓰는 부분이다. 아래는 "AI가 만든 티"가 나는 흔한 원인과 그 반대로 하는 방법이다.

1. **팔레트를 먼저 정하고 그 색만 쓴다.** 아래 팔레트 밖의 색 금지 (표의 최대 색 수 안에서). 비슷한 색 여러 개(색 번짐) 금지
   - 먹 `#282322` · 옻칠 어둠 `#120e16` `#1c1622` `#2a2236` · 청동 `#5a4630` `#8a6a48` `#a8862e` · 금박 `#e8c35a` `#fff1c4`
   - 흙 `#b98a5e` `#7a5a44` · 한지 `#e8dcb8` `#f2e6c8` · 쇠 `#6f6c66` `#b0b8c0` `#dfe6ee` · 진사 `#b8463a` `#7a2a24` · 청자 `#6b9878` `#a6c5a3` · 불 `#ff9a3c`
2. **점은 손으로 찍은 것처럼:** 의미 있는 덩어리(클러스터)로만. 외톨이 점·흩뿌린 잡티·노이즈 결 금지. 모든 점이 "왜 거기 있는지" 설명되어야 한다
3. **빛은 왼쪽 위 한 방향.** 하이라이트는 1~2px, 그림자는 오른쪽 아래. 형태마다 빛 방향이 다르면 AI 티가 난다
4. **그라데이션·흐림·광택 번짐 금지.** 단계는 2~3단으로 끊는다. 디더링은 필요한 곳에만 아주 조금
5. **1배 크기에서 읽혀야 한다.** 16×16 아이콘은 실루엣만 보고도 무엇인지 알아야 한다 — 디테일보다 형태 먼저. 작게 줄여 확인할 것
6. **외곽선:** 먹색 1px. 안쪽 선은 바깥보다 밝게(선택적 외곽선). 계단(jaggies) 없이 1-2-3 규칙적인 기울기
7. **한 벌로:** 아이콘 14개는 같은 크기 틀(대략 12~13px 안), 같은 외곽선 굵기, 같은 빛·같은 채도. 하나만 튀면 안 된다
8. **9조각 그림(panel·button·card·title_plate·chip):** 모서리는 정해진 px 안에서 끝나고, **가운데와 변은 단색**(늘어나도 무늬가 늘어지지 않게). 버튼·카드·제목 판은 **밝은 무채색**으로 — 게임이 상황마다 색을 입힌다
9. **장식은 절제:** 한국 전통 장석·구름무늬는 모서리에 작게 하나. 테두리 전체를 문양으로 채우지 않는다
10. 글자·로고를 그림에 넣지 않는다 (게임이 글을 쓴다)

## 정한 그림체 (반드시 따른다)
- 가 + 다 섞음: 형태는 또렷하게, 바탕은 먹·흙 회색조, 강한 색은 포인트에만
- 투명 배경 (9조각의 깎은 모서리 바깥도 투명), 흐림(안티에일리어싱) 없음, 표의 색 수 이하

## 그리는 방법 (사용자가 정한 것)
- [x] 이미지 생성 후 코드로 다듬기 (크기 맞추기·배경 투명·색 줄이기) — 사용자가 handoff-01 에서 정함 (2026-11-27)
- 단, 위 "AI 티 없애기" 규칙에 맞게 **색을 팔레트로 강제로 맞추고, 외톨이 점을 지우고, 1배로 줄여 확인**하는 다듬기를 꼭 거친다

정한 방법을 쓸 수 없으면 다른 방법으로 바꾸지 말고 `결과: 못 돌림` 으로 보고한다.

## 만들 것 (22장)

| 파일 | 크기 | 최대 색 | 내용 |
|---|---|---|---|
| `assets/sprites/ui/icon_ticket.png` | 16×16 | 12 | 아이콘 16×16 · 뽑기권 — 붉은 띠를 두른 누런 한지 표, 귀퉁이 접힘. 1배 크기에서 실루엣만으로 알아볼 것. 외곽선 1px(먹색 #282322), 빛은 왼쪽 위에서 한 방향. 투명 배경 |
| `assets/sprites/ui/icon_clay.png` | 16×16 | 12 | 아이콘 16×16 · 흙 — 손으로 뭉친 붉은 흙덩이, 손자국 한두 개. 1배 크기에서 실루엣만으로 알아볼 것. 외곽선 1px(먹색 #282322), 빛은 왼쪽 위에서 한 방향. 투명 배경 |
| `assets/sprites/ui/icon_pearl.png` | 16×16 | 12 | 아이콘 16×16 · 진주 — 흰 진주 한 알, 왼쪽 위 반사광 1px, 아래 연한 그림자. 1배 크기에서 실루엣만으로 알아볼 것. 외곽선 1px(먹색 #282322), 빛은 왼쪽 위에서 한 방향. 투명 배경 |
| `assets/sprites/ui/icon_shard.png` | 16×16 | 12 | 아이콘 16×16 · 요변 파편 — 유약 빛이 도는 깨진 도자기 조각 (보라·금 반사). 1배 크기에서 실루엣만으로 알아볼 것. 외곽선 1px(먹색 #282322), 빛은 왼쪽 위에서 한 방향. 투명 배경 |
| `assets/sprites/ui/icon_ember.png` | 16×16 | 12 | 아이콘 16×16 · 불씨 — 숯 위의 작은 불씨, 주황 심지. 1배 크기에서 실루엣만으로 알아볼 것. 외곽선 1px(먹색 #282322), 빛은 왼쪽 위에서 한 방향. 투명 배경 |
| `assets/sprites/ui/icon_fire.png` | 16×16 | 12 | 아이콘 16×16 · 불 다스리기 — 아궁이 불꽃 세 갈래. 1배 크기에서 실루엣만으로 알아볼 것. 외곽선 1px(먹색 #282322), 빛은 왼쪽 위에서 한 방향. 투명 배경 |
| `assets/sprites/ui/icon_blade.png` | 16×16 | 12 | 아이콘 16×16 · 강철 칼날 — 비스듬한 짧은 환도 날, 금빛 코등이. 1배 크기에서 실루엣만으로 알아볼 것. 외곽선 1px(먹색 #282322), 빛은 왼쪽 위에서 한 방향. 투명 배경 |
| `assets/sprites/ui/icon_armor.png` | 16×16 | 12 | 아이콘 16×16 · 두석린갑 — 쇠 비늘 갑옷 앞판 (비늘 3줄). 1배 크기에서 실루엣만으로 알아볼 것. 외곽선 1px(먹색 #282322), 빛은 왼쪽 위에서 한 방향. 투명 배경 |
| `assets/sprites/ui/icon_charm.png` | 16×16 | 12 | 아이콘 16×16 · 신속 부적 — 노란 한지에 붉은 경면주사 글씨 (글자 대신 획 모양만). 1배 크기에서 실루엣만으로 알아볼 것. 외곽선 1px(먹색 #282322), 빛은 왼쪽 위에서 한 방향. 투명 배경 |
| `assets/sprites/ui/icon_gourd.png` | 16×16 | 12 | 아이콘 16×16 · 약 호리병 — 붉은 끈 맨 호리병. 1배 크기에서 실루엣만으로 알아볼 것. 외곽선 1px(먹색 #282322), 빛은 왼쪽 위에서 한 방향. 투명 배경 |
| `assets/sprites/ui/icon_whetstone.png` | 16×16 | 12 | 아이콘 16×16 · 숫돌 — 회색 숫돌 위 물기 한 줄. 1배 크기에서 실루엣만으로 알아볼 것. 외곽선 1px(먹색 #282322), 빛은 왼쪽 위에서 한 방향. 투명 배경 |
| `assets/sprites/ui/icon_scale.png` | 16×16 | 12 | 아이콘 16×16 · 쇠비늘 — 겹친 쇠 비늘 세 장. 1배 크기에서 실루엣만으로 알아볼 것. 외곽선 1px(먹색 #282322), 빛은 왼쪽 위에서 한 방향. 투명 배경 |
| `assets/sprites/ui/icon_scroll.png` | 16×16 | 12 | 아이콘 16×16 · 비급서 — 실로 묶은 낡은 책 (표지 끈). 1배 크기에서 실루엣만으로 알아볼 것. 외곽선 1px(먹색 #282322), 빛은 왼쪽 위에서 한 방향. 투명 배경 |
| `assets/sprites/ui/icon_bell.png` | 16×16 | 12 | 아이콘 16×16 · 신령 방울 — 무당 방울 셋이 달린 손잡이. 1배 크기에서 실루엣만으로 알아볼 것. 외곽선 1px(먹색 #282322), 빛은 왼쪽 위에서 한 방향. 투명 배경 |
| `assets/sprites/ui/panel_9.png` | 48×48 | 16 | 창(패널) 9조각 그림 — 모서리 8px 은 그대로, 가운데·변은 게임이 늘린다. 옻칠한 검붉은 나무판(#1c1622 계열) + 바깥 청동 테두리 2px + 안쪽 가는 선 1px. 가운데(늘어나는 부분)는 단색 또는 아주 약한 결 하나만 (늘여도 이상하지 않게). 모서리 1~2px 깎기 |
| `assets/sprites/ui/panel_corner.png` | 14×14 | 10 | 창 모서리 장식 (왼쪽 위 한 장, 게임이 뒤집어 네 모서리에) — 반닫이 장석 같은 금박 쇠 장식, ㄱ자 모양에 작은 구름무늬 하나. 투명 배경 |
| `assets/sprites/ui/button_9.png` | 24×24 | 12 | 버튼 9조각 (모서리 6px). **밝은 무채색 청동** (게임이 버튼마다 색을 입힌다). 위쪽 1px 하이라이트, 아래 2px 두께감, 모서리 깎기. 가운데는 단색 |
| `assets/sprites/ui/button_primary_9.png` | 24×24 | 12 | 주 버튼 9조각 (모서리 6px) — 금박 칠 (#e8c35a 계열), 위 하이라이트·아래 두께감. 가운데는 단색 (글자가 그 위에 먹색으로 올라간다) |
| `assets/sprites/ui/card_9.png` | 24×24 | 12 | 병사 카드 틀 9조각 (모서리 6px) — **밝은 무채색** (게임이 등급 색을 입힌다), 안쪽은 어두운 바탕, 아래쪽 이름 띠 자리가 살짝 더 어둡게. 가운데 단색 |
| `assets/sprites/ui/title_plate_9.png` | 20×14 | 8 | 창 제목 판 9조각 (모서리 5px) — 작은 현판 모양, 밝은 무채색 테두리 (게임이 색을 입힌다), 안은 어두운 옻칠 |
| `assets/sprites/ui/chip_9.png` | 16×16 | 8 | 자원 알약 9조각 (모서리 6px) — 안으로 파인 어두운 홈, 청동 테두리 1px |
| `assets/sprites/ui/merchant.png` | 48×64 | 24 | 진주 상점 상인 (가슴 위 정도, 오른쪽을 봄) — 지게에 보따리를 진 보부상 도자기 인형, 패랭이 모자에 목화 송이, 손에 진주 한 알, 부드럽게 웃는 얼굴. 병사 도자기 인형과 같은 그림체 (얼굴 회색, 흰 광택), 옷은 흙빛·쪽빛. 투명 배경 |

## 고쳐도 되는 범위
- `assets/sprites/ui/icon_ticket.png` (새 파일)
- `assets/sprites/ui/icon_clay.png` (새 파일)
- `assets/sprites/ui/icon_pearl.png` (새 파일)
- `assets/sprites/ui/icon_shard.png` (새 파일)
- `assets/sprites/ui/icon_ember.png` (새 파일)
- `assets/sprites/ui/icon_fire.png` (새 파일)
- `assets/sprites/ui/icon_blade.png` (새 파일)
- `assets/sprites/ui/icon_armor.png` (새 파일)
- `assets/sprites/ui/icon_charm.png` (새 파일)
- `assets/sprites/ui/icon_gourd.png` (새 파일)
- `assets/sprites/ui/icon_whetstone.png` (새 파일)
- `assets/sprites/ui/icon_scale.png` (새 파일)
- `assets/sprites/ui/icon_scroll.png` (새 파일)
- `assets/sprites/ui/icon_bell.png` (새 파일)
- `assets/sprites/ui/panel_9.png` (새 파일)
- `assets/sprites/ui/panel_corner.png` (새 파일)
- `assets/sprites/ui/button_9.png` (새 파일)
- `assets/sprites/ui/button_primary_9.png` (새 파일)
- `assets/sprites/ui/card_9.png` (새 파일)
- `assets/sprites/ui/title_plate_9.png` (새 파일)
- `assets/sprites/ui/chip_9.png` (새 파일)
- `assets/sprites/ui/merchant.png` (새 파일)

이 목록에 없는 파일은 만들거나 고치지 않는다.

## 보호 검사 결과 (Claude가 미리 확인함)
- `python3 scripts/protected.py <위 파일들>` → 걸린 파일 없음 (모두 새 파일)
- 이 검사는 Claude가 했다. Codex는 다시 돌리지 않는다.

## 하면 안 되는 일
- 범위 밖 파일 수정·삭제 (특히 `src/`, `tests/`, `art/references/`, `art/rubric.md`, 이미 있는 `assets/sprites/`)
- 게임 코드에 그림을 연결하는 작업 (이미 되어 있다: 파일이 있으면 코드 그림 대신 쓴다)
- 저장소의 Python 스크립트 실행 (검사는 Claude가 작업 후에 한다)
- git commit / push
- 못 했는데 했다고 보고하기

## 끝나면 이 형식으로 보고
```
결과: 통과 | 실패 | 못 돌림   ← 셋 중 하나만
바뀐 파일:
- 경로 — 무엇을
직접 확인한 것:
- 예) 1배·4배로 줄여 보고 실루엣 확인, 팔레트 밖 색 없음, 9조각 가운데 단색
그리는 데 쓴 방법:
- 이미지 생성 / 코드 / 둘 다 (무엇을 어떻게, 팔레트 맞추기를 어떻게 했는지)
못 한 것 / 걱정되는 것:
- …
```
- 저장소의 Python 검사를 못 돌린 것만으로는 `못 돌림`이 아니다. 검사는 Claude가 한다.

## Claude가 받은 뒤 할 일
1. `git status` — 바뀐 파일이 위 범위뿐인지
2. `python3 scripts/check_sprites.py --group "UI" --sheet work/2026-11-30-UI그림/sheet-08.png` — 크기·투명 배경·색 수·흐린 가장자리
3. 게임 화면 스크린샷 (`tests/screens_proto.gd`): 로비·뽑기·상점·클리어 창·전술 강화에서 직접 본다 (9조각이 늘어날 때 깨지지 않는지)
4. **그림 루프** (`.claude/skills/art-loop/SKILL.md`): 처음 보는 검토자 2명이 `art/rubric.md` 로 "AI 티"·"그림체 어울림" 채점 → 낮으면 다시 지시
5. `python3 scripts/test.py --stage all`
6. 사용자에게 보여 주고 "검사는 통과, 미술 판단은 사용자 몫" — 허락을 받은 뒤 커밋

warning: Codex is ignoring 1 unrecognized configuration setting. Check for typos or deprecated settings.
  user (C:\Users\pc\.codex\config.toml): `computer_use.windows.always_allowed_app_ids` is ignored.
warning: Codex is ignoring 1 unrecognized configuration setting. Check for typos or deprecated settings.
  user (C:\Users\pc\.codex\config.toml): `computer_use.windows.always_allowed_app_ids` is ignored.
codex
지시서의 참고 그림과 보호 목록부터 확인하겠습니다. imagegen 스킬로 원본을 생성한 뒤 지정 팔레트와 픽셀 규격에 맞게 다듬고, 허용된 PNG 22개만 저장하겠습니다.

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Get-Content AGENTS.md; Get-Content PROTECTED.txt; Get-Content C:/Users/pc/.codex/skills/.system/imagegen/SKILL.md' in C:\Users\pc\Documents\game
 succeeded in 320ms:
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
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -Encoding UTF8 AGENTS.md; Get-Content -Encoding UTF8 PROTECTED.txt; git status --porcelain; rg --files art/references work/2026-11-30-UI그림 assets/sprites/kiln assets/sprites/ui; rg -n 'UI|icon_ticket|merchant|panel_9' docs/그림-목록.md art/sprite_list.json" in C:\Users\pc\Documents\game
 succeeded in 0ms:
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

지금: **1분 시험판 두 개** — B 가마의 병사, A 알을 품는 성 (기획안 비교 `docs/기획안-비교.md`). 첫 화면 `src/game/launcher.tscn` 에서 고른다.
지난 시험판 **AFTERSELF (가제)** 는 보류 (`docs/기획서.md`, `src/core/`). Godot 4.7, 위에서 내려다보는 2D 픽셀 아트(타일 32×32).

| 위치 | 내용 |
|---|---|
| `src/proto/` | 1분 시험판 규칙 (화면과 무관). `data.gd` 수치 · `battle.gd` 공용 자동 전투 · `kiln.gd` 가마 · `nest.gd` 둥지 |
| `src/core/` | (보류) AFTERSELF 규칙 (화면과 무관). `data.gd` 수치 · `world.gd` 방 하나의 전투 · `run.gd` 한 판 흐름 · `habits.gd` 습관 기록 · `echo.gd` 어제의 나 · `save.gd` 판 사이 저장 |
| `src/game/` | 화면·입력. `launcher` 첫 화면 · `kiln_scene` · `nest_scene` · `proto_base` 공통 연출 · `main` (보류) AFTERSELF. 규칙을 읽어서 그리기만 한다 |
| `assets/` | 게임에 들어가는 그림·글꼴 (글꼴: 갈무리, OFL). 그림은 `assets/sprites/` — 목록 `art/sprite_list.json`, 설명 `docs/그림-목록.md`. 파일이 있으면 게임이 쓰고, 없으면 도형으로 그린다 |
| `tests/` | Godot 테스트 (`test_p0.gd`, `test_p1.gd`, `test_boss.gd`), 봇, 성능 측정(`bench.gd`), 스크린샷(`screens.gd`) |
| `art/` | 그림 루프용 기준 그림·기준표 (게임에 안 들어감) |

- 규칙은 `src/proto/`(지금) · `src/core/`(보류) 에만 쓴다. 화면 코드에서 규칙을 바꾸지 않는다 (테스트·봇이 화면 없이 규칙을 돌리기 때문).
- 수치(밸런스)는 `src/proto/data.gd`(지금) 한 곳에서만 바꾼다.
- **그리기 층 (HD-2D)**: 화면은 1280×800 으로 그리고(실행 중에 canvas_items 로 바꿈), 픽셀 그림은 또렷하게, 빛·안개는 부드럽게. 층: `bg` 바닥 → `back` 그림자·뒷빛·안개 → 기본(캐릭터·UI) → `glow` 빛(가산 혼합) → `front` 앞 안개·밤 색감·비네트 (`src/game/glow_layer.gd`, `proto_base.gd` 의 `draw_layer`). 전투가 보일 때 기본층은 화면 전체를 칠하지 않는다 (`draw_screen_bg`).
- **이펙트 애니메이션**: `assets/sprites/fx/<이름>.png` (정사각형 장면을 가로 한 줄) 이 있으면 `play_fx` 로 재생, 없으면 코드 효과.
- **억울하지 않은 운** (사용자 요청): 안전 구간은 반드시 보통 이상 · 확률은 화면에 숫자로 · 실패하면 파편/조각 · 3개 모이면 확정 보상. 이 규칙을 깨는 변경은 사용자에게 먼저 묻는다.
- `work/`, `reports/`, `docs/`, `scripts/`, `perf/`, `art/` 에는 `.gdignore` 가 있어 Godot 가 읽지 않는다.

## 실행 환경

- 이 문서의 `python3` 명령은 Windows에서 `python3` 이 안 되면 `python` 으로 바꿔 실행한다 (같은 것).
- Godot: `scripts/godot_cmd.py` 가 찾는다 (환경 변수 `GODOT` → PATH 의 `godot` → Windows 기본 위치의 `*_console.exe`). 못 찾으면 환경 변수 `GODOT` 에 실행 파일 경로를 넣는다. Windows는 창 없는 실행을 위해 `_console.exe` 를 쓴다.
- 화면 확인(스크린샷): `godot --path . --script res://tests/screens_proto.gd -- <저장 폴더>` (지난 시험판은 `screens.gd`) (화면이 있는 환경에서. 서버에서는 Xvfb 필요). 화면을 바꾸면 스크린샷을 직접 열어 확인한다.
- Codex는 `codex exec` (Codex CLI)로 부른다. git 저장소 폴더 안에서만 실행한다.
  쓰기 작업은 `--sandbox workspace-write`, 읽기만 하면 `--sandbox read-only` (Codex CLI 0.172 기준. `--full-auto` 는 없음).

## 자동 테스트

| 단계 | 뜻 | 위치 |
|---|---|---|
| P0 | 깨지면 게임이 안 되는 것 (시작·이동·공격·죽음→메아리·같은 시드 같은 결과) | `tests/test_p0.gd` |
| P1 | 게임 전반. 1분 시험판(가마 확률·파편 확정·알 터짐·먹이·합동 기술·균형) `tests/test_proto.gd` + AFTERSELF `tests/test_p1.gd` | `tests/test_proto.gd`, `tests/test_p1.gd` |
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

## 그림 검사

- Codex가 그림을 넣으면: `python3 scripts/check_sprites.py [--group 이름] [--sheet 비교시트.png]` — 크기·투명 배경·색 수(24개 이하)·흐린 가장자리
- 그다음 스크린샷으로 게임 화면에서 직접 본다. 그림체 판단은 사용자 몫.

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
# 사용자가 직접 고친 파일 / 덮어쓰면 안 되는 파일 (한 줄에 하나, glob 가능)
# Claude·Codex는 여기 적힌 파일을 덮어쓰지 않는다. 고쳐야 하면 바꿀 내용을 제안만 한다.
art/references/*
art/rubric.md
 M assets/sprites/enemy/goblin.png
 M assets/sprites/field/house.png
 M reports/boss/history.csv
 M "work/2026-11-27-\352\267\270\353\246\274/NOTES.md"
 M "work/2026-11-27-\352\267\270\353\246\274/handoff-03.md"
?? assets/sprites/enemy/armored.png
?? assets/sprites/enemy/armored.png.import
?? assets/sprites/enemy/brute.png
?? assets/sprites/enemy/brute.png.import
?? assets/sprites/enemy/chief.png
?? assets/sprites/enemy/chief.png.import
?? assets/sprites/enemy/fox.png
?? assets/sprites/enemy/fox.png.import
?? assets/sprites/enemy/ghost.png
?? assets/sprites/enemy/ghost.png.import
?? assets/sprites/enemy/giant.png
?? assets/sprites/enemy/giant.png.import
?? assets/sprites/enemy/goblin.png.import
?? assets/sprites/enemy/gumiho.png
?? assets/sprites/enemy/gumiho.png.import
?? assets/sprites/enemy/imp.png
?? assets/sprites/enemy/imp.png.import
?? assets/sprites/enemy/imugi.png
?? assets/sprites/enemy/imugi.png.import
?? assets/sprites/enemy/king.png
?? assets/sprites/enemy/king.png.import
?? assets/sprites/enemy/reaper.png
?? assets/sprites/enemy/reaper.png.import
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
?? assets/sprites/kiln/soldier_baekho_earth.png
?? assets/sprites/kiln/soldier_baekho_earth.png.import
?? assets/sprites/kiln/soldier_baekho_fire.png
?? assets/sprites/kiln/soldier_baekho_fire.png.import
?? assets/sprites/kiln/soldier_baekho_water.png
?? assets/sprites/kiln/soldier_baekho_water.png.import
?? assets/sprites/kiln/soldier_bulgasari_earth.png
?? assets/sprites/kiln/soldier_bulgasari_earth.png.import
?? assets/sprites/kiln/soldier_bulgasari_fire.png
?? assets/sprites/kiln/soldier_bulgasari_fire.png.import
?? assets/sprites/kiln/soldier_bulgasari_water.png
?? assets/sprites/kiln/soldier_bulgasari_water.png.import
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
?? assets/sprites/kiln/soldier_cheoyong_earth.png
?? assets/sprites/kiln/soldier_cheoyong_earth.png.import
?? assets/sprites/kiln/soldier_cheoyong_fire.png
?? assets/sprites/kiln/soldier_cheoyong_fire.png.import
?? assets/sprites/kiln/soldier_cheoyong_water.png
?? assets/sprites/kiln/soldier_cheoyong_water.png.import
?? assets/sprites/kiln/soldier_dragon_earth.png
?? assets/sprites/kiln/soldier_dragon_earth.png.import
?? assets/sprites/kiln/soldier_dragon_fire.png
?? assets/sprites/kiln/soldier_dragon_fire.png.import
?? assets/sprites/kiln/soldier_dragon_water.png
?? assets/sprites/kiln/soldier_dragon_water.png.import
?? assets/sprites/kiln/soldier_general_earth.png
?? assets/sprites/kiln/soldier_general_earth.png.import
?? assets/sprites/kiln/soldier_general_fire.png
?? assets/sprites/kiln/soldier_general_fire.png.import
?? assets/sprites/kiln/soldier_general_water.png
?? assets/sprites/kiln/soldier_general_water.png.import
?? assets/sprites/kiln/soldier_haetae_earth.png
?? assets/sprites/kiln/soldier_haetae_earth.png.import
?? assets/sprites/kiln/soldier_haetae_fire.png
?? assets/sprites/kiln/soldier_haetae_fire.png.import
?? assets/sprites/kiln/soldier_haetae_water.png
?? assets/sprites/kiln/soldier_haetae_water.png.import
?? assets/sprites/kiln/soldier_healer_earth.png
?? assets/sprites/kiln/soldier_healer_earth.png.import
?? assets/sprites/kiln/soldier_healer_fire.png
?? assets/sprites/kiln/soldier_healer_fire.png.import
?? assets/sprites/kiln/soldier_healer_water.png
?? assets/sprites/kiln/soldier_healer_water.png.import
?? assets/sprites/kiln/soldier_hyeonmu_earth.png
?? assets/sprites/kiln/soldier_hyeonmu_earth.png.import
?? assets/sprites/kiln/soldier_hyeonmu_fire.png
?? assets/sprites/kiln/soldier_hyeonmu_fire.png.import
?? assets/sprites/kiln/soldier_hyeonmu_water.png
?? assets/sprites/kiln/soldier_hyeonmu_water.png.import
?? assets/sprites/kiln/soldier_jujak_earth.png
?? assets/sprites/kiln/soldier_jujak_earth.png.import
?? assets/sprites/kiln/soldier_jujak_fire.png
?? assets/sprites/kiln/soldier_jujak_fire.png.import
?? assets/sprites/kiln/soldier_jujak_water.png
?? assets/sprites/kiln/soldier_jujak_water.png.import
?? assets/sprites/kiln/soldier_slinger_earth.png
?? assets/sprites/kiln/soldier_slinger_earth.png.import
?? assets/sprites/kiln/soldier_slinger_fire.png
?? assets/sprites/kiln/soldier_slinger_fire.png.import
?? assets/sprites/kiln/soldier_slinger_water.png
?? assets/sprites/kiln/soldier_slinger_water.png.import
?? assets/sprites/kiln/soldier_sniper_earth.png
?? assets/sprites/kiln/soldier_sniper_earth.png.import
?? assets/sprites/kiln/soldier_sniper_fire.png
?? assets/sprites/kiln/soldier_sniper_fire.png.import
?? assets/sprites/kiln/soldier_sniper_water.png
?? assets/sprites/kiln/soldier_sniper_water.png.import
?? assets/sprites/kiln/soldier_twin_earth.png
?? assets/sprites/kiln/soldier_twin_earth.png.import
?? assets/sprites/kiln/soldier_twin_fire.png
?? assets/sprites/kiln/soldier_twin_fire.png.import
?? assets/sprites/kiln/soldier_twin_water.png
?? assets/sprites/kiln/soldier_twin_water.png.import
?? assets/sprites/nest/
?? reports/boss/history-local-backup.csv
?? src/game/pixel_art.gd.uid
?? src/proto/kiln_run.gd.uid
?? src/proto/meta.gd.uid
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
?? "work/2026-11-28-\353\213\244\353\223\254\352\270\260/old-06-soldiers/"
?? "work/2026-11-28-\353\213\244\353\223\254\352\270\260/screens-05/"
?? "work/2026-11-28-\353\213\244\353\223\254\352\270\260/screens-06/"
?? "work/2026-11-28-\353\213\244\353\223\254\352\270\260/sheet-05.png"
?? "work/2026-11-28-\353\213\244\353\223\254\352\270\260/sheet-06a.png"
?? "work/2026-11-28-\353\213\244\353\223\254\352\270\260/sheet-06b.png"
?? "work/2026-11-29-\354\212\244\355\202\254\354\247\204\354\230\201/handoff-07.report.md"
?? "work/2026-11-29-\354\212\244\355\202\254\354\247\204\354\230\201/screens-07/"
?? "work/2026-11-29-\354\212\244\355\202\254\354\247\204\354\230\201/sheet-07a.png"
?? "work/2026-11-29-\354\212\244\355\202\254\354\247\204\354\230\201/sheet-07b.png"
?? "work/2026-11-30-UI\352\267\270\353\246\274/handoff-08.report.md"
rg: assets/sprites/ui: 지정된 파일을 찾을 수 없습니다. (os error 2)
work/2026-11-30-UI그림\ref_tactics.png
work/2026-11-30-UI그림\ref_shop.png
work/2026-11-30-UI그림\ref_lobby.png
work/2026-11-30-UI그림\ref_gacha.png
work/2026-11-30-UI그림\ref_clear.png
work/2026-11-30-UI그림\NOTES.md
work/2026-11-30-UI그림\handoff-08.report.md
work/2026-11-30-UI그림\handoff-08.md
art/references\soldier_spear_fire.png
art/references\soldier_shield_earth.png
art/references\soldier_archer_water.png
art/references\sheet.png
art/references\README.md
art/references\house.png
art/references\goblin.png
art/references\creature_shield_water.png
assets/sprites/kiln\soldier_twin_water.png.import
assets/sprites/kiln\soldier_twin_water.png
assets/sprites/kiln\soldier_twin_fire.png.import
assets/sprites/kiln\soldier_twin_fire.png
assets/sprites/kiln\soldier_twin_earth.png.import
assets/sprites/kiln\soldier_twin_earth.png
assets/sprites/kiln\soldier_spear_water.png.import
assets/sprites/kiln\soldier_spear_water.png
assets/sprites/kiln\soldier_spear_fire.png.import
assets/sprites/kiln\soldier_spear_fire.png
assets/sprites/kiln\soldier_spear_earth.png.import
assets/sprites/kiln\soldier_spear_earth.png
assets/sprites/kiln\soldier_sniper_water.png.import
assets/sprites/kiln\soldier_sniper_water.png
assets/sprites/kiln\soldier_sniper_fire.png.import
assets/sprites/kiln\soldier_sniper_fire.png
assets/sprites/kiln\soldier_sniper_earth.png.import
assets/sprites/kiln\soldier_sniper_earth.png
assets/sprites/kiln\soldier_slinger_water.png.import
assets/sprites/kiln\soldier_slinger_water.png
assets/sprites/kiln\soldier_slinger_fire.png.import
assets/sprites/kiln\soldier_slinger_fire.png
assets/sprites/kiln\soldier_slinger_earth.png.import
assets/sprites/kiln\soldier_slinger_earth.png
assets/sprites/kiln\soldier_shield_water.png.import
assets/sprites/kiln\soldier_shield_water.png
assets/sprites/kiln\soldier_shield_fire.png.import
assets/sprites/kiln\soldier_shield_fire.png
assets/sprites/kiln\soldier_shield_earth.png.import
assets/sprites/kiln\soldier_shield_earth.png
assets/sprites/kiln\soldier_jujak_water.png.import
assets/sprites/kiln\soldier_jujak_water.png
assets/sprites/kiln\soldier_jujak_fire.png.import
assets/sprites/kiln\soldier_jujak_fire.png
assets/sprites/kiln\soldier_jujak_earth.png.import
assets/sprites/kiln\soldier_jujak_earth.png
assets/sprites/kiln\soldier_hyeonmu_water.png.import
assets/sprites/kiln\soldier_hyeonmu_water.png
assets/sprites/kiln\soldier_hyeonmu_fire.png.import
assets/sprites/kiln\soldier_hyeonmu_fire.png
assets/sprites/kiln\soldier_hyeonmu_earth.png.import
assets/sprites/kiln\soldier_hyeonmu_earth.png
assets/sprites/kiln\soldier_healer_water.png.import
assets/sprites/kiln\soldier_healer_water.png
assets/sprites/kiln\soldier_healer_fire.png.import
assets/sprites/kiln\soldier_healer_fire.png
assets/sprites/kiln\soldier_healer_earth.png.import
assets/sprites/kiln\soldier_healer_earth.png
assets/sprites/kiln\soldier_haetae_water.png.import
assets/sprites/kiln\soldier_haetae_water.png
assets/sprites/kiln\soldier_haetae_fire.png.import
assets/sprites/kiln\soldier_haetae_fire.png
assets/sprites/kiln\soldier_haetae_earth.png.import
assets/sprites/kiln\soldier_haetae_earth.png
assets/sprites/kiln\soldier_general_water.png.import
assets/sprites/kiln\soldier_general_water.png
assets/sprites/kiln\soldier_general_fire.png.import
assets/sprites/kiln\soldier_general_fire.png
assets/sprites/kiln\soldier_general_earth.png.import
assets/sprites/kiln\soldier_general_earth.png
assets/sprites/kiln\soldier_dragon_water.png.import
assets/sprites/kiln\soldier_dragon_water.png
assets/sprites/kiln\soldier_dragon_fire.png.import
assets/sprites/kiln\soldier_dragon_fire.png
assets/sprites/kiln\soldier_dragon_earth.png.import
assets/sprites/kiln\soldier_dragon_earth.png
assets/sprites/kiln\soldier_cheoyong_water.png.import
assets/sprites/kiln\soldier_cheoyong_water.png
assets/sprites/kiln\soldier_cheoyong_fire.png.import
assets/sprites/kiln\soldier_cheoyong_fire.png
assets/sprites/kiln\soldier_cheoyong_earth.png.import
assets/sprites/kiln\soldier_cheoyong_earth.png
assets/sprites/kiln\soldier_cavalry_water.png.import
assets/sprites/kiln\soldier_cavalry_water.png
assets/sprites/kiln\soldier_cavalry_fire.png.import
assets/sprites/kiln\soldier_cavalry_fire.png
assets/sprites/kiln\soldier_cavalry_earth.png.import
assets/sprites/kiln\soldier_cavalry_earth.png
assets/sprites/kiln\soldier_cannon_water.png.import
assets/sprites/kiln\soldier_cannon_water.png
assets/sprites/kiln\soldier_cannon_fire.png.import
assets/sprites/kiln\soldier_cannon_fire.png
assets/sprites/kiln\soldier_cannon_earth.png.import
assets/sprites/kiln\soldier_cannon_earth.png
assets/sprites/kiln\soldier_bulgasari_water.png.import
assets/sprites/kiln\soldier_bulgasari_water.png
assets/sprites/kiln\soldier_bulgasari_fire.png.import
assets/sprites/kiln\soldier_bulgasari_fire.png
assets/sprites/kiln\soldier_bulgasari_earth.png.import
assets/sprites/kiln\soldier_bulgasari_earth.png
assets/sprites/kiln\soldier_baekho_water.png.import
assets/sprites/kiln\soldier_baekho_water.png
assets/sprites/kiln\soldier_baekho_fire.png.import
assets/sprites/kiln\soldier_baekho_fire.png
assets/sprites/kiln\soldier_baekho_earth.png.import
assets/sprites/kiln\soldier_baekho_earth.png
assets/sprites/kiln\soldier_axe_water.png.import
assets/sprites/kiln\soldier_axe_water.png
assets/sprites/kiln\soldier_axe_fire.png.import
assets/sprites/kiln\soldier_axe_fire.png
assets/sprites/kiln\soldier_axe_earth.png.import
assets/sprites/kiln\soldier_axe_earth.png
assets/sprites/kiln\soldier_archer_water.png.import
assets/sprites/kiln\soldier_archer_water.png
assets/sprites/kiln\soldier_archer_fire.png.import
assets/sprites/kiln\soldier_archer_fire.png
assets/sprites/kiln\soldier_archer_earth.png.import
assets/sprites/kiln\soldier_archer_earth.png
assets/sprites/kiln\kiln_body.png.import
assets/sprites/kiln\kiln_body.png
art/sprite_list.json:1179:      "path": "assets/sprites/ui/icon_ticket.png",
art/sprite_list.json:1184:      "group": "UI",
art/sprite_list.json:1194:      "group": "UI",
art/sprite_list.json:1204:      "group": "UI",
art/sprite_list.json:1214:      "group": "UI",
art/sprite_list.json:1224:      "group": "UI",
art/sprite_list.json:1234:      "group": "UI",
art/sprite_list.json:1244:      "group": "UI",
art/sprite_list.json:1254:      "group": "UI",
art/sprite_list.json:1264:      "group": "UI",
art/sprite_list.json:1274:      "group": "UI",
art/sprite_list.json:1284:      "group": "UI",
art/sprite_list.json:1294:      "group": "UI",
art/sprite_list.json:1304:      "group": "UI",
art/sprite_list.json:1314:      "group": "UI",
art/sprite_list.json:1319:      "path": "assets/sprites/ui/panel_9.png",
art/sprite_list.json:1324:      "group": "UI",
art/sprite_list.json:1334:      "group": "UI",
art/sprite_list.json:1344:      "group": "UI",
art/sprite_list.json:1354:      "group": "UI",
art/sprite_list.json:1364:      "group": "UI",
art/sprite_list.json:1374:      "group": "UI",
art/sprite_list.json:1384:      "group": "UI",
art/sprite_list.json:1389:      "path": "assets/sprites/ui/merchant.png",
art/sprite_list.json:1394:      "group": "UI",
docs/그림-목록.md:61:### UI (22장, 지시서 `work/2026-11-30-UI그림/handoff-08.md`)
docs/그림-목록.md:66:| `ui/panel_9.png` · `panel_corner.png` | 48×48 · 14×14 | 창 9조각 (모서리 8px) · 모서리 장석 장식 |
docs/그림-목록.md:68:| `ui/merchant.png` | 48×64 | 진주 상점 보부상 |

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Get-Content -Encoding UTF8 C:/Users/pc/.codex/skills/.system/imagegen/SKILL.md | Select-Object -Skip 100 -First 65' in C:\Users\pc\Documents\game
 succeeded in 364ms:
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
- photorealistic-natural — candid/editorial lifestyle scenes with real texture and natural lighting.
- product-mockup — product/packaging shots, catalog imagery, merch concepts.
- ui-mockup — app/web interface mockups and wireframes; specify the desired fidelity.
- infographic-diagram — diagrams/infographics with structured layout and text.
- scientific-educational — classroom explainers, scientific diagrams, and learning visuals with required labels and accuracy constraints.
- ads-marketing — campaign concepts and ad creatives with audience, brand position, scene, and exact tagline/copy.
- productivity-visual — slide, chart, workflow, and data-heavy business visuals.
- logo-brand — logo/mark exploration, vector-friendly.
- illustration-story — comics, children’s book art, narrative scenes.
- stylized-concept — style-driven concept art, 3D/stylized renders.
- historical-scene — period-accurate/world-knowledge scenes.

Edit:
- text-localization — translate/replace in-image text, preserve layout.
- identity-preserve — try-on, person-in-scene; lock face/body/pose.
- precise-object-edit — remove/replace a specific element (including interior swaps).
- lighting-weather — time-of-day/season/atmosphere changes only.
- background-extraction — transparent background / clean cutout. Ask built-in `image_gen` for actual transparency.

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Get-Content -Encoding UTF8 art/references/README.md; Get-Content -Encoding UTF8 docs/그림-목록.md | Select-Object -Skip 60 -First 12; Get-Content -Encoding UTF8 art/sprite_list.json | Select-Object -Skip 1176 -First 225; Get-Content -Encoding UTF8 work/2026-11-30-UI그림/handoff-08.report.md' in C:\Users\pc\Documents\game
 succeeded in 495ms:
# 기준 그림

우리 그림체를 대표하는 그림을 이 폴더에 넣어 주세요 (png/jpg, 3~8장 권장).
검토자는 이 그림들과 `art/rubric.md`만 보고 채점합니다.
### UI (22장, 지시서 `work/2026-11-30-UI그림/handoff-08.md`)

| 파일 | 크기 | 내용 |
|---|---|---|
| `ui/icon_<이름>.png` ×14 | 16×16 | 뽑기권·흙·진주·파편·불씨·불·칼날·갑옷·부적·호리병·숫돌·쇠비늘·비급서·방울 |
| `ui/panel_9.png` · `panel_corner.png` | 48×48 · 14×14 | 창 9조각 (모서리 8px) · 모서리 장석 장식 |
| `ui/button_9.png` · `button_primary_9.png` · `card_9.png` · `title_plate_9.png` · `chip_9.png` | 24·24·24·20×14·16 | 9조각. 버튼·카드·제목 판은 밝은 무채색 (게임이 색을 입힘) |
| `ui/merchant.png` | 48×64 | 진주 상점 보부상 |

"AI 티 없애기" 규칙(팔레트 고정·손으로 찍은 점 덩어리·한 방향 빛·1배에서 읽힘·9조각 가운데 단색)은 지시서에 있다.

### 알을 품는 성 (12장)
    },
    {
      "path": "assets/sprites/ui/icon_ticket.png",
      "size": [
        16,
        16
      ],
      "group": "UI",
      "max_colors": 12,
      "what": "아이콘 16×16 · 뽑기권 — 붉은 띠를 두른 누런 한지 표, 귀퉁이 접힘. 1배 크기에서 실루엣만으로 알아볼 것. 외곽선 1px(먹색 #282322), 빛은 왼쪽 위에서 한 방향. 투명 배경"
    },
    {
      "path": "assets/sprites/ui/icon_clay.png",
      "size": [
        16,
        16
      ],
      "group": "UI",
      "max_colors": 12,
      "what": "아이콘 16×16 · 흙 — 손으로 뭉친 붉은 흙덩이, 손자국 한두 개. 1배 크기에서 실루엣만으로 알아볼 것. 외곽선 1px(먹색 #282322), 빛은 왼쪽 위에서 한 방향. 투명 배경"
    },
    {
      "path": "assets/sprites/ui/icon_pearl.png",
      "size": [
        16,
        16
      ],
      "group": "UI",
      "max_colors": 12,
      "what": "아이콘 16×16 · 진주 — 흰 진주 한 알, 왼쪽 위 반사광 1px, 아래 연한 그림자. 1배 크기에서 실루엣만으로 알아볼 것. 외곽선 1px(먹색 #282322), 빛은 왼쪽 위에서 한 방향. 투명 배경"
    },
    {
      "path": "assets/sprites/ui/icon_shard.png",
      "size": [
        16,
        16
      ],
      "group": "UI",
      "max_colors": 12,
      "what": "아이콘 16×16 · 요변 파편 — 유약 빛이 도는 깨진 도자기 조각 (보라·금 반사). 1배 크기에서 실루엣만으로 알아볼 것. 외곽선 1px(먹색 #282322), 빛은 왼쪽 위에서 한 방향. 투명 배경"
    },
    {
      "path": "assets/sprites/ui/icon_ember.png",
      "size": [
        16,
        16
      ],
      "group": "UI",
      "max_colors": 12,
      "what": "아이콘 16×16 · 불씨 — 숯 위의 작은 불씨, 주황 심지. 1배 크기에서 실루엣만으로 알아볼 것. 외곽선 1px(먹색 #282322), 빛은 왼쪽 위에서 한 방향. 투명 배경"
    },
    {
      "path": "assets/sprites/ui/icon_fire.png",
      "size": [
        16,
        16
      ],
      "group": "UI",
      "max_colors": 12,
      "what": "아이콘 16×16 · 불 다스리기 — 아궁이 불꽃 세 갈래. 1배 크기에서 실루엣만으로 알아볼 것. 외곽선 1px(먹색 #282322), 빛은 왼쪽 위에서 한 방향. 투명 배경"
    },
    {
      "path": "assets/sprites/ui/icon_blade.png",
      "size": [
        16,
        16
      ],
      "group": "UI",
      "max_colors": 12,
      "what": "아이콘 16×16 · 강철 칼날 — 비스듬한 짧은 환도 날, 금빛 코등이. 1배 크기에서 실루엣만으로 알아볼 것. 외곽선 1px(먹색 #282322), 빛은 왼쪽 위에서 한 방향. 투명 배경"
    },
    {
      "path": "assets/sprites/ui/icon_armor.png",
      "size": [
        16,
        16
      ],
      "group": "UI",
      "max_colors": 12,
      "what": "아이콘 16×16 · 두석린갑 — 쇠 비늘 갑옷 앞판 (비늘 3줄). 1배 크기에서 실루엣만으로 알아볼 것. 외곽선 1px(먹색 #282322), 빛은 왼쪽 위에서 한 방향. 투명 배경"
    },
    {
      "path": "assets/sprites/ui/icon_charm.png",
      "size": [
        16,
        16
      ],
      "group": "UI",
      "max_colors": 12,
      "what": "아이콘 16×16 · 신속 부적 — 노란 한지에 붉은 경면주사 글씨 (글자 대신 획 모양만). 1배 크기에서 실루엣만으로 알아볼 것. 외곽선 1px(먹색 #282322), 빛은 왼쪽 위에서 한 방향. 투명 배경"
    },
    {
      "path": "assets/sprites/ui/icon_gourd.png",
      "size": [
        16,
        16
      ],
      "group": "UI",
      "max_colors": 12,
      "what": "아이콘 16×16 · 약 호리병 — 붉은 끈 맨 호리병. 1배 크기에서 실루엣만으로 알아볼 것. 외곽선 1px(먹색 #282322), 빛은 왼쪽 위에서 한 방향. 투명 배경"
    },
    {
      "path": "assets/sprites/ui/icon_whetstone.png",
      "size": [
        16,
        16
      ],
      "group": "UI",
      "max_colors": 12,
      "what": "아이콘 16×16 · 숫돌 — 회색 숫돌 위 물기 한 줄. 1배 크기에서 실루엣만으로 알아볼 것. 외곽선 1px(먹색 #282322), 빛은 왼쪽 위에서 한 방향. 투명 배경"
    },
    {
      "path": "assets/sprites/ui/icon_scale.png",
      "size": [
        16,
        16
      ],
      "group": "UI",
      "max_colors": 12,
      "what": "아이콘 16×16 · 쇠비늘 — 겹친 쇠 비늘 세 장. 1배 크기에서 실루엣만으로 알아볼 것. 외곽선 1px(먹색 #282322), 빛은 왼쪽 위에서 한 방향. 투명 배경"
    },
    {
      "path": "assets/sprites/ui/icon_scroll.png",
      "size": [
        16,
        16
      ],
      "group": "UI",
      "max_colors": 12,
      "what": "아이콘 16×16 · 비급서 — 실로 묶은 낡은 책 (표지 끈). 1배 크기에서 실루엣만으로 알아볼 것. 외곽선 1px(먹색 #282322), 빛은 왼쪽 위에서 한 방향. 투명 배경"
    },
    {
      "path": "assets/sprites/ui/icon_bell.png",
      "size": [
        16,
        16
      ],
      "group": "UI",
      "max_colors": 12,
      "what": "아이콘 16×16 · 신령 방울 — 무당 방울 셋이 달린 손잡이. 1배 크기에서 실루엣만으로 알아볼 것. 외곽선 1px(먹색 #282322), 빛은 왼쪽 위에서 한 방향. 투명 배경"
    },
    {
      "path": "assets/sprites/ui/panel_9.png",
      "size": [
        48,
        48
      ],
      "group": "UI",
      "max_colors": 16,
      "what": "창(패널) 9조각 그림 — 모서리 8px 은 그대로, 가운데·변은 게임이 늘린다. 옻칠한 검붉은 나무판(#1c1622 계열) + 바깥 청동 테두리 2px + 안쪽 가는 선 1px. 가운데(늘어나는 부분)는 단색 또는 아주 약한 결 하나만 (늘여도 이상하지 않게). 모서리 1~2px 깎기"
    },
    {
      "path": "assets/sprites/ui/panel_corner.png",
      "size": [
        14,
        14
      ],
      "group": "UI",
      "max_colors": 10,
      "what": "창 모서리 장식 (왼쪽 위 한 장, 게임이 뒤집어 네 모서리에) — 반닫이 장석 같은 금박 쇠 장식, ㄱ자 모양에 작은 구름무늬 하나. 투명 배경"
    },
    {
      "path": "assets/sprites/ui/button_9.png",
      "size": [
        24,
        24
      ],
      "group": "UI",
      "max_colors": 12,
      "what": "버튼 9조각 (모서리 6px). **밝은 무채색 청동** (게임이 버튼마다 색을 입힌다). 위쪽 1px 하이라이트, 아래 2px 두께감, 모서리 깎기. 가운데는 단색"
    },
    {
      "path": "assets/sprites/ui/button_primary_9.png",
      "size": [
        24,
        24
      ],
      "group": "UI",
      "max_colors": 12,
      "what": "주 버튼 9조각 (모서리 6px) — 금박 칠 (#e8c35a 계열), 위 하이라이트·아래 두께감. 가운데는 단색 (글자가 그 위에 먹색으로 올라간다)"
    },
    {
      "path": "assets/sprites/ui/card_9.png",
      "size": [
        24,
        24
      ],
      "group": "UI",
      "max_colors": 12,
      "what": "병사 카드 틀 9조각 (모서리 6px) — **밝은 무채색** (게임이 등급 색을 입힌다), 안쪽은 어두운 바탕, 아래쪽 이름 띠 자리가 살짝 더 어둡게. 가운데 단색"
    },
    {
      "path": "assets/sprites/ui/title_plate_9.png",
      "size": [
        20,
        14
      ],
      "group": "UI",
      "max_colors": 8,
      "what": "창 제목 판 9조각 (모서리 5px) — 작은 현판 모양, 밝은 무채색 테두리 (게임이 색을 입힌다), 안은 어두운 옻칠"
    },
    {
      "path": "assets/sprites/ui/chip_9.png",
      "size": [
        16,
        16
      ],
      "group": "UI",
      "max_colors": 8,
      "what": "자원 알약 9조각 (모서리 6px) — 안으로 파인 어두운 홈, 청동 테두리 1px"
    },
    {
      "path": "assets/sprites/ui/merchant.png",
      "size": [
        48,
        64
      ],
      "group": "UI",
      "max_colors": 24,
      "what": "진주 상점 상인 (가슴 위 정도, 오른쪽을 봄) — 지게에 보따리를 진 보부상 도자기 인형, 패랭이 모자에 목화 송이, 손에 진주 한 알, 부드럽게 웃는 얼굴. 병사 도자기 인형과 같은 그림체 (얼굴 회색, 흰 광택), 옷은 흙빛·쪽빛. 투명 배경"
    }
  ],
  "정한 그림체 (2026-11-27, 사용자 승인)": [
    "기준 그림: art/references/ (= art/style/mix 시안)",
    "형태·디테일·표정은 '가'처럼 — 32×32 에서도 무엇인지 한눈에",
OpenAI Codex v0.172.0
--------
workdir: C:\Users\pc\Documents\game
model: gpt-6-astra
provider: openai
approval: never
sandbox: workspace-write [workdir, /tmp, $TMPDIR]
reasoning effort: high
reasoning summaries: none
session id: 01a21fdd-4bf0-7523-bd11-b4f8ef3b8757
--------
user
# Codex 작업 지시서 — UI 그림 (아이콘 14 · 창·버튼·카드 틀 7 · 상인 1)

- 날짜: 2026-11-30
- 작업 폴더: work/2026-11-30-UI그림/
- 지시서 번호: 08

## 먼저 읽을 것
1. AGENTS.md
2. art/references/ — 정한 그림체 (가 + 다: 흙·먹색 바탕, 유약 색은 포인트)
3. `assets/sprites/kiln/soldier_*.png` — 병사 도자기 인형 (상인은 이 인형과 같은 그림체)
4. `work/2026-11-30-UI그림/ref_lobby.png`, `ref_gacha.png`, `ref_shop.png`, `ref_clear.png`, `ref_tactics.png` — 지금 게임 화면 (코드로 그린 임시 UI). **이 자리에 들어갈 그림**이다
5. UI 시안: claude.ai 아티팩트 "가마의 병사 UI 개편 시안" — 색과 배치의 방향 (옻칠 바탕 · 청동 테두리 · 금박)
6. docs/그림-목록.md, art/sprite_list.json 의 "UI" 묶음

## 목표 (사용자 말 그대로)
> "UI 그림(아이콘, 패널 장식, 상인 그림)도 Codex 지시서로 만들어줘. 좀 더 세련되고 AI가 만든 것 같지 않도록 실제 전문 디자이너가 한 것처럼 자연스럽게 만들어줘."

## AI 티 없애기 — 전문 픽셀 UI 디자이너처럼 (반드시 지킨다)
사용자가 가장 신경 쓰는 부분이다. 아래는 "AI가 만든 티"가 나는 흔한 원인과 그 반대로 하는 방법이다.

1. **팔레트를 먼저 정하고 그 색만 쓴다.** 아래 팔레트 밖의 색 금지 (표의 최대 색 수 안에서). 비슷한 색 여러 개(색 번짐) 금지
   - 먹 `#282322` · 옻칠 어둠 `#120e16` `#1c1622` `#2a2236` · 청동 `#5a4630` `#8a6a48` `#a8862e` · 금박 `#e8c35a` `#fff1c4`
   - 흙 `#b98a5e` `#7a5a44` · 한지 `#e8dcb8` `#f2e6c8` · 쇠 `#6f6c66` `#b0b8c0` `#dfe6ee` · 진사 `#b8463a` `#7a2a24` · 청자 `#6b9878` `#a6c5a3` · 불 `#ff9a3c`
2. **점은 손으로 찍은 것처럼:** 의미 있는 덩어리(클러스터)로만. 외톨이 점·흩뿌린 잡티·노이즈 결 금지. 모든 점이 "왜 거기 있는지" 설명되어야 한다
3. **빛은 왼쪽 위 한 방향.** 하이라이트는 1~2px, 그림자는 오른쪽 아래. 형태마다 빛 방향이 다르면 AI 티가 난다
4. **그라데이션·흐림·광택 번짐 금지.** 단계는 2~3단으로 끊는다. 디더링은 필요한 곳에만 아주 조금
5. **1배 크기에서 읽혀야 한다.** 16×16 아이콘은 실루엣만 보고도 무엇인지 알아야 한다 — 디테일보다 형태 먼저. 작게 줄여 확인할 것
6. **외곽선:** 먹색 1px. 안쪽 선은 바깥보다 밝게(선택적 외곽선). 계단(jaggies) 없이 1-2-3 규칙적인 기울기
7. **한 벌로:** 아이콘 14개는 같은 크기 틀(대략 12~13px 안), 같은 외곽선 굵기, 같은 빛·같은 채도. 하나만 튀면 안 된다
8. **9조각 그림(panel·button·card·title_plate·chip):** 모서리는 정해진 px 안에서 끝나고, **가운데와 변은 단색**(늘어나도 무늬가 늘어지지 않게). 버튼·카드·제목 판은 **밝은 무채색**으로 — 게임이 상황마다 색을 입힌다
9. **장식은 절제:** 한국 전통 장석·구름무늬는 모서리에 작게 하나. 테두리 전체를 문양으로 채우지 않는다
10. 글자·로고를 그림에 넣지 않는다 (게임이 글을 쓴다)

## 정한 그림체 (반드시 따른다)
- 가 + 다 섞음: 형태는 또렷하게, 바탕은 먹·흙 회색조, 강한 색은 포인트에만
- 투명 배경 (9조각의 깎은 모서리 바깥도 투명), 흐림(안티에일리어싱) 없음, 표의 색 수 이하

## 그리는 방법 (사용자가 정한 것)
- [x] 이미지 생성 후 코드로 다듬기 (크기 맞추기·배경 투명·색 줄이기) — 사용자가 handoff-01 에서 정함 (2026-11-27)
- 단, 위 "AI 티 없애기" 규칙에 맞게 **색을 팔레트로 강제로 맞추고, 외톨이 점을 지우고, 1배로 줄여 확인**하는 다듬기를 꼭 거친다

정한 방법을 쓸 수 없으면 다른 방법으로 바꾸지 말고 `결과: 못 돌림` 으로 보고한다.

## 만들 것 (22장)

| 파일 | 크기 | 최대 색 | 내용 |
|---|---|---|---|
| `assets/sprites/ui/icon_ticket.png` | 16×16 | 12 | 아이콘 16×16 · 뽑기권 — 붉은 띠를 두른 누런 한지 표, 귀퉁이 접힘. 1배 크기에서 실루엣만으로 알아볼 것. 외곽선 1px(먹색 #282322), 빛은 왼쪽 위에서 한 방향. 투명 배경 |
| `assets/sprites/ui/icon_clay.png` | 16×16 | 12 | 아이콘 16×16 · 흙 — 손으로 뭉친 붉은 흙덩이, 손자국 한두 개. 1배 크기에서 실루엣만으로 알아볼 것. 외곽선 1px(먹색 #282322), 빛은 왼쪽 위에서 한 방향. 투명 배경 |
| `assets/sprites/ui/icon_pearl.png` | 16×16 | 12 | 아이콘 16×16 · 진주 — 흰 진주 한 알, 왼쪽 위 반사광 1px, 아래 연한 그림자. 1배 크기에서 실루엣만으로 알아볼 것. 외곽선 1px(먹색 #282322), 빛은 왼쪽 위에서 한 방향. 투명 배경 |
| `assets/sprites/ui/icon_shard.png` | 16×16 | 12 | 아이콘 16×16 · 요변 파편 — 유약 빛이 도는 깨진 도자기 조각 (보라·금 반사). 1배 크기에서 실루엣만으로 알아볼 것. 외곽선 1px(먹색 #282322), 빛은 왼쪽 위에서 한 방향. 투명 배경 |
| `assets/sprites/ui/icon_ember.png` | 16×16 | 12 | 아이콘 16×16 · 불씨 — 숯 위의 작은 불씨, 주황 심지. 1배 크기에서 실루엣만으로 알아볼 것. 외곽선 1px(먹색 #282322), 빛은 왼쪽 위에서 한 방향. 투명 배경 |
| `assets/sprites/ui/icon_fire.png` | 16×16 | 12 | 아이콘 16×16 · 불 다스리기 — 아궁이 불꽃 세 갈래. 1배 크기에서 실루엣만으로 알아볼 것. 외곽선 1px(먹색 #282322), 빛은 왼쪽 위에서 한 방향. 투명 배경 |
| `assets/sprites/ui/icon_blade.png` | 16×16 | 12 | 아이콘 16×16 · 강철 칼날 — 비스듬한 짧은 환도 날, 금빛 코등이. 1배 크기에서 실루엣만으로 알아볼 것. 외곽선 1px(먹색 #282322), 빛은 왼쪽 위에서 한 방향. 투명 배경 |
| `assets/sprites/ui/icon_armor.png` | 16×16 | 12 | 아이콘 16×16 · 두석린갑 — 쇠 비늘 갑옷 앞판 (비늘 3줄). 1배 크기에서 실루엣만으로 알아볼 것. 외곽선 1px(먹색 #282322), 빛은 왼쪽 위에서 한 방향. 투명 배경 |
| `assets/sprites/ui/icon_charm.png` | 16×16 | 12 | 아이콘 16×16 · 신속 부적 — 노란 한지에 붉은 경면주사 글씨 (글자 대신 획 모양만). 1배 크기에서 실루엣만으로 알아볼 것. 외곽선 1px(먹색 #282322), 빛은 왼쪽 위에서 한 방향. 투명 배경 |
| `assets/sprites/ui/icon_gourd.png` | 16×16 | 12 | 아이콘 16×16 · 약 호리병 — 붉은 끈 맨 호리병. 1배 크기에서 실루엣만으로 알아볼 것. 외곽선 1px(먹색 #282322), 빛은 왼쪽 위에서 한 방향. 투명 배경 |
| `assets/sprites/ui/icon_whetstone.png` | 16×16 | 12 | 아이콘 16×16 · 숫돌 — 회색 숫돌 위 물기 한 줄. 1배 크기에서 실루엣만으로 알아볼 것. 외곽선 1px(먹색 #282322), 빛은 왼쪽 위에서 한 방향. 투명 배경 |
| `assets/sprites/ui/icon_scale.png` | 16×16 | 12 | 아이콘 16×16 · 쇠비늘 — 겹친 쇠 비늘 세 장. 1배 크기에서 실루엣만으로 알아볼 것. 외곽선 1px(먹색 #282322), 빛은 왼쪽 위에서 한 방향. 투명 배경 |
| `assets/sprites/ui/icon_scroll.png` | 16×16 | 12 | 아이콘 16×16 · 비급서 — 실로 묶은 낡은 책 (표지 끈). 1배 크기에서 실루엣만으로 알아볼 것. 외곽선 1px(먹색 #282322), 빛은 왼쪽 위에서 한 방향. 투명 배경 |
| `assets/sprites/ui/icon_bell.png` | 16×16 | 12 | 아이콘 16×16 · 신령 방울 — 무당 방울 셋이 달린 손잡이. 1배 크기에서 실루엣만으로 알아볼 것. 외곽선 1px(먹색 #282322), 빛은 왼쪽 위에서 한 방향. 투명 배경 |
| `assets/sprites/ui/panel_9.png` | 48×48 | 16 | 창(패널) 9조각 그림 — 모서리 8px 은 그대로, 가운데·변은 게임이 늘린다. 옻칠한 검붉은 나무판(#1c1622 계열) + 바깥 청동 테두리 2px + 안쪽 가는 선 1px. 가운데(늘어나는 부분)는 단색 또는 아주 약한 결 하나만 (늘여도 이상하지 않게). 모서리 1~2px 깎기 |
| `assets/sprites/ui/panel_corner.png` | 14×14 | 10 | 창 모서리 장식 (왼쪽 위 한 장, 게임이 뒤집어 네 모서리에) — 반닫이 장석 같은 금박 쇠 장식, ㄱ자 모양에 작은 구름무늬 하나. 투명 배경 |
| `assets/sprites/ui/button_9.png` | 24×24 | 12 | 버튼 9조각 (모서리 6px). **밝은 무채색 청동** (게임이 버튼마다 색을 입힌다). 위쪽 1px 하이라이트, 아래 2px 두께감, 모서리 깎기. 가운데는 단색 |
| `assets/sprites/ui/button_primary_9.png` | 24×24 | 12 | 주 버튼 9조각 (모서리 6px) — 금박 칠 (#e8c35a 계열), 위 하이라이트·아래 두께감. 가운데는 단색 (글자가 그 위에 먹색으로 올라간다) |
| `assets/sprites/ui/card_9.png` | 24×24 | 12 | 병사 카드 틀 9조각 (모서리 6px) — **밝은 무채색** (게임이 등급 색을 입힌다), 안쪽은 어두운 바탕, 아래쪽 이름 띠 자리가 살짝 더 어둡게. 가운데 단색 |
| `assets/sprites/ui/title_plate_9.png` | 20×14 | 8 | 창 제목 판 9조각 (모서리 5px) — 작은 현판 모양, 밝은 무채색 테두리 (게임이 색을 입힌다), 안은 어두운 옻칠 |
| `assets/sprites/ui/chip_9.png` | 16×16 | 8 | 자원 알약 9조각 (모서리 6px) — 안으로 파인 어두운 홈, 청동 테두리 1px |
| `assets/sprites/ui/merchant.png` | 48×64 | 24 | 진주 상점 상인 (가슴 위 정도, 오른쪽을 봄) — 지게에 보따리를 진 보부상 도자기 인형, 패랭이 모자에 목화 송이, 손에 진주 한 알, 부드럽게 웃는 얼굴. 병사 도자기 인형과 같은 그림체 (얼굴 회색, 흰 광택), 옷은 흙빛·쪽빛. 투명 배경 |

## 고쳐도 되는 범위
- `assets/sprites/ui/icon_ticket.png` (새 파일)
- `assets/sprites/ui/icon_clay.png` (새 파일)
- `assets/sprites/ui/icon_pearl.png` (새 파일)
- `assets/sprites/ui/icon_shard.png` (새 파일)
- `assets/sprites/ui/icon_ember.png` (새 파일)
- `assets/sprites/ui/icon_fire.png` (새 파일)
- `assets/sprites/ui/icon_blade.png` (새 파일)
- `assets/sprites/ui/icon_armor.png` (새 파일)
- `assets/sprites/ui/icon_charm.png` (새 파일)
- `assets/sprites/ui/icon_gourd.png` (새 파일)
- `assets/sprites/ui/icon_whetstone.png` (새 파일)
- `assets/sprites/ui/icon_scale.png` (새 파일)
- `assets/sprites/ui/icon_scroll.png` (새 파일)
- `assets/sprites/ui/icon_bell.png` (새 파일)
- `assets/sprites/ui/panel_9.png` (새 파일)
- `assets/sprites/ui/panel_corner.png` (새 파일)
- `assets/sprites/ui/button_9.png` (새 파일)
- `assets/sprites/ui/button_primary_9.png` (새 파일)
- `assets/sprites/ui/card_9.png` (새 파일)
- `assets/sprites/ui/title_plate_9.png` (새 파일)
- `assets/sprites/ui/chip_9.png` (새 파일)
- `assets/sprites/ui/merchant.png` (새 파일)

이 목록에 없는 파일은 만들거나 고치지 않는다.

## 보호 검사 결과 (Claude가 미리 확인함)
- `python3 scripts/protected.py <위 파일들>` → 걸린 파일 없음 (모두 새 파일)
- 이 검사는 Claude가 했다. Codex는 다시 돌리지 않는다.

## 하면 안 되는 일
- 범위 밖 파일 수정·삭제 (특히 `src/`, `tests/`, `art/references/`, `art/rubric.md`, 이미 있는 `assets/sprites/`)
- 게임 코드에 그림을 연결하는 작업 (이미 되어 있다: 파일이 있으면 코드 그림 대신 쓴다)
- 저장소의 Python 스크립트 실행 (검사는 Claude가 작업 후에 한다)
- git commit / push
- 못 했는데 했다고 보고하기

## 끝나면 이 형식으로 보고
```
결과: 통과 | 실패 | 못 돌림   ← 셋 중 하나만
바뀐 파일:
- 경로 — 무엇을
직접 확인한 것:
- 예) 1배·4배로 줄여 보고 실루엣 확인, 팔레트 밖 색 없음, 9조각 가운데 단색
그리는 데 쓴 방법:
- 이미지 생성 / 코드 / 둘 다 (무엇을 어떻게, 팔레트 맞추기를 어떻게 했는지)
못 한 것 / 걱정되는 것:
- …
```
- 저장소의 Python 검사를 못 돌린 것만으로는 `못 돌림`이 아니다. 검사는 Claude가 한다.

## Claude가 받은 뒤 할 일
1. `git status` — 바뀐 파일이 위 범위뿐인지
2. `python3 scripts/check_sprites.py --group "UI" --sheet work/2026-11-30-UI그림/sheet-08.png` — 크기·투명 배경·색 수·흐린 가장자리
3. 게임 화면 스크린샷 (`tests/screens_proto.gd`): 로비·뽑기·상점·클리어 창·전술 강화에서 직접 본다 (9조각이 늘어날 때 깨지지 않는지)
4. **그림 루프** (`.claude/skills/art-loop/SKILL.md`): 처음 보는 검토자 2명이 `art/rubric.md` 로 "AI 티"·"그림체 어울림" 채점 → 낮으면 다시 지시
5. `python3 scripts/test.py --stage all`
6. 사용자에게 보여 주고 "검사는 통과, 미술 판단은 사용자 몫" — 허락을 받은 뒤 커밋

warning: Codex is ignoring 1 unrecognized configuration setting. Check for typos or deprecated settings.
  user (C:\Users\pc\.codex\config.toml): `computer_use.windows.always_allowed_app_ids` is ignored.
warning: Codex is ignoring 1 unrecognized configuration setting. Check for typos or deprecated settings.
  user (C:\Users\pc\.codex\config.toml): `computer_use.windows.always_allowed_app_ids` is ignored.
codex
지시서의 참고 그림과 보호 목록부터 확인하겠습니다. imagegen 스킬로 원본을 생성한 뒤 지정 팔레트와 픽셀 규격에 맞게 다듬고, 허용된 PNG 22개만 저장하겠습니다.

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Get-Content AGENTS.md; Get-Content PROTECTED.txt; Get-Content C:/Users/pc/.codex/skills/.system/imagegen/SKILL.md' in C:\Users\pc\Documents\game
 succeeded in 320ms:
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
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -Encoding UTF8 AGENTS.md; Get-Content -Encoding UTF8 PROTECTED.txt; git status --porcelain; rg --files art/references work/2026-11-30-UI그림 assets/sprites/kiln assets/sprites/ui; rg -n 'UI|icon_ticket|merchant|panel_9' docs/그림-목록.md art/sprite_list.json" in C:\Users\pc\Documents\game
 succeeded in 0ms:
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

지금: **1분 시험판 두 개** — B 가마의 병사, A 알을 품는 성 (기획안 비교 `docs/기획안-비교.md`). 첫 화면 `src/game/launcher.tscn` 에서 고른다.
지난 시험판 **AFTERSELF (가제)** 는 보류 (`docs/기획서.md`, `src/core/`). Godot 4.7, 위에서 내려다보는 2D 픽셀 아트(타일 32×32).

| 위치 | 내용 |
|---|---|
| `src/proto/` | 1분 시험판 규칙 (화면과 무관). `data.gd` 수치 · `battle.gd` 공용 자동 전투 · `kiln.gd` 가마 · `nest.gd` 둥지 |
| `src/core/` | (보류) AFTERSELF 규칙 (화면과 무관). `data.gd` 수치 · `world.gd` 방 하나의 전투 · `run.gd` 한 판 흐름 · `habits.gd` 습관 기록 · `echo.gd` 어제의 나 · `save.gd` 판 사이 저장 |
| `src/game/` | 화면·입력. `launcher` 첫 화면 · `kiln_scene` · `nest_scene` · `proto_base` 공통 연출 · `main` (보류) AFTERSELF. 규칙을 읽어서 그리기만 한다 |
| `assets/` | 게임에 들어가는 그림·글꼴 (글꼴: 갈무리, OFL). 그림은 `assets/sprites/` — 목록 `art/sprite_list.json`, 설명 `docs/그림-목록.md`. 파일이 있으면 게임이 쓰고, 없으면 도형으로 그린다 |
| `tests/` | Godot 테스트 (`test_p0.gd`, `test_p1.gd`, `test_boss.gd`), 봇, 성능 측정(`bench.gd`), 스크린샷(`screens.gd`) |
| `art/` | 그림 루프용 기준 그림·기준표 (게임에 안 들어감) |

- 규칙은 `src/proto/`(지금) · `src/core/`(보류) 에만 쓴다. 화면 코드에서 규칙을 바꾸지 않는다 (테스트·봇이 화면 없이 규칙을 돌리기 때문).
- 수치(밸런스)는 `src/proto/data.gd`(지금) 한 곳에서만 바꾼다.
- **그리기 층 (HD-2D)**: 화면은 1280×800 으로 그리고(실행 중에 canvas_items 로 바꿈), 픽셀 그림은 또렷하게, 빛·안개는 부드럽게. 층: `bg` 바닥 → `back` 그림자·뒷빛·안개 → 기본(캐릭터·UI) → `glow` 빛(가산 혼합) → `front` 앞 안개·밤 색감·비네트 (`src/game/glow_layer.gd`, `proto_base.gd` 의 `draw_layer`). 전투가 보일 때 기본층은 화면 전체를 칠하지 않는다 (`draw_screen_bg`).
- **이펙트 애니메이션**: `assets/sprites/fx/<이름>.png` (정사각형 장면을 가로 한 줄) 이 있으면 `play_fx` 로 재생, 없으면 코드 효과.
- **억울하지 않은 운** (사용자 요청): 안전 구간은 반드시 보통 이상 · 확률은 화면에 숫자로 · 실패하면 파편/조각 · 3개 모이면 확정 보상. 이 규칙을 깨는 변경은 사용자에게 먼저 묻는다.
- `work/`, `reports/`, `docs/`, `scripts/`, `perf/`, `art/` 에는 `.gdignore` 가 있어 Godot 가 읽지 않는다.

## 실행 환경

- 이 문서의 `python3` 명령은 Windows에서 `python3` 이 안 되면 `python` 으로 바꿔 실행한다 (같은 것).
- Godot: `scripts/godot_cmd.py` 가 찾는다 (환경 변수 `GODOT` → PATH 의 `godot` → Windows 기본 위치의 `*_console.exe`). 못 찾으면 환경 변수 `GODOT` 에 실행 파일 경로를 넣는다. Windows는 창 없는 실행을 위해 `_console.exe` 를 쓴다.
- 화면 확인(스크린샷): `godot --path . --script res://tests/screens_proto.gd -- <저장 폴더>` (지난 시험판은 `screens.gd`) (화면이 있는 환경에서. 서버에서는 Xvfb 필요). 화면을 바꾸면 스크린샷을 직접 열어 확인한다.
- Codex는 `codex exec` (Codex CLI)로 부른다. git 저장소 폴더 안에서만 실행한다.
  쓰기 작업은 `--sandbox workspace-write`, 읽기만 하면 `--sandbox read-only` (Codex CLI 0.172 기준. `--full-auto` 는 없음).

## 자동 테스트

| 단계 | 뜻 | 위치 |
|---|---|---|
| P0 | 깨지면 게임이 안 되는 것 (시작·이동·공격·죽음→메아리·같은 시드 같은 결과) | `tests/test_p0.gd` |
| P1 | 게임 전반. 1분 시험판(가마 확률·파편 확정·알 터짐·먹이·합동 기술·균형) `tests/test_proto.gd` + AFTERSELF `tests/test_p1.gd` | `tests/test_proto.gd`, `tests/test_p1.gd` |
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

## 그림 검사

- Codex가 그림을 넣으면: `python3 scripts/check_sprites.py [--group 이름] [--sheet 비교시트.png]` — 크기·투명 배경·색 수(24개 이하)·흐린 가장자리
- 그다음 스크린샷으로 게임 화면에서 직접 본다. 그림체 판단은 사용자 몫.

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
# 사용자가 직접 고친 파일 / 덮어쓰면 안 되는 파일 (한 줄에 하나, glob 가능)
# Claude·Codex는 여기 적힌 파일을 덮어쓰지 않는다. 고쳐야 하면 바꿀 내용을 제안만 한다.
art/references/*
art/rubric.md
 M assets/sprites/enemy/goblin.png
 M assets/sprites/field/house.png
 M reports/boss/history.csv
 M "work/2026-11-27-\352\267\270\353\246\274/NOTES.md"
 M "work/2026-11-27-\352\267\270\353\246\274/handoff-03.md"
?? assets/sprites/enemy/armored.png
?? assets/sprites/enemy/armored.png.import
?? assets/sprites/enemy/brute.png
?? assets/sprites/enemy/brute.png.import
?? assets/sprites/enemy/chief.png
?? assets/sprites/enemy/chief.png.import
?? assets/sprites/enemy/fox.png
?? assets/sprites/enemy/fox.png.import
?? assets/sprites/enemy/ghost.png
?? assets/sprites/enemy/ghost.png.import
?? assets/sprites/enemy/giant.png
?? assets/sprites/enemy/giant.png.import
?? assets/sprites/enemy/goblin.png.import
?? assets/sprites/enemy/gumiho.png
?? assets/sprites/enemy/gumiho.png.import
?? assets/sprites/enemy/imp.png
?? assets/sprites/enemy/imp.png.import
?? assets/sprites/enemy/imugi.png
?? assets/sprites/enemy/imugi.png.import
?? assets/sprites/enemy/king.png
?? assets/sprites/enemy/king.png.import
?? assets/sprites/enemy/reaper.png
?? assets/sprites/enemy/reaper.png.import
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
?? assets/sprites/kiln/soldier_baekho_earth.png
?? assets/sprites/kiln/soldier_baekho_earth.png.import
?? assets/sprites/kiln/soldier_baekho_fire.png
?? assets/sprites/kiln/soldier_baekho_fire.png.import
?? assets/sprites/kiln/soldier_baekho_water.png
?? assets/sprites/kiln/soldier_baekho_water.png.import
?? assets/sprites/kiln/soldier_bulgasari_earth.png
?? assets/sprites/kiln/soldier_bulgasari_earth.png.import
?? assets/sprites/kiln/soldier_bulgasari_fire.png
?? assets/sprites/kiln/soldier_bulgasari_fire.png.import
?? assets/sprites/kiln/soldier_bulgasari_water.png
?? assets/sprites/kiln/soldier_bulgasari_water.png.import
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
?? assets/sprites/kiln/soldier_cheoyong_earth.png
?? assets/sprites/kiln/soldier_cheoyong_earth.png.import
?? assets/sprites/kiln/soldier_cheoyong_fire.png
?? assets/sprites/kiln/soldier_cheoyong_fire.png.import
?? assets/sprites/kiln/soldier_cheoyong_water.png
?? assets/sprites/kiln/soldier_cheoyong_water.png.import
?? assets/sprites/kiln/soldier_dragon_earth.png
?? assets/sprites/kiln/soldier_dragon_earth.png.import
?? assets/sprites/kiln/soldier_dragon_fire.png
?? assets/sprites/kiln/soldier_dragon_fire.png.import
?? assets/sprites/kiln/soldier_dragon_water.png
?? assets/sprites/kiln/soldier_dragon_water.png.import
?? assets/sprites/kiln/soldier_general_earth.png
?? assets/sprites/kiln/soldier_general_earth.png.import
?? assets/sprites/kiln/soldier_general_fire.png
?? assets/sprites/kiln/soldier_general_fire.png.import
?? assets/sprites/kiln/soldier_general_water.png
?? assets/sprites/kiln/soldier_general_water.png.import
?? assets/sprites/kiln/soldier_haetae_earth.png
?? assets/sprites/kiln/soldier_haetae_earth.png.import
?? assets/sprites/kiln/soldier_haetae_fire.png
?? assets/sprites/kiln/soldier_haetae_fire.png.import
?? assets/sprites/kiln/soldier_haetae_water.png
?? assets/sprites/kiln/soldier_haetae_water.png.import
?? assets/sprites/kiln/soldier_healer_earth.png
?? assets/sprites/kiln/soldier_healer_earth.png.import
?? assets/sprites/kiln/soldier_healer_fire.png
?? assets/sprites/kiln/soldier_healer_fire.png.import
?? assets/sprites/kiln/soldier_healer_water.png
?? assets/sprites/kiln/soldier_healer_water.png.import
?? assets/sprites/kiln/soldier_hyeonmu_earth.png
?? assets/sprites/kiln/soldier_hyeonmu_earth.png.import
?? assets/sprites/kiln/soldier_hyeonmu_fire.png
?? assets/sprites/kiln/soldier_hyeonmu_fire.png.import
?? assets/sprites/kiln/soldier_hyeonmu_water.png
?? assets/sprites/kiln/soldier_hyeonmu_water.png.import
?? assets/sprites/kiln/soldier_jujak_earth.png
?? assets/sprites/kiln/soldier_jujak_earth.png.import
?? assets/sprites/kiln/soldier_jujak_fire.png
?? assets/sprites/kiln/soldier_jujak_fire.png.import
?? assets/sprites/kiln/soldier_jujak_water.png
?? assets/sprites/kiln/soldier_jujak_water.png.import
?? assets/sprites/kiln/soldier_slinger_earth.png
?? assets/sprites/kiln/soldier_slinger_earth.png.import
?? assets/sprites/kiln/soldier_slinger_fire.png
?? assets/sprites/kiln/soldier_slinger_fire.png.import
?? assets/sprites/kiln/soldier_slinger_water.png
?? assets/sprites/kiln/soldier_slinger_water.png.import
?? assets/sprites/kiln/soldier_sniper_earth.png
?? assets/sprites/kiln/soldier_sniper_earth.png.import
?? assets/sprites/kiln/soldier_sniper_fire.png
?? assets/sprites/kiln/soldier_sniper_fire.png.import
?? assets/sprites/kiln/soldier_sniper_water.png
?? assets/sprites/kiln/soldier_sniper_water.png.import
?? assets/sprites/kiln/soldier_twin_earth.png
?? assets/sprites/kiln/soldier_twin_earth.png.import
?? assets/sprites/kiln/soldier_twin_fire.png
?? assets/sprites/kiln/soldier_twin_fire.png.import
?? assets/sprites/kiln/soldier_twin_water.png
?? assets/sprites/kiln/soldier_twin_water.png.import
?? assets/sprites/nest/
?? reports/boss/history-local-backup.csv
?? src/game/pixel_art.gd.uid
?? src/proto/kiln_run.gd.uid
?? src/proto/meta.gd.uid
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
?? "work/2026-11-28-\353\213\244\353\223\254\352\270\260/old-06-soldiers/"
?? "work/2026-11-28-\353\213\244\353\223\254\352\270\260/screens-05/"
?? "work/2026-11-28-\353\213\244\353\223\254\352\270\260/screens-06/"
?? "work/2026-11-28-\353\213\244\353\223\254\352\270\260/sheet-05.png"
?? "work/2026-11-28-\353\213\244\353\223\254\352\270\260/sheet-06a.png"
?? "work/2026-11-28-\353\213\244\353\223\254\352\270\260/sheet-06b.png"
?? "work/2026-11-29-\354\212\244\355\202\254\354\247\204\354\230\201/handoff-07.report.md"
?? "work/2026-11-29-\354\212\244\355\202\254\354\247\204\354\230\201/screens-07/"
?? "work/2026-11-29-\354\212\244\355\202\254\354\247\204\354\230\201/sheet-07a.png"
?? "work/2026-11-29-\354\212\244\355\202\254\354\247\204\354\230\201/sheet-07b.png"
?? "work/2026-11-30-UI\352\267\270\353\246\274/handoff-08.report.md"
rg: assets/sprites/ui: 지정된 파일을 찾을 수 없습니다. (os error 2)
work/2026-11-30-UI그림\ref_tactics.png
work/2026-11-30-UI그림\ref_shop.png
work/2026-11-30-UI그림\ref_lobby.png
work/2026-11-30-UI그림\ref_gacha.png
work/2026-11-30-UI그림\ref_clear.png
work/2026-11-30-UI그림\NOTES.md
work/2026-11-30-UI그림\handoff-08.report.md
work/2026-11-30-UI그림\handoff-08.md
art/references\soldier_spear_fire.png
art/references\soldier_shield_earth.png
art/references\soldier_archer_water.png
art/references\sheet.png
art/references\README.md
art/references\house.png
art/references\goblin.png
art/references\creature_shield_water.png
assets/sprites/kiln\soldier_twin_water.png.import
assets/sprites/kiln\soldier_twin_water.png
assets/sprites/kiln\soldier_twin_fire.png.import
assets/sprites/kiln\soldier_twin_fire.png
assets/sprites/kiln\soldier_twin_earth.png.import
assets/sprites/kiln\soldier_twin_earth.png
assets/sprites/kiln\soldier_spear_water.png.import
assets/sprites/kiln\soldier_spear_water.png
assets/sprites/kiln\soldier_spear_fire.png.import
assets/sprites/kiln\soldier_spear_fire.png
assets/sprites/kiln\soldier_spear_earth.png.import
assets/sprites/kiln\soldier_spear_earth.png
assets/sprites/kiln\soldier_sniper_water.png.import
assets/sprites/kiln\soldier_sniper_water.png
assets/sprites/kiln\soldier_sniper_fire.png.import
assets/sprites/kiln\soldier_sniper_fire.png
assets/sprites/kiln\soldier_sniper_earth.png.import
assets/sprites/kiln\soldier_sniper_earth.png
assets/sprites/kiln\soldier_slinger_water.png.import
assets/sprites/kiln\soldier_slinger_water.png
assets/sprites/kiln\soldier_slinger_fire.png.import
assets/sprites/kiln\soldier_slinger_fire.png
assets/sprites/kiln\soldier_slinger_earth.png.import
assets/sprites/kiln\soldier_slinger_earth.png
assets/sprites/kiln\soldier_shield_water.png.import
assets/sprites/kiln\soldier_shield_water.png
assets/sprites/kiln\soldier_shield_fire.png.import
assets/sprites/kiln\soldier_shield_fire.png
assets/sprites/kiln\soldier_shield_earth.png.import
assets/sprites/kiln\soldier_shield_earth.png
assets/sprites/kiln\soldier_jujak_water.png.import
assets/sprites/kiln\soldier_jujak_water.png
assets/sprites/kiln\soldier_jujak_fire.png.import
assets/sprites/kiln\soldier_jujak_fire.png
assets/sprites/kiln\soldier_jujak_earth.png.import
assets/sprites/kiln\soldier_jujak_earth.png
assets/sprites/kiln\soldier_hyeonmu_water.png.import
assets/sprites/kiln\soldier_hyeonmu_water.png
assets/sprites/kiln\soldier_hyeonmu_fire.png.import
assets/sprites/kiln\soldier_hyeonmu_fire.png
assets/sprites/kiln\soldier_hyeonmu_earth.png.import
assets/sprites/kiln\soldier_hyeonmu_earth.png
assets/sprites/kiln\soldier_healer_water.png.import
assets/sprites/kiln\soldier_healer_water.png
assets/sprites/kiln\soldier_healer_fire.png.import
assets/sprites/kiln\soldier_healer_fire.png
assets/sprites/kiln\soldier_healer_earth.png.import
assets/sprites/kiln\soldier_healer_earth.png
assets/sprites/kiln\soldier_haetae_water.png.import
assets/sprites/kiln\soldier_haetae_water.png
assets/sprites/kiln\soldier_haetae_fire.png.import
assets/sprites/kiln\soldier_haetae_fire.png
assets/sprites/kiln\soldier_haetae_earth.png.import
assets/sprites/kiln\soldier_haetae_earth.png
assets/sprites/kiln\soldier_general_water.png.import
assets/sprites/kiln\soldier_general_water.png
assets/sprites/kiln\soldier_general_fire.png.import
assets/sprites/kiln\soldier_general_fire.png
assets/sprites/kiln\soldier_general_earth.png.import
assets/sprites/kiln\soldier_general_earth.png
assets/sprites/kiln\soldier_dragon_water.png.import
assets/sprites/kiln\soldier_dragon_water.png
assets/sprites/kiln\soldier_dragon_fire.png.import
assets/sprites/kiln\soldier_dragon_fire.png
assets/sprites/kiln\soldier_dragon_earth.png.import
assets/sprites/kiln\soldier_dragon_earth.png
assets/sprites/kiln\soldier_cheoyong_water.png.import
assets/sprites/kiln\soldier_cheoyong_water.png
assets/sprites/kiln\soldier_cheoyong_fire.png.import
assets/sprites/kiln\soldier_cheoyong_fire.png
assets/sprites/kiln\soldier_cheoyong_earth.png.import
assets/sprites/kiln\soldier_cheoyong_earth.png
assets/sprites/kiln\soldier_cavalry_water.png.import
assets/sprites/kiln\soldier_cavalry_water.png
assets/sprites/kiln\soldier_cavalry_fire.png.import
assets/sprites/kiln\soldier_cavalry_fire.png
assets/sprites/kiln\soldier_cavalry_earth.png.import
assets/sprites/kiln\soldier_cavalry_earth.png
assets/sprites/kiln\soldier_cannon_water.png.import
assets/sprites/kiln\soldier_cannon_water.png
assets/sprites/kiln\soldier_cannon_fire.png.import
assets/sprites/kiln\soldier_cannon_fire.png
assets/sprites/kiln\soldier_cannon_earth.png.import
assets/sprites/kiln\soldier_cannon_earth.png
assets/sprites/kiln\soldier_bulgasari_water.png.import
assets/sprites/kiln\soldier_bulgasari_water.png
assets/sprites/kiln\soldier_bulgasari_fire.png.import
assets/sprites/kiln\soldier_bulgasari_fire.png
assets/sprites/kiln\soldier_bulgasari_earth.png.import
assets/sprites/kiln\soldier_bulgasari_earth.png
assets/sprites/kiln\soldier_baekho_water.png.import
assets/sprites/kiln\soldier_baekho_water.png
assets/sprites/kiln\soldier_baekho_fire.png.import
assets/sprites/kiln\soldier_baekho_fire.png
assets/sprites/kiln\soldier_baekho_earth.png.import
assets/sprites/kiln\soldier_baekho_earth.png
assets/sprites/kiln\soldier_axe_water.png.import
assets/sprites/kiln\soldier_axe_water.png
assets/sprites/kiln\soldier_axe_fire.png.import
assets/sprites/kiln\soldier_axe_fire.png
assets/sprites/kiln\soldier_axe_earth.png.import
assets/sprites/kiln\soldier_axe_earth.png
assets/sprites/kiln\soldier_archer_water.png.import
assets/sprites/kiln\soldier_archer_water.png
assets/sprites/kiln\soldier_archer_fire.png.import
assets/sprites/kiln\soldier_archer_fire.png
assets/sprites/kiln\soldier_archer_earth.png.import
assets/sprites/kiln\soldier_archer_earth.png
assets/sprites/kiln\kiln_body.png.import
assets/sprites/kiln\kiln_body.png
art/sprite_list.json:1179:      "path": "assets/sprites/ui/icon_ticket.png",
art/sprite_list.json:1184:      "group": "UI",
art/sprite_list.json:1194:      "group": "UI",
art/sprite_list.json:1204:      "group": "UI",
art/sprite_list.json:1214:      "group": "UI",
art/sprite_list.json:1224:      "group": "UI",
art/sprite_list.json:1234:      "group": "UI",
art/sprite_list.json:1244:      "group": "UI",
art/sprite_list.json:1254:      "group": "UI",
art/sprite_list.json:1264:      "group": "UI",
art/sprite_list.json:1274:      "group": "UI",
art/sprite_list.json:1284:      "group": "UI",
art/sprite_list.json:1294:      "group": "UI",
art/sprite_list.json:1304:      "group": "UI",
art/sprite_list.json:1314:      "group": "UI",
art/sprite_list.json:1319:      "path": "assets/sprites/ui/panel_9.png",
art/sprite_list.json:1324:      "group": "UI",
art/sprite_list.json:1334:      "group": "UI",
art/sprite_list.json:1344:      "group": "UI",
art/sprite_list.json:1354:      "group": "UI",
art/sprite_list.json:1364:      "group": "UI",
art/sprite_list.json:1374:      "group": "UI",
art/sprite_list.json:1384:      "group": "UI",
art/sprite_list.json:1389:      "path": "assets/sprites/ui/merchant.png",
art/sprite_list.json:1394:      "group": "UI",
docs/그림-목록.md:61:### UI (22장, 지시서 `work/2026-11-30-UI그림/handoff-08.md`)
docs/그림-목록.md:66:| `ui/panel_9.png` · `panel_corner.png` | 48×48 · 14×14 | 창 9조각 (모서리 8px) · 모서리 장석 장식 |
docs/그림-목록.md:68:| `ui/merchant.png` | 48×64 | 진주 상점 보부상 |

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Get-Content -Encoding UTF8 C:/Users/pc/.codex/skills/.system/imagegen/SKILL.md | Select-Object -Skip 100 -First 65' in C:\Users\pc\Documents\game
 succeeded in 364ms:
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
- photorealistic-natural — candid/editorial lifestyle scenes with real texture and natural lighting.
- product-mockup — product/packaging shots, catalog imagery, merch concepts.
- ui-mockup — app/web interface mockups and wireframes; specify the desired fidelity.
- infographic-diagram — diagrams/infographics with structured layout and text.
- scientific-educational — classroom explainers, scientific diagrams, and learning visuals with required labels and accuracy constraints.
- ads-marketing — campaign concepts and ad creatives with audience, brand position, scene, and exact tagline/copy.
- productivity-visual — slide, chart, workflow, and data-heavy business visuals.
- logo-brand — logo/mark exploration, vector-friendly.
- illustration-story — comics, children’s book art, narrative scenes.
- stylized-concept — style-driven concept art, 3D/stylized renders.
- historical-scene — period-accurate/world-knowledge scenes.

Edit:
- text-localization — translate/replace in-image text, preserve layout.
- identity-preserve — try-on, person-in-scene; lock face/body/pose.
- precise-object-edit — remove/replace a specific element (including interior swaps).
- lighting-weather — time-of-day/season/atmosphere changes only.
- background-extraction — transparent background / clean cutout. Ask built-in `image_gen` for actual transparency.

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Get-Content -Encoding UTF8 art/references/README.md; Get-Content -Encoding UTF8 docs/그림-목록.md | Select-Object -Skip 60 -First 12; Get-Content -Encoding UTF8 art/sprite_list.json | Select-Object -Skip 1176 -First 225; Get-Content -Encoding UTF8 work/2026-11-30-UI그림/handoff-08.report.md' in C:\Users\pc\Documents\game

codex
참고 화면에서 옻칠 바탕·가는 금속 테두리와 병사 인형의 회색 얼굴·작은 광택을 확인했습니다. 9조각은 늘어나는 부분을 단색으로 정리하고, 아이콘은 12~13px 안에서 형태가 구분되도록 맞추겠습니다. 범위 제한에 따라 작업 메모 파일도 추가하지 않겠습니다.

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Get-Command node,magick -ErrorAction SilentlyContinue | Select-Object Name,Source' in C:\Users\pc\Documents\game
 exited 1 in 2228ms:

Name     Source                          
----     ------                          
node.exe C:\Program Files\nodejs\node.exe



mcp: node_repl/js started
mcp: node_repl/js (failed)
codex
뽑기권·흙·진주·파편·불씨 원본이 생성됐습니다. 원본에 있는 미세한 색 변화는 후처리에서 지정 색으로 통일하고, 작은 크기에서 외곽선이 끊기는 부분을 정리하겠습니다.

mcp: node_repl/js started
mcp: node_repl/js (completed)
mcp: node_repl/js started
mcp: node_repl/js (completed)
mcp: node_repl/js started
mcp: node_repl/js (completed)
codex
첫 묶음을 축소해 보니 파편과 불씨가 어두운 바탕에서 약하게 보입니다. 지정 팔레트 안에서 형태를 구분하는 밝은 면을 보강하겠습니다. 버튼·카드·제목 판은 게임의 색 입히기를 고려해 무채색 테두리로 제작 중입니다.

context compacted
mcp: node_repl/js started
mcp: node_repl/js (completed)
codex
아이콘 14종을 실제 크기로 확인했습니다. 축소하면서 칼날이 가늘어지고 책 표지에 생성 이미지의 빈 부분이 남아, 해당 픽셀을 보정하고 있습니다. 상인은 생성됐으며, 이제 48×64로 줄여 얼굴과 진주가 읽히는지 확인합니다.

mcp: node_repl/js started
mcp: node_repl/js (completed)
mcp: node_repl/js started
mcp: node_repl/js (completed)
mcp: node_repl/js started
mcp: node_repl/js (completed)
codex
22종의 형태와 색을 정리했습니다. 창·버튼·카드의 늘어나는 구간은 단색으로 맞췄고, 지금은 가로·세로로 늘린 미리보기와 투명도·색 수를 확인하고 있습니다. 저장은 지시서의 PNG 22개로 제한합니다.

mcp: node_repl/js started
mcp: node_repl/js (completed)
mcp: node_repl/js started
mcp: node_repl/js (completed)
mcp: node_repl/js started
mcp: node_repl/js (completed)
mcp: node_repl/js started
mcp: node_repl/js (completed)
codex
PNG 22개를 저장했고, 다시 읽은 픽셀도 저장 전과 일치했습니다. 자체 확인에서 크기·지정 팔레트·색 수 제한·이진 투명도·9조각 늘림 조건을 통과했습니다. 저장소 검사와 실제 게임 화면 확인은 지시서대로 Claude의 후속 확인으로 남겨 둡니다.

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'git status --porcelain --untracked-files=all -- assets/sprites/ui' in C:\Users\pc\Documents\game
 succeeded in 111ms:
?? assets/sprites/ui/button_9.png
?? assets/sprites/ui/button_primary_9.png
?? assets/sprites/ui/card_9.png
?? assets/sprites/ui/chip_9.png
?? assets/sprites/ui/icon_armor.png
?? assets/sprites/ui/icon_bell.png
?? assets/sprites/ui/icon_blade.png
?? assets/sprites/ui/icon_charm.png
?? assets/sprites/ui/icon_clay.png
?? assets/sprites/ui/icon_ember.png
?? assets/sprites/ui/icon_fire.png
?? assets/sprites/ui/icon_gourd.png
?? assets/sprites/ui/icon_pearl.png
?? assets/sprites/ui/icon_scale.png
?? assets/sprites/ui/icon_scroll.png
?? assets/sprites/ui/icon_shard.png
?? assets/sprites/ui/icon_ticket.png
?? assets/sprites/ui/icon_whetstone.png
?? assets/sprites/ui/merchant.png
?? assets/sprites/ui/panel_9.png
?? assets/sprites/ui/panel_corner.png
?? assets/sprites/ui/title_plate_9.png

codex
결과: 통과

바뀐 파일: [assets/sprites/ui/](C:/Users/pc/Documents/game/assets/sprites/ui/) 아래 새 PNG 22장

- `icon_ticket.png` — 뽑기권
- `icon_clay.png` — 흙덩이
- `icon_pearl.png` — 진주
- `icon_shard.png` — 요변 파편
- `icon_ember.png` — 불씨
- `icon_fire.png` — 불꽃
- `icon_blade.png` — 환도
- `icon_armor.png` — 비늘 갑옷
- `icon_charm.png` — 부적
- `icon_gourd.png` — 호리병
- `icon_whetstone.png` — 숫돌
- `icon_scale.png` — 쇠비늘
- `icon_scroll.png` — 비급서
- `icon_bell.png` — 신령 방울
- `panel_9.png` — 옻칠 패널
- `panel_corner.png` — 금박 모서리 장식
- `button_9.png` — 무채색 버튼
- `button_primary_9.png` — 금박 주 버튼
- `card_9.png` — 병사 카드 틀
- `title_plate_9.png` — 제목 판
- `chip_9.png` — 자원 표시 홈
- `merchant.png` — 도자기 보부상

직접 확인한 것:

- 아이콘 1배·4배, 상인 확대, 9조각 늘림 미리보기 확인.
- 22장 모두 크기·팔레트·색 수 제한 충족. 반투명 픽셀·분리된 외톨이 점 없음.
- 9조각 가운데 단색, 변의 늘림 방향 색상 일정.
- 저장 후 22장 재읽기 일치.

그리는 데 쓴 방법:

- **이미지 생성 + JavaScript 다듬기.** 최근접 축소, 지정 팔레트 강제 변환, 투명도 정리, 형태·클러스터 보정, 9조각 구간 정리.

못 한 것 / 걱정되는 것:

- Claude.ai 아티팩트 원본은 확인하지 못했습니다.
- 저장소 Python 검사·실제 게임 화면·검토자 2명 평가는 Claude의 후속 확인으로 남았습니다.
- 코드 수정·커밋·푸시는 하지 않았습니다.

자체 규격 검사는 통과했으며, 재미·미술 판단은 사용자 몫입니다.
tokens used
129,203
결과: 통과

바뀐 파일: [assets/sprites/ui/](C:/Users/pc/Documents/game/assets/sprites/ui/) 아래 새 PNG 22장

- `icon_ticket.png` — 뽑기권
- `icon_clay.png` — 흙덩이
- `icon_pearl.png` — 진주
- `icon_shard.png` — 요변 파편
- `icon_ember.png` — 불씨
- `icon_fire.png` — 불꽃
- `icon_blade.png` — 환도
- `icon_armor.png` — 비늘 갑옷
- `icon_charm.png` — 부적
- `icon_gourd.png` — 호리병
- `icon_whetstone.png` — 숫돌
- `icon_scale.png` — 쇠비늘
- `icon_scroll.png` — 비급서
- `icon_bell.png` — 신령 방울
- `panel_9.png` — 옻칠 패널
- `panel_corner.png` — 금박 모서리 장식
- `button_9.png` — 무채색 버튼
- `button_primary_9.png` — 금박 주 버튼
- `card_9.png` — 병사 카드 틀
- `title_plate_9.png` — 제목 판
- `chip_9.png` — 자원 표시 홈
- `merchant.png` — 도자기 보부상

직접 확인한 것:

- 아이콘 1배·4배, 상인 확대, 9조각 늘림 미리보기 확인.
- 22장 모두 크기·팔레트·색 수 제한 충족. 반투명 픽셀·분리된 외톨이 점 없음.
- 9조각 가운데 단색, 변의 늘림 방향 색상 일정.
- 저장 후 22장 재읽기 일치.

그리는 데 쓴 방법:

- **이미지 생성 + JavaScript 다듬기.** 최근접 축소, 지정 팔레트 강제 변환, 투명도 정리, 형태·클러스터 보정, 9조각 구간 정리.

못 한 것 / 걱정되는 것:

- Claude.ai 아티팩트 원본은 확인하지 못했습니다.
- 저장소 Python 검사·실제 게임 화면·검토자 2명 평가는 Claude의 후속 확인으로 남았습니다.
- 코드 수정·커밋·푸시는 하지 않았습니다.

자체 규격 검사는 통과했으며, 재미·미술 판단은 사용자 몫입니다.
