OpenAI Codex v0.172.0
--------
workdir: C:\Users\pc\Documents\game
model: gpt-6-astra
provider: openai
approval: never
sandbox: workspace-write [workdir, /tmp, $TMPDIR]
reasoning effort: high
reasoning summaries: none
session id: 01a21b95-e3e8-7140-8a4e-33a49ce01434
--------
user
# Codex 작업 지시서 — 가마의 병사 그림 10장

- 날짜: 2026-11-27 (그림체가 정해진 뒤에 넘긴다)
- 작업 폴더: work/2026-11-27-그림/
- 지시서 번호: 02

## 먼저 읽을 것
1. AGENTS.md
2. **art/references/ — 사용자가 고른 그림체 시안(가+다 섞음). 이 그림체를 그대로 따른다** (없으면 시작하지 말고 `결과: 못 돌림`)
3. docs/그림-목록.md 의 공통 규칙
4. art/sprite_list.json (그림마다 크기와 설명)

## 목표 (사용자 말 그대로)
> "지금보니까 체험판이라기에 너무 디자인이 아쉬워. codex를 통해 이미지나 외형 디자인이 어느 정도 되야 느낌이 있을 것 같아."

해석(참고용): 고른 그림체로 가마의 병사에 필요한 병사 9장과 가마 1장을 그린다.

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

## 만들 것 (10장)

| 파일 | 크기 | 내용 |
|---|---|---|
| `assets/sprites/kiln/soldier_spear_water.png` | 32×32 | 유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(창병). 창을 든 모습. 몸 전체에 청자 유약 — 비취빛 푸른 녹색, 은은한 광택. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_spear_fire.png` | 32×32 | 유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(창병). 창을 든 모습. 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_spear_earth.png` | 32×32 | 유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(창병). 창을 든 모습. 몸 전체에 흑유 유약 — 검은 갈색, 기름 같은 광택. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_archer_water.png` | 32×32 | 유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(궁수). 활을 든 모습. 몸 전체에 청자 유약 — 비취빛 푸른 녹색, 은은한 광택. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_archer_fire.png` | 32×32 | 유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(궁수). 활을 든 모습. 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_archer_earth.png` | 32×32 | 유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(궁수). 활을 든 모습. 몸 전체에 흑유 유약 — 검은 갈색, 기름 같은 광택. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_shield_water.png` | 32×32 | 유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(방패병). 둥근 방패를 든 모습. 몸 전체에 청자 유약 — 비취빛 푸른 녹색, 은은한 광택. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_shield_fire.png` | 32×32 | 유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(방패병). 둥근 방패를 든 모습. 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_shield_earth.png` | 32×32 | 유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(방패병). 둥근 방패를 든 모습. 몸 전체에 흑유 유약 — 검은 갈색, 기름 같은 광택. 오른쪽을 본다. |
| `assets/sprites/kiln/kiln_body.png` | 160×160 | 전통 장작 가마(오름가마/둥근 흙가마)의 앞모습. 가운데 아치형 문 자리(가로 가운데 55%, 위에서 20~78%)와 아래쪽 아궁이 자리는 거의 검은색으로 비워 둔다 — 문·불길·빛은 게임이 그 위에 그린다. |

공통 규칙: PNG · 정확한 크기 · 투명 배경(바닥 타일만 꽉 채움) · 흐리게 다듬지 않은 픽셀 아트 · 한 장에 색 24개 이하 · 외곽선 1px · 캐릭터 가운데, 발은 아래에서 3~5px 위 · 아군은 오른쪽, 적은 왼쪽을 본다 · 요변/전설 빛·반짝임·맞을 때 번쩍임은 그리지 않는다(게임이 그림)

같은 종류끼리(예: 병사 9장, 괴수 9장) **키·덩치·외곽선 굵기·빛 방향(왼쪽 위)을 맞춘다.** 나란히 놓았을 때 한 세트로 보여야 한다.

## 고쳐도 되는 범위
- `assets/sprites/kiln/soldier_spear_water.png` (새 파일)
- `assets/sprites/kiln/soldier_spear_fire.png` (새 파일)
- `assets/sprites/kiln/soldier_spear_earth.png` (새 파일)
- `assets/sprites/kiln/soldier_archer_water.png` (새 파일)
- `assets/sprites/kiln/soldier_archer_fire.png` (새 파일)
- `assets/sprites/kiln/soldier_archer_earth.png` (새 파일)
- `assets/sprites/kiln/soldier_shield_water.png` (새 파일)
- `assets/sprites/kiln/soldier_shield_fire.png` (새 파일)
- `assets/sprites/kiln/soldier_shield_earth.png` (새 파일)
- `assets/sprites/kiln/kiln_body.png` (새 파일)

이 목록에 없는 파일은 만들거나 고치지 않는다.

## 보호 검사 결과 (Claude가 미리 확인함)
- `python3 scripts/protected.py <위 파일들>` → 걸린 파일 없음 (모두 새 파일)
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
2. `python3 scripts/check_sprites.py --group "가마의 병사" --sheet <작업폴더>/sheet-02.png` (그룹마다 한 번씩) — 크기·투명·색 수·흐림
3. `godot --path . --script res://tests/screens_proto.gd -- <폴더>` 로 게임 화면에 들어간 모습을 찍어 직접 열어 보기
4. `python3 scripts/test.py --stage all`
5. 사용자에게 비교 시트와 게임 화면을 보여 주고 "검사는 통과, 미술 판단은 사용자 몫" — 허락을 받은 뒤 커밋

warning: Codex is ignoring 1 unrecognized configuration setting. Check for typos or deprecated settings.
  user (C:\Users\pc\.codex\config.toml): `computer_use.windows.always_allowed_app_ids` is ignored.
warning: Codex is ignoring 1 unrecognized configuration setting. Check for typos or deprecated settings.
  user (C:\Users\pc\.codex\config.toml): `computer_use.windows.always_allowed_app_ids` is ignored.
codex
기준 그림과 허용된 파일 범위를 먼저 확인하겠습니다. imagegen 스킬에 따라 이미지를 생성한 뒤, 크기·투명도·색 수를 코드로 다듬겠습니다.

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content AGENTS.md; Get-Content PROTECTED.txt; Get-Content 'C:/Users/pc/.codex/skills/.system/imagegen/SKILL.md'; Get-Content 'docs/그림-목록.md'; Get-Content art/sprite_list.json; git status --porcelain; Get-ChildItem art/references -Force" in C:\Users\pc\Documents\game
 succeeded in 512ms:
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

1. ??**洹몃┝泥??쒖븞 3媛?* (`handoff-01.md`) ???욎? ?쒖븞 (`handoff-01b.md`) ??**?욎? 洹몃┝泥대줈 寃곗젙**
2. 怨좊Ⅸ ?쒖븞??湲곗? 洹몃┝(`art/references/`)?쇰줈 ?붾떎 ??蹂댄샇 ?대뜑??**?ъ슜???덈씫 ?ㅼ뿉** ?ｋ뒗??
3. **媛留덉쓽 蹂묒궗 洹몃┝ 10??* (`handoff-02.md`)
4. **?뚯쓣 ?덈뒗 ??洹몃┝ 12??+ 怨듯넻 7??* (`handoff-03.md`)
5. 留ㅻ쾲 Claude媛 `check_sprites.py` ? 寃뚯엫 ?ㅽ겕由곗꺑?쇰줈 ?뺤씤?섍퀬, ?ъ슜?먯뿉寃?蹂댁뿬 以 ??而ㅻ컠?쒕떎

## ?뺥븳 洹몃┝泥? 媛 + ???욎쓬 (2026-11-27 ?ъ슜???뱀씤)

> ?ъ슜?? "洹몃┝泥대뒗 "媛"媛 李쎈퀝?대씪?섏?, ?쒖삦, ?꾧묠鍮꾨? ?????쒗쁽??寃?媛숈븘. 洹몃윴??"?????됱긽? ?댄썑???대뼡寃??ㅼ뼱媛??吏???곕씪?????ъ슜???섎룄 ?덉쓣 寃?媛숈븘." ???욎? ?쒖븞(`art/style/mix`)??"?댁쟾蹂대떎 寃곌낵媛 醫뗭? 寃?媛숈븘. ?대?濡??댁꽌 ??踰?吏꾪뻾?대낫??"

| 臾댁뾿 | ?대뼸寃?|
|---|---|
| ?뺥깭쨌?뷀뀒?셋룻몴??| 媛 泥섎읆 ??32횞32 ?먯꽌???쒕늿??|
| 諛뷀깢 | ??泥섎읆 ??癒뱀깋쨌???뚯깋議? 李⑤텇?섍쾶 |
| 媛뺥븳 ??| **?좎빟쨌湲곗슫?먮쭔** (泥?옄 = 臾? 吏꾩궗 = 遺? ?묒쑀 = ??. ?됱씠 怨?寃뚯엫 ?뺣낫 |
| 湲덉깋 | ?붾?쨌?꾩꽕 媛숈? ?밸퀎??寃껋뿉留?|
| 蹂묒궗 | ?좎빟 諛붾Ⅸ **?꾩옄湲??명삎** ??留ㅻ걟??紐? ??愿묓깮, 諛쒕컩 諛쏆묠 |
| ?꾧묠鍮?| 癒밸튆 ?⑥깋쨌?뚯껌??+ ?몃? ??(吏꾩궗 鍮④컯 湲덉? ???꾧뎔怨?援щ텇) |

## 洹몃┝泥??꾨낫 (?쒖븞?먯꽌 鍮꾧탳?덈뜕 寃?

| ?대쫫 | ?먮굦 | ?멸낸??| ??|
|---|---|---|---|
| **媛. ?곕쑜????* | ?쒓뎅 ?꾪넻(?꾩옄湲걔룻븳?Β룸룄源⑤퉬)??李⑤텇?섍퀬 ?곕쑜?섍쾶 | 吏꾪븳 媛덉깋 1px | ?숈깋쨌癒뱀깋 諛뷀깢 + ?좎빟/湲곗슫 ??|
| **?? 諛앹? ?숉솕** | 洹?쎄퀬 ?먮졆?섍쾶, ?λ궃媛?媛숈? ?먮굦 | 寃??1px, 援듭? ?ㅻ（??| 梨꾨룄 ?믪? ??|
| **?? ?섎У ?쎌?** | 癒뱀쑝濡?洹몃┛ ??븳 ?묐갚 + ?ъ씤????| 癒뱀깋, 援듦린 蹂??| 嫄곗쓽 ?묐갚 + 泥?옄 珥덈줉쨌吏꾩궗 鍮④컯쨌湲덉깋留?|

## ?꾩껜 紐⑸줉 (29??

### 媛留덉쓽 蹂묒궗 (10??

| ?뚯씪 | ?ш린 | ?댁슜 |
|---|---|---|
| `kiln/soldier_{spear,archer,shield}_{water,fire,earth}.png` | 32횞32 횞9 | ?좎빟 諛붾Ⅸ ?꾩옄湲??명삎 蹂묒궗 (諛쏆묠쨌愿묓깮). 紐⑥뼇 = 李쎈퀝/沅곸닔/諛⑺뙣蹂? ?좎빟 = 泥?옄(鍮꾩랬鍮??뱀깋)/吏꾩궗(援щ━鍮?鍮④컯)/?묒쑀(寃? 媛덉깋). ?ㅻⅨ履쎌쓣 蹂몃떎 |
| `kiln/kiln_body.png` | 160횞160 | ?꾪넻 ?μ옉 媛留??욌え?? 媛?대뜲 臾??먮━? ?꾧턿?대뒗 ?대몼寃?鍮꾩? (臾맞룸텋湲몄? 寃뚯엫??洹몃┝) |

### ?뚯쓣 ?덈뒗 ??(12??

| ?뚯씪 | ?ш린 | ?댁슜 |
|---|---|---|
| `nest/creature_{spear,archer,shield}_{fire,water,earth}.png` | 32횞32 횞9 | 愿댁닔 ?덈겮 9醫? 遺덇퐙 ?꾨쭏諭쨌臾쇱궡 ?섎떖쨌媛??怨좎뒾?꾩튂 / 遺덉뵪 諛뺤쪖쨌臾쇰갑???댄뙆由?룸룎?붾ℓ ?먯댂??/ ?⑹븫 ?먭볼鍮꽷룹“媛?嫄곕턿쨌諛붿쐞 嫄곕턿. ?ㅻⅨ履쎌쓣 蹂몃떎 |
| `nest/egg_{spear,archer,shield}.png` | 32횞40 횞3 | 毓곗” ?뚭린 ??/ 湲몄춬????/ ?볦쟻???? **諛앹? ?곗깋?쇰줈留?* (寃뚯엫??湲곗슫 ?됱쑝濡?臾쇰뱾?? |

### 怨듯넻 (7??

| ?뚯씪 | ?ш린 | ?댁슜 |
|---|---|---|
| `enemy/goblin.png` | 32횞32 | ?꾧묠鍮???癒밸튆 ?⑥깋 ?쇰?, ?몃? ??(?쇱そ??蹂몃떎) |
| `enemy/imp.png` | 32횞32 | ?꾧묠鍮꾨텋 (?몃Ⅸ 遺덇퐙 ?뺣졊) |
| `enemy/brute.png` | 48횞48 | ???꾧묠鍮???媛숈? 癒밸튆 ?⑥깋, 諛⑸쭩??|
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
   "what": "?좎빟 諛붾Ⅸ ?꾩옄湲??명삎 蹂묒궗 (?щ엺???꾨땲??鍮싳? ?명삎: 留ㅻ걟??紐? ?쇱そ ????愿묓깮 1~2px, 諛쒕컩???묒? 諛쏆묠(援?)(李쎈퀝). 李쎌쓣 ??紐⑥뒿. 紐??꾩껜??泥?옄 ?좎빟 ??鍮꾩랬鍮??몃Ⅸ ?뱀깋, ????愿묓깮. ?ㅻⅨ履쎌쓣 蹂몃떎."
  },
  {
   "path": "assets/sprites/kiln/soldier_spear_fire.png",
   "size": [
    32,
    32
   ],
   "group": "媛留덉쓽 蹂묒궗",
   "what": "?좎빟 諛붾Ⅸ ?꾩옄湲??명삎 蹂묒궗 (?щ엺???꾨땲??鍮싳? ?명삎: 留ㅻ걟??紐? ?쇱そ ????愿묓깮 1~2px, 諛쒕컩???묒? 諛쏆묠(援?)(李쎈퀝). 李쎌쓣 ??紐⑥뒿. 紐??꾩껜??吏꾩궗 ?좎빟 ??援щ━鍮?源딆? 遺됱??? ?ㅻⅨ履쎌쓣 蹂몃떎."
  },
  {
   "path": "assets/sprites/kiln/soldier_spear_earth.png",
   "size": [
    32,
    32
   ],
   "group": "媛留덉쓽 蹂묒궗",
   "what": "?좎빟 諛붾Ⅸ ?꾩옄湲??명삎 蹂묒궗 (?щ엺???꾨땲??鍮싳? ?명삎: 留ㅻ걟??紐? ?쇱そ ????愿묓깮 1~2px, 諛쒕컩???묒? 諛쏆묠(援?)(李쎈퀝). 李쎌쓣 ??紐⑥뒿. 紐??꾩껜???묒쑀 ?좎빟 ??寃? 媛덉깋, 湲곕쫫 媛숈? 愿묓깮. ?ㅻⅨ履쎌쓣 蹂몃떎."
  },
  {
   "path": "assets/sprites/kiln/soldier_archer_water.png",
   "size": [
    32,
    32
   ],
   "group": "媛留덉쓽 蹂묒궗",
   "what": "?좎빟 諛붾Ⅸ ?꾩옄湲??명삎 蹂묒궗 (?щ엺???꾨땲??鍮싳? ?명삎: 留ㅻ걟??紐? ?쇱そ ????愿묓깮 1~2px, 諛쒕컩???묒? 諛쏆묠(援?)(沅곸닔). ?쒖쓣 ??紐⑥뒿. 紐??꾩껜??泥?옄 ?좎빟 ??鍮꾩랬鍮??몃Ⅸ ?뱀깋, ????愿묓깮. ?ㅻⅨ履쎌쓣 蹂몃떎."
  },
  {
   "path": "assets/sprites/kiln/soldier_archer_fire.png",
   "size": [
    32,
    32
   ],
   "group": "媛留덉쓽 蹂묒궗",
   "what": "?좎빟 諛붾Ⅸ ?꾩옄湲??명삎 蹂묒궗 (?щ엺???꾨땲??鍮싳? ?명삎: 留ㅻ걟??紐? ?쇱そ ????愿묓깮 1~2px, 諛쒕컩???묒? 諛쏆묠(援?)(沅곸닔). ?쒖쓣 ??紐⑥뒿. 紐??꾩껜??吏꾩궗 ?좎빟 ??援щ━鍮?源딆? 遺됱??? ?ㅻⅨ履쎌쓣 蹂몃떎."
  },
  {
   "path": "assets/sprites/kiln/soldier_archer_earth.png",
   "size": [
    32,
    32
   ],
   "group": "媛留덉쓽 蹂묒궗",
   "what": "?좎빟 諛붾Ⅸ ?꾩옄湲??명삎 蹂묒궗 (?щ엺???꾨땲??鍮싳? ?명삎: 留ㅻ걟??紐? ?쇱そ ????愿묓깮 1~2px, 諛쒕컩???묒? 諛쏆묠(援?)(沅곸닔). ?쒖쓣 ??紐⑥뒿. 紐??꾩껜???묒쑀 ?좎빟 ??寃? 媛덉깋, 湲곕쫫 媛숈? 愿묓깮. ?ㅻⅨ履쎌쓣 蹂몃떎."
  },
  {
   "path": "assets/sprites/kiln/soldier_shield_water.png",
   "size": [
    32,
    32
   ],
   "group": "媛留덉쓽 蹂묒궗",
   "what": "?좎빟 諛붾Ⅸ ?꾩옄湲??명삎 蹂묒궗 (?щ엺???꾨땲??鍮싳? ?명삎: 留ㅻ걟??紐? ?쇱そ ????愿묓깮 1~2px, 諛쒕컩???묒? 諛쏆묠(援?)(諛⑺뙣蹂?. ?κ렐 諛⑺뙣瑜???紐⑥뒿. 紐??꾩껜??泥?옄 ?좎빟 ??鍮꾩랬鍮??몃Ⅸ ?뱀깋, ????愿묓깮. ?ㅻⅨ履쎌쓣 蹂몃떎."
  },
  {
   "path": "assets/sprites/kiln/soldier_shield_fire.png",
   "size": [
    32,
    32
   ],
   "group": "媛留덉쓽 蹂묒궗",
   "what": "?좎빟 諛붾Ⅸ ?꾩옄湲??명삎 蹂묒궗 (?щ엺???꾨땲??鍮싳? ?명삎: 留ㅻ걟??紐? ?쇱そ ????愿묓깮 1~2px, 諛쒕컩???묒? 諛쏆묠(援?)(諛⑺뙣蹂?. ?κ렐 諛⑺뙣瑜???紐⑥뒿. 紐??꾩껜??吏꾩궗 ?좎빟 ??援щ━鍮?源딆? 遺됱??? ?ㅻⅨ履쎌쓣 蹂몃떎."
  },
  {
   "path": "assets/sprites/kiln/soldier_shield_earth.png",
   "size": [
    32,
    32
   ],
   "group": "媛留덉쓽 蹂묒궗",
   "what": "?좎빟 諛붾Ⅸ ?꾩옄湲??명삎 蹂묒궗 (?щ엺???꾨땲??鍮싳? ?명삎: 留ㅻ걟??紐? ?쇱そ ????愿묓깮 1~2px, 諛쒕컩???묒? 諛쏆묠(援?)(諛⑺뙣蹂?. ?κ렐 諛⑺뙣瑜???紐⑥뒿. 紐??꾩껜???묒쑀 ?좎빟 ??寃? 媛덉깋, 湲곕쫫 媛숈? 愿묓깮. ?ㅻⅨ履쎌쓣 蹂몃떎."
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
   "what": "'遺덇퐙 ?꾨쭏諭' ??洹?쎄퀬 ?묒? 愿댁닔 ?덈겮. 怨듦꺽??毓곗”??. ?ㅻⅨ履쎌쓣 蹂몃떎. 紐?諛뷀깢? 李⑤텇?섍쾶, 湲곗슫 ??遺?吏꾩궗 鍮④컯, 臾?泥?옄 珥덈줉, ???묒쑀 寃媛???媛???덉뿉 ?꾧쾶."
  },
  {
   "path": "assets/sprites/nest/creature_spear_water.png",
   "size": [
    32,
    32
   ],
   "group": "?뚯쓣 ?덈뒗 ??,
   "what": "'臾쇱궡 ?섎떖' ??洹?쎄퀬 ?묒? 愿댁닔 ?덈겮. 怨듦꺽??毓곗”??. ?ㅻⅨ履쎌쓣 蹂몃떎. 紐?諛뷀깢? 李⑤텇?섍쾶, 湲곗슫 ??遺?吏꾩궗 鍮④컯, 臾?泥?옄 珥덈줉, ???묒쑀 寃媛???媛???덉뿉 ?꾧쾶."
  },
  {
   "path": "assets/sprites/nest/creature_spear_earth.png",
   "size": [
    32,
    32
   ],
   "group": "?뚯쓣 ?덈뒗 ??,
   "what": "'媛??怨좎뒾?꾩튂' ??洹?쎄퀬 ?묒? 愿댁닔 ?덈겮. 怨듦꺽??毓곗”??. ?ㅻⅨ履쎌쓣 蹂몃떎. 紐?諛뷀깢? 李⑤텇?섍쾶, 湲곗슫 ??遺?吏꾩궗 鍮④컯, 臾?泥?옄 珥덈줉, ???묒쑀 寃媛???媛???덉뿉 ?꾧쾶."
  },
  {
   "path": "assets/sprites/nest/creature_archer_fire.png",
   "size": [
    32,
    32
   ],
   "group": "?뚯쓣 ?덈뒗 ??,
   "what": "'遺덉뵪 諛뺤쪖' ??洹?쎄퀬 ?묒? 愿댁닔 ?덈겮. ?먭굅由ы삎(?좊떎?덇굅???섏쭚). ?ㅻⅨ履쎌쓣 蹂몃떎. 紐?諛뷀깢? 李⑤텇?섍쾶, 湲곗슫 ??遺?吏꾩궗 鍮④컯, 臾?泥?옄 珥덈줉, ???묒쑀 寃媛???媛???덉뿉 ?꾧쾶."
  },
  {
   "path": "assets/sprites/nest/creature_archer_water.png",
   "size": [
    32,
    32
   ],
   "group": "?뚯쓣 ?덈뒗 ??,
   "what": "'臾쇰갑???댄뙆由? ??洹?쎄퀬 ?묒? 愿댁닔 ?덈겮. ?먭굅由ы삎(?좊떎?덇굅???섏쭚). ?ㅻⅨ履쎌쓣 蹂몃떎. 紐?諛뷀깢? 李⑤텇?섍쾶, 湲곗슫 ??遺?吏꾩궗 鍮④컯, 臾?泥?옄 珥덈줉, ???묒쑀 寃媛???媛???덉뿉 ?꾧쾶."
  },
  {
   "path": "assets/sprites/nest/creature_archer_earth.png",
   "size": [
    32,
    32
   ],
   "group": "?뚯쓣 ?덈뒗 ??,
   "what": "'?뚰뙏留??먯댂?? ??洹?쎄퀬 ?묒? 愿댁닔 ?덈겮. ?먭굅由ы삎(?좊떎?덇굅???섏쭚). ?ㅻⅨ履쎌쓣 蹂몃떎. 紐?諛뷀깢? 李⑤텇?섍쾶, 湲곗슫 ??遺?吏꾩궗 鍮④컯, 臾?泥?옄 珥덈줉, ???묒쑀 寃媛???媛???덉뿉 ?꾧쾶."
  },
  {
   "path": "assets/sprites/nest/creature_shield_fire.png",
   "size": [
    32,
    32
   ],
   "group": "?뚯쓣 ?덈뒗 ??,
   "what": "'?⑹븫 ?먭볼鍮? ??洹?쎄퀬 ?묒? 愿댁닔 ?덈겮. ?섎퉬???깅뵳吏쨌?⑤떒??. ?ㅻⅨ履쎌쓣 蹂몃떎. 紐?諛뷀깢? 李⑤텇?섍쾶, 湲곗슫 ??遺?吏꾩궗 鍮④컯, 臾?泥?옄 珥덈줉, ???묒쑀 寃媛???媛???덉뿉 ?꾧쾶."
  },
  {
   "path": "assets/sprites/nest/creature_shield_water.png",
   "size": [
    32,
    32
   ],
   "group": "?뚯쓣 ?덈뒗 ??,
   "what": "'議곌컻 嫄곕턿' ??洹?쎄퀬 ?묒? 愿댁닔 ?덈겮. ?섎퉬???깅뵳吏쨌?⑤떒??. ?ㅻⅨ履쎌쓣 蹂몃떎. 紐?諛뷀깢? 李⑤텇?섍쾶, 湲곗슫 ??遺?吏꾩궗 鍮④컯, 臾?泥?옄 珥덈줉, ???묒쑀 寃媛???媛???덉뿉 ?꾧쾶."
  },
  {
   "path": "assets/sprites/nest/creature_shield_earth.png",
   "size": [
    32,
    32
   ],
   "group": "?뚯쓣 ?덈뒗 ??,
   "what": "'諛붿쐞 嫄곕턿' ??洹?쎄퀬 ?묒? 愿댁닔 ?덈겮. ?섎퉬???깅뵳吏쨌?⑤떒??. ?ㅻⅨ履쎌쓣 蹂몃떎. 紐?諛뷀깢? 李⑤텇?섍쾶, 湲곗슫 ??遺?吏꾩궗 鍮④컯, 臾?泥?옄 珥덈줉, ???묒쑀 寃媛???媛???덉뿉 ?꾧쾶."
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
   "what": "?쒓뎅 ?꾧묠鍮? 癒밸튆 ?⑥깋쨌?뚯껌???쇰?, ?몃? ?? 肉? ?앺겢?댁쭊 癒몃━ (吏꾩궗 鍮④컯? ?곗? ?딅뒗?????꾧뎔怨?援щ텇). ?쇱そ??蹂몃떎."
  },
  {
   "path": "assets/sprites/enemy/imp.png",
   "size": [
    32,
    32
   ],
   "group": "怨듯넻 (??",
   "what": "?꾧묠鍮꾨텋. 李쎈갚???몃Ⅸ 遺덇퐙 紐⑥뼇???묒? ?뺣졊, ?몃? ?덈쭔 ?덈떎 (泥?옄 珥덈줉怨??룰컝由ъ? ?딄쾶 李④????몃Ⅸ??. ?쇱そ??蹂몃떎."
  },
  {
   "path": "assets/sprites/enemy/brute.png",
   "size": [
    48,
    48
   ],
   "group": "怨듯넻 (??",
   "what": "???꾧묠鍮? goblin 怨?媛숈? 癒밸튆 ?⑥깋 ?쇰?쨌?몃? ?? ?⑹튂 ?ш퀬 ?꾧묠鍮?諛⑸쭩?대? ?좊떎. ?쇱そ??蹂몃떎."
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
 ],
 "?뺥븳 洹몃┝泥?(2026-11-27, ?ъ슜???뱀씤)": [
  "湲곗? 洹몃┝: art/references/ (= art/style/mix ?쒖븞)",
  "?뺥깭쨌?뷀뀒?셋룻몴?뺤? '媛'泥섎읆 ??32횞32 ?먯꽌??臾댁뾿?몄? ?쒕늿??,
  "諛뷀깢? '??泥섎읆 癒뱀깋쨌???뚯깋議곕줈 李⑤텇?섍쾶, 媛뺥븳 ?됱? ?좎빟쨌湲곗슫?먮쭔 (泥?옄 鍮꾩랬 珥덈줉 / 吏꾩궗 援щ━ 鍮④컯 / ?묒쑀 寃? 媛덉깋 + 湲곕쫫 愿묓깮)",
  "湲덉깋? ?붾?쨌?꾩꽕 媛숈? ?밸퀎??寃껋뿉留?,
  "蹂묒궗???좎빟 諛붾Ⅸ ?꾩옄湲??명삎 (留ㅻ걟??紐? ??愿묓깮, 諛쒕컩 諛쏆묠)",
  "?꾧묠鍮?臾대━??癒밸튆 ?⑥깋쨌?뚯껌??+ ?몃? ??(吏꾩궗 鍮④컯 湲덉?)",
  "?멸낸??1px 吏꾪븳 癒밴컝?? ?꾩껜 ?붾젅?몃뒗 湲곗? 洹몃┝???곕Ⅸ??
 ]
}
A  art/references/creature_shield_water.png
A  art/references/goblin.png
A  art/references/house.png
A  art/references/sheet.png
A  art/references/soldier_archer_water.png
A  art/references/soldier_shield_earth.png
A  art/references/soldier_spear_fire.png
A  art/style/da/creature_shield_water.png
A  art/style/da/goblin.png
A  art/style/da/house.png
A  art/style/da/sheet.png
A  art/style/da/soldier_spear_fire.png
A  art/style/ga/creature_shield_water.png
A  art/style/ga/goblin.png
A  art/style/ga/house.png
A  art/style/ga/sheet.png
A  art/style/ga/soldier_spear_fire.png
A  art/style/mix/creature_shield_water.png
A  art/style/mix/goblin.png
A  art/style/mix/house.png
A  art/style/mix/sheet.png
A  art/style/mix/soldier_archer_water.png
A  art/style/mix/soldier_shield_earth.png
A  art/style/mix/soldier_spear_fire.png
A  art/style/na/creature_shield_water.png
A  art/style/na/goblin.png
A  art/style/na/house.png
A  art/style/na/sheet.png
A  art/style/na/soldier_spear_fire.png
 M assets/fonts/Galmuri11-Bold.ttf.import
 M assets/fonts/Galmuri11.ttf.import
MM "work/2026-11-27-\352\267\270\353\246\274/NOTES.md"
M  "work/2026-11-27-\352\267\270\353\246\274/handoff-01.md"
A  "work/2026-11-27-\352\267\270\353\246\274/handoff-01.report.md"
A  "work/2026-11-27-\352\267\270\353\246\274/handoff-01b.report.md"
?? reports/boss/history-local-backup.csv
?? "work/2026-11-27-\352\267\270\353\246\274/handoff-02.report.md"


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



exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -Encoding UTF8 'C:/Users/pc/.codex/skills/.system/imagegen/SKILL.md' | Select-Object -Skip 105; Get-Content -Encoding UTF8 'docs/그림-목록.md'; Get-Content -Encoding UTF8 PROTECTED.txt; Get-Content -Encoding UTF8 art/references/README.md; Get-ChildItem assets/sprites/kiln -ErrorAction SilentlyContinue" in C:\Users\pc\Documents\game
 exited 1 in 511ms:
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

### 알을 품는 성 (12장)

| 파일 | 크기 | 내용 |
|---|---|---|
| `nest/creature_{spear,archer,shield}_{fire,water,earth}.png` | 32×32 ×9 | 괴수 새끼 9종: 불꽃 도마뱀·물살 수달·가시 고슴도치 / 불씨 박쥐·물방울 해파리·돌팔매 원숭이 / 용암 두꺼비·조개 거북·바위 거북. 오른쪽을 본다 |
| `nest/egg_{spear,archer,shield}.png` | 32×40 ×3 | 뾰족 돌기 알 / 길쭉한 알 / 넓적한 알. **밝은 흰색으로만** (게임이 기운 색으로 물들임) |

### 공통 (7장)

| 파일 | 크기 | 내용 |
|---|---|---|
| `enemy/goblin.png` | 32×32 | 도깨비 — 먹빛 남색 피부, 노란 눈 (왼쪽을 본다) |
| `enemy/imp.png` | 32×32 | 도깨비불 (푸른 불꽃 정령) |
| `enemy/brute.png` | 48×48 | 큰 도깨비 — 같은 먹빛 남색, 방망이 |
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
# 기준 그림

우리 그림체를 대표하는 그림을 이 폴더에 넣어 주세요 (png/jpg, 3~8장 권장).
검토자는 이 그림들과 `art/rubric.md`만 보고 채점합니다.

2026-11-27T05:59:19.788358Z ERROR codex_memories_write::phase2::agent: memory consolidation artifacts are invalid: memory summary artifact does not start with v1: C:\Users\pc\.codex\memories_v2\memory_summary.md
codex
기준 그림을 확인했습니다. 넓은 모자와 단순한 인형 형태, 낮은 받침, 차분한 유약색을 맞추겠습니다. 최신 지시서가 파일 생성을 10장으로 제한하므로 NOTES.md와 보고서 파일은 수정하지 않고, 결과는 대화에 남기겠습니다.

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Get-Content -Encoding UTF8 AGENTS.md; $manifest = Get-Content -Raw -Encoding UTF8 art/sprite_list.json | ConvertFrom-Json; $manifest.files | Where-Object { $_.path -like '"'*kiln/*' } | ConvertTo-Json -Depth 4; Get-Command node,magick -ErrorAction SilentlyContinue | Select-Object Name,Source" in C:\Users\pc\Documents\game
 exited 1 in 2235ms:
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
[
    {
        "path":  "assets/sprites/kiln/soldier_spear_water.png",
        "size":  [
                     32,
                     32
                 ],
        "group":  "가마의 병사",
        "what":  "유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(창병). 창을 든 모습. 몸 전체에 청자 유약 — 비취빛 푸른 녹색, 은은한 광택. 오른쪽을 본다."
    },
    {
        "path":  "assets/sprites/kiln/soldier_spear_fire.png",
        "size":  [
                     32,
                     32
                 ],
        "group":  "가마의 병사",
        "what":  "유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(창병). 창을 든 모습. 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다."
    },
    {
        "path":  "assets/sprites/kiln/soldier_spear_earth.png",
        "size":  [
                     32,
                     32
                 ],
        "group":  "가마의 병사",
        "what":  "유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(창병). 창을 든 모습. 몸 전체에 흑유 유약 — 검은 갈색, 기름 같은 광택. 오른쪽을 본다."
    },
    {
        "path":  "assets/sprites/kiln/soldier_archer_water.png",
        "size":  [
                     32,
                     32
                 ],
        "group":  "가마의 병사",
        "what":  "유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(궁수). 활을 든 모습. 몸 전체에 청자 유약 — 비취빛 푸른 녹색, 은은한 광택. 오른쪽을 본다."
    },
    {
        "path":  "assets/sprites/kiln/soldier_archer_fire.png",
        "size":  [
                     32,
                     32
                 ],
        "group":  "가마의 병사",
        "what":  "유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(궁수). 활을 든 모습. 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다."
    },
    {
        "path":  "assets/sprites/kiln/soldier_archer_earth.png",
        "size":  [
                     32,
                     32
                 ],
        "group":  "가마의 병사",
        "what":  "유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(궁수). 활을 든 모습. 몸 전체에 흑유 유약 — 검은 갈색, 기름 같은 광택. 오른쪽을 본다."
    },
    {
        "path":  "assets/sprites/kiln/soldier_shield_water.png",
        "size":  [
                     32,
                     32
                 ],
        "group":  "가마의 병사",
        "what":  "유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(방패병). 둥근 방패를 든 모습. 몸 전체에 청자 유약 — 비취빛 푸른 녹색, 은은한 광택. 오른쪽을 본다."
    },
    {
        "path":  "assets/sprites/kiln/soldier_shield_fire.png",
        "size":  [
                     32,
                     32
                 ],
        "group":  "가마의 병사",
        "what":  "유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(방패병). 둥근 방패를 든 모습. 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다."
    },
    {
        "path":  "assets/sprites/kiln/soldier_shield_earth.png",
        "size":  [
                     32,
                     32
                 ],
        "group":  "가마의 병사",
        "what":  "유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(방패병). 둥근 방패를 든 모습. 몸 전체에 흑유 유약 — 검은 갈색, 기름 같은 광택. 오른쪽을 본다."
    },
    {
        "path":  "assets/sprites/kiln/kiln_body.png",
        "size":  [
                     160,
                     160
                 ],
        "group":  "가마의 병사",
        "what":  "전통 장작 가마(오름가마/둥근 흙가마)의 앞모습. 가운데 아치형 문 자리(가로 가운데 55%, 위에서 20~78%)와 아래쪽 아궁이 자리는 거의 검은색으로 비워 둔다 — 문·불길·빛은 게임이 그 위에 그린다."
    }
]

Name     Source                          
----     ------                          
node.exe C:\Program Files\nodejs\node.exe



mcp: node_repl/js started
mcp: node_repl/js (completed)
codex
창병·궁수·방패병과 가마 원본을 생성했습니다. 병사별 유약 변형을 만든 뒤, 32×32로 줄여도 무기가 구분되는지 확인하겠습니다. 가마는 문과 아궁이를 어둡게 비우고 불빛은 넣지 않았습니다.

codex
유약 변형을 생성하고 있습니다. 후처리에서는 기준 그림의 팔레트로 색을 맞추고, 병사 높이와 발밑 여백을 통일하겠습니다. 저장소의 Python 검사는 실행하지 않습니다.

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Add-Type -AssemblyName System.Drawing
foreach ($name in @('"'soldier_spear_fire','soldier_archer_water','soldier_shield_earth')) { "'$im = [System.Drawing.Bitmap]::new((Join-Path (Get-Location) "art/references/$name.png")); $colors = @{}; for($y=0;$y -lt $im.Height;$y++){ for($x=0;$x -lt $im.Width;$x++){ $c=$im.GetPixel($x,$y); if($c.A -gt 0){ $k='"'{0:X2}{1:X2}{2:X2}' -f "'$c.R,$c.G,$c.B; $colors[$k] = 1 + $colors[$k] } } }; Write-Output $name; $colors.GetEnumerator() | Sort-Object Value -Descending | Format-Table -HideTableHeaders; $im.Dispose() }
Get-ChildItem '"'C:/Users/pc/.codex/generated_images/01a21b95-e3e8-7140-8a4e-33a49ce01434' | Select-Object Name,Length" in C:\Users\pc\Documents\game
 succeeded in 455ms:
soldier_spear_fire

282322                         143                                                                                     
A84438                         95                                                                                      
929187                         44                                                                                      
67332E                         36                                                                                      
CD6851                         18                                                                                      
706258                         12                                                                                      
B9BAAD                         12                                                                                      
F2F1E7                         1                                                                                       
302C2A                         1                                                                                       
DDDCD0                         1                                                                                       


soldier_archer_water

282322                         161                                                                                     
6B9878                         41                                                                                      
466F59                         40                                                                                      
B9BAAD                         32                                                                                      
A6C5A3                         27                                                                                      
929187                         26                                                                                      
304B42                         16                                                                                      
706258                         12                                                                                      
3A3733                         6                                                                                       
DDDCD0                         4                                                                                       
F2F1E7                         3                                                                                       
302C2A                         3                                                                                       
494039                         1                                                                                       
4D4942                         1                                                                                       


soldier_shield_earth

282322                         222                                                                                     
3A3733                         57                                                                                      
706258                         56                                                                                      
929187                         31                                                                                      
494039                         30                                                                                      
4D4942                         8                                                                                       
B9BAAD                         3                                                                                       
F2F1E7                         2                                                                                       
302C2A                         2                                                                                       



Name                                          Length
----                                          ------
exec-10d7f9c7-2436-46e3-bf63-679abfc6ec2b.png 595391
exec-40253f35-4bb7-445b-8739-398c76a4a869.png 575991
exec-8287848b-608e-43d4-8069-312e3ad51915.png 459140
exec-9e8badb5-adfd-43c6-8fb0-f502e01c1c0d.png 591385
exec-9f5165b4-556a-4788-be2e-cc042ec70a5a.png 470493
exec-b34dd0eb-f28d-4784-b0e8-0bf503f9a338.png 592983
exec-c98e100d-36c7-4277-b5d0-c92212cc5fcb.png 860139
exec-dff48d29-45f6-42b8-8331-c045831a4c5c.png 483056



exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Add-Type -AssemblyName System.Drawing
$im=[System.Drawing.Bitmap]::new('"'C:/Users/pc/.codex/generated_images/01a21b95-e3e8-7140-8a4e-33a49ce01434/exec-dff48d29-45f6-42b8-8331-c045831a4c5c.png')
"'$im.GetPixel(0,0) | Format-List
$im.Dispose()' in C:\Users\pc\Documents\game
 succeeded in 296ms:


R             : 0
G             : 0
B             : 0
A             : 0
IsKnownColor  : False
IsEmpty       : False
IsNamedColor  : False
IsSystemColor : False
Name          : 0




codex
생성본에서 일부 유약색과 받침 색이 기준 팔레트에서 벗어난 부분을 확인했습니다. 색을 정리하면서 반투명 픽셀을 제거하고, 병사 9장의 발밑 여백을 4px로 맞추고 있습니다.

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Add-Type -AssemblyName System.Drawing
Add-Type -ReferencedAssemblies System.Drawing -TypeDefinition @'

using System;
using System.Drawing;
using System.Drawing.Imaging;
using System.Collections.Generic;
public static class SpriteFinish {
 public static Color Hex(string s) { return Color.FromArgb(255,Convert.ToInt32(s.Substring(0,2),16),Convert.ToInt32(s.Substring(2,2),16),Convert.ToInt32(s.Substring(4,2),16)); }
 public static void Run(string input,string output,string kind) {
 using(var src=new Bitmap(input)) {
 bool kiln=kind==\"kiln\"; int n=kiln?160:32;
 var colors=new List<Color>();
 string pal=\"282322 302C2A 3A3733 4D4942 706258 929187 B9BAAD DDDCD0 F2F1E7 \";
 pal+=kind==\"water\"?\"304B42 466F59 6B9878 A6C5A3\":kind==\"fire\"?\"67332E A84438 CD6851\":kind==\"earth\"?\"494039\":\"161414 494039\";
 foreach(string c in pal.Split(' ')) if(c.Length==6) colors.Add(Hex(c));
 int x0=src.Width,y0=src.Height,x1=0,y1=0;
 for(int y=0;y<src.Height;y++)for(int x=0;x<src.Width;x++){ if(src.GetPixel(x,y).A>=128){x0=Math.Min(x0,x); y0=Math.Min(y0,y); x1=Math.Max(x1,x); y1=Math.Max(y1,y);}}
 int h=24,w=(int)Math.Round((x1-x0+1)*24.0/(y1-y0+1)),ox=(32-w)/2,oy=4;
 using(var dst=new Bitmap(n,n,PixelFormat.Format32bppArgb)) {
 for(int y=0;y<n;y++)for(int x=0;x<n;x++){
 double sx,sy;
 if(kiln) {
 if(x<6||x>153||y<6||y>153)continue;
 sx=x<36?100+(x-6)*215.0/30:x<=124?315+(x-36)*623.0/88:938+(x-124)*212.0/30;
 sy=y<32?114+(y-6)*236.0/26:y<=125?350+(y-32)*595.0/93:945+(y-125)*235.0/29;
 } else {
 if(x<ox||x>=ox+w||y<oy||y>=oy+h)continue;
 sx=x0+(x-ox+0.5)*(x1-x0+1)/w;sy=y0+(y-oy+0.5)*(y1-y0+1)/h;
 }
 Color c=src.GetPixel(Math.Min(src.Width-1,(int)sx),Math.Min(src.Height-1,(int)sy));
 if(c.A<128)continue;
 double best=Double.MaxValue; Color outc=colors[0];
 foreach(Color q in colors){double d=(c.R-q.R)*(c.R-q.R)+(c.G-q.G)*(c.G-q.G)+(c.B-q.B)*(c.B-q.B);if(d<best){best=d;outc=q;}}
 dst.SetPixel(x,y,outc);
 }
 // Remove stray isolated alpha pixels introduced by downsampling.
 for(int y=1;y<n-1;y++)for(int x=1;x<n-1;x++){if(dst.GetPixel(x,y).A==0)continue; int count=0;for(int dy=-1;dy<=1;dy++)for(int dx=-1;dx<=1;dx++)if((dx"'!=0||dy!=0)&&dst.GetPixel(x+dx,y+dy).A>0)count++;if(count==0)dst.SetPixel(x,y,Color.Transparent);}
 dst.Save(output,ImageFormat.Png);
 var unique=new HashSet<int>();var alpha=new HashSet<int>();int bottom=-1,top=n;
 for(int y=0;y<n;y++)for(int x=0;x<n;x++){var c=dst.GetPixel(x,y);alpha.Add(c.A);if(c.A>0){unique.Add(c.ToArgb());bottom=Math.Max(bottom,y);top=Math.Min(top,y);}}
 Console.WriteLine(System.IO.Path.GetFileName(output)+" "+n+"x"+n+" colors="+unique.Count+" alpha="+String.Join(",",alpha)+" y="+top+".."+bottom);
 }
 }
 }
 public static string Preview(string folder) {
 using(var sheet=new Bitmap(760,620))using(var g=Graphics.FromImage(sheet)){
 g.Clear(Hex("DDDCD0")); g.InterpolationMode=System.Drawing.Drawing2D.InterpolationMode.NearestNeighbor;g.PixelOffsetMode=System.Drawing.Drawing2D.PixelOffsetMode.Half;
 string[] roles={"spear","archer","shield"},els={"water","fire","earth"};
 for(int j=0;j<3;j++)for(int i=0;i<3;i++){using(var b=new Bitmap(System.IO.Path.Combine(folder,"soldier_"+roles[i]+"_"+els[j]+".png"))){g.FillRectangle(new SolidBrush(Hex("3A3733")),10+i*140,10+j*190,128,128);g.DrawImage(b,new Rectangle(10+i*140,10+j*190,128,128));g.DrawImageUnscaled(b,55+i*140,145+j*190);}}
 using(var b=new Bitmap(System.IO.Path.Combine(folder,"kiln_body.png")))g.DrawImage(b,new Rectangle(435,30,320,320));
 using(var ms=new System.IO.MemoryStream()){sheet.Save(ms,ImageFormat.Png);return Convert.ToBase64String(ms.ToArray());}
 }
 }
}

'"'@
if(Test-Path 'C:/Users/pc/Documents/game/assets/sprites/kiln/soldier_spear_water.png'){throw 'Target exists: spear_water'}
if(Test-Path 'C:/Users/pc/Documents/game/assets/sprites/kiln/soldier_spear_fire.png'){throw 'Target exists: spear_fire'}
if(Test-Path 'C:/Users/pc/Documents/game/assets/sprites/kiln/soldier_spear_earth.png'){throw 'Target exists: spear_earth'}
if(Test-Path 'C:/Users/pc/Documents/game/assets/sprites/kiln/soldier_archer_water.png'){throw 'Target exists: archer_water'}
if(Test-Path 'C:/Users/pc/Documents/game/assets/sprites/kiln/soldier_shield_earth.png'){throw 'Target exists: shield_earth'}
if(Test-Path 'C:/Users/pc/Documents/game/assets/sprites/kiln/soldier_shield_fire.png'){throw 'Target exists: shield_fire'}
if(Test-Path 'C:/Users/pc/Documents/game/assets/sprites/kiln/soldier_shield_water.png'){throw 'Target exists: shield_water'}
if(Test-Path 'C:/Users/pc/Documents/game/assets/sprites/kiln/kiln_body.png'){throw 'Target exists: kiln_body'}
if(Test-Path 'C:/Users/pc/Documents/game/assets/sprites/kiln/soldier_archer_fire.png'){throw 'Target exists: archer_fire'}
if(Test-Path 'C:/Users/pc/Documents/game/assets/sprites/kiln/soldier_archer_earth.png'){throw 'Target exists: archer_earth'}
New-Item -ItemType Directory -Path 'C:/Users/pc/Documents/game/assets/sprites/kiln' -Force | Out-Null
[SpriteFinish]::Run('C:/Users/pc/.codex/generated_images/01a21b95-e3e8-7140-8a4e-33a49ce01434/exec-dff48d29-45f6-42b8-8331-c045831a4c5c.png','C:/Users/pc/Documents/game/assets/sprites/kiln/soldier_spear_water.png','water')
[SpriteFinish]::Run('C:/Users/pc/.codex/generated_images/01a21b95-e3e8-7140-8a4e-33a49ce01434/exec-9f5165b4-556a-4788-be2e-cc042ec70a5a.png','C:/Users/pc/Documents/game/assets/sprites/kiln/soldier_spear_fire.png','fire')
[SpriteFinish]::Run('C:/Users/pc/.codex/generated_images/01a21b95-e3e8-7140-8a4e-33a49ce01434/exec-8287848b-608e-43d4-8069-312e3ad51915.png','C:/Users/pc/Documents/game/assets/sprites/kiln/soldier_spear_earth.png','earth')
[SpriteFinish]::Run('C:/Users/pc/.codex/generated_images/01a21b95-e3e8-7140-8a4e-33a49ce01434/exec-9e8badb5-adfd-43c6-8fb0-f502e01c1c0d.png','C:/Users/pc/Documents/game/assets/sprites/kiln/soldier_archer_water.png','water')
[SpriteFinish]::Run('C:/Users/pc/.codex/generated_images/01a21b95-e3e8-7140-8a4e-33a49ce01434/exec-40253f35-4bb7-445b-8739-398c76a4a869.png','C:/Users/pc/Documents/game/assets/sprites/kiln/soldier_shield_earth.png','earth')
[SpriteFinish]::Run('C:/Users/pc/.codex/generated_images/01a21b95-e3e8-7140-8a4e-33a49ce01434/exec-10d7f9c7-2436-46e3-bf63-679abfc6ec2b.png','C:/Users/pc/Documents/game/assets/sprites/kiln/soldier_shield_fire.png','fire')
[SpriteFinish]::Run('C:/Users/pc/.codex/generated_images/01a21b95-e3e8-7140-8a4e-33a49ce01434/exec-b34dd0eb-f28d-4784-b0e8-0bf503f9a338.png','C:/Users/pc/Documents/game/assets/sprites/kiln/soldier_shield_water.png','water')
[SpriteFinish]::Run('C:/Users/pc/.codex/generated_images/01a21b95-e3e8-7140-8a4e-33a49ce01434/exec-c98e100d-36c7-4277-b5d0-c92212cc5fcb.png','C:/Users/pc/Documents/game/assets/sprites/kiln/kiln_body.png','kiln')
[SpriteFinish]::Run('C:/Users/pc/.codex/generated_images/01a21b95-e3e8-7140-8a4e-33a49ce01434/exec-cfacf3ce-b5db-447a-9845-922f777ca74b.png','C:/Users/pc/Documents/game/assets/sprites/kiln/soldier_archer_fire.png','fire')
[SpriteFinish]::Run('C:/Users/pc/.codex/generated_images/01a21b95-e3e8-7140-8a4e-33a49ce01434/exec-760cb15e-5288-4edf-a6c9-9c26349a3f40.png','C:/Users/pc/Documents/game/assets/sprites/kiln/soldier_archer_earth.png','earth')
'PREVIEW:'+[SpriteFinish]::Preview('C:/Users/pc/Documents/game/assets/sprites/kiln')" in C:\Users\pc\Documents\game
 succeeded in 4217ms:
soldier_spear_water.png 32x32 colors=12 alpha=0,255 y=4..27
soldier_spear_fire.png 32x32 colors=8 alpha=0,255 y=4..27
soldier_spear_earth.png 32x32 colors=9 alpha=0,255 y=4..27
soldier_archer_water.png 32x32 colors=12 alpha=0,255 y=4..27
soldier_shield_earth.png 32x32 colors=8 alpha=0,255 y=4..27
soldier_shield_fire.png 32x32 colors=10 alpha=0,255 y=4..27
soldier_shield_water.png 32x32 colors=11 alpha=0,255 y=4..27
kiln_body.png 160x160 colors=9 alpha=0,255 y=6..153
soldier_archer_fire.png 32x32 colors=10 alpha=0,255 y=4..27
soldier_archer_earth.png 32x32 colors=10 alpha=0,255 y=4..27
PREVIEW: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A75eP7avob99bBPwn2u57+3HKfzxi/a/8rRx+ZP7aL3ReqH9JrBpv/b6nmnynomIiB6PDvgLg/zXtA/1Mj4f3md7/dN7w1r7WfvXfolna72wvEde/9ef9l7xT/Fff925IiIi3pWA//IBfv3RnKb9KW0bn4D/XC3Ev/5pfft1fw4/YtHeL4b41z84eP1N4+s/O1dERMS7Hh/wF68f4Ndw3379dWwCflTSH9G8BvctnCciImKLBPyXj/Dv//C7n/Fjmw/wc7V/y8nym7/ln1//V57X/0x/hJaeeP0xnUX+F5+IiDhKAv4bf8rm+HimpRf8ES6lZ0K+T+T4iIiIXgn4ERERERE3koAfEREREXEjCfgRERERETeSgB8RERERcSMJ+BERERERN5KAHxERERFxIwn4ERERERE3koAfEREREXEjCfgRERERETeSgB8RERERcSMJ+BERERERN5KAHxERERFxIwn4ERERERE3koAfEREREXEjCfgRERERETeSgB8RERERcSMJ+BERERERN5KAHxERERFxIwn4ERERERE3koAfEREREXEjCfgRERERETeSgB8RERERcSMJ+BERERERN5KAHxERERFxIwn4ERERERE3koAfEREREXEjCfgRERERETeSgB8RERERcSMJ+BERERERN5KAHxERERFxIwn4ERERERE3koAfEREREXEjCfgRERERETeSgB8RERERcSMJ+BERERERN5KAHxERERFxIwn4ERERERE3koAfEREREXEjCfgRERERETeSgB8RERERcSMJ+BERERERN5KAHxERERFxIwn4ERERERE3koAfEREREXEjCfgRERERETeSgB8RERERcSMJ+BERERERN5KAHxERERFxIwn4ERERERE3koAfEREREXEjCfgRERERETeSgB8RERERcSMJ+BERERERN5KAHxERERFxIwn4ERERERE3koAfEREREXEjCfgRERERETeSgB8RERERcSMJ+BERERERN5KAHxERERFxIwn4ERERERE3koAfEREREXEjCfgRERERETeSgB8RERERcSMJ+BERERERN5KAHxERERFxIwn4ERERERE38v8DVZCUNjWIB9cAAAAASUVORK5CYII=

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Add-Type -AssemblyName System.Drawing
foreach($name in @('"'soldier_spear_water','soldier_archer_water','soldier_shield_earth')){
"'$im=[System.Drawing.Bitmap]::new((Join-Path (Get-Location) "assets/sprites/kiln/$name.png")); Write-Output $name
for($y=4;$y -lt 14;$y++){ $row='"'';for("'$x=0;$x -lt 32;$x++){ $c=$im.GetPixel($x,$y); $ch=if($c.A -eq 0){'"'.'}elseif("'$c.R -eq 40 -and $c.G -eq 35){'"'#'}elseif("'$c.R -gt 225){'"'W'}elseif("'$c.G -gt $c.R){'"'g'}else{'o'};"'$row+=$ch}; Write-Output ('"'{0:D2} {1}' -f "'$y,$row)}
$im.Dispose()
}
git status --porcelain --untracked-files=all' in C:\Users\pc\Documents\game
 succeeded in 466ms:
soldier_spear_water
04 ......................#.........
05 .............###.....#g.........
06 .............gg#.....og#........
07 ............gggg#....#o#........
08 ..........##gggg##...#g.........
09 ..........#gogggg##..#o.........
10 ..........#ggggggg#..#o.........
11 .........#ggggggggg..#o.........
12 .......##ggggggggggg##o.........
13 .......#ggggg###gggo##o.........
soldier_archer_water
04 ............###.................
05 ............ggg.................
06 ............ggg.................
07 ...........#gog#................
08 ..........#Wogog#.#g............
09 .........#gggoggo#.#g#..........
10 ........#ggggggggg#.#o#.........
11 ........####oo#o##...#o#........
12 ......#o..ggoo#g......go........
13 .....####..##ogg##....#o........
soldier_shield_earth
04 ..............#o#...............
05 .............oooo...............
06 .............####...............
07 ...........#oooooo#.............
08 ..........#oWoooooo#............
09 ..........#oo#####o#............
10 ..........#o######oo#...........
11 .........#ooooooooooo#..........
12 ........#o###o#o##o##o..........
13 ........####oo#oo#o#............
 M assets/fonts/Galmuri11-Bold.ttf.import
 M assets/fonts/Galmuri11.ttf.import
?? assets/sprites/kiln/kiln_body.png
?? assets/sprites/kiln/soldier_archer_earth.png
?? assets/sprites/kiln/soldier_archer_fire.png
?? assets/sprites/kiln/soldier_archer_water.png
?? assets/sprites/kiln/soldier_shield_earth.png
?? assets/sprites/kiln/soldier_shield_fire.png
?? assets/sprites/kiln/soldier_shield_water.png
?? assets/sprites/kiln/soldier_spear_earth.png
?? assets/sprites/kiln/soldier_spear_fire.png
?? assets/sprites/kiln/soldier_spear_water.png
?? reports/boss/history-local-backup.csv
?? "work/2026-11-27-\352\267\270\353\246\274/handoff-02.report.md"

codex
10장을 지정 크기로 저장했고, 원본 크기와 확대 화면을 나란히 확인했습니다. 현재 모두 24색 이하이고 반투명 픽셀은 없습니다. 축소하면서 창병의 흰 광택이 사라진 부분을 보정한 뒤 최종 확인하겠습니다.

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Add-Type -AssemblyName System.Drawing
Add-Type -ReferencedAssemblies System.Drawing -TypeDefinition @'

using System;
using System.Drawing;
using System.Drawing.Imaging;
using System.Collections.Generic;
public static class SpriteFinish {
 public static Color Hex(string s) { return Color.FromArgb(255,Convert.ToInt32(s.Substring(0,2),16),Convert.ToInt32(s.Substring(2,2),16),Convert.ToInt32(s.Substring(4,2),16)); }
 public static void Run(string input,string output,string kind) {
 using(var src=new Bitmap(input)) {
 bool kiln=kind==\"kiln\"; int n=kiln?160:32;
 var colors=new List<Color>();
 string pal=\"282322 302C2A 3A3733 4D4942 706258 929187 B9BAAD DDDCD0 F2F1E7 \";
 pal+=kind==\"water\"?\"304B42 466F59 6B9878 A6C5A3\":kind==\"fire\"?\"67332E A84438 CD6851\":kind==\"earth\"?\"494039\":\"161414 494039\";
 foreach(string c in pal.Split(' ')) if(c.Length==6) colors.Add(Hex(c));
 int x0=src.Width,y0=src.Height,x1=0,y1=0;
 for(int y=0;y<src.Height;y++)for(int x=0;x<src.Width;x++){ if(src.GetPixel(x,y).A>=128){x0=Math.Min(x0,x); y0=Math.Min(y0,y); x1=Math.Max(x1,x); y1=Math.Max(y1,y);}}
 int h=24,w=(int)Math.Round((x1-x0+1)*24.0/(y1-y0+1)),ox=(32-w)/2,oy=4;
 using(var dst=new Bitmap(n,n,PixelFormat.Format32bppArgb)) {
 for(int y=0;y<n;y++)for(int x=0;x<n;x++){
 double sx,sy;
 if(kiln) {
 if(x<6||x>153||y<6||y>153)continue;
 sx=x<36?100+(x-6)*215.0/30:x<=124?315+(x-36)*623.0/88:938+(x-124)*212.0/30;
 sy=y<32?114+(y-6)*236.0/26:y<=125?350+(y-32)*595.0/93:945+(y-125)*235.0/29;
 } else {
 if(x<ox||x>=ox+w||y<oy||y>=oy+h)continue;
 sx=x0+(x-ox+0.5)*(x1-x0+1)/w;sy=y0+(y-oy+0.5)*(y1-y0+1)/h;
 }
 Color c=src.GetPixel(Math.Min(src.Width-1,(int)sx),Math.Min(src.Height-1,(int)sy));
 if(c.A<128)continue;
 double best=Double.MaxValue; Color outc=colors[0];
 foreach(Color q in colors){double d=(c.R-q.R)*(c.R-q.R)+(c.G-q.G)*(c.G-q.G)+(c.B-q.B)*(c.B-q.B);if(d<best){best=d;outc=q;}}
 dst.SetPixel(x,y,outc);
 }
 // Remove stray isolated alpha pixels introduced by downsampling.
 for(int y=1;y<n-1;y++)for(int x=1;x<n-1;x++){if(dst.GetPixel(x,y).A==0)continue; int count=0;for(int dy=-1;dy<=1;dy++)for(int dx=-1;dx<=1;dx++)if((dx"'!=0||dy!=0)&&dst.GetPixel(x+dx,y+dy).A>0)count++;if(count==0)dst.SetPixel(x,y,Color.Transparent);}
 dst.Save(output,ImageFormat.Png);
 var unique=new HashSet<int>();var alpha=new HashSet<int>();int bottom=-1,top=n;
 for(int y=0;y<n;y++)for(int x=0;x<n;x++){var c=dst.GetPixel(x,y);alpha.Add(c.A);if(c.A>0){unique.Add(c.ToArgb());bottom=Math.Max(bottom,y);top=Math.Min(top,y);}}
 Console.WriteLine(System.IO.Path.GetFileName(output)+" "+n+"x"+n+" colors="+unique.Count+" alpha="+String.Join(",",alpha)+" y="+top+".."+bottom);
 }
 }
 }
 public static string Preview(string folder) {
 using(var sheet=new Bitmap(760,620))using(var g=Graphics.FromImage(sheet)){
 g.Clear(Hex("DDDCD0")); g.InterpolationMode=System.Drawing.Drawing2D.InterpolationMode.NearestNeighbor;g.PixelOffsetMode=System.Drawing.Drawing2D.PixelOffsetMode.Half;
 string[] roles={"spear","archer","shield"},els={"water","fire","earth"};
 for(int j=0;j<3;j++)for(int i=0;i<3;i++){using(var b=new Bitmap(System.IO.Path.Combine(folder,"soldier_"+roles[i]+"_"+els[j]+".png"))){g.FillRectangle(new SolidBrush(Hex("3A3733")),10+i*140,10+j*190,128,128);g.DrawImage(b,new Rectangle(10+i*140,10+j*190,128,128));g.DrawImageUnscaled(b,55+i*140,145+j*190);}}
 using(var b=new Bitmap(System.IO.Path.Combine(folder,"kiln_body.png")))g.DrawImage(b,new Rectangle(435,30,320,320));
 using(var ms=new System.IO.MemoryStream()){sheet.Save(ms,ImageFormat.Png);return Convert.ToBase64String(ms.ToArray());}
 }
 }
}

'"'@

"'$folder='"'C:/Users/pc/Documents/game/assets/sprites/kiln'
foreach("'$role in @('"'spear','archer','shield')){foreach("'$el in @('"'water','fire','earth')){
"'$path=Join-Path $folder ('"'soldier_'+"'$role+'"'_'+"'$el+'"'.png')
"'$source=[System.Drawing.Bitmap]::new($path)
$im=[System.Drawing.Bitmap]::new($source)
$source.Dispose()
for($y=0;$y -lt 32;$y++){for($x=0;$x -lt 32;$x++){
$c=$im.GetPixel($x,$y)
if($c.A -eq 255 -and $c.R -eq 242 -and $c.G -eq 241){$im.SetPixel($x,$y,[SpriteFinish]::Hex('"'DDDCD0'))}
}}
if("'$role -eq '"'spear'){"'$im.SetPixel(12,9,[SpriteFinish]::Hex('"'F2F1E7'))}
elseif("'$role -eq '"'archer'){"'$im.SetPixel(11,8,[SpriteFinish]::Hex('"'F2F1E7'))}
else{"'$im.SetPixel(12,8,[SpriteFinish]::Hex('"'F2F1E7'))}
"'$im.Save($path,[System.Drawing.Imaging.ImageFormat]::Png)
$im.Dispose()
}}
'"'PREVIEW:'+[SpriteFinish]::Preview("'$folder)
' in C:\Users\pc\Documents\game
 succeeded in 621ms:
PREVIEW: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

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Add-Type -AssemblyName System.Drawing
Get-ChildItem assets/sprites/kiln/*.png | ForEach-Object {
$im=[System.Drawing.Bitmap]::new($_.FullName);$colors=[System.Collections.Generic.HashSet[int]]::new();$alphas=[System.Collections.Generic.HashSet[int]]::new();$bottom=-1;$white=0
for($y=0;$y -lt $im.Height;$y++){for($x=0;$x -lt $im.Width;$x++){$c=$im.GetPixel($x,$y);[void]$alphas.Add($c.A);if($c.A -gt 0){[void]$colors.Add($c.ToArgb());$bottom=$y;if($c.R -eq 242 -and $c.G -eq 241 -and $c.B -eq 231){$white++}}}}
$expected=if($_.Name -eq '"'kiln_body.png'){160}else{32}
if("'$im.Width -ne $expected -or $im.Height -ne $expected -or $colors.Count -gt 24 -or $alphas.Count -ne 2 -or !$alphas.Contains(0) -or !$alphas.Contains(255)){throw ('"'Invalid output: '+"'$_.Name)}
if($expected -eq 32 -and ($bottom -ne 27 -or $white -ne 1)){throw ('"'Invalid soldier placement/highlight: '+"'$_.Name)}
Write-Output ($_.Name+'"' | '+"'$im.Width+'"'x'+"'$im.Height+'"' | '+"'$colors.Count+'"' colors | binary alpha | bottom margin '+("'$im.Height-1-$bottom))
$im.Dispose()
}
git diff --name-only
 git ls-files --others --exclude-standard assets/sprites/kiln' in C:\Users\pc\Documents\game
 succeeded in 707ms:
kiln_body.png | 160x160 | 9 colors | binary alpha | bottom margin 6
soldier_archer_earth.png | 32x32 | 10 colors | binary alpha | bottom margin 4
soldier_archer_fire.png | 32x32 | 10 colors | binary alpha | bottom margin 4
soldier_archer_water.png | 32x32 | 12 colors | binary alpha | bottom margin 4
soldier_shield_earth.png | 32x32 | 8 colors | binary alpha | bottom margin 4
soldier_shield_fire.png | 32x32 | 11 colors | binary alpha | bottom margin 4
soldier_shield_water.png | 32x32 | 12 colors | binary alpha | bottom margin 4
soldier_spear_earth.png | 32x32 | 9 colors | binary alpha | bottom margin 4
soldier_spear_fire.png | 32x32 | 8 colors | binary alpha | bottom margin 4
soldier_spear_water.png | 32x32 | 12 colors | binary alpha | bottom margin 4
warning: in the working copy of 'assets/fonts/Galmuri11-Bold.ttf.import', LF will be replaced by CRLF the next time Git touches it
warning: in the working copy of 'assets/fonts/Galmuri11.ttf.import', LF will be replaced by CRLF the next time Git touches it
assets/sprites/kiln/kiln_body.png
assets/sprites/kiln/soldier_archer_earth.png
assets/sprites/kiln/soldier_archer_fire.png
assets/sprites/kiln/soldier_archer_water.png
assets/sprites/kiln/soldier_shield_earth.png
assets/sprites/kiln/soldier_shield_fire.png
assets/sprites/kiln/soldier_shield_water.png
assets/sprites/kiln/soldier_spear_earth.png
assets/sprites/kiln/soldier_spear_fire.png
assets/sprites/kiln/soldier_spear_water.png

codex
결과: 통과

바뀐 파일 — [assets/sprites/kiln/](/C:/Users/pc/Documents/game/assets/sprites/kiln) 아래 새 PNG 10장:

- `soldier_spear_water.png`, `soldier_spear_fire.png`, `soldier_spear_earth.png` — 창병 3종
- `soldier_archer_water.png`, `soldier_archer_fire.png`, `soldier_archer_earth.png` — 궁수 3종
- `soldier_shield_water.png`, `soldier_shield_fire.png`, `soldier_shield_earth.png` — 방패병 3종
- `kiln_body.png` — 문·아궁이를 어둡게 비운 가마

직접 확인한 것:

- 10장 모두 원본 크기와 확대 화면으로 확인
- 병사 32×32, 가마 160×160
- 이미지당 8~12색, 투명 배경, 반투명 픽셀 없음
- 병사 발밑 여백 4px, 왼쪽 위 흰 광택 1px

그리는 데 쓴 방법:

- 둘 다: 내장 image_gen으로 각각 생성하고 C#으로 크기·팔레트·투명도·광택 정리
- 프롬프트: 기준 그림체 유지, 오른쪽을 보는 도자기 병사, 유약 3종, 받침·왼쪽 위 광택, 금색·효과 제외

못 한 것 / 걱정되는 것:

- 저장소 Python 검사와 게임 화면 확인은 지시대로 Claude에게 남겼습니다.
- 허용된 PNG 10장만 추가했으며 커밋·푸시는 하지 않았습니다.
- 파일 규격 확인은 통과했습니다. 재미·미술 판단은 사용자 몫입니다.
tokens used
75,079
결과: 통과

바뀐 파일 — [assets/sprites/kiln/](/C:/Users/pc/Documents/game/assets/sprites/kiln) 아래 새 PNG 10장:

- `soldier_spear_water.png`, `soldier_spear_fire.png`, `soldier_spear_earth.png` — 창병 3종
- `soldier_archer_water.png`, `soldier_archer_fire.png`, `soldier_archer_earth.png` — 궁수 3종
- `soldier_shield_water.png`, `soldier_shield_fire.png`, `soldier_shield_earth.png` — 방패병 3종
- `kiln_body.png` — 문·아궁이를 어둡게 비운 가마

직접 확인한 것:

- 10장 모두 원본 크기와 확대 화면으로 확인
- 병사 32×32, 가마 160×160
- 이미지당 8~12색, 투명 배경, 반투명 픽셀 없음
- 병사 발밑 여백 4px, 왼쪽 위 흰 광택 1px

그리는 데 쓴 방법:

- 둘 다: 내장 image_gen으로 각각 생성하고 C#으로 크기·팔레트·투명도·광택 정리
- 프롬프트: 기준 그림체 유지, 오른쪽을 보는 도자기 병사, 유약 3종, 받침·왼쪽 위 광택, 금색·효과 제외

못 한 것 / 걱정되는 것:

- 저장소 Python 검사와 게임 화면 확인은 지시대로 Claude에게 남겼습니다.
- 허용된 PNG 10장만 추가했으며 커밋·푸시는 하지 않았습니다.
- 파일 규격 확인은 통과했습니다. 재미·미술 판단은 사용자 몫입니다.
