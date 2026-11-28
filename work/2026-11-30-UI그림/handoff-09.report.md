OpenAI Codex v0.172.0
--------
workdir: C:\Users\pc\Documents\game
model: gpt-6-astra
provider: openai
approval: never
sandbox: workspace-write [workdir, /tmp, $TMPDIR]
reasoning effort: high
reasoning summaries: none
session id: 01a21ff8-e260-7e03-b67f-acc4920090e2
--------
user
# Codex 작업 지시서 — 합동 기술 컷신 일러스트 3장 + 시작 화면 배경

- 날짜: 2026-11-30
- 작업 폴더: work/2026-11-30-UI그림/
- 지시서 번호: 09

## 먼저 읽을 것
1. AGENTS.md
2. art/references/ — 정한 그림체
3. `assets/sprites/kiln/soldier_*.png` — 병사 도자기 인형 (컷신 병사는 이 인형을 **크게, 일러스트로** 그린 것)
4. work/2026-11-30-UI그림/handoff-08.md 의 "AI 티 없애기" 규칙 — 여기서도 똑같이 지킨다
5. work/2026-11-30-UI그림/ref_cutin_now.png · ref_title_now.png — 지금 게임 화면 (코드로 그린 임시)

## 목표 (사용자 말 그대로)
> "합동 공격시 컷신이 등장하는데, 그냥 도트 병사들 줄만 세워놓았던데, 합동 공격 답게, 도트보다는 실제 병사들 이미지 컷이 화려하게 들어가면 좋겠어."
> "게임 시작 화면에 배경과 게임을 좀 소개하는 듯한 살짝 움직이는 게임 소개 배경이 들어가면 좋겠어."

해석(참고용): 컷신은 유약(속성)마다 1장. 합동 기술이 터지면 화면이 어두워지고 이 그림이 기울어진 넓은 칸으로 날아 들어와 천천히 확대된다 (게임이 처리). 시작 화면 배경은 정지 그림이고, 움직이는 것(병사 행군·반딧불·연기)은 게임이 위에 더한다.

## 그림체 (반드시 따른다)
- 컷신: 도트 인형을 키운 것이 아니라 **크게 그린 일러스트**. 그래도 게임과 어울리게 픽셀 느낌(선명한 가장자리, 정해진 색 수)을 유지. 병사는 '유약 바른 도자기 인형' — 매끈한 몸, 유약 반사, 받침, 얼굴은 회색 도자기
- 유약 색: 청자(물) 비취 · 진사(불) 구리빛 붉은 · 흑유(땅) 검은 갈색 + 기름 광택
- 시작 화면: 밤, 차분한 먹·남색 바탕, 강한 색은 가마 불빛과 마을 창 불빛에만
- 글자·로고 넣지 않기 (게임이 쓴다)
- handoff-08 의 "AI 티 없애기" 10가지 (팔레트·덩어리·한 방향 빛·그라데이션 절제·형태 먼저·한 벌)

## 그리는 방법 (사용자가 정한 것)
- [x] 이미지 생성 후 코드로 다듬기 (크기 맞추기·색 줄이기) — 사용자가 handoff-01 에서 정함
- 색을 표의 최대 색 수 이하로 줄이고, 외톨이 점·흐린 가장자리를 정리한다

정한 방법을 쓸 수 없으면 다른 방법으로 바꾸지 말고 `결과: 못 돌림` 으로 보고한다.

## 만들 것 (4장)

| 파일 | 크기 | 최대 색 | 내용 |
|---|---|---|---|
| `assets/sprites/fx/cutin_water.png` | 560×220 | 64 | 합동 기술 '해일' 컷신 일러스트 — 청자 유약 도자기 병사 셋이 창·활·방패를 들고 앞으로 뛰어드는 순간, 뒤로 거대한 물마루. 화면을 가로지르는 기울어진 넓은 칸에 들어간다 (게임이 살짝 기울여 확대). 병사는 도트 인형이 아니라 **크게 그린 상반신 일러스트** (도자기 질감·유약 반사·금 간 선), 역동적인 구도, 속도선 |
| `assets/sprites/fx/cutin_fire.png` | 560×220 | 64 | 합동 기술 '화염 파도' 컷신 일러스트 — 진사(구리빛 붉은) 유약 병사들이 불길을 등지고 돌격, 불티. 위와 같은 형식 |
| `assets/sprites/fx/cutin_earth.png` | 560×220 | 64 | 합동 기술 '지진' 컷신 일러스트 — 흑유(검은 갈색, 기름 광택) 병사들이 땅을 내리치고 바위가 솟구침, 흙먼지. 위와 같은 형식 |
| `assets/sprites/ui/title_bg.png` | 640×400 | 96 | 시작 화면 배경 — 달 뜬 밤, 왼쪽 초가·기와 마을의 창 불빛, 오른쪽 언덕 위 장작 가마의 불길과 연기, 멀리 산 두 겹. 아래쪽 1/3 은 비워 둔다 (게임이 그 위로 행군하는 병사·도깨비 눈빛·반딧불·제목·버튼을 그린다). 가운데 위쪽은 제목 자리라 어둡고 단순하게 |

## 고쳐도 되는 범위
- `assets/sprites/fx/cutin_water.png` (새 파일)
- `assets/sprites/fx/cutin_fire.png` (새 파일)
- `assets/sprites/fx/cutin_earth.png` (새 파일)
- `assets/sprites/ui/title_bg.png` (새 파일)

이 목록에 없는 파일은 만들거나 고치지 않는다.

## 보호 검사 결과 (Claude가 미리 확인함)
- `python3 scripts/protected.py <위 파일들>` → 걸린 파일 없음 (모두 새 파일)

## 하면 안 되는 일
- 범위 밖 파일 수정·삭제, 게임 코드 연결(이미 되어 있음), 저장소 Python 실행, git commit / push, 못 했는데 했다고 보고하기

## 끝나면 이 형식으로 보고
```
결과: 통과 | 실패 | 못 돌림
바뀐 파일:
- 경로 — 무엇을
직접 확인한 것:
그리는 데 쓴 방법:
못 한 것 / 걱정되는 것:
```

## Claude가 받은 뒤 할 일
1. `git status` · 2. `python3 scripts/check_sprites.py --group "컷신·시작 화면 일러스트" --sheet work/2026-11-30-UI그림/sheet-09.png` · 3. 스크린샷 (컷신·시작 화면) · 4. 그림 루프 채점 · 5. 테스트 · 6. 사용자 확인 뒤 커밋

warning: Codex is ignoring 1 unrecognized configuration setting. Check for typos or deprecated settings.
  user (C:\Users\pc\.codex\config.toml): `computer_use.windows.always_allowed_app_ids` is ignored.
warning: Codex is ignoring 1 unrecognized configuration setting. Check for typos or deprecated settings.
  user (C:\Users\pc\.codex\config.toml): `computer_use.windows.always_allowed_app_ids` is ignored.
codex
지정된 그림체와 기존 병사·화면을 먼저 확인하겠습니다. 이미지 생성 스킬로 네 장을 만든 뒤, 허용된 PNG 파일만 크기와 색 수를 맞춰 저장하겠습니다.

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content AGENTS.md; Get-Content 'C:/Users/pc/.codex/skills/.system/imagegen/SKILL.md'; Get-Content 'work/2026-11-30-UI그림/handoff-08.md'; Get-Content PROTECTED.txt; git status --porcelain; rg --files art/references assets/sprites/kiln work/2026-11-30-UI그림" in C:\Users\pc\Documents\game
 succeeded in 469ms:
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

吏湲? **媛留덉쓽 蹂묒궗** ?섎굹 (2026-11-30 ?ъ슜?? "寃뚯엫? 媛留?蹂묒궗留??섍퀬 ??愿??寃뚯엫? ?놁씠"). ?쒖옉?섎㈃ `src/game/kiln_scene` 泥??붾㈃?쇰줈 諛붾줈 媛꾨떎.
吏???쒗뿕??**AFTERSELF (媛??** ??蹂대쪟 (`docs/湲고쉷??md`, `src/core/`). Godot 4.7, ?꾩뿉???대젮?ㅻ낫??2D ?쎌? ?꾪듃(???32횞32).

| ?꾩튂 | ?댁슜 |
|---|---|
| `src/proto/` | 媛留덉쓽 蹂묒궗 洹쒖튃 (?붾㈃怨?臾닿?). `data.gd` ?섏튂 쨌 `battle.gd` ?꾪닾 쨌 `kiln.gd` 媛留?쨌 `kiln_run.gd` ????梨뺥꽣쨌戮묎린쨌?곸젏쨌?꾩쭅) 쨌 `meta.gd` ?꾩닠 媛뺥솕쨌湲곕줉 |
| `src/core/` | (蹂대쪟) AFTERSELF 洹쒖튃 (?붾㈃怨?臾닿?). `data.gd` ?섏튂 쨌 `world.gd` 諛??섎굹???꾪닾 쨌 `run.gd` ?????먮쫫 쨌 `habits.gd` ?듦? 湲곕줉 쨌 `echo.gd` ?댁젣????쨌 `save.gd` ???ъ씠 ???|
| `src/game/` | ?붾㈃쨌?낅젰. `kiln_scene` 紐⑤뱺 ?붾㈃ 쨌 `proto_base` 怨듯넻 ?곗텧쨌UI 遺??쨌 `pixel_art.gd` ?꾩떆 ?꾪듃 쨌 `launcher` 諛붾줈 kiln ?쇰줈 쨌 `main` (蹂대쪟) AFTERSELF. 洹쒖튃???쎌뼱??洹몃━湲곕쭔 ?쒕떎 |
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
| P1 | 寃뚯엫 ?꾨컲. 媛留덉쓽 蹂묒궗(媛留??뺣쪧쨌?뚰렪쨌?⑸룞 湲곗닠쨌戮묎린쨌梨뺥꽣쨌?ㅽ궗쨌吏꾩쁺쨌?곸젏쨌洹좏삎) `tests/test_proto.gd` `tests/test_kiln_run.gd` + AFTERSELF `tests/test_p1.gd` | `tests/test_proto.gd`, `tests/test_kiln_run.gd`, `tests/test_p1.gd` |
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
# Codex ?묒뾽 吏?쒖꽌 ??UI 洹몃┝ (?꾩씠肄?14 쨌 李승룸쾭?셋룹뭅??? 7 쨌 ?곸씤 1)

- ?좎쭨: 2026-11-30
- ?묒뾽 ?대뜑: work/2026-11-30-UI洹몃┝/
- 吏?쒖꽌 踰덊샇: 08

## 癒쇱? ?쎌쓣 寃?
1. AGENTS.md
2. art/references/ ???뺥븳 洹몃┝泥?(媛 + ?? ?쇑룸㉨??諛뷀깢, ?좎빟 ?됱? ?ъ씤??
3. `assets/sprites/kiln/soldier_*.png` ??蹂묒궗 ?꾩옄湲??명삎 (?곸씤? ???명삎怨?媛숈? 洹몃┝泥?
4. `work/2026-11-30-UI洹몃┝/ref_lobby.png`, `ref_gacha.png`, `ref_shop.png`, `ref_clear.png`, `ref_tactics.png` ??吏湲?寃뚯엫 ?붾㈃ (肄붾뱶濡?洹몃┛ ?꾩떆 UI). **???먮━???ㅼ뼱媛?洹몃┝**?대떎
5. UI ?쒖븞: claude.ai ?꾪떚?⑺듃 "媛留덉쓽 蹂묒궗 UI 媛쒗렪 ?쒖븞" ???됯낵 諛곗튂??諛⑺뼢 (?살튌 諛뷀깢 쨌 泥?룞 ?뚮몢由?쨌 湲덈컯)
6. docs/洹몃┝-紐⑸줉.md, art/sprite_list.json ??"UI" 臾띠쓬

## 紐⑺몴 (?ъ슜??留?洹몃?濡?
> "UI 洹몃┝(?꾩씠肄? ?⑤꼸 ?μ떇, ?곸씤 洹몃┝)??Codex 吏?쒖꽌濡?留뚮뱾?댁쨾. 醫 ???몃젴?섍퀬 AI媛 留뚮뱺 寃?媛숈? ?딅룄濡??ㅼ젣 ?꾨Ц ?붿옄?대꼫媛 ??寃껋쿂???먯뿰?ㅻ읇寃?留뚮뱾?댁쨾."

## AI ???놁븷湲????꾨Ц ?쎌? UI ?붿옄?대꼫泥섎읆 (諛섎뱶??吏?⑤떎)
?ъ슜?먭? 媛???좉꼍 ?곕뒗 遺遺꾩씠?? ?꾨옒??"AI媛 留뚮뱺 ??媛 ?섎뒗 ?뷀븳 ?먯씤怨?洹?諛섎?濡??섎뒗 諛⑸쾿?대떎.

1. **?붾젅?몃? 癒쇱? ?뺥븯怨?洹??됰쭔 ?대떎.** ?꾨옒 ?붾젅??諛뽰쓽 ??湲덉? (?쒖쓽 理쒕? ?????덉뿉??. 鍮꾩듂?????щ윭 媛???踰덉쭚) 湲덉?
   - 癒?`#282322` 쨌 ?살튌 ?대몺 `#120e16` `#1c1622` `#2a2236` 쨌 泥?룞 `#5a4630` `#8a6a48` `#a8862e` 쨌 湲덈컯 `#e8c35a` `#fff1c4`
   - ??`#b98a5e` `#7a5a44` 쨌 ?쒖? `#e8dcb8` `#f2e6c8` 쨌 ??`#6f6c66` `#b0b8c0` `#dfe6ee` 쨌 吏꾩궗 `#b8463a` `#7a2a24` 쨌 泥?옄 `#6b9878` `#a6c5a3` 쨌 遺?`#ff9a3c`
2. **?먯? ?먯쑝濡?李띿? 寃껋쿂??** ?섎? ?덈뒗 ?⑹뼱由??대윭?ㅽ꽣)濡쒕쭔. ?명넧???먃룻씓肉뚮┛ ?≫떚쨌?몄씠利?寃?湲덉?. 紐⑤뱺 ?먯씠 "??嫄곌린 ?덈뒗吏" ?ㅻ챸?섏뼱???쒕떎
3. **鍮쏆? ?쇱そ ????諛⑺뼢.** ?섏씠?쇱씠?몃뒗 1~2px, 洹몃┝?먮뒗 ?ㅻⅨ履??꾨옒. ?뺥깭留덈떎 鍮?諛⑺뼢???ㅻⅤ硫?AI ?곌? ?쒕떎
4. **洹몃씪?곗씠?샕룻쓲由셋룰킅??踰덉쭚 湲덉?.** ?④퀎??2~3?⑥쑝濡??딅뒗?? ?붾뜑留곸? ?꾩슂??怨녹뿉留??꾩＜ 議곌툑
5. **1諛??ш린?먯꽌 ?쏀????쒕떎.** 16횞16 ?꾩씠肄섏? ?ㅻ（?ｋ쭔 蹂닿퀬??臾댁뾿?몄? ?뚯븘???쒕떎 ???뷀뀒?쇰낫???뺥깭 癒쇱?. ?묎쾶 以꾩뿬 ?뺤씤??寃?
6. **?멸낸??** 癒뱀깋 1px. ?덉そ ?좎? 諛붽묑蹂대떎 諛앷쾶(?좏깮???멸낸??. 怨꾨떒(jaggies) ?놁씠 1-2-3 洹쒖튃?곸씤 湲곗슱湲?
7. **??踰뚮줈:** ?꾩씠肄?14媛쒕뒗 媛숈? ?ш린 ?(???12~13px ??, 媛숈? ?멸낸??援듦린, 媛숈? 鍮쎛룰컳? 梨꾨룄. ?섎굹留??硫????쒕떎
8. **9議곌컖 洹몃┝(panel쨌button쨌card쨌title_plate쨌chip):** 紐⑥꽌由щ뒗 ?뺥빐吏?px ?덉뿉???앸굹怨? **媛?대뜲? 蹂? ?⑥깋**(?섏뼱?섎룄 臾대뒳媛 ?섏뼱吏吏 ?딄쾶). 踰꾪듉쨌移대뱶쨌?쒕ぉ ?먯? **諛앹? 臾댁콈??*?쇰줈 ??寃뚯엫???곹솴留덈떎 ?됱쓣 ?낇엺??
9. **?μ떇? ?덉젣:** ?쒓뎅 ?꾪넻 ?μ꽍쨌援щ쫫臾대뒳??紐⑥꽌由ъ뿉 ?묎쾶 ?섎굹. ?뚮몢由??꾩껜瑜?臾몄뼇?쇰줈 梨꾩슦吏 ?딅뒗??
10. 湲?먃룸줈怨좊? 洹몃┝???ｌ? ?딅뒗??(寃뚯엫??湲???대떎)

## ?뺥븳 洹몃┝泥?(諛섎뱶???곕Ⅸ??
- 媛 + ???욎쓬: ?뺥깭???먮졆?섍쾶, 諛뷀깢? 癒뮤룻쓾 ?뚯깋議? 媛뺥븳 ?됱? ?ъ씤?몄뿉留?
- ?щ챸 諛곌꼍 (9議곌컖??源롮? 紐⑥꽌由?諛붽묑???щ챸), ?먮┝(?덊떚?먯씪由ъ뼱?? ?놁쓬, ?쒖쓽 ?????댄븯

## 洹몃━??諛⑸쾿 (?ъ슜?먭? ?뺥븳 寃?
- [x] ?대?吏 ?앹꽦 ??肄붾뱶濡??ㅻ벉湲?(?ш린 留욎텛湲걔룸같寃??щ챸쨌??以꾩씠湲? ???ъ슜?먭? handoff-01 ?먯꽌 ?뺥븿 (2026-11-27)
- ?? ??"AI ???놁븷湲? 洹쒖튃??留욊쾶 **?됱쓣 ?붾젅?몃줈 媛뺤젣濡?留욎텛怨? ?명넧???먯쓣 吏?곌퀬, 1諛곕줈 以꾩뿬 ?뺤씤**?섎뒗 ?ㅻ벉湲곕? 瑗?嫄곗튇??

?뺥븳 諛⑸쾿???????놁쑝硫??ㅻⅨ 諛⑸쾿?쇰줈 諛붽씀吏 留먭퀬 `寃곌낵: 紐??뚮┝` ?쇰줈 蹂닿퀬?쒕떎.

## 留뚮뱾 寃?(22??

| ?뚯씪 | ?ш린 | 理쒕? ??| ?댁슜 |
|---|---|---|---|
| `assets/sprites/ui/icon_ticket.png` | 16횞16 | 12 | ?꾩씠肄?16횞16 쨌 戮묎린沅???遺됱? ?좊? ?먮Ⅸ ?꾨윴 ?쒖? ?? 洹?곸씠 ?묓옒. 1諛??ш린?먯꽌 ?ㅻ（?ｋ쭔?쇰줈 ?뚯븘蹂?寃? ?멸낸??1px(癒뱀깋 #282322), 鍮쏆? ?쇱そ ?꾩뿉????諛⑺뼢. ?щ챸 諛곌꼍 |
| `assets/sprites/ui/icon_clay.png` | 16횞16 | 12 | ?꾩씠肄?16횞16 쨌 ?????먯쑝濡?萸됱튇 遺됱? ?숇뜦?? ?먯옄援??쒕몢 媛? 1諛??ш린?먯꽌 ?ㅻ（?ｋ쭔?쇰줈 ?뚯븘蹂?寃? ?멸낸??1px(癒뱀깋 #282322), 鍮쏆? ?쇱そ ?꾩뿉????諛⑺뼢. ?щ챸 諛곌꼍 |
| `assets/sprites/ui/icon_pearl.png` | 16횞16 | 12 | ?꾩씠肄?16횞16 쨌 吏꾩＜ ????吏꾩＜ ???? ?쇱そ ??諛섏궗愿?1px, ?꾨옒 ?고븳 洹몃┝?? 1諛??ш린?먯꽌 ?ㅻ（?ｋ쭔?쇰줈 ?뚯븘蹂?寃? ?멸낸??1px(癒뱀깋 #282322), 鍮쏆? ?쇱そ ?꾩뿉????諛⑺뼢. ?щ챸 諛곌꼍 |
| `assets/sprites/ui/icon_shard.png` | 16횞16 | 12 | ?꾩씠肄?16횞16 쨌 ?붾? ?뚰렪 ???좎빟 鍮쏆씠 ?꾨뒗 源⑥쭊 ?꾩옄湲?議곌컖 (蹂대씪쨌湲?諛섏궗). 1諛??ш린?먯꽌 ?ㅻ（?ｋ쭔?쇰줈 ?뚯븘蹂?寃? ?멸낸??1px(癒뱀깋 #282322), 鍮쏆? ?쇱そ ?꾩뿉????諛⑺뼢. ?щ챸 諛곌꼍 |
| `assets/sprites/ui/icon_ember.png` | 16횞16 | 12 | ?꾩씠肄?16횞16 쨌 遺덉뵪 ?????꾩쓽 ?묒? 遺덉뵪, 二쇳솴 ?ъ?. 1諛??ш린?먯꽌 ?ㅻ（?ｋ쭔?쇰줈 ?뚯븘蹂?寃? ?멸낸??1px(癒뱀깋 #282322), 鍮쏆? ?쇱そ ?꾩뿉????諛⑺뼢. ?щ챸 諛곌꼍 |
| `assets/sprites/ui/icon_fire.png` | 16횞16 | 12 | ?꾩씠肄?16횞16 쨌 遺??ㅼ뒪由ш린 ???꾧턿??遺덇퐙 ??媛덈옒. 1諛??ш린?먯꽌 ?ㅻ（?ｋ쭔?쇰줈 ?뚯븘蹂?寃? ?멸낸??1px(癒뱀깋 #282322), 鍮쏆? ?쇱そ ?꾩뿉????諛⑺뼢. ?щ챸 諛곌꼍 |
| `assets/sprites/ui/icon_blade.png` | 16횞16 | 12 | ?꾩씠肄?16횞16 쨌 媛뺤쿋 移쇰궇 ??鍮꾩뒪?ы븳 吏㏃? ?섎룄 ?? 湲덈튆 肄붾벑?? 1諛??ш린?먯꽌 ?ㅻ（?ｋ쭔?쇰줈 ?뚯븘蹂?寃? ?멸낸??1px(癒뱀깋 #282322), 鍮쏆? ?쇱そ ?꾩뿉????諛⑺뼢. ?щ챸 諛곌꼍 |
| `assets/sprites/ui/icon_armor.png` | 16횞16 | 12 | ?꾩씠肄?16횞16 쨌 ?먯꽍由곌컩 ????鍮꾨뒛 媛묒샆 ?욏뙋 (鍮꾨뒛 3以?. 1諛??ш린?먯꽌 ?ㅻ（?ｋ쭔?쇰줈 ?뚯븘蹂?寃? ?멸낸??1px(癒뱀깋 #282322), 鍮쏆? ?쇱そ ?꾩뿉????諛⑺뼢. ?щ챸 諛곌꼍 |
| `assets/sprites/ui/icon_charm.png` | 16횞16 | 12 | ?꾩씠肄?16횞16 쨌 ?좎냽 遺?????몃? ?쒖???遺됱? 寃쎈㈃二쇱궗 湲??(湲???????紐⑥뼇留?. 1諛??ш린?먯꽌 ?ㅻ（?ｋ쭔?쇰줈 ?뚯븘蹂?寃? ?멸낸??1px(癒뱀깋 #282322), 鍮쏆? ?쇱そ ?꾩뿉????諛⑺뼢. ?щ챸 諛곌꼍 |
| `assets/sprites/ui/icon_gourd.png` | 16횞16 | 12 | ?꾩씠肄?16횞16 쨌 ???몃━蹂???遺됱? ??留??몃━蹂? 1諛??ш린?먯꽌 ?ㅻ（?ｋ쭔?쇰줈 ?뚯븘蹂?寃? ?멸낸??1px(癒뱀깋 #282322), 鍮쏆? ?쇱そ ?꾩뿉????諛⑺뼢. ?щ챸 諛곌꼍 |
| `assets/sprites/ui/icon_whetstone.png` | 16횞16 | 12 | ?꾩씠肄?16횞16 쨌 ?ル룎 ???뚯깋 ?ル룎 ??臾쇨린 ??以? 1諛??ш린?먯꽌 ?ㅻ（?ｋ쭔?쇰줈 ?뚯븘蹂?寃? ?멸낸??1px(癒뱀깋 #282322), 鍮쏆? ?쇱そ ?꾩뿉????諛⑺뼢. ?щ챸 諛곌꼍 |
| `assets/sprites/ui/icon_scale.png` | 16횞16 | 12 | ?꾩씠肄?16횞16 쨌 ?좊퉬????寃뱀튇 ??鍮꾨뒛 ???? 1諛??ш린?먯꽌 ?ㅻ（?ｋ쭔?쇰줈 ?뚯븘蹂?寃? ?멸낸??1px(癒뱀깋 #282322), 鍮쏆? ?쇱そ ?꾩뿉????諛⑺뼢. ?щ챸 諛곌꼍 |
| `assets/sprites/ui/icon_scroll.png` | 16횞16 | 12 | ?꾩씠肄?16횞16 쨌 鍮꾧툒?????ㅻ줈 臾띠? ?≪? 梨?(?쒖? ??. 1諛??ш린?먯꽌 ?ㅻ（?ｋ쭔?쇰줈 ?뚯븘蹂?寃? ?멸낸??1px(癒뱀깋 #282322), 鍮쏆? ?쇱そ ?꾩뿉????諛⑺뼢. ?щ챸 諛곌꼍 |
| `assets/sprites/ui/icon_bell.png` | 16횞16 | 12 | ?꾩씠肄?16횞16 쨌 ?좊졊 諛⑹슱 ??臾대떦 諛⑹슱 ?뗭씠 ?щ┛ ?먯옟?? 1諛??ш린?먯꽌 ?ㅻ（?ｋ쭔?쇰줈 ?뚯븘蹂?寃? ?멸낸??1px(癒뱀깋 #282322), 鍮쏆? ?쇱そ ?꾩뿉????諛⑺뼢. ?щ챸 諛곌꼍 |
| `assets/sprites/ui/panel_9.png` | 48횞48 | 16 | 李??⑤꼸) 9議곌컖 洹몃┝ ??紐⑥꽌由?8px ? 洹몃?濡? 媛?대뜲쨌蹂? 寃뚯엫???섎┛?? ?살튌??寃遺됱? ?섎Т??#1c1622 怨꾩뿴) + 諛붽묑 泥?룞 ?뚮몢由?2px + ?덉そ 媛????1px. 媛?대뜲(?섏뼱?섎뒗 遺遺????⑥깋 ?먮뒗 ?꾩＜ ?쏀븳 寃??섎굹留?(?섏뿬???댁긽?섏? ?딄쾶). 紐⑥꽌由?1~2px 源롪린 |
| `assets/sprites/ui/panel_corner.png` | 14횞14 | 10 | 李?紐⑥꽌由??μ떇 (?쇱そ ?????? 寃뚯엫???ㅼ쭛????紐⑥꽌由ъ뿉) ??諛섎떕???μ꽍 媛숈? 湲덈컯 ???μ떇, ?깆옄 紐⑥뼇???묒? 援щ쫫臾대뒳 ?섎굹. ?щ챸 諛곌꼍 |
| `assets/sprites/ui/button_9.png` | 24횞24 | 12 | 踰꾪듉 9議곌컖 (紐⑥꽌由?6px). **諛앹? 臾댁콈??泥?룞** (寃뚯엫??踰꾪듉留덈떎 ?됱쓣 ?낇엺??. ?꾩そ 1px ?섏씠?쇱씠?? ?꾨옒 2px ?먭퍡媛? 紐⑥꽌由?源롪린. 媛?대뜲???⑥깋 |
| `assets/sprites/ui/button_primary_9.png` | 24횞24 | 12 | 二?踰꾪듉 9議곌컖 (紐⑥꽌由?6px) ??湲덈컯 移?(#e8c35a 怨꾩뿴), ???섏씠?쇱씠?맞룹븘???먭퍡媛? 媛?대뜲???⑥깋 (湲?먭? 洹??꾩뿉 癒뱀깋?쇰줈 ?щ씪媛꾨떎) |
| `assets/sprites/ui/card_9.png` | 24횞24 | 12 | 蹂묒궗 移대뱶 ? 9議곌컖 (紐⑥꽌由?6px) ??**諛앹? 臾댁콈??* (寃뚯엫???깃툒 ?됱쓣 ?낇엺??, ?덉そ? ?대몢??諛뷀깢, ?꾨옒履??대쫫 ???먮━媛 ?댁쭩 ???대몼寃? 媛?대뜲 ?⑥깋 |
| `assets/sprites/ui/title_plate_9.png` | 20횞14 | 8 | 李??쒕ぉ ??9議곌컖 (紐⑥꽌由?5px) ???묒? ?꾪뙋 紐⑥뼇, 諛앹? 臾댁콈???뚮몢由?(寃뚯엫???됱쓣 ?낇엺??, ?덉? ?대몢???살튌 |
| `assets/sprites/ui/chip_9.png` | 16횞16 | 8 | ?먯썝 ?뚯빟 9議곌컖 (紐⑥꽌由?6px) ???덉쑝濡??뚯씤 ?대몢???? 泥?룞 ?뚮몢由?1px |
| `assets/sprites/ui/merchant.png` | 48횞64 | 24 | 吏꾩＜ ?곸젏 ?곸씤 (媛?????뺣룄, ?ㅻⅨ履쎌쓣 遊? ??吏寃뚯뿉 蹂대뵲由щ? 吏?蹂대????꾩옄湲??명삎, ?⑤옲??紐⑥옄??紐⑺솕 ?≪씠, ?먯뿉 吏꾩＜ ???? 遺?쒕읇寃??껊뒗 ?쇨뎬. 蹂묒궗 ?꾩옄湲??명삎怨?媛숈? 洹몃┝泥?(?쇨뎬 ?뚯깋, ??愿묓깮), ?룹? ?숇튆쨌履쎈튆. ?щ챸 諛곌꼍 |

## 怨좎퀜???섎뒗 踰붿쐞
- `assets/sprites/ui/icon_ticket.png` (???뚯씪)
- `assets/sprites/ui/icon_clay.png` (???뚯씪)
- `assets/sprites/ui/icon_pearl.png` (???뚯씪)
- `assets/sprites/ui/icon_shard.png` (???뚯씪)
- `assets/sprites/ui/icon_ember.png` (???뚯씪)
- `assets/sprites/ui/icon_fire.png` (???뚯씪)
- `assets/sprites/ui/icon_blade.png` (???뚯씪)
- `assets/sprites/ui/icon_armor.png` (???뚯씪)
- `assets/sprites/ui/icon_charm.png` (???뚯씪)
- `assets/sprites/ui/icon_gourd.png` (???뚯씪)
- `assets/sprites/ui/icon_whetstone.png` (???뚯씪)
- `assets/sprites/ui/icon_scale.png` (???뚯씪)
- `assets/sprites/ui/icon_scroll.png` (???뚯씪)
- `assets/sprites/ui/icon_bell.png` (???뚯씪)
- `assets/sprites/ui/panel_9.png` (???뚯씪)
- `assets/sprites/ui/panel_corner.png` (???뚯씪)
- `assets/sprites/ui/button_9.png` (???뚯씪)
- `assets/sprites/ui/button_primary_9.png` (???뚯씪)
- `assets/sprites/ui/card_9.png` (???뚯씪)
- `assets/sprites/ui/title_plate_9.png` (???뚯씪)
- `assets/sprites/ui/chip_9.png` (???뚯씪)
- `assets/sprites/ui/merchant.png` (???뚯씪)

??紐⑸줉???녿뒗 ?뚯씪? 留뚮뱾嫄곕굹 怨좎튂吏 ?딅뒗??

## 蹂댄샇 寃??寃곌낵 (Claude媛 誘몃━ ?뺤씤??
- `python3 scripts/protected.py <???뚯씪??` ??嫄몃┛ ?뚯씪 ?놁쓬 (紐⑤몢 ???뚯씪)
- ??寃?щ뒗 Claude媛 ?덈떎. Codex???ㅼ떆 ?뚮━吏 ?딅뒗??

## ?섎㈃ ???섎뒗 ??
- 踰붿쐞 諛??뚯씪 ?섏젙쨌??젣 (?뱁엳 `src/`, `tests/`, `art/references/`, `art/rubric.md`, ?대? ?덈뒗 `assets/sprites/`)
- 寃뚯엫 肄붾뱶??洹몃┝???곌껐?섎뒗 ?묒뾽 (?대? ?섏뼱 ?덈떎: ?뚯씪???덉쑝硫?肄붾뱶 洹몃┝ ????대떎)
- ??μ냼??Python ?ㅽ겕由쏀듃 ?ㅽ뻾 (寃?щ뒗 Claude媛 ?묒뾽 ?꾩뿉 ?쒕떎)
- git commit / push
- 紐??덈뒗???덈떎怨?蹂닿퀬?섍린

## ?앸굹硫????뺤떇?쇰줈 蹂닿퀬
```
寃곌낵: ?듦낵 | ?ㅽ뙣 | 紐??뚮┝   ????以??섎굹留?
諛붾??뚯씪:
- 寃쎈줈 ??臾댁뾿??
吏곸젒 ?뺤씤??寃?
- ?? 1諛걔?諛곕줈 以꾩뿬 蹂닿퀬 ?ㅻ（???뺤씤, ?붾젅??諛????놁쓬, 9議곌컖 媛?대뜲 ?⑥깋
洹몃━??????諛⑸쾿:
- ?대?吏 ?앹꽦 / 肄붾뱶 / ????(臾댁뾿???대뼸寃? ?붾젅??留욎텛湲곕? ?대뼸寃??덈뒗吏)
紐???寃?/ 嫄깆젙?섎뒗 寃?
- ??
```
- ??μ냼??Python 寃?щ? 紐??뚮┛ 寃껊쭔?쇰줈??`紐??뚮┝`???꾨땲?? 寃?щ뒗 Claude媛 ?쒕떎.

## Claude媛 諛쏆? ??????
1. `git status` ??諛붾??뚯씪????踰붿쐞肉먯씤吏
2. `python3 scripts/check_sprites.py --group "UI" --sheet work/2026-11-30-UI洹몃┝/sheet-08.png` ???ш린쨌?щ챸 諛곌꼍쨌???샕룻쓲由?媛?μ옄由?
3. 寃뚯엫 ?붾㈃ ?ㅽ겕由곗꺑 (`tests/screens_proto.gd`): 濡쒕퉬쨌戮묎린쨌?곸젏쨌?대━??李승룹쟾??媛뺥솕?먯꽌 吏곸젒 蹂몃떎 (9議곌컖???섏뼱????源⑥?吏 ?딅뒗吏)
4. **洹몃┝ 猷⑦봽** (`.claude/skills/art-loop/SKILL.md`): 泥섏쓬 蹂대뒗 寃?좎옄 2紐낆씠 `art/rubric.md` 濡?"AI ??쨌"洹몃┝泥??댁슱由? 梨꾩젏 ????쑝硫??ㅼ떆 吏??
5. `python3 scripts/test.py --stage all`
6. ?ъ슜?먯뿉寃?蹂댁뿬 二쇨퀬 "寃?щ뒗 ?듦낵, 誘몄닠 ?먮떒? ?ъ슜??紐? ???덈씫??諛쏆? ??而ㅻ컠
# ?ъ슜?먭? 吏곸젒 怨좎튇 ?뚯씪 / ??뼱?곕㈃ ???섎뒗 ?뚯씪 (??以꾩뿉 ?섎굹, glob 媛??
# Claude쨌Codex???ш린 ?곹엺 ?뚯씪????뼱?곗? ?딅뒗?? 怨좎퀜???섎㈃ 諛붽? ?댁슜???쒖븞留??쒕떎.
art/references/*
art/rubric.md
 M reports/boss/history.csv
 M "work/2026-11-27-\352\267\270\353\246\274/NOTES.md"
 M "work/2026-11-27-\352\267\270\353\246\274/handoff-03.md"
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
?? "work/2026-11-30-UI\352\267\270\353\246\274/handoff-09.report.md"
?? "work/2026-11-30-UI\352\267\270\353\246\274/screens-08/"
?? "work/2026-11-30-UI\352\267\270\353\246\274/sheet-08.png"
?? work/art-ui08/
assets/sprites/kiln\soldier_spear_water.png.import
assets/sprites/kiln\soldier_spear_water.png
assets/sprites/kiln\soldier_spear_fire.png.import
assets/sprites/kiln\soldier_spear_fire.png
assets/sprites/kiln\soldier_spear_earth.png.import
assets/sprites/kiln\soldier_spear_earth.png
assets/sprites/kiln\soldier_shield_water.png.import
assets/sprites/kiln\soldier_shield_water.png
assets/sprites/kiln\soldier_shield_fire.png.import
assets/sprites/kiln\soldier_shield_fire.png
assets/sprites/kiln\soldier_shield_earth.png.import
assets/sprites/kiln\soldier_shield_earth.png
assets/sprites/kiln\soldier_archer_water.png.import
assets/sprites/kiln\soldier_archer_water.png
assets/sprites/kiln\soldier_archer_fire.png.import
assets/sprites/kiln\soldier_archer_fire.png
assets/sprites/kiln\soldier_archer_earth.png.import
assets/sprites/kiln\soldier_archer_earth.png
assets/sprites/kiln\kiln_body.png.import
assets/sprites/kiln\kiln_body.png
art/references\soldier_spear_fire.png
art/references\soldier_shield_earth.png
art/references\soldier_archer_water.png
art/references\sheet.png
art/references\README.md
art/references\house.png
art/references\goblin.png
art/references\creature_shield_water.png
work/2026-11-30-UI그림\sheet-08.png
work/2026-11-30-UI그림\screens-08\p12_nest_battle.png
work/2026-11-30-UI그림\screens-08\p11_nest_night.png
work/2026-11-30-UI그림\screens-08\p10_nest_burst.png
work/2026-11-30-UI그림\screens-08\p09_nest_hatch.png
work/2026-11-30-UI그림\screens-08\p08_nest_egg.png
work/2026-11-30-UI그림\screens-08\p07_kiln_night_end.png
work/2026-11-30-UI그림\screens-08\p07f_kiln_loot.png
work/2026-11-30-UI그림\screens-08\p07e_kiln_king.png
work/2026-11-30-UI그림\screens-08\p07e2_kiln_end_anim.png
work/2026-11-30-UI그림\screens-08\p07d_kiln_gumiho.png
work/2026-11-30-UI그림\screens-08\p07c_kiln_chapter_clear.png
work/2026-11-30-UI그림\screens-08\p07b_kiln_chief.png
work/2026-11-30-UI그림\screens-08\p06_kiln_battle_mid.png
work/2026-11-30-UI그림\screens-08\p06d_kiln_cutin.png
work/2026-11-30-UI그림\screens-08\p06c_kiln_battle_busy.png
work/2026-11-30-UI그림\screens-08\p06b_kiln_synergy_wave.png
work/2026-11-30-UI그림\screens-08\p05_kiln_prep_night2.png
work/2026-11-30-UI그림\screens-08\p05h_kiln_deploy.png
work/2026-11-30-UI그림\screens-08\p05g_kiln_promo.png
work/2026-11-30-UI그림\screens-08\p05f_kiln_shop.png
work/2026-11-30-UI그림\screens-08\p05e_kiln_equip.png
work/2026-11-30-UI그림\screens-08\p05d_kiln_help.png
work/2026-11-30-UI그림\screens-08\p05c_kiln_prep_chapter2.png
work/2026-11-30-UI그림\screens-08\p04_kiln_reveal_done.png
work/2026-11-30-UI그림\screens-08\p03_kiln_reveal_legend.png
work/2026-11-30-UI그림\screens-08\p03b_kiln_gacha_show.png
work/2026-11-30-UI그림\screens-08\p03a_kiln_gacha_tap.png
work/2026-11-30-UI그림\screens-08\p02_kiln_fire.png
work/2026-11-30-UI그림\screens-08\p02b_kiln_fire_hot.png
work/2026-11-30-UI그림\screens-08\p01_kiln_prep_first.png
work/2026-11-30-UI그림\screens-08\p01b_kiln_gacha.png
work/2026-11-30-UI그림\screens-08\p01a_kiln_tutorial_draw.png
work/2026-11-30-UI그림\screens-08\p00_launcher.png
work/2026-11-30-UI그림\screens-08\p00d_kiln_records.png
work/2026-11-30-UI그림\screens-08\p00c_kiln_meta.png
work/2026-11-30-UI그림\screens-08\p00b_kiln_title.png
work/2026-11-30-UI그림\ref_title_now.png
work/2026-11-30-UI그림\ref_tactics.png
work/2026-11-30-UI그림\ref_shop.png
work/2026-11-30-UI그림\ref_lobby.png
work/2026-11-30-UI그림\ref_gacha.png
work/2026-11-30-UI그림\ref_cutin_now.png
work/2026-11-30-UI그림\ref_clear.png
work/2026-11-30-UI그림\NOTES.md
work/2026-11-30-UI그림\handoff-09.report.md
work/2026-11-30-UI그림\handoff-09.md
work/2026-11-30-UI그림\handoff-08.report.md
work/2026-11-30-UI그림\handoff-08.md

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -Encoding UTF8 'C:/Users/pc/.codex/skills/.system/imagegen/SKILL.md' | Select-Object -Skip 115; Get-Content -Encoding UTF8 AGENTS.md | Select-Object -First 35" in C:\Users\pc\Documents\game
 succeeded in 0ms:

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
- style-transfer — apply reference style while changing subject/scene.
- compositing — multi-image insert/merge with matched lighting/perspective.
- sketch-to-render — drawing/line art to photoreal render.

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

지금: **가마의 병사** 하나 (2026-11-30 사용자: "게임은 가마 병사만 하고 알 관련 게임은 없이"). 시작하면 `src/game/kiln_scene` 첫 화면으로 바로 간다.

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -Encoding UTF8 'work/2026-11-30-UI그림/handoff-08.md'; Get-Content -Encoding UTF8 PROTECTED.txt; git status --porcelain; rg --files art/references; Get-ChildItem assets/sprites/kiln/soldier_*.png | Select-Object -ExpandProperty Name; Get-Command magick,node -ErrorAction SilentlyContinue | Select-Object Name,Source" in C:\Users\pc\Documents\game
 exited 1 in 2418ms:
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
# 사용자가 직접 고친 파일 / 덮어쓰면 안 되는 파일 (한 줄에 하나, glob 가능)
# Claude·Codex는 여기 적힌 파일을 덮어쓰지 않는다. 고쳐야 하면 바꿀 내용을 제안만 한다.
art/references/*
art/rubric.md
 M reports/boss/history.csv
 M "work/2026-11-27-\352\267\270\353\246\274/NOTES.md"
 M "work/2026-11-27-\352\267\270\353\246\274/handoff-03.md"
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
?? "work/2026-11-30-UI\352\267\270\353\246\274/handoff-09.report.md"
?? "work/2026-11-30-UI\352\267\270\353\246\274/screens-08/"
?? "work/2026-11-30-UI\352\267\270\353\246\274/sheet-08.png"
?? work/art-ui08/
art/references\soldier_spear_fire.png
art/references\soldier_shield_earth.png
art/references\soldier_archer_water.png
art/references\sheet.png
art/references\README.md
art/references\house.png
art/references\goblin.png
art/references\creature_shield_water.png
soldier_archer_earth.png
soldier_archer_fire.png
soldier_archer_water.png
soldier_shield_earth.png
soldier_shield_fire.png
soldier_shield_water.png
soldier_spear_earth.png
soldier_spear_fire.png
soldier_spear_water.png

Name     Source                          
----     ------                          
node.exe C:\Program Files\nodejs\node.exe



exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -Encoding UTF8 art/references/README.md; Get-Item assets/sprites/fx/cutin_water.png,assets/sprites/fx/cutin_fire.png,assets/sprites/fx/cutin_earth.png,assets/sprites/ui/title_bg.png -ErrorAction SilentlyContinue | Select-Object FullName,Length; Get-Content -Encoding UTF8 'work/2026-11-30-UI그림/handoff-09.report.md'" in C:\Users\pc\Documents\game
 succeeded in 561ms:
# 기준 그림

우리 그림체를 대표하는 그림을 이 폴더에 넣어 주세요 (png/jpg, 3~8장 권장).
검토자는 이 그림들과 `art/rubric.md`만 보고 채점합니다.
OpenAI Codex v0.172.0
--------
workdir: C:\Users\pc\Documents\game
model: gpt-6-astra
provider: openai
approval: never
sandbox: workspace-write [workdir, /tmp, $TMPDIR]
reasoning effort: high
reasoning summaries: none
session id: 01a21ff8-e260-7e03-b67f-acc4920090e2
--------
user
# Codex 작업 지시서 — 합동 기술 컷신 일러스트 3장 + 시작 화면 배경

- 날짜: 2026-11-30
- 작업 폴더: work/2026-11-30-UI그림/
- 지시서 번호: 09

## 먼저 읽을 것
1. AGENTS.md
2. art/references/ — 정한 그림체
3. `assets/sprites/kiln/soldier_*.png` — 병사 도자기 인형 (컷신 병사는 이 인형을 **크게, 일러스트로** 그린 것)
4. work/2026-11-30-UI그림/handoff-08.md 의 "AI 티 없애기" 규칙 — 여기서도 똑같이 지킨다
5. work/2026-11-30-UI그림/ref_cutin_now.png · ref_title_now.png — 지금 게임 화면 (코드로 그린 임시)

## 목표 (사용자 말 그대로)
> "합동 공격시 컷신이 등장하는데, 그냥 도트 병사들 줄만 세워놓았던데, 합동 공격 답게, 도트보다는 실제 병사들 이미지 컷이 화려하게 들어가면 좋겠어."
> "게임 시작 화면에 배경과 게임을 좀 소개하는 듯한 살짝 움직이는 게임 소개 배경이 들어가면 좋겠어."

해석(참고용): 컷신은 유약(속성)마다 1장. 합동 기술이 터지면 화면이 어두워지고 이 그림이 기울어진 넓은 칸으로 날아 들어와 천천히 확대된다 (게임이 처리). 시작 화면 배경은 정지 그림이고, 움직이는 것(병사 행군·반딧불·연기)은 게임이 위에 더한다.

## 그림체 (반드시 따른다)
- 컷신: 도트 인형을 키운 것이 아니라 **크게 그린 일러스트**. 그래도 게임과 어울리게 픽셀 느낌(선명한 가장자리, 정해진 색 수)을 유지. 병사는 '유약 바른 도자기 인형' — 매끈한 몸, 유약 반사, 받침, 얼굴은 회색 도자기
- 유약 색: 청자(물) 비취 · 진사(불) 구리빛 붉은 · 흑유(땅) 검은 갈색 + 기름 광택
- 시작 화면: 밤, 차분한 먹·남색 바탕, 강한 색은 가마 불빛과 마을 창 불빛에만
- 글자·로고 넣지 않기 (게임이 쓴다)
- handoff-08 의 "AI 티 없애기" 10가지 (팔레트·덩어리·한 방향 빛·그라데이션 절제·형태 먼저·한 벌)

## 그리는 방법 (사용자가 정한 것)
- [x] 이미지 생성 후 코드로 다듬기 (크기 맞추기·색 줄이기) — 사용자가 handoff-01 에서 정함
- 색을 표의 최대 색 수 이하로 줄이고, 외톨이 점·흐린 가장자리를 정리한다

정한 방법을 쓸 수 없으면 다른 방법으로 바꾸지 말고 `결과: 못 돌림` 으로 보고한다.

## 만들 것 (4장)

| 파일 | 크기 | 최대 색 | 내용 |
|---|---|---|---|
| `assets/sprites/fx/cutin_water.png` | 560×220 | 64 | 합동 기술 '해일' 컷신 일러스트 — 청자 유약 도자기 병사 셋이 창·활·방패를 들고 앞으로 뛰어드는 순간, 뒤로 거대한 물마루. 화면을 가로지르는 기울어진 넓은 칸에 들어간다 (게임이 살짝 기울여 확대). 병사는 도트 인형이 아니라 **크게 그린 상반신 일러스트** (도자기 질감·유약 반사·금 간 선), 역동적인 구도, 속도선 |
| `assets/sprites/fx/cutin_fire.png` | 560×220 | 64 | 합동 기술 '화염 파도' 컷신 일러스트 — 진사(구리빛 붉은) 유약 병사들이 불길을 등지고 돌격, 불티. 위와 같은 형식 |
| `assets/sprites/fx/cutin_earth.png` | 560×220 | 64 | 합동 기술 '지진' 컷신 일러스트 — 흑유(검은 갈색, 기름 광택) 병사들이 땅을 내리치고 바위가 솟구침, 흙먼지. 위와 같은 형식 |
| `assets/sprites/ui/title_bg.png` | 640×400 | 96 | 시작 화면 배경 — 달 뜬 밤, 왼쪽 초가·기와 마을의 창 불빛, 오른쪽 언덕 위 장작 가마의 불길과 연기, 멀리 산 두 겹. 아래쪽 1/3 은 비워 둔다 (게임이 그 위로 행군하는 병사·도깨비 눈빛·반딧불·제목·버튼을 그린다). 가운데 위쪽은 제목 자리라 어둡고 단순하게 |

## 고쳐도 되는 범위
- `assets/sprites/fx/cutin_water.png` (새 파일)
- `assets/sprites/fx/cutin_fire.png` (새 파일)
- `assets/sprites/fx/cutin_earth.png` (새 파일)
- `assets/sprites/ui/title_bg.png` (새 파일)

이 목록에 없는 파일은 만들거나 고치지 않는다.

## 보호 검사 결과 (Claude가 미리 확인함)
- `python3 scripts/protected.py <위 파일들>` → 걸린 파일 없음 (모두 새 파일)

## 하면 안 되는 일
- 범위 밖 파일 수정·삭제, 게임 코드 연결(이미 되어 있음), 저장소 Python 실행, git commit / push, 못 했는데 했다고 보고하기

## 끝나면 이 형식으로 보고
```
결과: 통과 | 실패 | 못 돌림
바뀐 파일:
- 경로 — 무엇을
직접 확인한 것:
그리는 데 쓴 방법:
못 한 것 / 걱정되는 것:
```

## Claude가 받은 뒤 할 일
1. `git status` · 2. `python3 scripts/check_sprites.py --group "컷신·시작 화면 일러스트" --sheet work/2026-11-30-UI그림/sheet-09.png` · 3. 스크린샷 (컷신·시작 화면) · 4. 그림 루프 채점 · 5. 테스트 · 6. 사용자 확인 뒤 커밋

warning: Codex is ignoring 1 unrecognized configuration setting. Check for typos or deprecated settings.
  user (C:\Users\pc\.codex\config.toml): `computer_use.windows.always_allowed_app_ids` is ignored.
warning: Codex is ignoring 1 unrecognized configuration setting. Check for typos or deprecated settings.
  user (C:\Users\pc\.codex\config.toml): `computer_use.windows.always_allowed_app_ids` is ignored.
codex
지정된 그림체와 기존 병사·화면을 먼저 확인하겠습니다. 이미지 생성 스킬로 네 장을 만든 뒤, 허용된 PNG 파일만 크기와 색 수를 맞춰 저장하겠습니다.

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content AGENTS.md; Get-Content 'C:/Users/pc/.codex/skills/.system/imagegen/SKILL.md'; Get-Content 'work/2026-11-30-UI그림/handoff-08.md'; Get-Content PROTECTED.txt; git status --porcelain; rg --files art/references assets/sprites/kiln work/2026-11-30-UI그림" in C:\Users\pc\Documents\game
 succeeded in 469ms:
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

吏湲? **媛留덉쓽 蹂묒궗** ?섎굹 (2026-11-30 ?ъ슜?? "寃뚯엫? 媛留?蹂묒궗留??섍퀬 ??愿??寃뚯엫? ?놁씠"). ?쒖옉?섎㈃ `src/game/kiln_scene` 泥??붾㈃?쇰줈 諛붾줈 媛꾨떎.
吏???쒗뿕??**AFTERSELF (媛??** ??蹂대쪟 (`docs/湲고쉷??md`, `src/core/`). Godot 4.7, ?꾩뿉???대젮?ㅻ낫??2D ?쎌? ?꾪듃(???32횞32).

| ?꾩튂 | ?댁슜 |
|---|---|
| `src/proto/` | 媛留덉쓽 蹂묒궗 洹쒖튃 (?붾㈃怨?臾닿?). `data.gd` ?섏튂 쨌 `battle.gd` ?꾪닾 쨌 `kiln.gd` 媛留?쨌 `kiln_run.gd` ????梨뺥꽣쨌戮묎린쨌?곸젏쨌?꾩쭅) 쨌 `meta.gd` ?꾩닠 媛뺥솕쨌湲곕줉 |
| `src/core/` | (蹂대쪟) AFTERSELF 洹쒖튃 (?붾㈃怨?臾닿?). `data.gd` ?섏튂 쨌 `world.gd` 諛??섎굹???꾪닾 쨌 `run.gd` ?????먮쫫 쨌 `habits.gd` ?듦? 湲곕줉 쨌 `echo.gd` ?댁젣????쨌 `save.gd` ???ъ씠 ???|
| `src/game/` | ?붾㈃쨌?낅젰. `kiln_scene` 紐⑤뱺 ?붾㈃ 쨌 `proto_base` 怨듯넻 ?곗텧쨌UI 遺??쨌 `pixel_art.gd` ?꾩떆 ?꾪듃 쨌 `launcher` 諛붾줈 kiln ?쇰줈 쨌 `main` (蹂대쪟) AFTERSELF. 洹쒖튃???쎌뼱??洹몃━湲곕쭔 ?쒕떎 |
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
| P1 | 寃뚯엫 ?꾨컲. 媛留덉쓽 蹂묒궗(媛留??뺣쪧쨌?뚰렪쨌?⑸룞 湲곗닠쨌戮묎린쨌梨뺥꽣쨌?ㅽ궗쨌吏꾩쁺쨌?곸젏쨌洹좏삎) `tests/test_proto.gd` `tests/test_kiln_run.gd` + AFTERSELF `tests/test_p1.gd` | `tests/test_proto.gd`, `tests/test_kiln_run.gd`, `tests/test_p1.gd` |
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
# Codex ?묒뾽 吏?쒖꽌 ??UI 洹몃┝ (?꾩씠肄?14 쨌 李승룸쾭?셋룹뭅??? 7 쨌 ?곸씤 1)

- ?좎쭨: 2026-11-30
- ?묒뾽 ?대뜑: work/2026-11-30-UI洹몃┝/
- 吏?쒖꽌 踰덊샇: 08

## 癒쇱? ?쎌쓣 寃?
1. AGENTS.md
2. art/references/ ???뺥븳 洹몃┝泥?(媛 + ?? ?쇑룸㉨??諛뷀깢, ?좎빟 ?됱? ?ъ씤??
3. `assets/sprites/kiln/soldier_*.png` ??蹂묒궗 ?꾩옄湲??명삎 (?곸씤? ???명삎怨?媛숈? 洹몃┝泥?
4. `work/2026-11-30-UI洹몃┝/ref_lobby.png`, `ref_gacha.png`, `ref_shop.png`, `ref_clear.png`, `ref_tactics.png` ??吏湲?寃뚯엫 ?붾㈃ (肄붾뱶濡?洹몃┛ ?꾩떆 UI). **???먮━???ㅼ뼱媛?洹몃┝**?대떎
5. UI ?쒖븞: claude.ai ?꾪떚?⑺듃 "媛留덉쓽 蹂묒궗 UI 媛쒗렪 ?쒖븞" ???됯낵 諛곗튂??諛⑺뼢 (?살튌 諛뷀깢 쨌 泥?룞 ?뚮몢由?쨌 湲덈컯)
6. docs/洹몃┝-紐⑸줉.md, art/sprite_list.json ??"UI" 臾띠쓬

## 紐⑺몴 (?ъ슜??留?洹몃?濡?
> "UI 洹몃┝(?꾩씠肄? ?⑤꼸 ?μ떇, ?곸씤 洹몃┝)??Codex 吏?쒖꽌濡?留뚮뱾?댁쨾. 醫 ???몃젴?섍퀬 AI媛 留뚮뱺 寃?媛숈? ?딅룄濡??ㅼ젣 ?꾨Ц ?붿옄?대꼫媛 ??寃껋쿂???먯뿰?ㅻ읇寃?留뚮뱾?댁쨾."

## AI ???놁븷湲????꾨Ц ?쎌? UI ?붿옄?대꼫泥섎읆 (諛섎뱶??吏?⑤떎)
?ъ슜?먭? 媛???좉꼍 ?곕뒗 遺遺꾩씠?? ?꾨옒??"AI媛 留뚮뱺 ??媛 ?섎뒗 ?뷀븳 ?먯씤怨?洹?諛섎?濡??섎뒗 諛⑸쾿?대떎.

1. **?붾젅?몃? 癒쇱? ?뺥븯怨?洹??됰쭔 ?대떎.** ?꾨옒 ?붾젅??諛뽰쓽 ??湲덉? (?쒖쓽 理쒕? ?????덉뿉??. 鍮꾩듂?????щ윭 媛???踰덉쭚) 湲덉?
   - 癒?`#282322` 쨌 ?살튌 ?대몺 `#120e16` `#1c1622` `#2a2236` 쨌 泥?룞 `#5a4630` `#8a6a48` `#a8862e` 쨌 湲덈컯 `#e8c35a` `#fff1c4`
   - ??`#b98a5e` `#7a5a44` 쨌 ?쒖? `#e8dcb8` `#f2e6c8` 쨌 ??`#6f6c66` `#b0b8c0` `#dfe6ee` 쨌 吏꾩궗 `#b8463a` `#7a2a24` 쨌 泥?옄 `#6b9878` `#a6c5a3` 쨌 遺?`#ff9a3c`
2. **?먯? ?먯쑝濡?李띿? 寃껋쿂??** ?섎? ?덈뒗 ?⑹뼱由??대윭?ㅽ꽣)濡쒕쭔. ?명넧???먃룻씓肉뚮┛ ?≫떚쨌?몄씠利?寃?湲덉?. 紐⑤뱺 ?먯씠 "??嫄곌린 ?덈뒗吏" ?ㅻ챸?섏뼱???쒕떎
3. **鍮쏆? ?쇱そ ????諛⑺뼢.** ?섏씠?쇱씠?몃뒗 1~2px, 洹몃┝?먮뒗 ?ㅻⅨ履??꾨옒. ?뺥깭留덈떎 鍮?諛⑺뼢???ㅻⅤ硫?AI ?곌? ?쒕떎
4. **洹몃씪?곗씠?샕룻쓲由셋룰킅??踰덉쭚 湲덉?.** ?④퀎??2~3?⑥쑝濡??딅뒗?? ?붾뜑留곸? ?꾩슂??怨녹뿉留??꾩＜ 議곌툑
5. **1諛??ш린?먯꽌 ?쏀????쒕떎.** 16횞16 ?꾩씠肄섏? ?ㅻ（?ｋ쭔 蹂닿퀬??臾댁뾿?몄? ?뚯븘???쒕떎 ???뷀뀒?쇰낫???뺥깭 癒쇱?. ?묎쾶 以꾩뿬 ?뺤씤??寃?
6. **?멸낸??** 癒뱀깋 1px. ?덉そ ?좎? 諛붽묑蹂대떎 諛앷쾶(?좏깮???멸낸??. 怨꾨떒(jaggies) ?놁씠 1-2-3 洹쒖튃?곸씤 湲곗슱湲?
7. **??踰뚮줈:** ?꾩씠肄?14媛쒕뒗 媛숈? ?ш린 ?(???12~13px ??, 媛숈? ?멸낸??援듦린, 媛숈? 鍮쎛룰컳? 梨꾨룄. ?섎굹留??硫????쒕떎
8. **9議곌컖 洹몃┝(panel쨌button쨌card쨌title_plate쨌chip):** 紐⑥꽌由щ뒗 ?뺥빐吏?px ?덉뿉???앸굹怨? **媛?대뜲? 蹂? ?⑥깋**(?섏뼱?섎룄 臾대뒳媛 ?섏뼱吏吏 ?딄쾶). 踰꾪듉쨌移대뱶쨌?쒕ぉ ?먯? **諛앹? 臾댁콈??*?쇰줈 ??寃뚯엫???곹솴留덈떎 ?됱쓣 ?낇엺??
9. **?μ떇? ?덉젣:** ?쒓뎅 ?꾪넻 ?μ꽍쨌援щ쫫臾대뒳??紐⑥꽌由ъ뿉 ?묎쾶 ?섎굹. ?뚮몢由??꾩껜瑜?臾몄뼇?쇰줈 梨꾩슦吏 ?딅뒗??
10. 湲?먃룸줈怨좊? 洹몃┝???ｌ? ?딅뒗??(寃뚯엫??湲???대떎)

## ?뺥븳 洹몃┝泥?(諛섎뱶???곕Ⅸ??
- 媛 + ???욎쓬: ?뺥깭???먮졆?섍쾶, 諛뷀깢? 癒뮤룻쓾 ?뚯깋議? 媛뺥븳 ?됱? ?ъ씤?몄뿉留?
- ?щ챸 諛곌꼍 (9議곌컖??源롮? 紐⑥꽌由?諛붽묑???щ챸), ?먮┝(?덊떚?먯씪由ъ뼱?? ?놁쓬, ?쒖쓽 ?????댄븯

## 洹몃━??諛⑸쾿 (?ъ슜?먭? ?뺥븳 寃?
- [x] ?대?吏 ?앹꽦 ??肄붾뱶濡??ㅻ벉湲?(?ш린 留욎텛湲걔룸같寃??щ챸쨌??以꾩씠湲? ???ъ슜?먭? handoff-01 ?먯꽌 ?뺥븿 (2026-11-27)
- ?? ??"AI ???놁븷湲? 洹쒖튃??留욊쾶 **?됱쓣 ?붾젅?몃줈 媛뺤젣濡?留욎텛怨? ?명넧???먯쓣 吏?곌퀬, 1諛곕줈 以꾩뿬 ?뺤씤**?섎뒗 ?ㅻ벉湲곕? 瑗?嫄곗튇??

?뺥븳 諛⑸쾿???????놁쑝硫??ㅻⅨ 諛⑸쾿?쇰줈 諛붽씀吏 留먭퀬 `寃곌낵: 紐??뚮┝` ?쇰줈 蹂닿퀬?쒕떎.

## 留뚮뱾 寃?(22??

| ?뚯씪 | ?ш린 | 理쒕? ??| ?댁슜 |
|---|---|---|---|
| `assets/sprites/ui/icon_ticket.png` | 16횞16 | 12 | ?꾩씠肄?16횞16 쨌 戮묎린沅???遺됱? ?좊? ?먮Ⅸ ?꾨윴 ?쒖? ?? 洹?곸씠 ?묓옒. 1諛??ш린?먯꽌 ?ㅻ（?ｋ쭔?쇰줈 ?뚯븘蹂?寃? ?멸낸??1px(癒뱀깋 #282322), 鍮쏆? ?쇱そ ?꾩뿉????諛⑺뼢. ?щ챸 諛곌꼍 |
| `assets/sprites/ui/icon_clay.png` | 16횞16 | 12 | ?꾩씠肄?16횞16 쨌 ?????먯쑝濡?萸됱튇 遺됱? ?숇뜦?? ?먯옄援??쒕몢 媛? 1諛??ш린?먯꽌 ?ㅻ（?ｋ쭔?쇰줈 ?뚯븘蹂?寃? ?멸낸??1px(癒뱀깋 #282322), 鍮쏆? ?쇱そ ?꾩뿉????諛⑺뼢. ?щ챸 諛곌꼍 |
| `assets/sprites/ui/icon_pearl.png` | 16횞16 | 12 | ?꾩씠肄?16횞16 쨌 吏꾩＜ ????吏꾩＜ ???? ?쇱そ ??諛섏궗愿?1px, ?꾨옒 ?고븳 洹몃┝?? 1諛??ш린?먯꽌 ?ㅻ（?ｋ쭔?쇰줈 ?뚯븘蹂?寃? ?멸낸??1px(癒뱀깋 #282322), 鍮쏆? ?쇱そ ?꾩뿉????諛⑺뼢. ?щ챸 諛곌꼍 |
| `assets/sprites/ui/icon_shard.png` | 16횞16 | 12 | ?꾩씠肄?16횞16 쨌 ?붾? ?뚰렪 ???좎빟 鍮쏆씠 ?꾨뒗 源⑥쭊 ?꾩옄湲?議곌컖 (蹂대씪쨌湲?諛섏궗). 1諛??ш린?먯꽌 ?ㅻ（?ｋ쭔?쇰줈 ?뚯븘蹂?寃? ?멸낸??1px(癒뱀깋 #282322), 鍮쏆? ?쇱そ ?꾩뿉????諛⑺뼢. ?щ챸 諛곌꼍 |
| `assets/sprites/ui/icon_ember.png` | 16횞16 | 12 | ?꾩씠肄?16횞16 쨌 遺덉뵪 ?????꾩쓽 ?묒? 遺덉뵪, 二쇳솴 ?ъ?. 1諛??ш린?먯꽌 ?ㅻ（?ｋ쭔?쇰줈 ?뚯븘蹂?寃? ?멸낸??1px(癒뱀깋 #282322), 鍮쏆? ?쇱そ ?꾩뿉????諛⑺뼢. ?щ챸 諛곌꼍 |
| `assets/sprites/ui/icon_fire.png` | 16횞16 | 12 | ?꾩씠肄?16횞16 쨌 遺??ㅼ뒪由ш린 ???꾧턿??遺덇퐙 ??媛덈옒. 1諛??ш린?먯꽌 ?ㅻ（?ｋ쭔?쇰줈 ?뚯븘蹂?寃? ?멸낸??1px(癒뱀깋 #282322), 鍮쏆? ?쇱そ ?꾩뿉????諛⑺뼢. ?щ챸 諛곌꼍 |
| `assets/sprites/ui/icon_blade.png` | 16횞16 | 12 | ?꾩씠肄?16횞16 쨌 媛뺤쿋 移쇰궇 ??鍮꾩뒪?ы븳 吏㏃? ?섎룄 ?? 湲덈튆 肄붾벑?? 1諛??ш린?먯꽌 ?ㅻ（?ｋ쭔?쇰줈 ?뚯븘蹂?寃? ?멸낸??1px(癒뱀깋 #282322), 鍮쏆? ?쇱そ ?꾩뿉????諛⑺뼢. ?щ챸 諛곌꼍 |
| `assets/sprites/ui/icon_armor.png` | 16횞16 | 12 | ?꾩씠肄?16횞16 쨌 ?먯꽍由곌컩 ????鍮꾨뒛 媛묒샆 ?욏뙋 (鍮꾨뒛 3以?. 1諛??ш린?먯꽌 ?ㅻ（?ｋ쭔?쇰줈 ?뚯븘蹂?寃? ?멸낸??1px(癒뱀깋 #282322), 鍮쏆? ?쇱そ ?꾩뿉????諛⑺뼢. ?щ챸 諛곌꼍 |
| `assets/sprites/ui/icon_charm.png` | 16횞16 | 12 | ?꾩씠肄?16횞16 쨌 ?좎냽 遺?????몃? ?쒖???遺됱? 寃쎈㈃二쇱궗 湲??(湲???????紐⑥뼇留?. 1諛??ш린?먯꽌 ?ㅻ（?ｋ쭔?쇰줈 ?뚯븘蹂?寃? ?멸낸??1px(癒뱀깋 #282322), 鍮쏆? ?쇱そ ?꾩뿉????諛⑺뼢. ?щ챸 諛곌꼍 |
| `assets/sprites/ui/icon_gourd.png` | 16횞16 | 12 | ?꾩씠肄?16횞16 쨌 ???몃━蹂???遺됱? ??留??몃━蹂? 1諛??ш린?먯꽌 ?ㅻ（?ｋ쭔?쇰줈 ?뚯븘蹂?寃? ?멸낸??1px(癒뱀깋 #282322), 鍮쏆? ?쇱そ ?꾩뿉????諛⑺뼢. ?щ챸 諛곌꼍 |
| `assets/sprites/ui/icon_whetstone.png` | 16횞16 | 12 | ?꾩씠肄?16횞16 쨌 ?ル룎 ???뚯깋 ?ル룎 ??臾쇨린 ??以? 1諛??ш린?먯꽌 ?ㅻ（?ｋ쭔?쇰줈 ?뚯븘蹂?寃? ?멸낸??1px(癒뱀깋 #282322), 鍮쏆? ?쇱そ ?꾩뿉????諛⑺뼢. ?щ챸 諛곌꼍 |
| `assets/sprites/ui/icon_scale.png` | 16횞16 | 12 | ?꾩씠肄?16횞16 쨌 ?좊퉬????寃뱀튇 ??鍮꾨뒛 ???? 1諛??ш린?먯꽌 ?ㅻ（?ｋ쭔?쇰줈 ?뚯븘蹂?寃? ?멸낸??1px(癒뱀깋 #282322), 鍮쏆? ?쇱そ ?꾩뿉????諛⑺뼢. ?щ챸 諛곌꼍 |
| `assets/sprites/ui/icon_scroll.png` | 16횞16 | 12 | ?꾩씠肄?16횞16 쨌 鍮꾧툒?????ㅻ줈 臾띠? ?≪? 梨?(?쒖? ??. 1諛??ш린?먯꽌 ?ㅻ（?ｋ쭔?쇰줈 ?뚯븘蹂?寃? ?멸낸??1px(癒뱀깋 #282322), 鍮쏆? ?쇱そ ?꾩뿉????諛⑺뼢. ?щ챸 諛곌꼍 |
| `assets/sprites/ui/icon_bell.png` | 16횞16 | 12 | ?꾩씠肄?16횞16 쨌 ?좊졊 諛⑹슱 ??臾대떦 諛⑹슱 ?뗭씠 ?щ┛ ?먯옟?? 1諛??ш린?먯꽌 ?ㅻ（?ｋ쭔?쇰줈 ?뚯븘蹂?寃? ?멸낸??1px(癒뱀깋 #282322), 鍮쏆? ?쇱そ ?꾩뿉????諛⑺뼢. ?щ챸 諛곌꼍 |
| `assets/sprites/ui/panel_9.png` | 48횞48 | 16 | 李??⑤꼸) 9議곌컖 洹몃┝ ??紐⑥꽌由?8px ? 洹몃?濡? 媛?대뜲쨌蹂? 寃뚯엫???섎┛?? ?살튌??寃遺됱? ?섎Т??#1c1622 怨꾩뿴) + 諛붽묑 泥?룞 ?뚮몢由?2px + ?덉そ 媛????1px. 媛?대뜲(?섏뼱?섎뒗 遺遺????⑥깋 ?먮뒗 ?꾩＜ ?쏀븳 寃??섎굹留?(?섏뿬???댁긽?섏? ?딄쾶). 紐⑥꽌由?1~2px 源롪린 |
| `assets/sprites/ui/panel_corner.png` | 14횞14 | 10 | 李?紐⑥꽌由??μ떇 (?쇱そ ?????? 寃뚯엫???ㅼ쭛????紐⑥꽌由ъ뿉) ??諛섎떕???μ꽍 媛숈? 湲덈컯 ???μ떇, ?깆옄 紐⑥뼇???묒? 援щ쫫臾대뒳 ?섎굹. ?щ챸 諛곌꼍 |
| `assets/sprites/ui/button_9.png` | 24횞24 | 12 | 踰꾪듉 9議곌컖 (紐⑥꽌由?6px). **諛앹? 臾댁콈??泥?룞** (寃뚯엫??踰꾪듉留덈떎 ?됱쓣 ?낇엺??. ?꾩そ 1px ?섏씠?쇱씠?? ?꾨옒 2px ?먭퍡媛? 紐⑥꽌由?源롪린. 媛?대뜲???⑥깋 |
| `assets/sprites/ui/button_primary_9.png` | 24횞24 | 12 | 二?踰꾪듉 9議곌컖 (紐⑥꽌由?6px) ??湲덈컯 移?(#e8c35a 怨꾩뿴), ???섏씠?쇱씠?맞룹븘???먭퍡媛? 媛?대뜲???⑥깋 (湲?먭? 洹??꾩뿉 癒뱀깋?쇰줈 ?щ씪媛꾨떎) |
| `assets/sprites/ui/card_9.png` | 24횞24 | 12 | 蹂묒궗 移대뱶 ? 9議곌컖 (紐⑥꽌由?6px) ??**諛앹? 臾댁콈??* (寃뚯엫???깃툒 ?됱쓣 ?낇엺??, ?덉そ? ?대몢??諛뷀깢, ?꾨옒履??대쫫 ???먮━媛 ?댁쭩 ???대몼寃? 媛?대뜲 ?⑥깋 |
| `assets/sprites/ui/title_plate_9.png` | 20횞14 | 8 | 李??쒕ぉ ??9議곌컖 (紐⑥꽌由?5px) ???묒? ?꾪뙋 紐⑥뼇, 諛앹? 臾댁콈???뚮몢由?(寃뚯엫???됱쓣 ?낇엺??, ?덉? ?대몢???살튌 |
| `assets/sprites/ui/chip_9.png` | 16횞16 | 8 | ?먯썝 ?뚯빟 9議곌컖 (紐⑥꽌由?6px) ???덉쑝濡??뚯씤 ?대몢???? 泥?룞 ?뚮몢由?1px |
| `assets/sprites/ui/merchant.png` | 48횞64 | 24 | 吏꾩＜ ?곸젏 ?곸씤 (媛?????뺣룄, ?ㅻⅨ履쎌쓣 遊? ??吏寃뚯뿉 蹂대뵲由щ? 吏?蹂대????꾩옄湲??명삎, ?⑤옲??紐⑥옄??紐⑺솕 ?≪씠, ?먯뿉 吏꾩＜ ???? 遺?쒕읇寃??껊뒗 ?쇨뎬. 蹂묒궗 ?꾩옄湲??명삎怨?媛숈? 洹몃┝泥?(?쇨뎬 ?뚯깋, ??愿묓깮), ?룹? ?숇튆쨌履쎈튆. ?щ챸 諛곌꼍 |

## 怨좎퀜???섎뒗 踰붿쐞
- `assets/sprites/ui/icon_ticket.png` (???뚯씪)
- `assets/sprites/ui/icon_clay.png` (???뚯씪)
- `assets/sprites/ui/icon_pearl.png` (???뚯씪)
- `assets/sprites/ui/icon_shard.png` (???뚯씪)
- `assets/sprites/ui/icon_ember.png` (???뚯씪)
- `assets/sprites/ui/icon_fire.png` (???뚯씪)
- `assets/sprites/ui/icon_blade.png` (???뚯씪)
- `assets/sprites/ui/icon_armor.png` (???뚯씪)
- `assets/sprites/ui/icon_charm.png` (???뚯씪)
- `assets/sprites/ui/icon_gourd.png` (???뚯씪)
- `assets/sprites/ui/icon_whetstone.png` (???뚯씪)
- `assets/sprites/ui/icon_scale.png` (???뚯씪)
- `assets/sprites/ui/icon_scroll.png` (???뚯씪)
- `assets/sprites/ui/icon_bell.png` (???뚯씪)
- `assets/sprites/ui/panel_9.png` (???뚯씪)
- `assets/sprites/ui/panel_corner.png` (???뚯씪)
- `assets/sprites/ui/button_9.png` (???뚯씪)
- `assets/sprites/ui/button_primary_9.png` (???뚯씪)
- `assets/sprites/ui/card_9.png` (???뚯씪)
- `assets/sprites/ui/title_plate_9.png` (???뚯씪)
- `assets/sprites/ui/chip_9.png` (???뚯씪)
- `assets/sprites/ui/merchant.png` (???뚯씪)

??紐⑸줉???녿뒗 ?뚯씪? 留뚮뱾嫄곕굹 怨좎튂吏 ?딅뒗??

## 蹂댄샇 寃??寃곌낵 (Claude媛 誘몃━ ?뺤씤??
- `python3 scripts/protected.py <???뚯씪??` ??嫄몃┛ ?뚯씪 ?놁쓬 (紐⑤몢 ???뚯씪)
- ??寃?щ뒗 Claude媛 ?덈떎. Codex???ㅼ떆 ?뚮━吏 ?딅뒗??

## ?섎㈃ ???섎뒗 ??
- 踰붿쐞 諛??뚯씪 ?섏젙쨌??젣 (?뱁엳 `src/`, `tests/`, `art/references/`, `art/rubric.md`, ?대? ?덈뒗 `assets/sprites/`)
- 寃뚯엫 肄붾뱶??洹몃┝???곌껐?섎뒗 ?묒뾽 (?대? ?섏뼱 ?덈떎: ?뚯씪???덉쑝硫?肄붾뱶 洹몃┝ ????대떎)
- ??μ냼??Python ?ㅽ겕由쏀듃 ?ㅽ뻾 (寃?щ뒗 Claude媛 ?묒뾽 ?꾩뿉 ?쒕떎)
- git commit / push
- 紐??덈뒗???덈떎怨?蹂닿퀬?섍린

## ?앸굹硫????뺤떇?쇰줈 蹂닿퀬
```
寃곌낵: ?듦낵 | ?ㅽ뙣 | 紐??뚮┝   ????以??섎굹留?
諛붾??뚯씪:
- 寃쎈줈 ??臾댁뾿??
吏곸젒 ?뺤씤??寃?
- ?? 1諛걔?諛곕줈 以꾩뿬 蹂닿퀬 ?ㅻ（???뺤씤, ?붾젅??諛????놁쓬, 9議곌컖 媛?대뜲 ?⑥깋
洹몃━??????諛⑸쾿:
- ?대?吏 ?앹꽦 / 肄붾뱶 / ????(臾댁뾿???대뼸寃? ?붾젅??留욎텛湲곕? ?대뼸寃??덈뒗吏)
紐???寃?/ 嫄깆젙?섎뒗 寃?
- ??
```
- ??μ냼??Python 寃?щ? 紐??뚮┛ 寃껊쭔?쇰줈??`紐??뚮┝`???꾨땲?? 寃?щ뒗 Claude媛 ?쒕떎.

## Claude媛 諛쏆? ??????
1. `git status` ??諛붾??뚯씪????踰붿쐞肉먯씤吏
2. `python3 scripts/check_sprites.py --group "UI" --sheet work/2026-11-30-UI洹몃┝/sheet-08.png` ???ш린쨌?щ챸 諛곌꼍쨌???샕룻쓲由?媛?μ옄由?
3. 寃뚯엫 ?붾㈃ ?ㅽ겕由곗꺑 (`tests/screens_proto.gd`): 濡쒕퉬쨌戮묎린쨌?곸젏쨌?대━??李승룹쟾??媛뺥솕?먯꽌 吏곸젒 蹂몃떎 (9議곌컖???섏뼱????源⑥?吏 ?딅뒗吏)
4. **洹몃┝ 猷⑦봽** (`.claude/skills/art-loop/SKILL.md`): 泥섏쓬 蹂대뒗 寃?좎옄 2紐낆씠 `art/rubric.md` 濡?"AI ??쨌"洹몃┝泥??댁슱由? 梨꾩젏 ????쑝硫??ㅼ떆 吏??
5. `python3 scripts/test.py --stage all`
6. ?ъ슜?먯뿉寃?蹂댁뿬 二쇨퀬 "寃?щ뒗 ?듦낵, 誘몄닠 ?먮떒? ?ъ슜??紐? ???덈씫??諛쏆? ??而ㅻ컠
# ?ъ슜?먭? 吏곸젒 怨좎튇 ?뚯씪 / ??뼱?곕㈃ ???섎뒗 ?뚯씪 (??以꾩뿉 ?섎굹, glob 媛??
# Claude쨌Codex???ш린 ?곹엺 ?뚯씪????뼱?곗? ?딅뒗?? 怨좎퀜???섎㈃ 諛붽? ?댁슜???쒖븞留??쒕떎.
art/references/*
art/rubric.md
 M reports/boss/history.csv
 M "work/2026-11-27-\352\267\270\353\246\274/NOTES.md"
 M "work/2026-11-27-\352\267\270\353\246\274/handoff-03.md"
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
?? "work/2026-11-30-UI\352\267\270\353\246\274/handoff-09.report.md"
?? "work/2026-11-30-UI\352\267\270\353\246\274/screens-08/"
?? "work/2026-11-30-UI\352\267\270\353\246\274/sheet-08.png"
?? work/art-ui08/
assets/sprites/kiln\soldier_spear_water.png.import
assets/sprites/kiln\soldier_spear_water.png
assets/sprites/kiln\soldier_spear_fire.png.import
assets/sprites/kiln\soldier_spear_fire.png
assets/sprites/kiln\soldier_spear_earth.png.import
assets/sprites/kiln\soldier_spear_earth.png
assets/sprites/kiln\soldier_shield_water.png.import
assets/sprites/kiln\soldier_shield_water.png
assets/sprites/kiln\soldier_shield_fire.png.import
assets/sprites/kiln\soldier_shield_fire.png
assets/sprites/kiln\soldier_shield_earth.png.import
assets/sprites/kiln\soldier_shield_earth.png
assets/sprites/kiln\soldier_archer_water.png.import
assets/sprites/kiln\soldier_archer_water.png
assets/sprites/kiln\soldier_archer_fire.png.import
assets/sprites/kiln\soldier_archer_fire.png
assets/sprites/kiln\soldier_archer_earth.png.import
assets/sprites/kiln\soldier_archer_earth.png
assets/sprites/kiln\kiln_body.png.import
assets/sprites/kiln\kiln_body.png
art/references\soldier_spear_fire.png
art/references\soldier_shield_earth.png
art/references\soldier_archer_water.png
art/references\sheet.png
art/references\README.md
art/references\house.png
art/references\goblin.png
art/references\creature_shield_water.png
work/2026-11-30-UI그림\sheet-08.png
work/2026-11-30-UI그림\screens-08\p12_nest_battle.png
work/2026-11-30-UI그림\screens-08\p11_nest_night.png
work/2026-11-30-UI그림\screens-08\p10_nest_burst.png
work/2026-11-30-UI그림\screens-08\p09_nest_hatch.png
work/2026-11-30-UI그림\screens-08\p08_nest_egg.png
work/2026-11-30-UI그림\screens-08\p07_kiln_night_end.png
work/2026-11-30-UI그림\screens-08\p07f_kiln_loot.png
work/2026-11-30-UI그림\screens-08\p07e_kiln_king.png
work/2026-11-30-UI그림\screens-08\p07e2_kiln_end_anim.png
work/2026-11-30-UI그림\screens-08\p07d_kiln_gumiho.png
work/2026-11-30-UI그림\screens-08\p07c_kiln_chapter_clear.png
work/2026-11-30-UI그림\screens-08\p07b_kiln_chief.png
work/2026-11-30-UI그림\screens-08\p06_kiln_battle_mid.png
work/2026-11-30-UI그림\screens-08\p06d_kiln_cutin.png
work/2026-11-30-UI그림\screens-08\p06c_kiln_battle_busy.png
work/2026-11-30-UI그림\screens-08\p06b_kiln_synergy_wave.png
work/2026-11-30-UI그림\screens-08\p05_kiln_prep_night2.png
work/2026-11-30-UI그림\screens-08\p05h_kiln_deploy.png
work/2026-11-30-UI그림\screens-08\p05g_kiln_promo.png
work/2026-11-30-UI그림\screens-08\p05f_kiln_shop.png
work/2026-11-30-UI그림\screens-08\p05e_kiln_equip.png
work/2026-11-30-UI그림\screens-08\p05d_kiln_help.png
work/2026-11-30-UI그림\screens-08\p05c_kiln_prep_chapter2.png
work/2026-11-30-UI그림\screens-08\p04_kiln_reveal_done.png
work/2026-11-30-UI그림\screens-08\p03_kiln_reveal_legend.png
work/2026-11-30-UI그림\screens-08\p03b_kiln_gacha_show.png
work/2026-11-30-UI그림\screens-08\p03a_kiln_gacha_tap.png
work/2026-11-30-UI그림\screens-08\p02_kiln_fire.png
work/2026-11-30-UI그림\screens-08\p02b_kiln_fire_hot.png
work/2026-11-30-UI그림\screens-08\p01_kiln_prep_first.png
work/2026-11-30-UI그림\screens-08\p01b_kiln_gacha.png
work/2026-11-30-UI그림\screens-08\p01a_kiln_tutorial_draw.png
work/2026-11-30-UI그림\screens-08\p00_launcher.png
work/2026-11-30-UI그림\screens-08\p00d_kiln_records.png
work/2026-11-30-UI그림\screens-08\p00c_kiln_meta.png
work/2026-11-30-UI그림\screens-08\p00b_kiln_title.png
work/2026-11-30-UI그림\ref_title_now.png
work/2026-11-30-UI그림\ref_tactics.png
work/2026-11-30-UI그림\ref_shop.png
work/2026-11-30-UI그림\ref_lobby.png
work/2026-11-30-UI그림\ref_gacha.png
work/2026-11-30-UI그림\ref_cutin_now.png
work/2026-11-30-UI그림\ref_clear.png
work/2026-11-30-UI그림\NOTES.md
work/2026-11-30-UI그림\handoff-09.report.md
work/2026-11-30-UI그림\handoff-09.md
work/2026-11-30-UI그림\handoff-08.report.md
work/2026-11-30-UI그림\handoff-08.md

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -Encoding UTF8 'C:/Users/pc/.codex/skills/.system/imagegen/SKILL.md' | Select-Object -Skip 115; Get-Content -Encoding UTF8 AGENTS.md | Select-Object -First 35" in C:\Users\pc\Documents\game
 succeeded in 0ms:

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
- style-transfer — apply reference style while changing subject/scene.
- compositing — multi-image insert/merge with matched lighting/perspective.
- sketch-to-render — drawing/line art to photoreal render.

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

지금: **가마의 병사** 하나 (2026-11-30 사용자: "게임은 가마 병사만 하고 알 관련 게임은 없이"). 시작하면 `src/game/kiln_scene` 첫 화면으로 바로 간다.

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -Encoding UTF8 'work/2026-11-30-UI그림/handoff-08.md'; Get-Content -Encoding UTF8 PROTECTED.txt; git status --porcelain; rg --files art/references; Get-ChildItem assets/sprites/kiln/soldier_*.png | Select-Object -ExpandProperty Name; Get-Command magick,node -ErrorAction SilentlyContinue | Select-Object Name,Source" in C:\Users\pc\Documents\game
 exited 1 in 2418ms:
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
# 사용자가 직접 고친 파일 / 덮어쓰면 안 되는 파일 (한 줄에 하나, glob 가능)
# Claude·Codex는 여기 적힌 파일을 덮어쓰지 않는다. 고쳐야 하면 바꿀 내용을 제안만 한다.
art/references/*
art/rubric.md
 M reports/boss/history.csv
 M "work/2026-11-27-\352\267\270\353\246\274/NOTES.md"
 M "work/2026-11-27-\352\267\270\353\246\274/handoff-03.md"
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
?? "work/2026-11-30-UI\352\267\270\353\246\274/handoff-09.report.md"
?? "work/2026-11-30-UI\352\267\270\353\246\274/screens-08/"
?? "work/2026-11-30-UI\352\267\270\353\246\274/sheet-08.png"
?? work/art-ui08/
art/references\soldier_spear_fire.png
art/references\soldier_shield_earth.png
art/references\soldier_archer_water.png
art/references\sheet.png
art/references\README.md
art/references\house.png
art/references\goblin.png
art/references\creature_shield_water.png
soldier_archer_earth.png
soldier_archer_fire.png
soldier_archer_water.png
soldier_shield_earth.png
soldier_shield_fire.png
soldier_shield_water.png
soldier_spear_earth.png
soldier_spear_fire.png
soldier_spear_water.png

Name     Source                          
----     ------                          
node.exe C:\Program Files\nodejs\node.exe



exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -Encoding UTF8 art/references/README.md; Get-Item assets/sprites/fx/cutin_water.png,assets/sprites/fx/cutin_fire.png,assets/sprites/fx/cutin_earth.png,assets/sprites/ui/title_bg.png -ErrorAction SilentlyContinue | Select-Object FullName,Length; Get-Content -Encoding UTF8 'work/2026-11-30-UI그림/handoff-09.report.md'" in C:\Users\pc\Documents\game

codex
기준 병사는 넓은 챙의 투구와 회색 도자기 얼굴, 둥근 유약 몸체가 특징입니다. 컷신은 이 특징을 살린 상반신 구도로 만들고, 시작 배경은 중앙 위쪽과 아래 1/3을 어둡고 단순하게 비우겠습니다. 색상은 handoff-08의 지정 팔레트로 맞추겠습니다.

mcp: node_repl/js started
mcp: node_repl/js (completed)
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-ChildItem 'C:/Users/pc/.codex/generated_images' -ErrorAction SilentlyContinue | Select-Object -Last 3 Name,LastWriteTime; Get-ChildItem assets/sprites/fx,assets/sprites/ui | Select-Object Name" in C:\Users\pc\Documents\game
 exited 1 in 415ms:

Name                                 LastWriteTime         
----                                 -------------         
01a21c87-bb0e-7563-a198-0077bdf18c6c 2026-11-27 오후 7:40:09 
01a21f90-3732-7161-94ee-403a0836455f 2026-11-28 오전 9:51:36 
01a21fdd-4bf0-7523-bd11-b4f8ef3b8757 2026-11-28 오전 11:04:24
Get-ChildItem : 'C:\Users\pc\Documents\game\assets\sprites\fx' 경로는 존재하지 않으므로 찾을 수 없습니다.
위치 줄:2 문자:127
+ ... tWriteTime; Get-ChildItem assets/sprites/fx,assets/sprites/ui | Selec ...
+                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (C:\Users\pc\Doc...sets\sprites\fx:String) [Get-ChildItem], ItemNotFound 
   Exception
    + FullyQualifiedErrorId : PathNotFound,Microsoft.PowerShell.Commands.GetChildItemCommand
 
Get-ChildItem : 'C:\Users\pc\Documents\game\assets\sprites\ui' 경로는 존재하지 않으므로 찾을 수 없습니다.
위치 줄:2 문자:127
+ ... tWriteTime; Get-ChildItem assets/sprites/fx,assets/sprites/ui | Selec ...
+                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (C:\Users\pc\Doc...sets\sprites\ui:String) [Get-ChildItem], ItemNotFound 
   Exception
    + FullyQualifiedErrorId : PathNotFound,Microsoft.PowerShell.Commands.GetChildItemCommand
 



codex
물·불 컷신 원본이 생성됐습니다. 두 장 모두 창·활·방패 병사의 상반신과 유약 반사가 크게 보이는 구도입니다. 이어서 땅 컷신과 밤 배경을 생성한 뒤, 축소·팔레트 변환 후의 실제 크기로 확인하겠습니다.

codex
네 장의 원본이 생성됐습니다. 이제 지정 팔레트로 색을 고정하고, 고립된 픽셀을 정리하겠습니다. 시작 배경은 건물과 가마가 아래 1/3을 침범하지 않도록 세로 배치를 조금 조정합니다. 게임 안에서의 렌더 확인과 저장소 검사는 지시서대로 Claude에게 남깁니다.

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Add-Type -AssemblyName System.Drawing; $im=[System.Drawing.Bitmap]::FromFile('"'C:/Users/pc/.codex/generated_images/01a21ff8-e260-7e03-b67f-acc4920090e2/exec-62429584-8f71-4222-bcc6-64d787c32567.png'); Write-Output \""'$($im.Width)x$($im.Height)"; $im.Dispose(); git -c core.quotePath=false status --porcelain' in C:\Users\pc\Documents\game
 succeeded in 425ms:
1586x992
 M reports/boss/history.csv
 M work/2026-11-27-그림/NOTES.md
 M work/2026-11-27-그림/handoff-03.md
?? reports/boss/history-local-backup.csv
?? src/game/pixel_art.gd.uid
?? src/proto/kiln_run.gd.uid
?? src/proto/meta.gd.uid
?? tests/sweep_kiln.gd.uid
?? tests/test_kiln_run.gd.uid
?? work/2026-11-27-그림/compare-03-screens.png
?? work/2026-11-27-그림/compare-03.png
?? work/2026-11-27-그림/handoff-03-run1/
?? work/2026-11-27-그림/handoff-03-run2/
?? work/2026-11-27-그림/handoff-03.report.md
?? work/2026-11-27-그림/screens-02b/
?? work/2026-11-27-그림/screens-03-run1/
?? work/2026-11-27-그림/screens-03-run2/
?? work/2026-11-27-실감/handoff-04.report.md
?? work/2026-11-27-실감/sheet-04.png
?? work/2026-11-28-다듬기/handoff-05.report.md
?? work/2026-11-28-다듬기/handoff-06.report.md
?? work/2026-11-28-다듬기/old-06-soldiers/
?? work/2026-11-28-다듬기/screens-05/
?? work/2026-11-28-다듬기/screens-06/
?? work/2026-11-28-다듬기/sheet-05.png
?? work/2026-11-28-다듬기/sheet-06a.png
?? work/2026-11-28-다듬기/sheet-06b.png
?? work/2026-11-29-스킬진영/handoff-07.report.md
?? work/2026-11-29-스킬진영/screens-07/
?? work/2026-11-29-스킬진영/sheet-07a.png
?? work/2026-11-29-스킬진영/sheet-07b.png
?? work/2026-11-30-UI그림/handoff-08.report.md
?? work/2026-11-30-UI그림/handoff-09.report.md
?? work/2026-11-30-UI그림/screens-08/
?? work/2026-11-30-UI그림/sheet-08.png
?? work/art-ui08/

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command '
Add-Type -AssemblyName System.Drawing
$source = @'"'
using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Collections.Generic;
using System.IO;
public static class KilnIllustration09 {
 static string[] hex={\"282322\",\"120e16\",\"1c1622\",\"2a2236\",\"5a4630\",\"8a6a48\",\"a8862e\",\"e8c35a\",\"fff1c4\",\"b98a5e\",\"7a5a44\",\"e8dcb8\",\"f2e6c8\",\"6f6c66\",\"b0b8c0\",\"dfe6ee\",\"b8463a\",\"7a2a24\",\"6b9878\",\"a6c5a3\",\"ff9a3c\"};
 static Color[] Pal() {
  Color[] p=new Color[hex.Length];
  for(int i=0;i<p.Length;i++) p[i]=ColorTranslator.FromHtml(\"#\"+hex[i]);
  return p;
 }
 public static void Build(string src,string dst,int w,int h,bool title) {
  if(File.Exists(dst)) throw new Exception(\"Refusing to overwrite existing asset: \"+dst);
  Color[] pal=Pal(); int[] px=new int[w*h];
  using(Bitmap input=new Bitmap(src))
  using(Bitmap small=new Bitmap(w,h,PixelFormat.Format32bppArgb)) {
   using(Graphics g=Graphics.FromImage(small)) {
    g.Clear(ColorTranslator.FromHtml(\"#120e16\"));
    g.InterpolationMode=InterpolationMode.HighQualityBicubic;
    g.PixelOffsetMode=PixelOffsetMode.HighQuality;
    using(ImageAttributes attrs=new ImageAttributes()) {
     attrs.SetWrapMode(WrapMode.TileFlipXY);
     if(title) {
      int sy=(int)Math.Round(input.Height*0.71);
      g.DrawImage(input,new Rectangle(0,0,w,267),0,0,input.Width,sy,GraphicsUnit.Pixel,attrs);
      g.DrawImage(input,new Rectangle(0,267,w,h-267),0,sy,input.Width,input.Height-sy,GraphicsUnit.Pixel,attrs);
     } else g.DrawImage(input,new Rectangle(0,0,w,h),0,0,input.Width,input.Height,GraphicsUnit.Pixel,attrs);
    }
   }
   var cache=new Dictionary<int,int>();
   for(int y=0;y<h;y++) for(int x=0;x<w;x++) {
    Color c=small.GetPixel(x,y); int key=c.ToArgb(); int best;
    if("'!cache.TryGetValue(key,out best)) {
     double min=double.MaxValue;best=0;
     for(int k=0;k<pal.Length;k++) {
      double dr=c.R-pal[k].R,dg=c.G-pal[k].G,db=c.B-pal[k].B;
      double rmean=(c.R+pal[k].R)/2.0;
      double d=(2+rmean/256)*dr*dr+4*dg*dg+(2+(255-rmean)/256)*db*db;
      if(d<min) { min=d;best=k; }
     }
     cache[key]=best;
    }
    px[y*w+x]=best;
   }
  }
  int removed=0;
  for(int pass=0;pass<6;pass++) {
   int[] next=(int[])px.Clone();int changed=0;
   for(int y=0;y<h;y++) for(int x=0;x<w;x++) {
    int own=px[y*w+x];bool same=false;int[] counts=new int[pal.Length];
    for(int dy=-1;dy<=1;dy++) for(int dx=-1;dx<=1;dx++) {
     if(dx==0&&dy==0)continue;
     int nx=x+dx,ny=y+dy;
     if(nx<0||ny<0||nx>=w||ny>=h)continue;
     int n=px[ny*w+nx]; if(n==own)same=true;counts[n]++;
    }
    if(!same) {
     int best=0;
     for(int k=1;k<counts.Length;k++)if(counts[k]>counts[best])best=k;
     next[y*w+x]=best;changed++;
    }
   }
   px=next;removed+=changed;if(changed==0)break;
  }
  Directory.CreateDirectory(Path.GetDirectoryName(dst));
  using(Bitmap output=new Bitmap(w,h,PixelFormat.Format32bppArgb)) {
   var colors=new HashSet<int>();
   for(int y=0;y<h;y++) for(int x=0;x<w;x++) { output.SetPixel(x,y,pal[px[y*w+x]]);colors.Add(px[y*w+x]); }
   output.Save(dst,ImageFormat.Png);
   Console.WriteLine(Path.GetFileName(dst)+" "+w+"x"+h+" colors="+colors.Count+" paletteOutside=0 alpha=255 isolatedPixelsCleaned="+removed);
  }
 }
}
'"'@
Add-Type -TypeDefinition "'$source -ReferencedAssemblies System.Drawing
$generated='"'C:/Users/pc/.codex/generated_images/01a21ff8-e260-7e03-b67f-acc4920090e2'
"'$target='"'C:/Users/pc/Documents/game/assets/sprites'
[KilnIllustration09]::Build(\""'$generated/exec-732b695d-b37f-4a3a-ab1c-dfff985bc82d.png","$target/fx/cutin_water.png",560,220,$false)
[KilnIllustration09]::Build("$generated/exec-e98e7ff8-a50d-4956-8076-ba0fe3ea407c.png","$target/fx/cutin_fire.png",560,220,$false)
[KilnIllustration09]::Build("$generated/exec-6587f485-f7e9-4195-8503-0793a9123386.png","$target/fx/cutin_earth.png",560,220,$false)
[KilnIllustration09]::Build("$generated/exec-62429584-8f71-4222-bcc6-64d787c32567.png","$target/ui/title_bg.png",640,400,$true)
' in C:\Users\pc\Documents\game
 succeeded in 1095ms:
cutin_water.png 560x220 colors=19 paletteOutside=0 alpha=255 isolatedPixelsCleaned=9333
cutin_fire.png 560x220 colors=20 paletteOutside=0 alpha=255 isolatedPixelsCleaned=7080
cutin_earth.png 560x220 colors=19 paletteOutside=0 alpha=255 isolatedPixelsCleaned=9727
title_bg.png 640x400 colors=17 paletteOutside=0 alpha=255 isolatedPixelsCleaned=2296

codex
실제 크기로 보니 팔레트 변환 과정에서 일부 얼굴에 녹색·흙색이 섞이고, 밤 배경의 빈 공간에 잔점이 생겼습니다. 얼굴의 저채도 색은 회색 계열로 제한하고, 빈 바탕과 연기의 색 덩어리를 정리하겠습니다.

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command '
Add-Type -AssemblyName System.Drawing
$source = @'"'
using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Collections.Generic;
using System.IO;
public static class Kiln09Refine {
 static string[] hex={\"282322\",\"120e16\",\"1c1622\",\"2a2236\",\"5a4630\",\"8a6a48\",\"a8862e\",\"e8c35a\",\"fff1c4\",\"b98a5e\",\"7a5a44\",\"e8dcb8\",\"f2e6c8\",\"6f6c66\",\"b0b8c0\",\"dfe6ee\",\"b8463a\",\"7a2a24\",\"6b9878\",\"a6c5a3\",\"ff9a3c\"};
 static int[] grey={0,13,14,15};
 static int[] night={1,2,3};
 static int[] cool={1,2,3,13,14,15};
 static Color[] Pal() { Color[] p=new Color[hex.Length];for(int i=0;i<p.Length;i++)p[i]=ColorTranslator.FromHtml(\"#\"+hex[i]);return p; }
 public static void Build(string src,string dst,int w,int h,bool title) {
  Color[] pal=Pal(); Color[] samples=new Color[w*h];int[] px=new int[w*h];
  using(Bitmap input=new Bitmap(src))
  using(Bitmap small=new Bitmap(w,h,PixelFormat.Format32bppArgb)) {
   using(Graphics g=Graphics.FromImage(small)) {
    g.Clear(pal[1]);g.InterpolationMode=InterpolationMode.HighQualityBicubic;g.PixelOffsetMode=PixelOffsetMode.HighQuality;
    using(ImageAttributes attrs=new ImageAttributes()) {
     attrs.SetWrapMode(WrapMode.TileFlipXY);
     if(title) {
      int sy=(int)Math.Round(input.Height*0.71);
      g.DrawImage(input,new Rectangle(0,0,w,267),0,0,input.Width,sy,GraphicsUnit.Pixel,attrs);
      g.DrawImage(input,new Rectangle(0,267,w,h-267),0,sy,input.Width,input.Height-sy,GraphicsUnit.Pixel,attrs);
     }else g.DrawImage(input,new Rectangle(0,0,w,h),0,0,input.Width,input.Height,GraphicsUnit.Pixel,attrs);
    }
   }
   for(int y=0;y<h;y++)for(int x=0;x<w;x++)samples[y*w+x]=small.GetPixel(x,y);
  }
  for(int y=0;y<h;y++)for(int x=0;x<w;x++) {
   // Median of five cross samples removes grain while retaining diagonal contour shape.
   int[] rr=new int[5],gg=new int[5],bb=new int[5];
   int[] offsets={y*w+x,y*w+Math.Max(0,x-1),y*w+Math.Min(w-1,x+1),Math.Max(0,y-1)*w+x,Math.Min(h-1,y+1)*w+x};
   for(int j=0;j<5;j++){Color s=samples[offsets[j]];rr[j]=s.R;gg[j]=s.G;bb[j]=s.B;}
   Array.Sort(rr);Array.Sort(gg);Array.Sort(bb);
   Color c=Color.FromArgb(rr[2],gg[2],bb[2]);
   int high=Math.Max(c.R,Math.Max(c.G,c.B)), low=Math.Min(c.R,Math.Min(c.G,c.B));
   int[] allowed=null;
   if(title) {
    if(high<65)allowed=night;
    else if(c.B>c.R*1.02&&c.B>c.G*1.02)allowed=cool;
   }else if(high>85&&high<210&&(high-low)/(double)high<0.32&&c.R>=c.G&&c.G>=c.B)allowed=grey;
   int best=0;double min=double.MaxValue;
   for(int k=0;k<pal.Length;k++) {
    if(allowed"'!=null&&Array.IndexOf(allowed,k)<0)continue;
    double dr=c.R-pal[k].R,dg=c.G-pal[k].G,db=c.B-pal[k].B,rm=(c.R+pal[k].R)/2.0;
    double d=(2+rm/256)*dr*dr+4*dg*dg+(2+(255-rm)/256)*db*db;
    if(d<min){min=d;best=k;}
   }
   if(title&&y>=267)best=y<320?2:1;
   px[y*w+x]=best;
  }
  int removed=0;
  for(int pass=0;pass<4;pass++) {
   bool[] seen=new bool[w*h];int[] next=(int[])px.Clone();int changed=0;
   for(int start=0;start<px.Length;start++) {
    if(seen[start])continue;
    var group=new List<int>();var q=new Queue<int>();q.Enqueue(start);seen[start]=true;
    while(q.Count>0){
     int p=q.Dequeue();group.Add(p);int x=p%w,y=p/w;
     for(int dy=-1;dy<=1;dy++)for(int dx=-1;dx<=1;dx++){
      int nx=x+dx,ny=y+dy;if(nx<0||ny<0||nx>=w||ny>=h)continue;
      int n=ny*w+nx;if(!seen[n]&&px[n]==px[start]){seen[n]=true;q.Enqueue(n);}
     }
    }
    if(group.Count>3)continue;
    int[] count=new int[pal.Length];
    foreach(int p in group){int x=p%w,y=p/w;for(int dy=-1;dy<=1;dy++)for(int dx=-1;dx<=1;dx++){
     int nx=x+dx,ny=y+dy;if(nx<0||ny<0||nx>=w||ny>=h)continue;
     int c=px[ny*w+nx];if(c!=px[start])count[c]++;
    }}
    int best=0;for(int k=1;k<count.Length;k++)if(count[k]>count[best])best=k;
    foreach(int p in group)next[p]=best;changed+=group.Count;
   }
   px=next;removed+=changed;if(changed==0)break;
  }
  using(Bitmap output=new Bitmap(w,h,PixelFormat.Format32bppArgb)){
   var used=new HashSet<int>();for(int y=0;y<h;y++)for(int x=0;x<w;x++){output.SetPixel(x,y,pal[px[y*w+x]]);used.Add(px[y*w+x]);}
   output.Save(dst,ImageFormat.Png);
   Console.WriteLine(Path.GetFileName(dst)+" "+w+"x"+h+" colors="+used.Count+" cleanedSmallClusterPixels="+removed);
  }
 }
}
'"'@
Add-Type -TypeDefinition "'$source -ReferencedAssemblies System.Drawing
$generated='"'C:/Users/pc/.codex/generated_images/01a21ff8-e260-7e03-b67f-acc4920090e2'
"'$target='"'C:/Users/pc/Documents/game/assets/sprites'
[Kiln09Refine]::Build(\""'$generated/exec-732b695d-b37f-4a3a-ab1c-dfff985bc82d.png","$target/fx/cutin_water.png",560,220,$false)
[Kiln09Refine]::Build("$generated/exec-e98e7ff8-a50d-4956-8076-ba0fe3ea407c.png","$target/fx/cutin_fire.png",560,220,$false)
[Kiln09Refine]::Build("$generated/exec-6587f485-f7e9-4195-8503-0793a9123386.png","$target/fx/cutin_earth.png",560,220,$false)
[Kiln09Refine]::Build("$generated/exec-62429584-8f71-4222-bcc6-64d787c32567.png","$target/ui/title_bg.png",640,400,$true)
' in C:\Users\pc\Documents\game
 succeeded in 1253ms:
cutin_water.png 560x220 colors=18 cleanedSmallClusterPixels=11336
cutin_fire.png 560x220 colors=18 cleanedSmallClusterPixels=9153
cutin_earth.png 560x220 colors=18 cleanedSmallClusterPixels=11576
title_bg.png 640x400 colors=16 cleanedSmallClusterPixels=1671

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command '
Add-Type -AssemblyName System.Drawing
$source=@'"'
using System;
using System.Drawing;
using System.Drawing.Imaging;
using System.Collections.Generic;
public static class Inspect09 {
 public static void Mountains(string src,string dst) {
  using(Bitmap original=new Bitmap(src))
  using(Bitmap image=new Bitmap(dst)) {
   int changed=0;
   for(int y=175;y<263;y++)for(int x=180;x<540;x++) {
    Color c=image.GetPixel(x,y);
    if(c.R"'!=42||c.G!=34||c.B!=54)continue;
    int sx=(int)((x+0.5)*original.Width/640.0);
    int sy=(int)((y+0.5)*Math.Round(original.Height*0.71)/267.0);
    Color s=original.GetPixel(sx,sy);
    if(s.B<58){image.SetPixel(x,y,Color.FromArgb(28,22,34));changed++;}
   }
   using(var copy=new Bitmap(image)) {
    image.Dispose();copy.Save(dst,ImageFormat.Png);
   }
   Console.WriteLine("Title mountain separation: "+changed+" pixels remapped within the permitted palette");
  }
 }
 public static void Check(string path,int expectW,int expectH,int maxColors) {
  var palette=new HashSet<int>();
  foreach(string h in new[]{"282322","120e16","1c1622","2a2236","5a4630","8a6a48","a8862e","e8c35a","fff1c4","b98a5e","7a5a44","e8dcb8","f2e6c8","6f6c66","b0b8c0","dfe6ee","b8463a","7a2a24","6b9878","a6c5a3","ff9a3c"})palette.Add(ColorTranslator.FromHtml("#"+h).ToArgb());
  using(Bitmap b=new Bitmap(path)){
   var colors=new HashSet<int>();int partial=0,outside=0,isolated=0;
   for(int y=0;y<b.Height;y++)for(int x=0;x<b.Width;x++){
    Color c=b.GetPixel(x,y);int own=c.ToArgb();colors.Add(own);
    if(c.A!=255)partial++;
    if(!palette.Contains(own))outside++;
    bool same=false;
    for(int dy=-1;dy<=1&&!same;dy++)for(int dx=-1;dx<=1;dx++){
     if(dx==0&&dy==0)continue;int nx=x+dx,ny=y+dy;
     if(nx>=0&&ny>=0&&nx<b.Width&&ny<b.Height&&b.GetPixel(nx,ny).ToArgb()==own){same=true;break;}
    }
    if(!same)isolated++;
   }
   if(b.Width!=expectW||b.Height!=expectH||colors.Count>maxColors||outside>0||partial>0)throw new Exception("Asset spec mismatch "+path);
   Console.WriteLine(System.IO.Path.GetFileName(path)+": "+b.Width+"x"+b.Height+", "+colors.Count+"/"+maxColors+" colors, off-palette="+outside+", nonopaque="+partial+", isolated single pixels="+isolated);
  }
 }
}
'"'@
Add-Type -TypeDefinition "'$source -ReferencedAssemblies System.Drawing
[Inspect09]::Mountains('"'C:/Users/pc/.codex/generated_images/01a21ff8-e260-7e03-b67f-acc4920090e2/exec-62429584-8f71-4222-bcc6-64d787c32567.png','C:/Users/pc/Documents/game/assets/sprites/ui/title_bg.png')
[Inspect09]::Check('C:/Users/pc/Documents/game/assets/sprites/fx/cutin_water.png',560,220,64)
[Inspect09]::Check('C:/Users/pc/Documents/game/assets/sprites/fx/cutin_fire.png',560,220,64)
[Inspect09]::Check('C:/Users/pc/Documents/game/assets/sprites/fx/cutin_earth.png',560,220,64)
[Inspect09]::Check('C:/Users/pc/Documents/game/assets/sprites/ui/title_bg.png',640,400,96)
git -c core.quotePath=false status --porcelain --untracked-files=all -- assets/sprites
" in C:\Users\pc\Documents\game
 succeeded in 874ms:
Title mountain separation: 3801 pixels remapped within the permitted palette
cutin_water.png: 560x220, 18/64 colors, off-palette=0, nonopaque=0, isolated single pixels=0
cutin_fire.png: 560x220, 18/64 colors, off-palette=0, nonopaque=0, isolated single pixels=0
cutin_earth.png: 560x220, 18/64 colors, off-palette=0, nonopaque=0, isolated single pixels=0
title_bg.png: 640x400, 16/96 colors, off-palette=0, nonopaque=0, isolated single pixels=138
?? assets/sprites/fx/cutin_earth.png
?? assets/sprites/fx/cutin_fire.png
?? assets/sprites/fx/cutin_water.png
?? assets/sprites/ui/title_bg.png

codex
컷신 세 장은 각각 560×220, 18색이며 고립된 1픽셀은 남아 있지 않습니다. 시작 배경도 규격과 빈 공간을 확인했고, 마지막으로 멀리 있는 산 두 겹의 색 경계를 정리하고 있습니다.

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command '
Add-Type -AssemblyName System.Drawing
$im=[System.Drawing.Bitmap]::FromFile('"'C:/Users/pc/.codex/generated_images/01a21ff8-e260-7e03-b67f-acc4920090e2/exec-62429584-8f71-4222-bcc6-64d787c32567.png')
foreach("'$pt in @(@(320,210),@(320,225),@(320,245),@(400,210),@(400,235),@(450,210),@(280,205),@(280,230))) { $sx=[int]($pt[0]*$im.Width/640);$sy=[int]($pt[1]*704/267);$c=$im.GetPixel($sx,$sy);Write-Output "$($pt[0]),$($pt[1]): $($c.R),$($c.G),$($c.B)" }
$im.Dispose()
' in C:\Users\pc\Documents\game
 succeeded in 460ms:
320,210: 20,14,24
320,225: 46,36,58
320,245: 46,36,58
400,210: 60,48,76
400,235: 47,37,59
450,210: 60,47,76
280,205: 46,36,58
280,230: 46,35,58

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command '
Add-Type -AssemblyName System.Drawing
$source=@'"'
using System;using System.Drawing;using System.Drawing.Imaging;using System.Collections.Generic;
public static class FinishTitle09{
 public static void Run(string src,string dst){
  using(Bitmap orig=new Bitmap(src))using(Bitmap b=new Bitmap(dst)){
   Color near=Color.FromArgb(28,22,34),far=Color.FromArgb(42,34,54);
   for(int y=175;y<263;y++)for(int x=180;x<540;x++){
    int c=b.GetPixel(x,y).ToArgb();
    if(c"'!=near.ToArgb()&&c!=far.ToArgb())continue;
    int sx=(int)((x+0.5)*orig.Width/640.0),sy=(int)((y+0.5)*Math.Round(orig.Height*0.71)/267.0);
    int sum=0;for(int dy=-2;dy<=2;dy++)for(int dx=-2;dx<=2;dx++)sum+=orig.GetPixel(sx+dx,sy+dy).B;
    b.SetPixel(x,y,sum/25.0<65?near:far);
   }
   for(int pass=0;pass<6;pass++){
    var changes=new Dictionary<int,Color>();
    for(int y=0;y<b.Height;y++)for(int x=0;x<b.Width;x++){
     int own=b.GetPixel(x,y).ToArgb();bool same=false;var counts=new Dictionary<int,int>();
     for(int dy=-1;dy<=1;dy++)for(int dx=-1;dx<=1;dx++){
      if(dx==0&&dy==0)continue;int nx=x+dx,ny=y+dy;if(nx<0||ny<0||nx>=b.Width||ny>=b.Height)continue;
      int n=b.GetPixel(nx,ny).ToArgb();if(n==own)same=true;if(!counts.ContainsKey(n))counts[n]=0;counts[n]++;
     }
     if(!same){int best=0,num=0;foreach(var pair in counts)if(pair.Value>num){best=pair.Key;num=pair.Value;}changes[y*b.Width+x]=Color.FromArgb(best);}
    }
    foreach(var pair in changes)b.SetPixel(pair.Key%b.Width,pair.Key/b.Width,pair.Value);
    if(changes.Count==0)break;
   }
   var colors=new HashSet<int>();int singleton=0,badAlpha=0;var bottom=new HashSet<int>();
   for(int y=0;y<b.Height;y++)for(int x=0;x<b.Width;x++){
    Color c=b.GetPixel(x,y);colors.Add(c.ToArgb());if(c.A!=255)badAlpha++;if(y>=267)bottom.Add(c.ToArgb());
    bool same=false;for(int dy=-1;dy<=1;dy++)for(int dx=-1;dx<=1;dx++){
     if(dx==0&&dy==0)continue;int nx=x+dx,ny=y+dy;
     if(nx>=0&&ny>=0&&nx<b.Width&&ny<b.Height&&b.GetPixel(nx,ny).ToArgb()==c.ToArgb())same=true;
    }if(!same)singleton++;
   }
   using(var copy=new Bitmap(b)){b.Dispose();copy.Save(dst,ImageFormat.Png);}
   Console.WriteLine("title_bg.png: 640x400, colors="+colors.Count+", nonopaque="+badAlpha+", isolatedSinglePixels="+singleton+", bottomThirdColors="+bottom.Count);
  }
 }
}
'"'@
Add-Type -TypeDefinition "'$source -ReferencedAssemblies System.Drawing
[FinishTitle09]::Run('"'C:/Users/pc/.codex/generated_images/01a21ff8-e260-7e03-b67f-acc4920090e2/exec-62429584-8f71-4222-bcc6-64d787c32567.png','C:/Users/pc/Documents/game/assets/sprites/ui/title_bg.png')
git -c core.quotePath=false status --porcelain
" in C:\Users\pc\Documents\game
 succeeded in 2411ms:
title_bg.png: 640x400, colors=16, nonopaque=0, isolatedSinglePixels=0, bottomThirdColors=2
 M reports/boss/history.csv
 M work/2026-11-27-그림/NOTES.md
 M work/2026-11-27-그림/handoff-03.md
?? assets/sprites/fx/
?? assets/sprites/ui/
?? reports/boss/history-local-backup.csv
?? src/game/pixel_art.gd.uid
?? src/proto/kiln_run.gd.uid
?? src/proto/meta.gd.uid
?? tests/sweep_kiln.gd.uid
?? tests/test_kiln_run.gd.uid
?? work/2026-11-27-그림/compare-03-screens.png
?? work/2026-11-27-그림/compare-03.png
?? work/2026-11-27-그림/handoff-03-run1/
?? work/2026-11-27-그림/handoff-03-run2/
?? work/2026-11-27-그림/handoff-03.report.md
?? work/2026-11-27-그림/screens-02b/
?? work/2026-11-27-그림/screens-03-run1/
?? work/2026-11-27-그림/screens-03-run2/
?? work/2026-11-27-실감/handoff-04.report.md
?? work/2026-11-27-실감/sheet-04.png
?? work/2026-11-28-다듬기/handoff-05.report.md
?? work/2026-11-28-다듬기/handoff-06.report.md
?? work/2026-11-28-다듬기/old-06-soldiers/
?? work/2026-11-28-다듬기/screens-05/
?? work/2026-11-28-다듬기/screens-06/
?? work/2026-11-28-다듬기/sheet-05.png
?? work/2026-11-28-다듬기/sheet-06a.png
?? work/2026-11-28-다듬기/sheet-06b.png
?? work/2026-11-29-스킬진영/handoff-07.report.md
?? work/2026-11-29-스킬진영/screens-07/
?? work/2026-11-29-스킬진영/sheet-07a.png
?? work/2026-11-29-스킬진영/sheet-07b.png
?? work/2026-11-30-UI그림/handoff-08.report.md
?? work/2026-11-30-UI그림/handoff-09.report.md
?? work/2026-11-30-UI그림/screens-08/
?? work/2026-11-30-UI그림/sheet-08.png
?? work/art-ui08/

codex
결과: 통과

바뀐 파일:

- [cutin_water.png](/C:/Users/pc/Documents/game/assets/sprites/fx/cutin_water.png) — 청자 병사 셋과 해일
- [cutin_fire.png](/C:/Users/pc/Documents/game/assets/sprites/fx/cutin_fire.png) — 진사 병사들의 화염 돌격
- [cutin_earth.png](/C:/Users/pc/Documents/game/assets/sprites/fx/cutin_earth.png) — 흑유 병사들의 지면 강타
- [title_bg.png](/C:/Users/pc/Documents/game/assets/sprites/ui/title_bg.png) — 밤마을·가마·두 겹 산 배경

직접 확인한 것:

- 네 장 모두 실제 크기로 열어 확인.
- 컷신 각각 560×220·18색, 시작 배경 640×400·16색.
- 지정 팔레트 밖 색과 고립된 1픽셀 없음.
- 배경 중앙 위쪽·아래 1/3 여백 확보.

그리는 데 쓴 방법:

- 이미지 생성 후 C#으로 축소, 팔레트 고정, 잔점 제거 및 회색 도자기 얼굴 색 보정.

못 한 것 / 걱정되는 것:

- 게임 화면 렌더·저장소 Python 검사·그림 루프 채점은 Claude 확인 단계로 남겼습니다.
- 파일 규격 확인은 통과, 재미·미술 판단은 사용자 몫입니다.
tokens used
65,953
결과: 통과

바뀐 파일:

- [cutin_water.png](/C:/Users/pc/Documents/game/assets/sprites/fx/cutin_water.png) — 청자 병사 셋과 해일
- [cutin_fire.png](/C:/Users/pc/Documents/game/assets/sprites/fx/cutin_fire.png) — 진사 병사들의 화염 돌격
- [cutin_earth.png](/C:/Users/pc/Documents/game/assets/sprites/fx/cutin_earth.png) — 흑유 병사들의 지면 강타
- [title_bg.png](/C:/Users/pc/Documents/game/assets/sprites/ui/title_bg.png) — 밤마을·가마·두 겹 산 배경

직접 확인한 것:

- 네 장 모두 실제 크기로 열어 확인.
- 컷신 각각 560×220·18색, 시작 배경 640×400·16색.
- 지정 팔레트 밖 색과 고립된 1픽셀 없음.
- 배경 중앙 위쪽·아래 1/3 여백 확보.

그리는 데 쓴 방법:

- 이미지 생성 후 C#으로 축소, 팔레트 고정, 잔점 제거 및 회색 도자기 얼굴 색 보정.

못 한 것 / 걱정되는 것:

- 게임 화면 렌더·저장소 Python 검사·그림 루프 채점은 Claude 확인 단계로 남겼습니다.
- 파일 규격 확인은 통과, 재미·미술 판단은 사용자 몫입니다.
