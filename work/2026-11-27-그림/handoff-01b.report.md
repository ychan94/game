OpenAI Codex v0.172.0
--------
workdir: C:\Users\pc\Documents\game
model: gpt-6-astra
provider: openai
approval: never
sandbox: workspace-write [workdir, /tmp, $TMPDIR]
reasoning effort: high
reasoning summaries: none
session id: 01a21b73-a009-79a1-b64b-dd97152c618a
--------
user
# Codex 작업 지시서 — 섞은 그림체 시안 (가 + 다)

- 날짜: 2026-11-27
- 작업 폴더: work/2026-11-27-그림/
- 지시서 번호: 01b

## 먼저 읽을 것
1. AGENTS.md
2. `art/style/ga/` 의 그림 전부 — **형태·디테일·표정의 기준**
3. `art/style/da/` 의 그림 전부 — **색 쓰는 방식의 기준**
4. docs/그림-목록.md 의 공통 규칙

## 목표 (사용자 말 그대로)
> "그림체는 "가"가 창병이라던지, 한옥, 도깨비를 더 잘 표현한 것 같아. 그런데 "다"도 색상은 이후에 어떤게 들어가는 지에 따라서 잘 사용할 수도 있을 것 같아."

해석(참고용): 가의 형태와 다의 색 쓰는 방식을 섞는다. 이 게임에서 색은 게임 정보다 (청자 = 물, 진사 = 불, 흑유 = 땅, 같은 색 3개 = 합동 기술). 그래서 **바탕은 차분하게, 색은 유약·기운에만** 쓴다.

## 그리는 방법 (사용자가 정한 것)
- [x] 이미지 생성 후 코드로 다듬기 (크기 맞추기·배경 투명·색 줄이기) — 사용자가 handoff-01 에서 정함 (2026-11-27)

정한 방법을 쓸 수 없으면 다른 방법으로 바꾸지 말고 `결과: 못 돌림` 으로 보고한다.

## 섞는 규칙

| 무엇 | 어떻게 |
|---|---|
| 형태·디테일·표정 | **가** 처럼: 32×32 에서도 무엇인지 한눈에 |
| 바탕 색 | **다** 처럼: 먹색·흙 회색조로 차분하게 (채도 낮게) |
| 강한 색 | **유약·기운에만**: 청자 비취 초록 / 진사 구리 빨강 / 흑유 검은 갈색 + 기름 광택 |
| 금색 | **요변·전설 같은 특별한 것에만** (이번 시안에서는 쓰지 않는다) |
| 병사 | **"유약 바른 도자기 인형"** 으로 보이게: 사람이 아니라 빚은 인형. 매끈한 몸, 왼쪽 위에 흰 광택 1~2px, 발밑에 작은 받침(굽) |
| 도깨비 | **진사 빨강을 쓰지 않는다.** 먹빛 남색·회청색 피부 + 노란 눈. 아군과 한눈에 구분되게 |
| 외곽선 | 1px, 진한 먹갈색 (가와 다의 중간) |
| 팔레트 | 다섯 장 전체가 같은 팔레트, 24색 이하 |

## 만들 것

| 파일 | 크기 | 내용 |
|---|---|---|
| `art/style/mix/soldier_spear_fire.png` | 32×32 | 진사 유약 창병 (오른쪽을 본다) |
| `art/style/mix/soldier_archer_water.png` | 32×32 | 청자 유약 궁수 |
| `art/style/mix/soldier_shield_earth.png` | 32×32 | 흑유 유약 방패병 |
| `art/style/mix/creature_shield_water.png` | 32×32 | 조개 거북 (괴수 새끼) |
| `art/style/mix/goblin.png` | 32×32 | 도깨비 (왼쪽을 본다) |
| `art/style/mix/house.png` | 32×32 | 초가집/한옥 |
| `art/style/mix/sheet.png` | 자유 | 위 6장을 4배로 키워 나란히 + 팔레트 칸 + **어두운 밤 풀밭 위에 병사 3명과 도깨비 2마리를 1배 크기로 섞어 세운 작은 장면** (실제 게임처럼 보이는지 확인용) |

## 고쳐도 되는 범위
- `art/style/mix/` 폴더 안에 위 표의 새 파일 7개

이 목록에 없는 파일은 만들거나 고치지 않는다. `art/style/ga/`, `art/style/da/` 는 읽기만 한다.

## 보호 검사 결과 (Claude가 미리 확인함)
- `python3 scripts/protected.py art/style/mix/x.png` → 걸린 파일 없음 (새 파일)
- 이 검사는 Claude가 했다. Codex는 다시 돌리지 않는다.

## 하면 안 되는 일
- 범위 밖 파일 수정·삭제 (특히 `art/style/ga/`, `art/style/da/`, `art/references/`, `art/rubric.md`)
- `assets/sprites/` 에 넣기 (시안은 게임에 들어가지 않는다)
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
- 저장소의 Python 검사를 못 돌린 것만으로는 `못 돌림`이 아니다. 검사는 Claude가 한다.

## Claude가 받은 뒤 할 일
1. `git status` — 바뀐 파일이 `art/style/mix/` 7개뿐인지
2. 6장의 크기·투명 배경·색 수 확인 (`check_sprites.py` 와 같은 기준: 24색 이하, 흐린 가장자리 없음)
3. `sheet.png` 를 직접 열어 확인: 병사가 도자기 인형으로 보이는지, 도깨비가 아군과 구분되는지
4. 사용자에게 `art/style/mix/sheet.png` 를 보여 준다 — 그림체 판단은 사용자 몫. Windows 에서 열 때는 경로를 하나씩 직접 적는다 (`$s` 같은 변수를 `start`/`ii` 에 넘기지 않는다)

warning: Codex is ignoring 1 unrecognized configuration setting. Check for typos or deprecated settings.
  user (C:\Users\pc\.codex\config.toml): `computer_use.windows.always_allowed_app_ids` is ignored.
warning: Codex is ignoring 1 unrecognized configuration setting. Check for typos or deprecated settings.
  user (C:\Users\pc\.codex\config.toml): `computer_use.windows.always_allowed_app_ids` is ignored.
codex
이미지 생성 스킬을 사용하겠습니다. ‘가’와 ‘다’의 그림 및 공통 규칙을 확인한 뒤, 이미지를 생성하고 코드로 크기·투명 배경·공통 팔레트를 정리하겠습니다. 수정은 지정된 7개 파일로 제한합니다.

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content AGENTS.md; Get-Content 'C:/Users/pc/.codex/skills/.system/imagegen/SKILL.md'; Get-Content 'docs/그림-목록.md'; Get-Content PROTECTED.txt; git status --porcelain; rg --files art/style/ga art/style/da art/style/mix" in C:\Users\pc\Documents\game
 exited 1 in 372ms:
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
# 洹몃┝ 紐⑸줉 (1遺??쒗뿕??

> 湲곌퀎媛 ?쎈뒗 紐⑸줉: `art/sprite_list.json` 쨌 寃?? `python3 scripts/check_sprites.py`
> 洹몃┝??`assets/sprites/...` ???ｌ쑝硫?寃뚯엫??諛붾줈 洹?洹몃┝???대떎. ?녿뒗 洹몃┝? 吏湲덉쿂???꾪삎?쇰줈 洹몃┛??

## ?쒖꽌

1. **洹몃┝泥??쒖븞 3媛?* (吏?쒖꽌 `work/2026-11-27-洹몃┝/handoff-01.md`) ???ъ슜?먭? ?섎굹 怨좊Ⅸ??
2. 怨좊Ⅸ ?쒖븞??湲곗? 洹몃┝(`art/references/`)?쇰줈 ?붾떎 ??蹂댄샇 ?대뜑??**?ъ슜???덈씫 ?ㅼ뿉** ?ｋ뒗??
3. **媛留덉쓽 蹂묒궗 洹몃┝ 10??* (`handoff-02.md`)
4. **?뚯쓣 ?덈뒗 ??洹몃┝ 12??+ 怨듯넻 7??* (`handoff-03.md`)
5. 留ㅻ쾲 Claude媛 `check_sprites.py` ? 寃뚯엫 ?ㅽ겕由곗꺑?쇰줈 ?뺤씤?섍퀬, ?ъ슜?먯뿉寃?蹂댁뿬 以 ??而ㅻ컠?쒕떎

## 洹몃┝泥??꾨낫 (?쒖븞?먯꽌 鍮꾧탳)

| ?대쫫 | ?먮굦 | ?멸낸??| ??|
|---|---|---|---|
| **媛. ?곕쑜????* | ?쒓뎅 ?꾪넻(?꾩옄湲걔룻븳?Β룸룄源⑤퉬)??李⑤텇?섍퀬 ?곕쑜?섍쾶 | 吏꾪븳 媛덉깋 1px | ?숈깋쨌癒뱀깋 諛뷀깢 + ?좎빟/湲곗슫 ??|
| **?? 諛앹? ?숉솕** | 洹?쎄퀬 ?먮졆?섍쾶, ?λ궃媛?媛숈? ?먮굦 | 寃??1px, 援듭? ?ㅻ（??| 梨꾨룄 ?믪? ??|
| **?? ?섎У ?쎌?** | 癒뱀쑝濡?洹몃┛ ??븳 ?묐갚 + ?ъ씤????| 癒뱀깋, 援듦린 蹂??| 嫄곗쓽 ?묐갚 + 泥?옄 珥덈줉쨌吏꾩궗 鍮④컯쨌湲덉깋留?|

## ?꾩껜 紐⑸줉 (29??

### 媛留덉쓽 蹂묒궗 (10??

| ?뚯씪 | ?ш린 | ?댁슜 |
|---|---|---|
| `kiln/soldier_{spear,archer,shield}_{water,fire,earth}.png` | 32횞32 횞9 | ???명삎 蹂묒궗. 紐⑥뼇 = 李쎈퀝/沅곸닔/諛⑺뙣蹂? ?좎빟 = 泥?옄(鍮꾩랬鍮??뱀깋)/吏꾩궗(援щ━鍮?鍮④컯)/?묒쑀(寃? 媛덉깋). ?ㅻⅨ履쎌쓣 蹂몃떎 |
| `kiln/kiln_body.png` | 160횞160 | ?꾪넻 ?μ옉 媛留??욌え?? 媛?대뜲 臾??먮━? ?꾧턿?대뒗 ?대몼寃?鍮꾩? (臾맞룸텋湲몄? 寃뚯엫??洹몃┝) |

### ?뚯쓣 ?덈뒗 ??(12??

| ?뚯씪 | ?ш린 | ?댁슜 |
|---|---|---|
| `nest/creature_{spear,archer,shield}_{fire,water,earth}.png` | 32횞32 횞9 | 愿댁닔 ?덈겮 9醫? 遺덇퐙 ?꾨쭏諭쨌臾쇱궡 ?섎떖쨌媛??怨좎뒾?꾩튂 / 遺덉뵪 諛뺤쪖쨌臾쇰갑???댄뙆由?룸룎?붾ℓ ?먯댂??/ ?⑹븫 ?먭볼鍮꽷룹“媛?嫄곕턿쨌諛붿쐞 嫄곕턿. ?ㅻⅨ履쎌쓣 蹂몃떎 |
| `nest/egg_{spear,archer,shield}.png` | 32횞40 횞3 | 毓곗” ?뚭린 ??/ 湲몄춬????/ ?볦쟻???? **諛앹? ?곗깋?쇰줈留?* (寃뚯엫??湲곗슫 ?됱쑝濡?臾쇰뱾?? |

### 怨듯넻 (7??

| ?뚯씪 | ?ш린 | ?댁슜 |
|---|---|---|
| `enemy/goblin.png` | 32횞32 | ?꾧묠鍮?(?쇱そ??蹂몃떎) |
| `enemy/imp.png` | 32횞32 | ?꾧묠鍮꾨텋 (?몃Ⅸ 遺덇퐙 ?뺣졊) |
| `enemy/brute.png` | 48횞48 | ???꾧묠鍮?(諛⑸쭩?? |
| `field/grass_a.png`, `grass_b.png` | 32횞32 | 諛??諛????(?댁뼱 遺숈뿬???댁쓬???놁씠) |
| `field/house.png`, `house_broken.png` | 32횞32 | 珥덇?吏??쒖삦, 遺?쒖쭊 紐⑥뒿 |

## 怨듯넻 洹쒖튃

- PNG, ?뺥솗???ш린, ?щ챸 諛곌꼍 (諛붾떏 ??쇰쭔 苑?梨꾩?)
- ?쎌? ?꾪듃: ?먮━寃??ㅻ벉吏 ?딅뒗??(?덊떚?먯씪由ъ뼱???놁쓬), ???μ뿉 ??24媛??댄븯
- ?멸낸??1px, 罹먮┃?곕뒗 媛?대뜲, 諛쒖? ?꾨옒?먯꽌 3~5px ??
- ?꾧뎔? ?ㅻⅨ履? ?곸? ?쇱そ??蹂몃떎
- ?붾?쨌?꾩꽕??臾댁?媛?鍮? ?곹뭹??諛섏쭩?? 留욎븯?????섏뼏寃?踰덉찉?꾩? **寃뚯엫??肄붾뱶濡?* 洹몃┛????洹몃┝???ｌ? ?딅뒗??
# ?ъ슜?먭? 吏곸젒 怨좎튇 ?뚯씪 / ??뼱?곕㈃ ???섎뒗 ?뚯씪 (??以꾩뿉 ?섎굹, glob 媛??
# Claude쨌Codex???ш린 ?곹엺 ?뚯씪????뼱?곗? ?딅뒗?? 怨좎퀜???섎㈃ 諛붽? ?댁슜???쒖븞留??쒕떎.
art/references/*
art/rubric.md
 M assets/fonts/Galmuri11-Bold.ttf.import
 M assets/fonts/Galmuri11.ttf.import
 M "work/2026-11-27-\352\267\270\353\246\274/NOTES.md"
 M "work/2026-11-27-\352\267\270\353\246\274/handoff-01.md"
?? art/style/
?? reports/boss/history-local-backup.csv
?? "work/2026-11-27-\352\267\270\353\246\274/handoff-01.report.md"
?? "work/2026-11-27-\352\267\270\353\246\274/handoff-01b.report.md"
rg: art/style/mix: 지정된 파일을 찾을 수 없습니다. (os error 2)
art/style/da\soldier_spear_fire.png
art/style/da\sheet.png
art/style/da\house.png
art/style/da\goblin.png
art/style/da\creature_shield_water.png
art/style/ga\creature_shield_water.png
art/style/ga\soldier_spear_fire.png
art/style/ga\sheet.png
art/style/ga\house.png
art/style/ga\goblin.png

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Get-Content -Encoding UTF8 'docs/그림-목록.md'; Get-Content -Encoding UTF8 PROTECTED.txt; git status --porcelain; rg --files art/style/ga art/style/da; Get-Content -Encoding UTF8 'C:/Users/pc/.codex/skills/.system/imagegen/SKILL.md' | Select-Object -Last 45" in C:\Users\pc\Documents\game
 succeeded in 407ms:
# 그림 목록 (1분 시험판)

> 기계가 읽는 목록: `art/sprite_list.json` · 검사: `python3 scripts/check_sprites.py`
> 그림을 `assets/sprites/...` 에 넣으면 게임이 바로 그 그림을 쓴다. 없는 그림은 지금처럼 도형으로 그린다.

## 순서

1. **그림체 시안 3개** (지시서 `work/2026-11-27-그림/handoff-01.md`) → 사용자가 하나 고른다
2. 고른 시안을 기준 그림(`art/references/`)으로 둔다 — 보호 폴더라 **사용자 허락 뒤에** 넣는다
3. **가마의 병사 그림 10장** (`handoff-02.md`)
4. **알을 품는 성 그림 12장 + 공통 7장** (`handoff-03.md`)
5. 매번 Claude가 `check_sprites.py` 와 게임 스크린샷으로 확인하고, 사용자에게 보여 준 뒤 커밋한다

## 그림체 후보 (시안에서 비교)

| 이름 | 느낌 | 외곽선 | 색 |
|---|---|---|---|
| **가. 따뜻한 흙** | 한국 전통(도자기·한옥·도깨비)을 차분하고 따뜻하게 | 진한 갈색 1px | 흙색·먹색 바탕 + 유약/기운 색 |
| **나. 밝은 동화** | 귀엽고 또렷하게, 장난감 같은 느낌 | 검정 1px, 굵은 실루엣 | 채도 높은 색 |
| **다. 수묵 픽셀** | 먹으로 그린 듯한 흑백 + 포인트 색 | 먹색, 굵기 변화 | 거의 흑백 + 청자 초록·진사 빨강·금색만 |

## 전체 목록 (29장)

### 가마의 병사 (10장)

| 파일 | 크기 | 내용 |
|---|---|---|
| `kiln/soldier_{spear,archer,shield}_{water,fire,earth}.png` | 32×32 ×9 | 흙 인형 병사. 모양 = 창병/궁수/방패병, 유약 = 청자(비취빛 녹색)/진사(구리빛 빨강)/흑유(검은 갈색). 오른쪽을 본다 |
| `kiln/kiln_body.png` | 160×160 | 전통 장작 가마 앞모습. 가운데 문 자리와 아궁이는 어둡게 비움 (문·불길은 게임이 그림) |

### 알을 품는 성 (12장)

| 파일 | 크기 | 내용 |
|---|---|---|
| `nest/creature_{spear,archer,shield}_{fire,water,earth}.png` | 32×32 ×9 | 괴수 새끼 9종: 불꽃 도마뱀·물살 수달·가시 고슴도치 / 불씨 박쥐·물방울 해파리·돌팔매 원숭이 / 용암 두꺼비·조개 거북·바위 거북. 오른쪽을 본다 |
| `nest/egg_{spear,archer,shield}.png` | 32×40 ×3 | 뾰족 돌기 알 / 길쭉한 알 / 넓적한 알. **밝은 흰색으로만** (게임이 기운 색으로 물들임) |

### 공통 (7장)

| 파일 | 크기 | 내용 |
|---|---|---|
| `enemy/goblin.png` | 32×32 | 도깨비 (왼쪽을 본다) |
| `enemy/imp.png` | 32×32 | 도깨비불 (푸른 불꽃 정령) |
| `enemy/brute.png` | 48×48 | 큰 도깨비 (방망이) |
| `field/grass_a.png`, `grass_b.png` | 32×32 | 밤 풀밭 타일 (이어 붙여도 이음새 없이) |
| `field/house.png`, `house_broken.png` | 32×32 | 초가집/한옥, 부서진 모습 |

## 공통 규칙

- PNG, 정확한 크기, 투명 배경 (바닥 타일만 꽉 채움)
- 픽셀 아트: 흐리게 다듬지 않는다 (안티에일리어싱 없음), 한 장에 색 24개 이하
- 외곽선 1px, 캐릭터는 가운데, 발은 아래에서 3~5px 위
- 아군은 오른쪽, 적은 왼쪽을 본다
- 요변·전설의 무지개 빛, 상품의 반짝임, 맞았을 때 하얗게 번쩍임은 **게임이 코드로** 그린다 — 그림에 넣지 않는다
# 사용자가 직접 고친 파일 / 덮어쓰면 안 되는 파일 (한 줄에 하나, glob 가능)
# Claude·Codex는 여기 적힌 파일을 덮어쓰지 않는다. 고쳐야 하면 바꿀 내용을 제안만 한다.
art/references/*
art/rubric.md
 M assets/fonts/Galmuri11-Bold.ttf.import
 M assets/fonts/Galmuri11.ttf.import
 M "work/2026-11-27-\352\267\270\353\246\274/NOTES.md"
 M "work/2026-11-27-\352\267\270\353\246\274/handoff-01.md"
?? art/style/
?? reports/boss/history-local-backup.csv
?? "work/2026-11-27-\352\267\270\353\246\274/handoff-01.report.md"
?? "work/2026-11-27-\352\267\270\353\246\274/handoff-01b.report.md"
art/style/da\goblin.png
art/style/da\creature_shield_water.png
art/style/da\sheet.png
art/style/da\soldier_spear_fire.png
art/style/da\house.png
art/style/ga\creature_shield_water.png
art/style/ga\soldier_spear_fire.png
art/style/ga\sheet.png
art/style/ga\house.png
art/style/ga\goblin.png
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

codex
‘가’의 창병·한옥·도깨비 형태와 ‘다’의 절제된 색 배치를 확인했습니다. 병사는 유약 광택과 작은 굽을 살리고, 도깨비는 남색 피부와 노란 눈으로 구분하겠습니다. 기존 사용자 변경이 있어 메모 파일도 건드리지 않겠습니다.

mcp: node_repl/js started
mcp: node_repl/js (failed)
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Test-Path 'art/style/mix'; Get-Content -Encoding UTF8 'C:/Users/pc/.codex/skills/.system/imagegen/SKILL.md' | Select-Object -Skip 110 -First 30" in C:\Users\pc\Documents\game
 succeeded in 378ms:
False
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

mcp: node_repl/js started
mcp: node_repl/js (completed)
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Add-Type -AssemblyName System.Drawing; [System.Drawing.Bitmap].FullName; Get-Command node -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Source' in C:\Users\pc\Documents\game
 succeeded in 317ms:
System.Drawing.Bitmap
C:\Program Files\nodejs\node.exe

mcp: node_repl/js started
mcp: node_repl/js (completed)
codex
생성된 궁수와 조개 거북, 집의 원본을 확인했습니다. 이제 32×32로 줄이면서 작은 특징이 사라지지 않도록 확인하고, 여섯 장을 같은 24색 이하 팔레트로 맞추겠습니다.

mcp: node_repl/js started
mcp: node_repl/js (completed)
mcp: node_repl/js started
mcp: node_repl/js (completed)
codex
32×32 축소 결과를 확인했습니다. 궁수의 활과 도깨비의 뿔·눈은 남아 있지만, 창병의 작은 표정과 일부 외곽선은 보정이 필요합니다. 광택과 굽도 정리한 뒤 1배 크기의 밤 풀밭 장면을 만들겠습니다.

mcp: node_repl/js started
mcp: node_repl/js (completed)
mcp: node_repl/js started
mcp: node_repl/js (completed)
mcp: node_repl/js started
mcp: node_repl/js (completed)
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Add-Type -AssemblyName System.Drawing
$sheetPath = '"'C:\\Users\\pc\\Documents\\game\\art\\style\\mix\\sheet.png'
"'$sourceImage = [System.Drawing.Image]::FromFile($sheetPath)
$sheetBitmap = New-Object System.Drawing.Bitmap($sourceImage)
$sourceImage.Dispose()
$graphics = [System.Drawing.Graphics]::FromImage($sheetBitmap)
$graphics.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::SingleBitPerPixelGridFit
$fontCollection = New-Object System.Drawing.Text.PrivateFontCollection
$fontCollection.AddFontFile('"'C:\\Users\\pc\\Documents\\game\\assets\\fonts\\Galmuri11.ttf')
"'$titleFont = New-Object System.Drawing.Font($fontCollection.Families[0], 22, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Pixel)
$smallFont = New-Object System.Drawing.Font($fontCollection.Families[0], 11, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Pixel)
$inkBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(40,35,34))
$graphics.DrawString('"'가 + 다 | 유약 인형 시안', "'$titleFont, $inkBrush, 24, 14)
$graphics.DrawString('"'가의 형태 · 다의 절제된 색 | 32×32 px / 4배 확대 | 강한 색은 유약과 기운에', "'$smallFont, $inkBrush, 24, 46)
$labels = @('"'진사 유약 창병','청자 유약 궁수','흑유 유약 방패병','조개 거북','먹빛 도깨비','초가집 / 한옥')
for ("'$labelIndex=0; $labelIndex -lt 6; $labelIndex++) { $graphics.DrawString($labels[$labelIndex], $smallFont, $inkBrush, (24 + $labelIndex*160), 208) }
$graphics.DrawString('"'공통 팔레트 / 22색 · 노랑은 도깨비 눈에만', "'$smallFont, $inkBrush, 24, 237)
$graphics.DrawString('"'밤 풀밭 배치 / 1배 · 병사 3명 + 도깨비 2마리', "'$smallFont, $inkBrush, 24, 302)
$graphics.DrawString('"'유약 인형: 매끈한 몸 · 왼쪽 위 흰 광택 · 발밑 굽', "'$smallFont, $inkBrush, 376, 332)
$graphics.DrawString('"'진사 = 불 / 청자 = 물 / 흑유 = 땅', "'$smallFont, $inkBrush, 376, 354)
$graphics.DrawString('"'도깨비: 먹빛 남색 피부 + 노란 눈 / 진사 빨강 없음', "'$smallFont, $inkBrush, 376, 376)
$graphics.DrawString('"'형태와 색 구분을 비교하는 시안 · 그림체 판단은 사용자 몫', "'$smallFont, $inkBrush, 376, 404)
$graphics.Dispose()
$sheetBitmap.Save($sheetPath, [System.Drawing.Imaging.ImageFormat]::Png)
$sheetBitmap.Dispose()
$titleFont.Dispose()
$smallFont.Dispose()
$inkBrush.Dispose()
$fontCollection.Dispose()' in C:\Users\pc\Documents\game
 succeeded in 358ms:
codex
여섯 스프라이트와 비교 시트를 저장하고 직접 열어 봤습니다. 시트에는 4배 확대 그림, 공통 팔레트, 병사 3명과 도깨비 2마리의 1배 배치를 넣었습니다. 마지막으로 크기·색 수·투명도와 변경 파일 범위를 확인하겠습니다.

mcp: node_repl/js started
mcp: node_repl/js (completed)
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'git status --porcelain; git ls-files --others --exclude-standard art/style/mix; git diff --stat' in C:\Users\pc\Documents\game
 succeeded in 281ms:
 M assets/fonts/Galmuri11-Bold.ttf.import
 M assets/fonts/Galmuri11.ttf.import
 M "work/2026-11-27-\352\267\270\353\246\274/NOTES.md"
 M "work/2026-11-27-\352\267\270\353\246\274/handoff-01.md"
?? art/style/
?? reports/boss/history-local-backup.csv
?? "work/2026-11-27-\352\267\270\353\246\274/handoff-01.report.md"
?? "work/2026-11-27-\352\267\270\353\246\274/handoff-01b.report.md"
art/style/mix/creature_shield_water.png
art/style/mix/goblin.png
art/style/mix/house.png
art/style/mix/sheet.png
art/style/mix/soldier_archer_water.png
art/style/mix/soldier_shield_earth.png
art/style/mix/soldier_spear_fire.png
warning: in the working copy of 'assets/fonts/Galmuri11-Bold.ttf.import', LF will be replaced by CRLF the next time Git touches it
warning: in the working copy of 'assets/fonts/Galmuri11.ttf.import', LF will be replaced by CRLF the next time Git touches it
warning: in the working copy of 'work/2026-11-27-그림/NOTES.md', LF will be replaced by CRLF the next time Git touches it
 .../2026-11-27-\352\267\270\353\246\274/NOTES.md"  | 44 ++++++++++++++++++++++
 .../handoff-01.md"                                 |  3 +-
 2 files changed, 46 insertions(+), 1 deletion(-)

codex
결과: 통과

바뀐 파일 — `art/style/mix/` 안의 7개:

- `soldier_spear_fire.png` — 진사 창병
- `soldier_archer_water.png` — 청자 궁수
- `soldier_shield_earth.png` — 흑유 방패병
- `creature_shield_water.png` — 조개 거북
- `goblin.png` — 남색 피부·노란 눈 도깨비
- `house.png` — 회갈색 한옥
- [sheet.png](C:/Users/pc/Documents/game/art/style/mix/sheet.png) — 4배 확대·팔레트·밤 풀밭 1배 장면

직접 확인한 것:

- 6장 모두 32×32, 전체 공통 22색, 투명도는 0·255만 사용.
- 발밑 여백 4px. 비교 시트를 열어 형태와 배치를 확인.

그리는 데 쓴 방법:

- **둘 다** — 내장 이미지 생성 후 JavaScript로 축소·팔레트 통일·외곽선과 표정 보정, 코드로 시트 구성.
- 프롬프트 기준: 가의 형태, 다의 절제된 색, 도자기 광택과 굽, 남색 도깨비.

못 한 것 / 걱정되는 것:

- 저장소 Python 검사는 지시대로 실행하지 않았습니다.
- 흑유 방패병은 밤 배경에서 대비가 낮습니다.
- 규격 검사는 통과, 재미·미술 판단은 사용자 몫입니다.
tokens used
107,400
결과: 통과

바뀐 파일 — `art/style/mix/` 안의 7개:

- `soldier_spear_fire.png` — 진사 창병
- `soldier_archer_water.png` — 청자 궁수
- `soldier_shield_earth.png` — 흑유 방패병
- `creature_shield_water.png` — 조개 거북
- `goblin.png` — 남색 피부·노란 눈 도깨비
- `house.png` — 회갈색 한옥
- [sheet.png](C:/Users/pc/Documents/game/art/style/mix/sheet.png) — 4배 확대·팔레트·밤 풀밭 1배 장면

직접 확인한 것:

- 6장 모두 32×32, 전체 공통 22색, 투명도는 0·255만 사용.
- 발밑 여백 4px. 비교 시트를 열어 형태와 배치를 확인.

그리는 데 쓴 방법:

- **둘 다** — 내장 이미지 생성 후 JavaScript로 축소·팔레트 통일·외곽선과 표정 보정, 코드로 시트 구성.
- 프롬프트 기준: 가의 형태, 다의 절제된 색, 도자기 광택과 굽, 남색 도깨비.

못 한 것 / 걱정되는 것:

- 저장소 Python 검사는 지시대로 실행하지 않았습니다.
- 흑유 방패병은 밤 배경에서 대비가 낮습니다.
- 규격 검사는 통과, 재미·미술 판단은 사용자 몫입니다.
