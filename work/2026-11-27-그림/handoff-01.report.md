OpenAI Codex v0.172.0
--------
workdir: C:\Users\pc\Documents\game
model: gpt-6-astra
provider: openai
approval: never
sandbox: workspace-write [workdir, /tmp, $TMPDIR]
reasoning effort: high
reasoning summaries: none
session id: 01a21b5b-7bf9-7810-866e-270c51f0beb0
--------
user
# Codex 작업 지시서 — 그림체 시안 3개

- 날짜: 2026-11-27
- 작업 폴더: work/2026-11-27-그림/
- 지시서 번호: 01

## 먼저 읽을 것
1. AGENTS.md
2. docs/그림-목록.md (전체 그림 목록과 그림체 후보 가·나·다)
3. art/sprite_list.json (그림마다 크기와 설명)
4. docs/기획안-비교.md 의 "B 가마의 병사", "A 알을 품는 성" (게임의 분위기)

## 목표 (사용자 말 그대로)
> "지금보니까 체험판이라기에 너무 디자인이 아쉬워. codex를 통해 이미지나 외형 디자인이 어느 정도 되야 느낌이 있을 것 같아."

해석(참고용): 전체 29장을 그리기 전에, 그림체를 고를 수 있도록 **후보 3개의 시안**을 만든다. 사용자가 하나를 고르면 그 시안이 앞으로의 기준 그림이 된다.

## 그리는 방법 (사용자가 정한 것)
- [ ] 이미지 생성 기능(image_gen)으로 그린다
- [ ] 코드로 직접 그린다
- [x] 이미지 생성 후 코드로 다듬기 (크기 맞추기·배경 투명·색 줄이기) ← 사용자가 정함 (2026-11-27 "이미지 생성 후 코드로 다듬기")

정한 방법을 쓸 수 없으면 다른 방법으로 바꾸지 말고 `결과: 못 돌림` 으로 보고한다.

## 만들 것
그림체 후보 가(따뜻한 흙)·나(밝은 동화)·다(수묵 픽셀) 각각에 대해 **같은 4가지**를 그린다. 크기와 규칙은 docs/그림-목록.md 의 공통 규칙과 같다.

| 파일 | 크기 | 내용 |
|---|---|---|
| `art/style/{ga,na,da}/soldier_spear_fire.png` | 32×32 | 진사 유약 창병 (흙 인형 병사) |
| `art/style/{ga,na,da}/creature_shield_water.png` | 32×32 | 조개 거북 (괴수 새끼) |
| `art/style/{ga,na,da}/goblin.png` | 32×32 | 도깨비 (왼쪽을 본다) |
| `art/style/{ga,na,da}/house.png` | 32×32 | 초가집/한옥 |
| `art/style/{ga,na,da}/sheet.png` | 자유 | 위 4장을 4배로 키워 나란히 놓고, 아래에 그 그림체에서 쓸 색(팔레트) 칸을 그린 비교용 한 장 |

## 고쳐도 되는 범위
- `art/style/` 폴더 안에 새 파일 만들기 (위 표의 15개)

이 목록에 없는 파일은 만들거나 고치지 않는다.

## 보호 검사 결과 (Claude가 미리 확인함)
- `python3 scripts/protected.py art/style/x.png` → 걸린 파일 없음 (새 파일)
- 2026-11-27 다시 확인: `python scripts/protected.py art/style/x.png` → 걸린 파일 없음 (art/style/ 폴더는 아직 없음)
- 이 검사는 Claude가 했다. Codex는 다시 돌리지 않는다.

## 하면 안 되는 일
- 범위 밖 파일 수정·삭제
- PROTECTED.txt 에 있는 파일 (art/references/, art/rubric.md) 건드리기
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
만든 그림:
- 경로
그리는 데 쓴 방법:
- 이미지 생성 / 코드 / 둘 다 (무엇을 어떻게)
못 한 것 / 걱정되는 것:
- …
```
- 통과: 목표대로 만들었다
- 실패: 만들었지만 목표에 못 미친다 (이유를 적는다)
- 못 돌림: 도구·권한·파일이 없어서 작업 자체를 하지 못했다 (무엇이 없었는지 적는다)
- 저장소의 Python 검사를 못 돌린 것만으로는 `못 돌림`이 아니다. 검사는 Claude가 한다.

## Claude가 받은 뒤 할 일
1. 바뀐 파일이 `art/style/` 안의 15개뿐인지 `git status` 로 확인
2. 4장씩 크기·투명 배경 확인 (`check_sprites.py` 와 같은 기준), `sheet.png` 3장을 직접 열어 보기
3. 사용자에게 시트 3장을 보여 주고 고르게 한다 — **그림체 판단은 사용자 몫**
4. 고른 시안을 `art/references/` 에 넣는 것은 사용자 허락을 받은 뒤

warning: Codex is ignoring 1 unrecognized configuration setting. Check for typos or deprecated settings.
  user (C:\Users\pc\.codex\config.toml): `computer_use.windows.always_allowed_app_ids` is ignored.
warning: Codex is ignoring 1 unrecognized configuration setting. Check for typos or deprecated settings.
  user (C:\Users\pc\.codex\config.toml): `computer_use.windows.always_allowed_app_ids` is ignored.
codex
이미지 생성 skill을 사용해 세 그림체 시안을 만들겠습니다. 먼저 지정 문서와 보호 목록을 읽고, 생성한 그림을 코드로 32×32·투명 배경·제한 팔레트에 맞추겠습니다. 이번 지시의 파일 범위에 따라 작업 메모는 만들지 않고, `art/style/`의 15개 파일만 만들겠습니다.

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath AGENTS.md, PROTECTED.txt, 'docs/그림-목록.md', art/sprite_list.json, 'docs/기획안-비교.md', 'C:/Users/pc/.codex/skills/.system/imagegen/SKILL.md'; git status --porcelain" in C:\Users\pc\Documents\game
 succeeded in 413ms:
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
# ?ъ슜?먭? 吏곸젒 怨좎튇 ?뚯씪 / ??뼱?곕㈃ ???섎뒗 ?뚯씪 (??以꾩뿉 ?섎굹, glob 媛??
# Claude쨌Codex???ш린 ?곹엺 ?뚯씪????뼱?곗? ?딅뒗?? 怨좎퀜???섎㈃ 諛붽? ?댁슜???쒖븞留??쒕떎.
art/references/*
art/rubric.md
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
{
 "version": 1,
 "怨듯넻 洹쒖튃": [
  "PNG, ?뺥솗???곹엺 ?ш린 (?? 32횞32). ?ш린媛 ?ㅻⅤ硫?寃?ъ뿉???ㅽ뙣",
  "?щ챸 諛곌꼍 (tile ??true ??諛붾떏 ??쇰쭔 苑?梨꾩?)",
  "?쎌? ?꾪듃: 怨꾨떒 ?꾩긽??洹몃?濡??붾떎 (遺?쒕읇寃??먮━吏 ?딆쓬, ?덊떚?먯씪由ъ뼱???놁쓬)",
  "?멸낸??1px (洹몃┝泥??쒖븞?먯꽌 ?뺥븳 ??",
  "洹몃┝ ???μ뿉 ??24媛??댄븯",
  "罹먮┃?곕뒗 媛?대뜲, 諛쒖? ?꾨옒?먯꽌 3~5px ??,
  "?꾧뎔(蹂묒궗쨌愿댁닔)? ?ㅻⅨ履? ???꾧묠鍮?? ?쇱そ??蹂몃떎"
 ],
 "files": [
  {
   "path": "assets/sprites/kiln/soldier_spear_water.png",
   "size": [
    32,
    32
   ],
   "group": "媛留덉쓽 蹂묒궗",
   "what": "?숈쑝濡?鍮싳? ?묒? ?명삎 蹂묒궗(李쎈퀝). 李쎌쓣 ??紐⑥뒿. 紐??꾩껜??泥?옄 ?좎빟 ??鍮꾩랬鍮??몃Ⅸ ?뱀깋, ????愿묓깮. ?ㅻⅨ履쎌쓣 蹂몃떎."
  },
  {
   "path": "assets/sprites/kiln/soldier_spear_fire.png",
   "size": [
    32,
    32
   ],
   "group": "媛留덉쓽 蹂묒궗",
   "what": "?숈쑝濡?鍮싳? ?묒? ?명삎 蹂묒궗(李쎈퀝). 李쎌쓣 ??紐⑥뒿. 紐??꾩껜??吏꾩궗 ?좎빟 ??援щ━鍮?源딆? 遺됱??? ?ㅻⅨ履쎌쓣 蹂몃떎."
  },
  {
   "path": "assets/sprites/kiln/soldier_spear_earth.png",
   "size": [
    32,
    32
   ],
   "group": "媛留덉쓽 蹂묒궗",
   "what": "?숈쑝濡?鍮싳? ?묒? ?명삎 蹂묒궗(李쎈퀝). 李쎌쓣 ??紐⑥뒿. 紐??꾩껜???묒쑀 ?좎빟 ??寃? 媛덉깋, 湲곕쫫 媛숈? 愿묓깮. ?ㅻⅨ履쎌쓣 蹂몃떎."
  },
  {
   "path": "assets/sprites/kiln/soldier_archer_water.png",
   "size": [
    32,
    32
   ],
   "group": "媛留덉쓽 蹂묒궗",
   "what": "?숈쑝濡?鍮싳? ?묒? ?명삎 蹂묒궗(沅곸닔). ?쒖쓣 ??紐⑥뒿. 紐??꾩껜??泥?옄 ?좎빟 ??鍮꾩랬鍮??몃Ⅸ ?뱀깋, ????愿묓깮. ?ㅻⅨ履쎌쓣 蹂몃떎."
  },
  {
   "path": "assets/sprites/kiln/soldier_archer_fire.png",
   "size": [
    32,
    32
   ],
   "group": "媛留덉쓽 蹂묒궗",
   "what": "?숈쑝濡?鍮싳? ?묒? ?명삎 蹂묒궗(沅곸닔). ?쒖쓣 ??紐⑥뒿. 紐??꾩껜??吏꾩궗 ?좎빟 ??援щ━鍮?源딆? 遺됱??? ?ㅻⅨ履쎌쓣 蹂몃떎."
  },
  {
   "path": "assets/sprites/kiln/soldier_archer_earth.png",
   "size": [
    32,
    32
   ],
   "group": "媛留덉쓽 蹂묒궗",
   "what": "?숈쑝濡?鍮싳? ?묒? ?명삎 蹂묒궗(沅곸닔). ?쒖쓣 ??紐⑥뒿. 紐??꾩껜???묒쑀 ?좎빟 ??寃? 媛덉깋, 湲곕쫫 媛숈? 愿묓깮. ?ㅻⅨ履쎌쓣 蹂몃떎."
  },
  {
   "path": "assets/sprites/kiln/soldier_shield_water.png",
   "size": [
    32,
    32
   ],
   "group": "媛留덉쓽 蹂묒궗",
   "what": "?숈쑝濡?鍮싳? ?묒? ?명삎 蹂묒궗(諛⑺뙣蹂?. ?κ렐 諛⑺뙣瑜???紐⑥뒿. 紐??꾩껜??泥?옄 ?좎빟 ??鍮꾩랬鍮??몃Ⅸ ?뱀깋, ????愿묓깮. ?ㅻⅨ履쎌쓣 蹂몃떎."
  },
  {
   "path": "assets/sprites/kiln/soldier_shield_fire.png",
   "size": [
    32,
    32
   ],
   "group": "媛留덉쓽 蹂묒궗",
   "what": "?숈쑝濡?鍮싳? ?묒? ?명삎 蹂묒궗(諛⑺뙣蹂?. ?κ렐 諛⑺뙣瑜???紐⑥뒿. 紐??꾩껜??吏꾩궗 ?좎빟 ??援щ━鍮?源딆? 遺됱??? ?ㅻⅨ履쎌쓣 蹂몃떎."
  },
  {
   "path": "assets/sprites/kiln/soldier_shield_earth.png",
   "size": [
    32,
    32
   ],
   "group": "媛留덉쓽 蹂묒궗",
   "what": "?숈쑝濡?鍮싳? ?묒? ?명삎 蹂묒궗(諛⑺뙣蹂?. ?κ렐 諛⑺뙣瑜???紐⑥뒿. 紐??꾩껜???묒쑀 ?좎빟 ??寃? 媛덉깋, 湲곕쫫 媛숈? 愿묓깮. ?ㅻⅨ履쎌쓣 蹂몃떎."
  },
  {
   "path": "assets/sprites/kiln/kiln_body.png",
   "size": [
    160,
    160
   ],
   "group": "媛留덉쓽 蹂묒궗",
   "what": "?꾪넻 ?μ옉 媛留??ㅻ쫫媛留??κ렐 ?숆?留????욌え?? 媛?대뜲 ?꾩튂??臾??먮━(媛濡?媛?대뜲 55%, ?꾩뿉??20~78%)? ?꾨옒履??꾧턿???먮━??嫄곗쓽 寃??됱쑝濡?鍮꾩썙 ?붾떎 ??臾맞룸텋湲맞룸튆? 寃뚯엫??洹??꾩뿉 洹몃┛??"
  },
  {
   "path": "assets/sprites/nest/creature_spear_fire.png",
   "size": [
    32,
    32
   ],
   "group": "?뚯쓣 ?덈뒗 ??,
   "what": "'遺덇퐙 ?꾨쭏諭' ??洹?쎄퀬 ?묒? 愿댁닔 ?덈겮. 怨듦꺽??毓곗”??. ?ㅻⅨ履쎌쓣 蹂몃떎."
  },
  {
   "path": "assets/sprites/nest/creature_spear_water.png",
   "size": [
    32,
    32
   ],
   "group": "?뚯쓣 ?덈뒗 ??,
   "what": "'臾쇱궡 ?섎떖' ??洹?쎄퀬 ?묒? 愿댁닔 ?덈겮. 怨듦꺽??毓곗”??. ?ㅻⅨ履쎌쓣 蹂몃떎."
  },
  {
   "path": "assets/sprites/nest/creature_spear_earth.png",
   "size": [
    32,
    32
   ],
   "group": "?뚯쓣 ?덈뒗 ??,
   "what": "'媛??怨좎뒾?꾩튂' ??洹?쎄퀬 ?묒? 愿댁닔 ?덈겮. 怨듦꺽??毓곗”??. ?ㅻⅨ履쎌쓣 蹂몃떎."
  },
  {
   "path": "assets/sprites/nest/creature_archer_fire.png",
   "size": [
    32,
    32
   ],
   "group": "?뚯쓣 ?덈뒗 ??,
   "what": "'遺덉뵪 諛뺤쪖' ??洹?쎄퀬 ?묒? 愿댁닔 ?덈겮. ?먭굅由ы삎(?좊떎?덇굅???섏쭚). ?ㅻⅨ履쎌쓣 蹂몃떎."
  },
  {
   "path": "assets/sprites/nest/creature_archer_water.png",
   "size": [
    32,
    32
   ],
   "group": "?뚯쓣 ?덈뒗 ??,
   "what": "'臾쇰갑???댄뙆由? ??洹?쎄퀬 ?묒? 愿댁닔 ?덈겮. ?먭굅由ы삎(?좊떎?덇굅???섏쭚). ?ㅻⅨ履쎌쓣 蹂몃떎."
  },
  {
   "path": "assets/sprites/nest/creature_archer_earth.png",
   "size": [
    32,
    32
   ],
   "group": "?뚯쓣 ?덈뒗 ??,
   "what": "'?뚰뙏留??먯댂?? ??洹?쎄퀬 ?묒? 愿댁닔 ?덈겮. ?먭굅由ы삎(?좊떎?덇굅???섏쭚). ?ㅻⅨ履쎌쓣 蹂몃떎."
  },
  {
   "path": "assets/sprites/nest/creature_shield_fire.png",
   "size": [
    32,
    32
   ],
   "group": "?뚯쓣 ?덈뒗 ??,
   "what": "'?⑹븫 ?먭볼鍮? ??洹?쎄퀬 ?묒? 愿댁닔 ?덈겮. ?섎퉬???깅뵳吏쨌?⑤떒??. ?ㅻⅨ履쎌쓣 蹂몃떎."
  },
  {
   "path": "assets/sprites/nest/creature_shield_water.png",
   "size": [
    32,
    32
   ],
   "group": "?뚯쓣 ?덈뒗 ??,
   "what": "'議곌컻 嫄곕턿' ??洹?쎄퀬 ?묒? 愿댁닔 ?덈겮. ?섎퉬???깅뵳吏쨌?⑤떒??. ?ㅻⅨ履쎌쓣 蹂몃떎."
  },
  {
   "path": "assets/sprites/nest/creature_shield_earth.png",
   "size": [
    32,
    32
   ],
   "group": "?뚯쓣 ?덈뒗 ??,
   "what": "'諛붿쐞 嫄곕턿' ??洹?쎄퀬 ?묒? 愿댁닔 ?덈겮. ?섎퉬???깅뵳吏쨌?⑤떒??. ?ㅻⅨ履쎌쓣 蹂몃떎."
  },
  {
   "path": "assets/sprites/nest/egg_spear.png",
   "size": [
    32,
    40
   ],
   "group": "?뚯쓣 ?덈뒗 ??,
   "what": "寃됱뿉 ?묒? 毓곗” ?뚭린媛 ?덈뒗 ?? ?꾩＜ 諛앹? ?곗깋/?고쉶?됱쑝濡쒕쭔 移좏븳??(寃뚯엫??湲곗슫 ?됱쑝濡?臾쇰뱾?몃떎). 湲덉? 洹몃━吏 ?딅뒗??"
  },
  {
   "path": "assets/sprites/nest/egg_archer.png",
   "size": [
    32,
    40
   ],
   "group": "?뚯쓣 ?덈뒗 ??,
   "what": "湲몄춬?섍퀬 媛???? ?꾩＜ 諛앹? ?곗깋/?고쉶?됱쑝濡쒕쭔 移좏븳??(寃뚯엫??湲곗슫 ?됱쑝濡?臾쇰뱾?몃떎). 湲덉? 洹몃━吏 ?딅뒗??"
  },
  {
   "path": "assets/sprites/nest/egg_shield.png",
   "size": [
    32,
    40
   ],
   "group": "?뚯쓣 ?덈뒗 ??,
   "what": "?κ?怨??볦쟻???? ?꾩＜ 諛앹? ?곗깋/?고쉶?됱쑝濡쒕쭔 移좏븳??(寃뚯엫??湲곗슫 ?됱쑝濡?臾쇰뱾?몃떎). 湲덉? 洹몃━吏 ?딅뒗??"
  },
  {
   "path": "assets/sprites/enemy/goblin.png",
   "size": [
    32,
    32
   ],
   "group": "怨듯넻 (??",
   "what": "?쒓뎅 ?꾧묠鍮? 遺됱? 媛덉깋 ?쇰?, 肉??섎굹 ?먮뒗 ?? ?λ궃?ㅻ읇怨??щ굹???쇨뎬. ?쇱そ??蹂몃떎."
  },
  {
   "path": "assets/sprites/enemy/imp.png",
   "size": [
    32,
    32
   ],
   "group": "怨듯넻 (??",
   "what": "?꾧묠鍮꾨텋. ?몃Ⅸ 遺덇퐙 紐⑥뼇???묒? ?뺣졊, ?덈쭔 ?덈떎. ?쇱そ??蹂몃떎."
  },
  {
   "path": "assets/sprites/enemy/brute.png",
   "size": [
    48,
    48
   ],
   "group": "怨듯넻 (??",
   "what": "???꾧묠鍮? ?⑹튂 ?ш퀬 ?꾧묠鍮?諛⑸쭩?대? ?좊떎. ?쇱そ??蹂몃떎."
  },
  {
   "path": "assets/sprites/field/grass_a.png",
   "size": [
    32,
    32
   ],
   "group": "怨듯넻 (?ㅽ뙋)",
   "tile": true,
   "what": "諛ㅼ쓽 ?諛?諛붾떏 ??? ?щ갑?쇰줈 ?댁뼱 遺숈뿬???댁쓬?덇? ??蹂댁뿬???쒕떎. ?대몼怨?李⑤텇?섍쾶 (罹먮┃?곌? ??蹂댁씠?꾨줉)."
  },
  {
   "path": "assets/sprites/field/grass_b.png",
   "size": [
    32,
    32
   ],
   "group": "怨듯넻 (?ㅽ뙋)",
   "tile": true,
   "what": "grass_a ? 嫄곗쓽 媛숆퀬 ? 臾대뒳留?議곌툑 ?ㅻⅨ ???(踰덇컝??源먮떎)."
  },
  {
   "path": "assets/sprites/field/house.png",
   "size": [
    32,
    32
   ],
   "group": "怨듯넻 (?ㅽ뙋)",
   "what": "?묒? 珥덇?吏??먮뒗 ?쒖삦 (吏耳쒖빞 ??留덉쓣). 李쎌뿉 遺덈튆."
  },
  {
   "path": "assets/sprites/field/house_broken.png",
   "size": [
    32,
    32
   ],
   "group": "怨듯넻 (?ㅽ뙋)",
   "what": "house 媛 遺?쒖?怨?遺덉씠 爰쇱쭊 紐⑥뒿."
  }
 ]
}
# 湲고쉷????媛吏 鍮꾧탳 (2026-11-27)

> ?щ????꾩쭅 **媛??*?대떎. 1遺??쒗뿕?먯쑝濡??ъ슜?먭? 吏곸젒 ?뺤씤?쒕떎.

## 異쒕컻?? ?ъ슜?먭? ?먰븯???щ?

?ъ슜??留?(2026-11-27):
- "?먮?由쇰낫??寃곗젙怨?怨듦컻???쒓컙???먭뺨吏???꾪뙆誘?媛숈? 寃?醫뗭? 寃?媛숈븘."
- "寃뚯엫?섎뒗 ?щ엺??湲댁옣媛먯쓣 ?먮겮怨??듭풄?⑤룄 ?먮겮怨??깆옣??寃쏀뿕?섎㈃ 醫뗪쿋??"
- "醫뗭? ?꾩씠?쒖쓣 ?댁씠 醫뗪쾶 媛吏寃??섏뿀?꾨븣, ?닿? ?먰븯?붾?濡??깆옣?닿컝 ???덈Т 醫뗭븯??寃?媛숈븘."
- ?レ뿀??寃? "怨쇨툑???섎ŉ 寃뚯엫?덉?留?怨쇨툑?섏? ?딆? 臾닿낵湲?罹먮┃?곌? ??媛뺥븷 ?뚭? ?덉뿀吏. 洹몃윴 寃쎌슦???덈Т ?듭슱?섍퀬 吏쒖쬆???섍릿 ?덉뼱."

**???먯뿉 ?곗졇????媛먯젙 ?쒖꽌:** 湲댁옣(??踰???) ??怨듦컻(?먭렐!) ???먰븯???濡??닿? 鍮꾪듉 ?뺣쪧) ??媛뺥빐吏?泥닿컧 ???듭풄(?몄뼱踰꾨━湲? ???깆옣(???ъ씠)

## ?꾩씠?붿뼱瑜??대뒗 諛⑸쾿 (?대쾲?????쒖꽌)

1. **媛먯젙 ?쒖꽌瑜?癒쇱? ?뺥븳??* (??. 洹쒖튃? 洹몃떎??
2. **?꾩떎?먯꽌 ?대? ?먭렐嫄곕━??'怨듦컻' ?됰룞??李얜뒗??* ???뚯씠 源⑥????쒓컙, 媛留?臾몄쓣 ?щ뒗 ?쒓컙, 洹몃Ъ???뚯뼱 ?щ━???쒓컙. ?щ엺?ㅼ씠 ?대? ?꾨뒗 ?먭렐嫄곕┝?대씪 ?ㅻ챸???꾩슂 ?녿떎.
3. **洹?怨듦컻??'?닿? 鍮꾪? ?먯옟??瑜??⑤떎** ??癒뱀씠, ?좎빟, 源딆씠. ?대쭔 ?덉쑝硫??듭슱?섍퀬, ?먯옟?닿? ?덉쑝硫?"?닿? ?대깉??媛 ?쒕떎.
4. **寃곌낵瑜??듭풄???꾪닾濡??뉖뒗??* ???먮?由????諛곗튂?섍퀬 吏耳쒕낫??諛⑹뼱?? ?レ옄媛 ?곗????곗텧.
5. **?듭슱??諛⑹? ?μ튂瑜??ｋ뒗??* (?꾨옒 怨듯넻 洹쒖튃).
6. **?ㅽ??먯꽌 寃뱀튂??寃뚯엫??李얜뒗??** 寃뱀튂硫?踰꾨━嫄곕굹 諛붽씔??(?대쾲??'寃쎈ℓ?? 援ъ긽? *Myriad Auction* 怨??듭떖??媛숈븘 踰꾨졇??.

## 怨듯넻 洹쒖튃: ?듭슱?섏? ?딆? ??

| 洹쒖튃 | ??|
|---|---|
| **?댁? '?쇰쭏???믪씠'瑜? 以鍮꾨뒗 '理쒖냼???대쭔?????뺥븳??* | 以鍮꾨? ?섑븯硫??댁씠 ?섎튌??瑗??쇱젙 ?댁긽 ?섏삩?? ?댁씠 醫뗭쑝硫?洹??꾨줈 ?곗쭊??|
| **?꾪뿕? ?덉뿉 蹂댁씤??* | "湲???以?= 源⑥쭏 ?뺣쪧 40%" 泥섎읆 ?レ옄쨌洹몃┝?쇰줈 蹂댁뿬 以?? 紐곕옒 吏?????놁쓬 |
| **?ㅽ뙣???볦씤??* | 源⑥?嫄곕굹 ?볦퀜??議곌컖쨌寃쏀뿕???④퀬, ?쇱젙??紐⑥씠硫??뺤젙?쇰줈 ?삳뒗??|
| **?덉쑝濡?媛뺥빐吏吏 ?딅뒗??* | ?ㅽ??먯꽌 ??踰??щ뒗 寃뚯엫. 怨쇨툑?쇰줈 媛뺥빐吏??援ъ“ ?놁쓬 |

---

## 湲고쉷??A ???뚯쓣 ?덈뒗 ??(?섏쭛쨌?좎갑??

**??以?** ??뿉???꾪뿕??嫄멸퀬 ?뚯쓣 ?덉뼱 愿댁닔瑜?源⑥슦怨? 諛ㅼ뿉??洹?愿댁닔?ㅻ줈 ?μ?瑜?吏?⑤떎.

| ?쒓컙 | ?섎뒗 ??|
|---|---|
| 湲댁옣 | ?뚯쓣 ??踰????곗슱?섎줉 媛뺥빐吏吏留? 湲덉씠 ?섏뼱 ?곗쭏 ?꾪뿕 |
| 怨듦컻 | ?뚯씠 源⑥?硫?鍮쏄낵 ?④퍡 愿댁닔 ?깆옣 (?ш??좎닔濡??붾젮?섍쾶) |
| ?먰븯???濡?| 癒뱀씠濡??깆쭏??湲곗슱?몃떎 (遺??대ℓ ??遺?愿댁닔). 媛숈? 怨꾩뿴 紐⑥쑝硫?臾대━ ?④낵 |
| ?듭풄 | 諛ㅼ뿉 紐곕젮?ㅻ뒗 ?곸쓣 臾대━ ?④낵濡??쒓볼踰덉뿉 ?몄뼱踰꾨┝ |
| ?깆옣 | ?μ?媛 ?먮씪怨??덈뒗 ?먮━쨌癒뱀씠쨌??醫낅쪟), 愿댁닔 ?꾧컧??梨꾩썙吏꾨떎 |

- **?듭슱??諛⑹?:** ?뚯씠 ?곗졇??猿띿쭏 議곌컖???⑥븘, 10媛?紐⑥쑝硫??먰븯??怨꾩뿴 ???뺤젙
- **鍮꾩듂??寃뚯엫:** Birb(?μ?쨌???덇린), Defend The Nest(?μ? 諛⑹뼱). ?꾪뿕 嫄멸퀬 ?덇린 + 諛⑹뼱 議고빀? 紐?李얠쓬
- **媛뺤젏:** 洹?ъ슫 愿댁닔???꾧뎄??醫뗭븘?섍퀬 ?좎갑???앷릿?? 32횞32 愿댁닔 洹몃━湲?醫뗭쓬
- **?쎌젏:** "紐ъ뒪???섏쭛"? ?뷀븳 ?뚯옱???곸젏 ?섏씠吏?먯꽌 ?덉뿉 ???????덈떎
- **?ш린:** 以묎컙 (愿댁닔 醫낅쪟쨌臾대━ ?④낵 ?ㅺ퀎媛 留롮쓬)

## 湲고쉷??B ??媛留덉쓽 蹂묒궗 (?쒖옉쨌議고빀??

**??以?** ?숈쑝濡?蹂묒궗瑜?鍮싰퀬, ?좎빟??諛붾Ⅴ怨? 遺덉쓣 ?щ젮 援쎈뒗?? 媛留?臾몄쓣 ?대㈃ 蹂묒궗?ㅼ씠 嫄몄뼱 ?섏? 留덉쓣??吏?⑤떎.

| ?쒓컙 | ?섎뒗 ??|
|---|---|
| 湲댁옣 | 遺덉쓣 ???щ┫?섎줉 **?붾?(囹?츏, 媛留??띿뿉???곗뿰???앷린??洹??鍮쏄퉼)** ???섏삱 ?뺣쪧???ㅻⅤ吏留? 湲?媛怨?源⑥쭏 ?꾪뿕???ㅻⅨ??|
| 怨듦컻 | ?곌린媛 嫄룻엳硫?媛留?臾몄씠 ?대━???쒓컙 ??以꾩?????蹂묒궗?ㅼ쓽 鍮쏄퉼???쒕윭?쒕떎 |
| ?먰븯???濡?| **鍮싲뒗 紐⑥뼇 = 蹂묎낵** (李쎈퀝쨌沅곸닔쨌諛⑺뙣), **?좎빟 = ?띿꽦** (泥?옄=臾? 吏꾩궗=遺? ?묒쑀=??. 議고빀?쇰줈 援곕?瑜??ㅺ퀎 |
| ?듭풄 | ?붾? 蹂묒궗 ?섎굹媛 ?꾩옣???ㅼ쭛怨? 媛숈? ?좎빟 蹂묒궗?ㅼ씠 ?④퍡 湲곗닠???곕쑉由?|
| ?깆옣 | 媛留덇? 而ㅼ?怨???踰덉뿉 援쎈뒗 ??, ???쇑룹쑀?승룸え?묒씠 ?대┛?? 源⑥쭊 蹂묒궗??議곌컖?쇰줈 ?ㅼ쓬 ???좎빟??留뚮뱺??|

- **?듭슱??諛⑹?:** 遺??멸린瑜??덉쟾 援ш컙???먮㈃ '蹂댄넻 ?덉쭏'? 諛섎뱶???섏삩?? ?붾?? ?꾪뿕 援ш컙?먯꽌留? 源⑥쭊 議곌컖? ?щ즺濡??뚯븘?⑤떎
- **鍮꾩듂??寃뚯엫:** ?꾩옄湲?濡쒓렇?쇱씠?몃뒗 紐?李얠쓬. *Kiln*(Double Fine, 2026)? ?꾩옄湲??뚯옱吏留??щ읉???섎뒗 ?쒗닾 寃뚯엫?쇰줈 ?λⅤ媛 ?ㅻ쫫
- **媛뺤젏:** **?쒓뎅 ?꾩옄湲?泥?옄쨌吏꾩궗쨌遺꾩껌)? ?좎슜(???명삎)** ?대씪???뚯옱媛 ?댁쇅?먯꽌 留ㅼ슦 ??꽕怨??꾨쫫?듬떎 ???곸젏 ?섏씠吏?먯꽌 諛붾줈 ?덉뿉 ?덈떎. "媛留?臾몄쓣 ?щ뒗 ?쒓컙"? ?ㅼ젣 ?꾧났?ㅻ룄 ?먭렐嫄곕━???쒓컙?대씪 ?ㅻ챸???꾩슂 ?녿떎
- **?쎌젏:** 紐⑥뼇횞?좎빟 議고빀 ?ㅺ퀎? 洹좏삎 ?↔린媛 ??以?媛???먯씠 留롮씠 媛꾨떎
- **?ш린:** 以묎컙

## 湲고쉷??C ???ы빐 ?몄뼇??(?먰뿕쨌?쒗깢??

**??以?** 諛곗뿉??媛덇퀬由щ? 源딆씠 ?대┫?섎줉 洹??蹂대Ъ??嫄몃━吏留? 以꾩씠 ?딆뼱吏嫄곕굹 ?ы빐 愿대Ъ???곕씪 ?щ씪?⑤떎. 嫄댁쭊 蹂대Ъ濡???щ? ?ъ븘 諛ㅼ쓽 ?댁쟻???좊젮 踰꾨┛??

| ?쒓컙 | ?섎뒗 ??|
|---|---|
| 湲댁옣 | ??源딆씠 ?대┫吏, 吏湲?媛먯븘 ?щ┫吏. 媛먮뒗 ?숈븞 以꾩씠 ?쏀뙺?댁?硫??좉퉸 ???以섏빞 ??|
| 怨듦컻 | 臾??꾨줈 ?щ씪?ㅻ뒗 ?쒓컙 ?뺤껜媛 ?쒕윭?쒕떎 (?곸옄? ??? 愿대Ъ?) |
| ?먰븯???濡?| ?뚰뙆 ?먯?湲걔룸??쇰줈 臾댁뾿??嫄몃┫吏 湲곗슱?몃떎. 諛곗뿉 ???룸룢쨌媛묓뙋???먰븯???濡??⑤떎 |
| ?듭풄 | ?댁쟻???쇱뿉 ??щ? ?쒓볼踰덉뿉 ?쇰???以꾩쨪??媛?쇱븠??|
| ?깆옣 | 諛곌? 而ㅼ?怨?????먮━), ??源딆? 諛붾떎媛 ?대┛??|

- **?듭슱??諛⑹?:** ?뺤? 諛붾떎?먯꽌???뺤젙 蹂댁긽. 以꾩씠 ?딆뼱?몃룄 媛덇퀬由??꾩튂??遺?쒓? ?⑥븘 ?ㅼ쓬???ㅼ떆 嫄댁쭏 ???덈떎
- **鍮꾩듂??寃뚯엫:** *Sol Cesto*(?낆냽?먯꽌 ?꾪뿕 嫄멸퀬 ?뚯뼱 ?щ━湲?, *Sector Scavengers*(??源딆씠 媛덉? 鍮좎쭏吏). ?꾪뿕 嫄멸퀬 ?뚯뼱 ?щ━湲곌? ?대? ?щ읉 ?덉쓬
- **媛뺤젏:** "??諛⑹뿉 ?諛? ?먮굦??媛??媛뺥븯?? 諛붾떎쨌?댁쟻? ?꾧뎄???꾨뒗 ?뚯옱
- **?쎌젏:** ?듭떖 ?щ?(??源딆씠 媛덇퉴?)媛 ?ㅻⅨ 寃뚯엫怨?媛??留롮씠 寃뱀튇??
- **?ш린:** 以묎컙

---

## 鍮꾧탳

| | A ?뚯쓣 ?덈뒗 ??| B 媛留덉쓽 蹂묒궗 | C ?ы빐 ?몄뼇??|
|---|---|---|---|
| 湲댁옣 (??踰???) | ?끸쁾??| ?끸쁾??| ?끸쁾??|
| 怨듦컻???먭렐嫄곕┝ | ?끸쁾????源⑥쭚 | ?끸쁾??媛留?臾??대┝ | ?끸쁾??臾??꾨줈 |
| ?먰븯???濡??ㅼ슦湲?| ?끸쁾 癒뱀씠쨌臾대━ | ?끸쁾??紐⑥뼇횞?좎빟 ?ㅺ퀎 | ?끸쁾 ?λ퉬 ?ш린 |
| ?듭풄??| ?끸쁾 | ?끸쁾??| ?끸쁾??|
| 寃뱀튂??寃뚯엫???곸쓬 | ?끸쁾 | ?끸쁾??| ??|
| ?곸젏 ?섏씠吏?먯꽌 ?덉뿉 ??| ?끸쁾 | ?끸쁾??| ?끸쁾 |
| 留뚮뱶??遺??(???곸쓣?섎줉 ?ъ?) | ?끸쁾 | ?끸쁾??| ?끸쁾 |

**異붿쿇: B 媛留덉쓽 蹂묒궗.** ?ъ슜?먭? 瑗쎌? ?ㅼ꽢 媛먯젙??紐⑤몢 媛뺥븯怨? 寃뱀튂??寃뚯엫???놁쑝硫? ?쒓뎅 ?꾩옄湲곕씪???뚯옱媛 ?댁쇅 ?쒖옣?먯꽌 媛쒖꽦???쒕떎. ???洹좏삎 ?↔린???먯씠 媛??留롮씠 媛꾨떎 ???먮룞 ?뚯뒪?맞룸큸?쇰줈 議고빀 洹좏삎??寃?ы븯??吏湲덉쓽 ?묒뾽 ?섍꼍???ш린???꾩????쒕떎.

## ?ㅼ쓬 ?④퀎

怨좊Ⅸ 湲고쉷???섎굹(?먮뒗 ????**1遺??쒗뿕??*??留뚮뱺?? 怨듦컻 ?μ튂 ??踰?+ 吏㏃? 諛⑹뼱????踰? ?ъ슜?먮뒗 ??媛吏留??먮떒?쒕떎.
1. "??踰??? ?섍퀬 ?띠? 湲댁옣???덈뒗媛
2. ?몄뼱踰꾨┫ ???쒖썝?쒓?
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
 M assets/fonts/Galmuri11-Bold.ttf.import
 M assets/fonts/Galmuri11.ttf.import
 M "work/2026-11-27-\352\267\270\353\246\274/NOTES.md"
 M "work/2026-11-27-\352\267\270\353\246\274/handoff-01.md"
?? reports/boss/history-local-backup.csv
?? "work/2026-11-27-\352\267\270\353\246\274/handoff-01.report.md"

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -Encoding UTF8 -LiteralPath 'docs/그림-목록.md', 'docs/기획안-비교.md'; Get-Content -Encoding UTF8 -LiteralPath 'C:/Users/pc/.codex/skills/.system/imagegen/SKILL.md' -TotalCount 45; Get-Content -Encoding UTF8 -LiteralPath art/sprite_list.json; Get-Command node, magick -ErrorAction SilentlyContinue | Select-Object Name,Source" in C:\Users\pc\Documents\game
 exited 1 in 2137ms:
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
# 기획안 세 가지 비교 (2026-11-27)

> 재미는 아직 **가설**이다. 1분 시험판으로 사용자가 직접 확인한다.

## 출발점: 사용자가 원하는 재미

사용자 말 (2026-11-27):
- "손놀림보다 결정과 공개의 순간이 느껴지는 도파민 같은 게 좋은 것 같아."
- "게임하는 사람이 긴장감을 느끼고 통쾌함도 느끼고 성장을 경험하면 좋겠어."
- "좋은 아이템을 운이 좋게 가지게 되었을때, 내가 원하는대로 성장해갈 때 너무 좋았던 것 같아."
- 싫었던 것: "과금을 하며 게임했지만 과금하지 않은 무과금 캐릭터가 더 강할 때가 있었지. 그런 경우는 너무 억울하고 짜증이 나긴 했어."

**한 판에 터져야 할 감정 순서:** 긴장(한 번 더?) → 공개(두근!) → 원하는 대로(내가 비튼 확률) → 강해진 체감 → 통쾌(쓸어버리기) → 성장(판 사이)

## 아이디어를 내는 방법 (이번에 쓴 순서)

1. **감정 순서를 먼저 정한다** (위). 규칙은 그다음.
2. **현실에서 이미 두근거리는 '공개' 행동을 찾는다** — 알이 깨지는 순간, 가마 문을 여는 순간, 그물을 끌어 올리는 순간. 사람들이 이미 아는 두근거림이라 설명이 필요 없다.
3. **그 공개에 '내가 비틀 손잡이'를 단다** — 먹이, 유약, 깊이. 운만 있으면 억울하고, 손잡이가 있으면 "내가 해냈다"가 된다.
4. **결과를 통쾌한 전투로 잇는다** — 손놀림 대신 배치하고 지켜보는 방어전, 숫자가 터지는 연출.
5. **억울함 방지 장치를 넣는다** (아래 공통 규칙).
6. **스팀에서 겹치는 게임을 찾는다.** 겹치면 버리거나 바꾼다 (이번에 '경매장' 구상은 *Myriad Auction* 과 핵심이 같아 버렸다).

## 공통 규칙: 억울하지 않은 운

| 규칙 | 뜻 |
|---|---|
| **운은 '얼마나 높이'를, 준비는 '최소한 이만큼'을 정한다** | 준비를 잘하면 운이 나빠도 꼭 일정 이상 나온다. 운이 좋으면 그 위로 터진다 |
| **위험은 눈에 보인다** | "금 세 줄 = 깨질 확률 40%" 처럼 숫자·그림으로 보여 준다. 몰래 지는 일 없음 |
| **실패도 쌓인다** | 깨지거나 놓쳐도 조각·경험이 남고, 일정량 모이면 확정으로 얻는다 |
| **돈으로 강해지지 않는다** | 스팀에서 한 번 사는 게임. 과금으로 강해지는 구조 없음 |

---

## 기획안 A — 알을 품는 성 (수집·애착형)

**한 줄:** 낮에는 위험을 걸고 알을 품어 괴수를 깨우고, 밤에는 그 괴수들로 둥지를 지킨다.

| 순간 | 하는 일 |
|---|---|
| 긴장 | 알을 한 번 더 데울수록 강해지지만, 금이 늘어 터질 위험 |
| 공개 | 알이 깨지며 빛과 함께 괴수 등장 (희귀할수록 화려하게) |
| 원하는 대로 | 먹이로 성질을 기울인다 (불 열매 → 불 괴수). 같은 계열 모으면 무리 효과 |
| 통쾌 | 밤에 몰려오는 적을 무리 효과로 한꺼번에 쓸어버림 |
| 성장 | 둥지가 자라고(품는 자리·먹이·알 종류), 괴수 도감이 채워진다 |

- **억울함 방지:** 알이 터져도 껍질 조각이 남아, 10개 모으면 원하는 계열 알 확정
- **비슷한 게임:** Birb(둥지·알 품기), Defend The Nest(둥지 방어). 위험 걸고 품기 + 방어 조합은 못 찾음
- **강점:** 귀여운 괴수는 누구나 좋아하고 애착이 생긴다. 32×32 괴수 그리기 좋음
- **약점:** "몬스터 수집"은 흔한 소재라 상점 페이지에서 눈에 덜 띌 수 있다
- **크기:** 중간 (괴수 종류·무리 효과 설계가 많음)

## 기획안 B — 가마의 병사 (제작·조합형)

**한 줄:** 흙으로 병사를 빚고, 유약을 바르고, 불을 올려 굽는다. 가마 문을 열면 병사들이 걸어 나와 마을을 지킨다.

| 순간 | 하는 일 |
|---|---|
| 긴장 | 불을 더 올릴수록 **요변(窯變, 가마 속에서 우연히 생기는 귀한 빛깔)** 이 나올 확률이 오르지만, 금 가고 깨질 위험도 오른다 |
| 공개 | 연기가 걷히며 가마 문이 열리는 순간 — 줄지어 선 병사들의 빛깔이 드러난다 |
| 원하는 대로 | **빚는 모양 = 병과** (창병·궁수·방패), **유약 = 속성** (청자=물, 진사=불, 흑유=땅). 조합으로 군대를 설계 |
| 통쾌 | 요변 병사 하나가 전장을 뒤집고, 같은 유약 병사들이 함께 기술을 터뜨림 |
| 성장 | 가마가 커지고(한 번에 굽는 수), 새 흙·유약·모양이 열린다. 깨진 병사의 조각으로 다음 판 유약을 만든다 |

- **억울함 방지:** 불 세기를 안전 구간에 두면 '보통 품질'은 반드시 나온다. 요변은 위험 구간에서만. 깨진 조각은 재료로 돌아온다
- **비슷한 게임:** 도자기 로그라이트는 못 찾음. *Kiln*(Double Fine, 2026)은 도자기 소재지만 여럿이 하는 난투 게임으로 장르가 다름
- **강점:** **한국 도자기(청자·진사·분청)와 토용(흙 인형)** 이라는 소재가 해외에서 매우 낯설고 아름답다 — 상점 페이지에서 바로 눈에 띈다. "가마 문을 여는 순간"은 실제 도공들도 두근거리는 순간이라 설명이 필요 없다
- **약점:** 모양×유약 조합 설계와 균형 잡기가 셋 중 가장 손이 많이 간다
- **크기:** 중간

## 기획안 C — 심해 인양선 (탐험·한탕형)

**한 줄:** 배에서 갈고리를 깊이 내릴수록 귀한 보물이 걸리지만, 줄이 끊어지거나 심해 괴물이 따라 올라온다. 건진 보물로 대포를 달아 밤의 해적을 날려 버린다.

| 순간 | 하는 일 |
|---|---|
| 긴장 | 더 깊이 내릴지, 지금 감아 올릴지. 감는 동안 줄이 팽팽해지면 잠깐 풀어 줘야 함 |
| 공개 | 물 위로 올라오는 순간 정체가 드러난다 (상자? 대포? 괴물?) |
| 원하는 대로 | 음파 탐지기·미끼로 무엇이 걸릴지 기울인다. 배에 대포·돛·갑판을 원하는 대로 단다 |
| 통쾌 | 해적선 떼에 대포를 한꺼번에 퍼부어 줄줄이 가라앉힘 |
| 성장 | 배가 커지고(대포 자리), 더 깊은 바다가 열린다 |

- **억울함 방지:** 얕은 바다에서는 확정 보상. 줄이 끊어져도 갈고리 위치에 부표가 남아 다음에 다시 건질 수 있다
- **비슷한 게임:** *Sol Cesto*(땅속에서 위험 걸고 끌어 올리기), *Sector Scavengers*(더 깊이 갈지 빠질지). 위험 걸고 끌어 올리기가 이미 여럿 있음
- **강점:** "한 방에 대박" 느낌이 가장 강하다. 바다·해적은 누구나 아는 소재
- **약점:** 핵심 재미(더 깊이 갈까?)가 다른 게임과 가장 많이 겹친다
- **크기:** 중간

---

## 비교

| | A 알을 품는 성 | B 가마의 병사 | C 심해 인양선 |
|---|---|---|---|
| 긴장 (한 번 더?) | ★★★ | ★★★ | ★★★ |
| 공개의 두근거림 | ★★★ 알 깨짐 | ★★★ 가마 문 열림 | ★★★ 물 위로 |
| 원하는 대로 키우기 | ★★ 먹이·무리 | ★★★ 모양×유약 설계 | ★★ 장비 달기 |
| 통쾌함 | ★★ | ★★★ | ★★★ |
| 겹치는 게임이 적음 | ★★ | ★★★ | ★ |
| 상점 페이지에서 눈에 띔 | ★★ | ★★★ | ★★ |
| 만드는 부담 (★ 적을수록 쉬움) | ★★ | ★★★ | ★★ |

**추천: B 가마의 병사.** 사용자가 꼽은 다섯 감정이 모두 강하고, 겹치는 게임이 없으며, 한국 도자기라는 소재가 해외 시장에서 개성이 된다. 대신 균형 잡기에 손이 가장 많이 간다 — 자동 테스트·봇으로 조합 균형을 검사하는 지금의 작업 환경이 여기서 도움이 된다.

## 다음 단계

고른 기획안 하나(또는 둘)의 **1분 시험판**을 만든다: 공개 장치 한 번 + 짧은 방어전 한 번. 사용자는 두 가지만 판단한다.
1. "한 번 더" 하고 싶은 긴장이 있는가
2. 쓸어버릴 때 시원한가
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

{
 "version": 1,
 "공통 규칙": [
  "PNG, 정확히 적힌 크기 (예: 32×32). 크기가 다르면 검사에서 실패",
  "투명 배경 (tile 이 true 인 바닥 타일만 꽉 채움)",
  "픽셀 아트: 계단 현상을 그대로 둔다 (부드럽게 흐리지 않음, 안티에일리어싱 없음)",
  "외곽선 1px (그림체 시안에서 정한 색)",
  "그림 한 장에 색 24개 이하",
  "캐릭터는 가운데, 발은 아래에서 3~5px 위",
  "아군(병사·괴수)은 오른쪽, 적(도깨비)은 왼쪽을 본다"
 ],
 "files": [
  {
   "path": "assets/sprites/kiln/soldier_spear_water.png",
   "size": [
    32,
    32
   ],
   "group": "가마의 병사",
   "what": "흙으로 빚은 작은 인형 병사(창병). 창을 든 모습. 몸 전체에 청자 유약 — 비취빛 푸른 녹색, 은은한 광택. 오른쪽을 본다."
  },
  {
   "path": "assets/sprites/kiln/soldier_spear_fire.png",
   "size": [
    32,
    32
   ],
   "group": "가마의 병사",
   "what": "흙으로 빚은 작은 인형 병사(창병). 창을 든 모습. 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다."
  },
  {
   "path": "assets/sprites/kiln/soldier_spear_earth.png",
   "size": [
    32,
    32
   ],
   "group": "가마의 병사",
   "what": "흙으로 빚은 작은 인형 병사(창병). 창을 든 모습. 몸 전체에 흑유 유약 — 검은 갈색, 기름 같은 광택. 오른쪽을 본다."
  },
  {
   "path": "assets/sprites/kiln/soldier_archer_water.png",
   "size": [
    32,
    32
   ],
   "group": "가마의 병사",
   "what": "흙으로 빚은 작은 인형 병사(궁수). 활을 든 모습. 몸 전체에 청자 유약 — 비취빛 푸른 녹색, 은은한 광택. 오른쪽을 본다."
  },
  {
   "path": "assets/sprites/kiln/soldier_archer_fire.png",
   "size": [
    32,
    32
   ],
   "group": "가마의 병사",
   "what": "흙으로 빚은 작은 인형 병사(궁수). 활을 든 모습. 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다."
  },
  {
   "path": "assets/sprites/kiln/soldier_archer_earth.png",
   "size": [
    32,
    32
   ],
   "group": "가마의 병사",
   "what": "흙으로 빚은 작은 인형 병사(궁수). 활을 든 모습. 몸 전체에 흑유 유약 — 검은 갈색, 기름 같은 광택. 오른쪽을 본다."
  },
  {
   "path": "assets/sprites/kiln/soldier_shield_water.png",
   "size": [
    32,
    32
   ],
   "group": "가마의 병사",
   "what": "흙으로 빚은 작은 인형 병사(방패병). 둥근 방패를 든 모습. 몸 전체에 청자 유약 — 비취빛 푸른 녹색, 은은한 광택. 오른쪽을 본다."
  },
  {
   "path": "assets/sprites/kiln/soldier_shield_fire.png",
   "size": [
    32,
    32
   ],
   "group": "가마의 병사",
   "what": "흙으로 빚은 작은 인형 병사(방패병). 둥근 방패를 든 모습. 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다."
  },
  {
   "path": "assets/sprites/kiln/soldier_shield_earth.png",
   "size": [
    32,
    32
   ],
   "group": "가마의 병사",
   "what": "흙으로 빚은 작은 인형 병사(방패병). 둥근 방패를 든 모습. 몸 전체에 흑유 유약 — 검은 갈색, 기름 같은 광택. 오른쪽을 본다."
  },
  {
   "path": "assets/sprites/kiln/kiln_body.png",
   "size": [
    160,
    160
   ],
   "group": "가마의 병사",
   "what": "전통 장작 가마(오름가마/둥근 흙가마)의 앞모습. 가운데 아치형 문 자리(가로 가운데 55%, 위에서 20~78%)와 아래쪽 아궁이 자리는 거의 검은색으로 비워 둔다 — 문·불길·빛은 게임이 그 위에 그린다."
  },
  {
   "path": "assets/sprites/nest/creature_spear_fire.png",
   "size": [
    32,
    32
   ],
   "group": "알을 품는 성",
   "what": "'불꽃 도마뱀' — 귀엽고 작은 괴수 새끼. 공격형(뾰족함). 오른쪽을 본다."
  },
  {
   "path": "assets/sprites/nest/creature_spear_water.png",
   "size": [
    32,
    32
   ],
   "group": "알을 품는 성",
   "what": "'물살 수달' — 귀엽고 작은 괴수 새끼. 공격형(뾰족함). 오른쪽을 본다."
  },
  {
   "path": "assets/sprites/nest/creature_spear_earth.png",
   "size": [
    32,
    32
   ],
   "group": "알을 품는 성",
   "what": "'가시 고슴도치' — 귀엽고 작은 괴수 새끼. 공격형(뾰족함). 오른쪽을 본다."
  },
  {
   "path": "assets/sprites/nest/creature_archer_fire.png",
   "size": [
    32,
    32
   ],
   "group": "알을 품는 성",
   "what": "'불씨 박쥐' — 귀엽고 작은 괴수 새끼. 원거리형(떠다니거나 던짐). 오른쪽을 본다."
  },
  {
   "path": "assets/sprites/nest/creature_archer_water.png",
   "size": [
    32,
    32
   ],
   "group": "알을 품는 성",
   "what": "'물방울 해파리' — 귀엽고 작은 괴수 새끼. 원거리형(떠다니거나 던짐). 오른쪽을 본다."
  },
  {
   "path": "assets/sprites/nest/creature_archer_earth.png",
   "size": [
    32,
    32
   ],
   "group": "알을 품는 성",
   "what": "'돌팔매 원숭이' — 귀엽고 작은 괴수 새끼. 원거리형(떠다니거나 던짐). 오른쪽을 본다."
  },
  {
   "path": "assets/sprites/nest/creature_shield_fire.png",
   "size": [
    32,
    32
   ],
   "group": "알을 품는 성",
   "what": "'용암 두꺼비' — 귀엽고 작은 괴수 새끼. 수비형(등딱지·단단함). 오른쪽을 본다."
  },
  {
   "path": "assets/sprites/nest/creature_shield_water.png",
   "size": [
    32,
    32
   ],
   "group": "알을 품는 성",
   "what": "'조개 거북' — 귀엽고 작은 괴수 새끼. 수비형(등딱지·단단함). 오른쪽을 본다."
  },
  {
   "path": "assets/sprites/nest/creature_shield_earth.png",
   "size": [
    32,
    32
   ],
   "group": "알을 품는 성",
   "what": "'바위 거북' — 귀엽고 작은 괴수 새끼. 수비형(등딱지·단단함). 오른쪽을 본다."
  },
  {
   "path": "assets/sprites/nest/egg_spear.png",
   "size": [
    32,
    40
   ],
   "group": "알을 품는 성",
   "what": "겉에 작은 뾰족 돌기가 있는 알. 아주 밝은 흰색/연회색으로만 칠한다 (게임이 기운 색으로 물들인다). 금은 그리지 않는다."
  },
  {
   "path": "assets/sprites/nest/egg_archer.png",
   "size": [
    32,
    40
   ],
   "group": "알을 품는 성",
   "what": "길쭉하고 가는 알. 아주 밝은 흰색/연회색으로만 칠한다 (게임이 기운 색으로 물들인다). 금은 그리지 않는다."
  },
  {
   "path": "assets/sprites/nest/egg_shield.png",
   "size": [
    32,
    40
   ],
   "group": "알을 품는 성",
   "what": "둥글고 넓적한 알. 아주 밝은 흰색/연회색으로만 칠한다 (게임이 기운 색으로 물들인다). 금은 그리지 않는다."
  },
  {
   "path": "assets/sprites/enemy/goblin.png",
   "size": [
    32,
    32
   ],
   "group": "공통 (적)",
   "what": "한국 도깨비. 붉은 갈색 피부, 뿔 하나 또는 둘, 장난스럽고 사나운 얼굴. 왼쪽을 본다."
  },
  {
   "path": "assets/sprites/enemy/imp.png",
   "size": [
    32,
    32
   ],
   "group": "공통 (적)",
   "what": "도깨비불. 푸른 불꽃 모양의 작은 정령, 눈만 있다. 왼쪽을 본다."
  },
  {
   "path": "assets/sprites/enemy/brute.png",
   "size": [
    48,
    48
   ],
   "group": "공통 (적)",
   "what": "큰 도깨비. 덩치 크고 도깨비 방망이를 든다. 왼쪽을 본다."
  },
  {
   "path": "assets/sprites/field/grass_a.png",
   "size": [
    32,
    32
   ],
   "group": "공통 (들판)",
   "tile": true,
   "what": "밤의 풀밭 바닥 타일. 사방으로 이어 붙여도 이음새가 안 보여야 한다. 어둡고 차분하게 (캐릭터가 잘 보이도록)."
  },
  {
   "path": "assets/sprites/field/grass_b.png",
   "size": [
    32,
    32
   ],
   "group": "공통 (들판)",
   "tile": true,
   "what": "grass_a 와 거의 같고 풀 무늬만 조금 다른 타일 (번갈아 깐다)."
  },
  {
   "path": "assets/sprites/field/house.png",
   "size": [
    32,
    32
   ],
   "group": "공통 (들판)",
   "what": "작은 초가집 또는 한옥 (지켜야 할 마을). 창에 불빛."
  },
  {
   "path": "assets/sprites/field/house_broken.png",
   "size": [
    32,
    32
   ],
   "group": "공통 (들판)",
   "what": "house 가 부서지고 불이 꺼진 모습."
  }
 ]
}

Name     Source                          
----     ------                          
node.exe C:\Program Files\nodejs\node.exe



2026-11-27T04:55:49.549791Z ERROR codex_memories_write::phase2::agent: memory consolidation artifacts are invalid: memory summary artifact does not start with v1: C:\Users\pc\.codex\memories_v2\memory_summary.md
codex
‘따뜻한 흙’의 원본 4장을 생성했습니다. 병사와 거북은 오른쪽, 도깨비는 왼쪽을 향합니다. 나머지 두 후보는 형태와 색에서도 차이가 드러나도록, 동화 쪽은 둥근 비례와 선명한 색으로, 수묵 쪽은 먹색 덩어리와 제한된 포인트 색으로 만들겠습니다.

codex
‘밝은 동화’는 검은 외곽선과 큰 머리 비례로 생성되고 있습니다. 생성 원본은 아직 큰 이미지이므로, 최종 비교는 32×32로 축소하고 색을 정리한 뒤 만든 4배 확대 시트로 확인하겠습니다.

codex
‘수묵 픽셀’은 흑백 바탕에 진사 빨강·청자 초록·금색 창빛을 배치했습니다. 다음으로 원본의 투명 영역을 기준으로 크기를 맞추고, 반투명 픽셀과 색 수를 정리해 비교 시트 3장을 만들겠습니다.

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Get-Content -Encoding UTF8 -LiteralPath AGENTS.md; if (Test-Path -LiteralPath art/style) { Get-ChildItem -Recurse -LiteralPath art/style | Select-Object FullName }; Add-Type -AssemblyName System.Drawing; [System.Drawing.Bitmap].FullName' in C:\Users\pc\Documents\game
 succeeded in 360ms:
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
System.Drawing.Bitmap

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command '$ErrorActionPreference = '"'Stop'
Add-Type -AssemblyName System.Drawing
Add-Type -ReferencedAssemblies System.Drawing -TypeDefinition @'

using System;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Text;
using System.Collections.Generic;
public static class StyleSprites {
 static Color[] Palette(string s) { var a=s.Split(','); var p=new Color[a.Length]; for(int i=0;i<a.Length;i++)p[i]=ColorTranslator.FromHtml(\"#\"+a[i]); return p; }
 static Color Quant(Color c,Color[] p) { double best=1e20; Color r=p[0]; foreach(var q in p){double d=2*Math.Pow(c.R-q.R,2)+3*Math.Pow(c.G-q.G,2)+Math.Pow(c.B-q.B,2);if(d<best){best=d;r=q;}}return r; }
 public static void Make(string[] paths,string dir,string colors,string title,string subtitle) {
 Directory.CreateDirectory(dir);
 var pal=Palette(colors);
 string[] names={\"soldier_spear_fire\",\"creature_shield_water\",\"goblin\",\"house\"};
 string[] labels={\"진사 유약 창병\",\"조개 거북\",\"도깨비\",\"초가집 / 한옥\"};
 var sprites=new Bitmap[4];
 for(int n=0;n<4;n++) {
 using(var src=new Bitmap(paths[n])) {
 int l=src.Width,t=src.Height,r=0,b=0;
 for(int y=0;y<src.Height;y++)for(int x=0;x<src.Width;x++)if(src.GetPixel(x,y).A>=128){l=Math.Min(l,x);t=Math.Min(t,y);r=Math.Max(r,x);b=Math.Max(b,y);}
 double scale=Math.Min(26.0/(r-l+1),26.0/(b-t+1));
 int w=(int)Math.Round((r-l+1)*scale),h=(int)Math.Round((b-t+1)*scale);
 int ox=(32-w)/2,oy=28-h; var dst=new Bitmap(32,32,PixelFormat.Format32bppArgb);
 for(int y=0;y<h;y++)for(int x=0;x<w;x++){
 int sx=l+(int)((x+0.5)*(r-l+1)/w),sy=t+(int)((y+0.5)*(b-t+1)/h);
 var c=src.GetPixel(Math.Min(r,sx),Math.Min(b,sy));
 if(c.A>=128)dst.SetPixel(x+ox,y+oy,Quant(c,pal));
 }
 // Restore a single logical-pixel outline after downsampling.
 var mask=new bool[32,32]; for(int y=0;y<32;y++)for(int x=0;x<32;x++)mask[x,y]=dst.GetPixel(x,y).A>0;
 for(int y=1;y<31;y++)for(int x=1;x<31;x++)if(mask[x,y]&&("'!mask[x-1,y]||!mask[x+1,y]||!mask[x,y-1]||!mask[x,y+1]))dst.SetPixel(x,y,pal[0]);
 dst.Save(Path.Combine(dir,names[n]+".png"),ImageFormat.Png);sprites[n]=dst;
 var used=new HashSet<int>();int partial=0,bottom=-1;for(int y=0;y<32;y++)for(int x=0;x<32;x++){var c=dst.GetPixel(x,y);if(c.A>0){used.Add(c.ToArgb());bottom=Math.Max(bottom,y);}if(c.A>0&&c.A<255)partial++;}
 Console.WriteLine(Path.Combine(dir,names[n]+".png")+" | 32x32 | colors="+used.Count+" | partial-alpha="+partial+" | bottom="+bottom);
 }}
 using(var sheet=new Bitmap(640,328,PixelFormat.Format32bppArgb))
 using(var g=Graphics.FromImage(sheet))
 using(var font=new Font("Malgun Gothic",12,FontStyle.Regular,GraphicsUnit.Pixel))
 using(var titleFont=new Font("Malgun Gothic",23,FontStyle.Bold,GraphicsUnit.Pixel))
 using(var ink=new SolidBrush(pal[0])) {
 g.Clear(Color.FromArgb(245,242,234));g.TextRenderingHint=TextRenderingHint.SingleBitPerPixelGridFit;
 g.DrawString(title,titleFont,ink,20,16);g.DrawString(subtitle,font,ink,22,49);
 for(int n=0;n<4;n++){
 int sx=22+n*156,sy=88;
 for(int y=0;y<128;y+=8)for(int x=0;x<128;x+=8)using(var brush=new SolidBrush(((x+y)/8)%2==0?Color.FromArgb(230,226,218):Color.FromArgb(239,236,228)))g.FillRectangle(brush,sx+x,sy+y,8,8);
 // Exact 4x copies, no interpolation.
 for(int y=0;y<32;y++)for(int x=0;x<32;x++){var c=sprites[n].GetPixel(x,y);if(c.A>0)using(var brush=new SolidBrush(c))g.FillRectangle(brush,sx+x*4,sy+y*4,4,4);}
 g.DrawString(labels[n],font,ink,sx,224);
 }
 g.DrawString("공용 팔레트  /  "+pal.Length+"색",font,ink,22,256);
 for(int i=0;i<pal.Length;i++)using(var brush=new SolidBrush(pal[i]))g.FillRectangle(brush,22+i*25,280,23,24);
 sheet.Save(Path.Combine(dir,"sheet.png"),ImageFormat.Png);
 }
 foreach(var s in sprites)s.Dispose();
 }
}
'"'@
[StyleSprites]::Make([string[]]@('C:\\Users\\pc\\.codex\\generated_images\\01a21b5b-7bf9-7810-866e-270c51f0beb0\\exec-dcfdd679-be9a-4761-a348-14c587a2cf4e.png','C:\\Users\\pc\\.codex\\generated_images\\01a21b5b-7bf9-7810-866e-270c51f0beb0\\exec-7318609c-4df1-40ac-aba5-463e543faa75.png','C:\\Users\\pc\\.codex\\generated_images\\01a21b5b-7bf9-7810-866e-270c51f0beb0\\exec-76b925f2-8595-40bb-8955-dd1ae78f6fcc.png','C:\\Users\\pc\\.codex\\generated_images\\01a21b5b-7bf9-7810-866e-270c51f0beb0\\exec-0a786d93-3db3-4b9a-896f-45ef0ad8f807.png'), 'C:\\Users\\pc\\Documents\\game\\art\\style\\ga', '321e18,50302a,754733,a96942,cf9560,ebc69a,f6e5c5,672d25,933c2e,b64d36,d77251,efa17e,414b39,667558,91a37b,b6c7a0,3d6358,648d79,98b6a0,c4d6bb,9b6b31,d39b46,f2c668', '가. 따뜻한 흙', '차분한 흙색 · 짙은 갈색 외곽선  |  32×32 px / 4배 확대')
[StyleSprites]::Make([string[]]@('C:\\Users\\pc\\.codex\\generated_images\\01a21b5b-7bf9-7810-866e-270c51f0beb0\\exec-9a874c15-52c6-49f1-9df7-726762b0ceb2.png','C:\\Users\\pc\\.codex\\generated_images\\01a21b5b-7bf9-7810-866e-270c51f0beb0\\exec-697f296d-7c51-4901-9d3d-aee05752d276.png','C:\\Users\\pc\\.codex\\generated_images\\01a21b5b-7bf9-7810-866e-270c51f0beb0\\exec-47edc29e-e8a9-4ca0-a390-13b61a2c6724.png','C:\\Users\\pc\\.codex\\generated_images\\01a21b5b-7bf9-7810-866e-270c51f0beb0\\exec-86a5ba5d-ffa5-4689-b49a-49c5715acfdf.png'), 'C:\\Users\\pc\\Documents\\game\\art\\style\\na', '100e18,2c2a51,55416c,6e204d,9f2871,bd171f,f73535,ff6956,ffb2a3,7d3a17,b9591c,e78c15,ffbd1d,ffe25a,fff5b1,f1c99d,fff1d4,00626a,009fa9,00d9d5,9af1d7,88ba00,c6ed36', '나. 밝은 동화', '큰 머리와 둥근 형태 · 선명한 색  |  32×32 px / 4배 확대')
[StyleSprites]::Make([string[]]@('C:\\Users\\pc\\.codex\\generated_images\\01a21b5b-7bf9-7810-866e-270c51f0beb0\\exec-ca0db6d8-8885-4788-94fd-f554c027cc94.png','C:\\Users\\pc\\.codex\\generated_images\\01a21b5b-7bf9-7810-866e-270c51f0beb0\\exec-1b6f5a4e-15be-4fe6-9c05-f89ff265b472.png','C:\\Users\\pc\\.codex\\generated_images\\01a21b5b-7bf9-7810-866e-270c51f0beb0\\exec-064af381-a2c8-41eb-8997-a609637f795a.png','C:\\Users\\pc\\.codex\\generated_images\\01a21b5b-7bf9-7810-866e-270c51f0beb0\\exec-6285f056-6359-4490-a12a-7f0a70705e66.png'), 'C:\\Users\\pc\\Documents\\game\\art\\style\\da', '171817,363837,626361,979894,c7c7c1,f4f1e9,762c2b,a63c36,c66554,4d7665,89ad94,b9cdb9,a58a47,e0bf73', '다. 수묵 픽셀', '먹색과 여백 · 진사 / 청자 / 금색 포인트  |  32×32 px / 4배 확대')
" in C:\Users\pc\Documents\game
 succeeded in 5595ms:
C:\Users\pc\Documents\game\art\style\ga\soldier_spear_fire.png | 32x32 | colors=9 | partial-alpha=0 | bottom=27
C:\Users\pc\Documents\game\art\style\ga\creature_shield_water.png | 32x32 | colors=10 | partial-alpha=0 | bottom=27
C:\Users\pc\Documents\game\art\style\ga\goblin.png | 32x32 | colors=9 | partial-alpha=0 | bottom=27
C:\Users\pc\Documents\game\art\style\ga\house.png | 32x32 | colors=14 | partial-alpha=0 | bottom=27
C:\Users\pc\Documents\game\art\style\na\soldier_spear_fire.png | 32x32 | colors=10 | partial-alpha=0 | bottom=27
C:\Users\pc\Documents\game\art\style\na\creature_shield_water.png | 32x32 | colors=12 | partial-alpha=0 | bottom=27
C:\Users\pc\Documents\game\art\style\na\goblin.png | 32x32 | colors=15 | partial-alpha=0 | bottom=27
C:\Users\pc\Documents\game\art\style\na\house.png | 32x32 | colors=12 | partial-alpha=0 | bottom=27
C:\Users\pc\Documents\game\art\style\da\soldier_spear_fire.png | 32x32 | colors=9 | partial-alpha=0 | bottom=27
C:\Users\pc\Documents\game\art\style\da\creature_shield_water.png | 32x32 | colors=7 | partial-alpha=0 | bottom=27
C:\Users\pc\Documents\game\art\style\da\goblin.png | 32x32 | colors=6 | partial-alpha=0 | bottom=27
C:\Users\pc\Documents\game\art\style\da\house.png | 32x32 | colors=7 | partial-alpha=0 | bottom=27

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'git status --porcelain --untracked-files=all' in C:\Users\pc\Documents\game
 succeeded in 134ms:
 M assets/fonts/Galmuri11-Bold.ttf.import
 M assets/fonts/Galmuri11.ttf.import
 M "work/2026-11-27-\352\267\270\353\246\274/NOTES.md"
 M "work/2026-11-27-\352\267\270\353\246\274/handoff-01.md"
?? art/style/da/creature_shield_water.png
?? art/style/da/goblin.png
?? art/style/da/house.png
?? art/style/da/sheet.png
?? art/style/da/soldier_spear_fire.png
?? art/style/ga/creature_shield_water.png
?? art/style/ga/goblin.png
?? art/style/ga/house.png
?? art/style/ga/sheet.png
?? art/style/ga/soldier_spear_fire.png
?? art/style/na/creature_shield_water.png
?? art/style/na/goblin.png
?? art/style/na/house.png
?? art/style/na/sheet.png
?? art/style/na/soldier_spear_fire.png
?? reports/boss/history-local-backup.csv
?? "work/2026-11-27-\352\267\270\353\246\274/handoff-01.report.md"

codex
결과: 통과

바뀐 파일:
- `art/style/{ga,na,da}/soldier_spear_fire.png` — 진사 유약 창병 3장
- `art/style/{ga,na,da}/creature_shield_water.png` — 조개 거북 3장
- `art/style/{ga,na,da}/goblin.png` — 도깨비 3장
- `art/style/{ga,na,da}/house.png` — 초가집·한옥 3장
- `art/style/{ga,na,da}/sheet.png` — 4배 확대와 팔레트 비교 시트 3장

직접 확인한 것:
- 스프라이트 12장 모두 32×32, 투명 배경, 반투명 픽셀 없음, 불투명 색 6~15개.
- 아래쪽 여백 4px. 아군은 오른쪽, 도깨비는 왼쪽 방향.
- 비교 시트 3장을 직접 열어 확인.
- 작업 시작 상태와 비교해 요청한 15개 파일만 추가.

만든 그림:
- [가 — 따뜻한 흙](C:/Users/pc/Documents/game/art/style/ga/sheet.png)
- [나 — 밝은 동화](C:/Users/pc/Documents/game/art/style/na/sheet.png)
- [다 — 수묵 픽셀](C:/Users/pc/Documents/game/art/style/da/sheet.png)

그리는 데 쓴 방법:
- **둘 다:** 내장 `image_gen`으로 원본 12장을 생성하고, C# 코드로 축소·투명 경계 정리·색 제한·외곽선 보정·시트 조립.
- 프롬프트는 같은 네 소재에 흙색·갈색 외곽선 / 선명한 색·둥근 비례 / 흑백·제한된 포인트 색을 각각 적용.

못 한 것 / 걱정되는 것:
- 저장소 Python 검사는 지시대로 실행하지 않았으며 Claude의 후속 확인이 필요합니다.
- 파일 형식 확인은 통과, 재미·미술 판단은 사용자 몫입니다.
tokens used
71,941
결과: 통과

바뀐 파일:
- `art/style/{ga,na,da}/soldier_spear_fire.png` — 진사 유약 창병 3장
- `art/style/{ga,na,da}/creature_shield_water.png` — 조개 거북 3장
- `art/style/{ga,na,da}/goblin.png` — 도깨비 3장
- `art/style/{ga,na,da}/house.png` — 초가집·한옥 3장
- `art/style/{ga,na,da}/sheet.png` — 4배 확대와 팔레트 비교 시트 3장

직접 확인한 것:
- 스프라이트 12장 모두 32×32, 투명 배경, 반투명 픽셀 없음, 불투명 색 6~15개.
- 아래쪽 여백 4px. 아군은 오른쪽, 도깨비는 왼쪽 방향.
- 비교 시트 3장을 직접 열어 확인.
- 작업 시작 상태와 비교해 요청한 15개 파일만 추가.

만든 그림:
- [가 — 따뜻한 흙](C:/Users/pc/Documents/game/art/style/ga/sheet.png)
- [나 — 밝은 동화](C:/Users/pc/Documents/game/art/style/na/sheet.png)
- [다 — 수묵 픽셀](C:/Users/pc/Documents/game/art/style/da/sheet.png)

그리는 데 쓴 방법:
- **둘 다:** 내장 `image_gen`으로 원본 12장을 생성하고, C# 코드로 축소·투명 경계 정리·색 제한·외곽선 보정·시트 조립.
- 프롬프트는 같은 네 소재에 흙색·갈색 외곽선 / 선명한 색·둥근 비례 / 흑백·제한된 포인트 색을 각각 적용.

못 한 것 / 걱정되는 것:
- 저장소 Python 검사는 지시대로 실행하지 않았으며 Claude의 후속 확인이 필요합니다.
- 파일 형식 확인은 통과, 재미·미술 판단은 사용자 몫입니다.
