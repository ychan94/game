OpenAI Codex v0.172.0
--------
workdir: C:\Users\pc\Documents\game
model: gpt-6-astra
provider: openai
approval: never
sandbox: workspace-write [workdir, /tmp, $TMPDIR]
reasoning effort: high
reasoning summaries: none
session id: 01a21bc7-8db6-71f2-ae4d-11b30cdf36e1
--------
user
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
- `assets/sprites/enemy/goblin.png` (새 파일)
- `assets/sprites/enemy/imp.png` (새 파일)
- `assets/sprites/enemy/brute.png` (새 파일)
- `assets/sprites/field/grass_a.png` (새 파일)
- `assets/sprites/field/grass_b.png` (새 파일)
- `assets/sprites/field/house.png` (새 파일)
- `assets/sprites/field/house_broken.png` (새 파일)

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
2. `python3 scripts/check_sprites.py --group "알을 품는 성" --group "공통 (적)" --sheet <작업폴더>/sheet-03.png` (그룹마다 한 번씩) — 크기·투명·색 수·흐림
3. `godot --path . --script res://tests/screens_proto.gd -- <폴더>` 로 게임 화면에 들어간 모습을 찍어 직접 열어 보기
4. `python3 scripts/test.py --stage all`
5. 사용자에게 비교 시트와 게임 화면을 보여 주고 "검사는 통과, 미술 판단은 사용자 몫" — 허락을 받은 뒤 커밋

warning: Codex is ignoring 1 unrecognized configuration setting. Check for typos or deprecated settings.
  user (C:\Users\pc\.codex\config.toml): `computer_use.windows.always_allowed_app_ids` is ignored.
warning: Codex is ignoring 1 unrecognized configuration setting. Check for typos or deprecated settings.
  user (C:\Users\pc\.codex\config.toml): `computer_use.windows.always_allowed_app_ids` is ignored.
codex
기준 그림과 허용된 파일 범위를 먼저 확인하겠습니다. imagegen 스킬을 사용해 그림을 생성하고, 크기·투명 배경·색 수를 코드로 다듬겠습니다.

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath AGENTS.md; Get-Content -LiteralPath PROTECTED.txt; Get-Content -LiteralPath 'C:\\Users\\pc\\.codex\\skills\\.system\\imagegen\\SKILL.md'; git status --porcelain; rg --files art/references; Get-Content -LiteralPath 'docs/그림-목록.md'; Get-Content -LiteralPath art/sprite_list.json" in C:\Users\pc\Documents\game
 succeeded in 400ms:
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
 M reports/boss/history.csv
 M "work/2026-11-27-\352\267\270\353\246\274/NOTES.md"
?? reports/boss/history-local-backup.csv
?? "work/2026-11-27-\352\267\270\353\246\274/handoff-03.report.md"
?? "work/2026-11-27-\352\267\270\353\246\274/screens-02b/"
art/references\README.md
art/references\goblin.png
art/references\sheet.png
art/references\soldier_spear_fire.png
art/references\soldier_shield_earth.png
art/references\soldier_archer_water.png
art/references\house.png
art/references\creature_shield_water.png
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

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -Encoding UTF8 -LiteralPath 'C:\\Users\\pc\\.codex\\skills\\.system\\imagegen\\SKILL.md'" in C:\Users\pc\Documents\game
 succeeded in 0ms:
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

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -Encoding UTF8 -LiteralPath 'docs/그림-목록.md'; Get-Content -Encoding UTF8 -LiteralPath 'art/references/README.md'; Get-Content -Encoding UTF8 -LiteralPath PROTECTED.txt; "'$s = Get-Content -Raw -Encoding UTF8 art/sprite_list.json | ConvertFrom-Json; $s.files | Where-Object { $_.path -notlike '"'*kiln*' } | ForEach-Object { [pscustomobject]@{path="'$_.path; size=$_.size -join '"'x'; exists=(Test-Path -LiteralPath "'$_.path)} } | Format-Table -AutoSize; Get-Command magick,node -ErrorAction SilentlyContinue | Select-Object Name,Source' in C:\Users\pc\Documents\game
 exited 1 in 2123ms:
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
# 기준 그림

우리 그림체를 대표하는 그림을 이 폴더에 넣어 주세요 (png/jpg, 3~8장 권장).
검토자는 이 그림들과 `art/rubric.md`만 보고 채점합니다.
# 사용자가 직접 고친 파일 / 덮어쓰면 안 되는 파일 (한 줄에 하나, glob 가능)
# Claude·Codex는 여기 적힌 파일을 덮어쓰지 않는다. 고쳐야 하면 바꿀 내용을 제안만 한다.
art/references/*
art/rubric.md

path                                          size  exists
----                                          ----  ------
assets/sprites/nest/creature_spear_fire.png   32x32  False
assets/sprites/nest/creature_spear_water.png  32x32  False
assets/sprites/nest/creature_spear_earth.png  32x32  False
assets/sprites/nest/creature_archer_fire.png  32x32  False
assets/sprites/nest/creature_archer_water.png 32x32  False
assets/sprites/nest/creature_archer_earth.png 32x32  False
assets/sprites/nest/creature_shield_fire.png  32x32  False
assets/sprites/nest/creature_shield_water.png 32x32  False
assets/sprites/nest/creature_shield_earth.png 32x32  False
assets/sprites/nest/egg_spear.png             32x40  False
assets/sprites/nest/egg_archer.png            32x40  False
assets/sprites/nest/egg_shield.png            32x40  False
assets/sprites/enemy/goblin.png               32x32  False
assets/sprites/enemy/imp.png                  32x32  False
assets/sprites/enemy/brute.png                48x48  False
assets/sprites/field/grass_a.png              32x32  False
assets/sprites/field/grass_b.png              32x32  False
assets/sprites/field/house.png                32x32  False
assets/sprites/field/house_broken.png         32x32  False



Name     Source                          
----     ------                          
node.exe C:\Program Files\nodejs\node.exe



codex
기준 그림을 확인했고, 대상 19개 파일은 모두 아직 없습니다. 기존 작업 메모에 수정 사항이 있어 그대로 보존하며, 이번 지시서에서 허용한 PNG 19개만 만들겠습니다. 먼저 기준 팔레트와 괴수의 크기를 맞춰 생성하겠습니다.

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Add-Type -AssemblyName System.Drawing; $im = [System.Drawing.Bitmap]::new((Join-Path (Get-Location) '"'art/references/creature_shield_water.png')); "'$colors = @{}; for($y=0;$y -lt $im.Height;$y++){for($x=0;$x -lt $im.Width;$x++){ $c=$im.GetPixel($x,$y); if($c.A -gt 0){$key='"'{0:X2}{1:X2}{2:X2}' -f "'$c.R,$c.G,$c.B; $colors[$key]++}}}; [pscustomobject]@{Width=$im.Width; Height=$im.Height; Colors=$colors}; $im.Dispose(); Get-ChildItem assets/sprites/nest,assets/sprites/enemy,assets/sprites/field -ErrorAction SilentlyContinue | Select-Object FullName' in C:\Users\pc\Documents\game
 exited 1 in 395ms:

Width Height Colors                             
----- ------ ------                             
   32     32 {706258, A6C5A3, 67645C, 929187...}



codex
불꽃 도마뱀·물살 수달·가시 고슴도치·불씨 박쥐의 원본을 생성했습니다. 원본의 색과 세부 묘사가 기준보다 많아, 최종 32×32 파일에서는 기준 팔레트로 줄이고 윤곽을 정리하겠습니다.

codex
원거리형과 수비형을 생성하고 있습니다. 불·물은 진사 빨강과 청자 초록으로, 땅은 검갈색 광택과 가시·바위 형태로 구분하도록 맞추고 있습니다.

codex
괴수 9종의 원본 생성이 끝났습니다. 알은 게임에서 색을 입힐 수 있도록 흰색·연회색만 쓰고, 도깨비는 남색·회청색과 노란 눈으로 아군과 구분하겠습니다.

codex
알 3종은 돌기·길쭉함·넓적함이 구분되는 형태로 나왔습니다. 도깨비불은 청자 초록과 겹치지 않는 차가운 파랑으로 생성했으며, 나머지 적과 들판 그림을 이어서 만들겠습니다.

codex
남은 원본은 부서진 집과 풀밭 변형 타일 2장입니다. 집은 정상 상태와 같은 구조를 유지하고, 풀밭 두 장은 번갈아 배치해도 경계가 드러나지 않도록 가장자리 색을 맞추겠습니다.

context compacted
codex
19장 원본 생성이 끝났습니다. 이제 기준 그림의 팔레트로 색을 줄이고, 실제 게임 크기에 맞춰 투명 배경과 외곽선을 다듬은 뒤 나란히 확인하겠습니다.

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Get-Content -Encoding UTF8 PROTECTED.txt; Get-ChildItem art/references -File | Select-Object Name; git status --porcelain' in C:\Users\pc\Documents\game
 succeeded in 405ms:
# 사용자가 직접 고친 파일 / 덮어쓰면 안 되는 파일 (한 줄에 하나, glob 가능)
# Claude·Codex는 여기 적힌 파일을 덮어쓰지 않는다. 고쳐야 하면 바꿀 내용을 제안만 한다.
art/references/*
art/rubric.md

 M assets/fonts/Galmuri11-Bold.ttf.import
 M assets/fonts/Galmuri11.ttf.import
 M project.godot
 M reports/boss/history.csv
 M "work/2026-11-27-\352\267\270\353\246\274/NOTES.md"
?? assets/sprites/kiln/kiln_body.png.import
?? assets/sprites/kiln/soldier_archer_earth.png.import
?? assets/sprites/kiln/soldier_archer_fire.png.import
?? assets/sprites/kiln/soldier_archer_water.png.import
?? assets/sprites/kiln/soldier_shield_earth.png.import
?? assets/sprites/kiln/soldier_shield_fire.png.import
?? assets/sprites/kiln/soldier_shield_water.png.import
?? assets/sprites/kiln/soldier_spear_earth.png.import
?? assets/sprites/kiln/soldier_spear_fire.png.import
?? assets/sprites/kiln/soldier_spear_water.png.import
?? reports/boss/history-local-backup.csv
?? src/game/glow_layer.gd.uid
?? "work/2026-11-27-\352\267\270\353\246\274/handoff-03.report.md"
?? "work/2026-11-27-\352\267\270\353\246\274/screens-02b/"
Name                     
----                     
creature_shield_water.png
goblin.png               
house.png                
README.md                
sheet.png                
soldier_archer_water.png 
soldier_shield_earth.png 
soldier_spear_fire.png   



exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Add-Type -AssemblyName System.Drawing
$colors = @{}
Get-ChildItem art/references/*.png | Where-Object Name -ne '"'sheet.png' | ForEach-Object { "'$b=[System.Drawing.Bitmap]::new($_.FullName); for($y=0;$y -lt $b.Height;$y++){for($x=0;$x -lt $b.Width;$x++){ $p=$b.GetPixel($x,$y); if($p.A -gt 0){$h='"'{0:X2}{1:X2}{2:X2}' -f "'$p.R,$p.G,$p.B; $colors[$h]=1}}}; $b.Dispose() }
$colors.Keys | Sort-Object' in C:\Users\pc\Documents\game
 succeeded in 391ms:
282322
29333F
302C2A
304B42
3A3733
3D5261
466F59
494039
4D4942
67332E
67645C
6A7E88
6B9878
706258
929187
A6C5A3
A84438
B9BAAD
CD6851
D9CC73
DDDCD0
F2F1E7

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Add-Type -AssemblyName System.Drawing
Add-Type -ReferencedAssemblies System.Drawing -TypeDefinition @'

using System;
using System.Drawing;
using System.Drawing.Imaging;
using System.Collections.Generic;
public class SpriteClean {
 public static Color C(string s){return Color.FromArgb(255,Convert.ToInt32(s.Substring(0,2),16),Convert.ToInt32(s.Substring(2,2),16),Convert.ToInt32(s.Substring(4,2),16));}
 public static Color[] Palette(string kind) {
 string s=\"282322 302C2A 3A3733 494039 4D4942 67645C 706258 929187 B9BAAD DDDCD0 F2F1E7\";
 if(kind==\"fire\")s+=\" 67332E A84438 CD6851\";
 if(kind==\"water\")s+=\" 304B42 466F59 6B9878 A6C5A3\";
 if(kind==\"enemy\")s=\"282322 29333F 3D5261 6A7E88 302C2A 494039 706258 929187 B9BAAD DDDCD0 D9CC73\";
 if(kind==\"imp\")s=\"29333F 3D5261 6A7E88 91ADBE C1D8E5 D9CC73\";
 if(kind==\"egg\")s=\"CECECE DADADA E6E6E6 F2F2F2 FFFFFF\";
 if(kind==\"grass\")s=\"282322 302C2A 3A3733 4D4942 304B42\";
 var list=new List<Color>();foreach(string h in s.Split(' '))list.Add(C(h));return list.ToArray();
 }
 public static Color Match(Color c,Color[] p){Color best=p[0];double bd=1e20;foreach(var q in p){double d=(c.R-q.R)*(c.R-q.R)+(c.G-q.G)*(c.G-q.G)+(c.B-q.B)*(c.B-q.B);if(d<bd){bd=d;best=q;}}return best;}
 public static void Make(string src,string dst,int w,int h,int mw,int mh,string kind){
 using(var b=new Bitmap(src))using(var o=new Bitmap(w,h,PixelFormat.Format32bppArgb)){
 int x0=b.Width,y0=b.Height,x1=-1,y1=-1;
 for(int y=0;y<b.Height;y++)for(int x=0;x<b.Width;x++){if(b.GetPixel(x,y).A>=128){x0=Math.Min(x0,x);x1=Math.Max(x1,x);y0=Math.Min(y0,y);y1=Math.Max(y1,y);}}
 if(x1<0)throw new Exception(\"Empty source\");
 bool tile=kind==\"grass\";
 if(tile){x0=0;y0=0;x1=b.Width-1;y1=b.Height-1;}
 double scale=Math.Min((double)mw/(x1-x0+1),(double)mh/(y1-y0+1));
 int dw=Math.Max(1,(int)Math.Round((x1-x0+1)*scale)),dh=Math.Max(1,(int)Math.Round((y1-y0+1)*scale));
 int ox=(w-dw)/2,oy=tile?0:h-4-dh;
 var palette=Palette(kind);
 for(int y=0;y<dh;y++)for(int x=0;x<dw;x++){
 int sx=x0+Math.Min(x1-x0,(int)((x+0.5)*(x1-x0+1)/dw)),sy=y0+Math.Min(y1-y0,(int)((y+0.5)*(y1-y0+1)/dh));
 Color c=b.GetPixel(sx,sy);
 if(c.A>=128||tile)o.SetPixel(ox+x,oy+y,Match(c,palette));
 }
 if(tile){for(int i=0;i<w;i++){o.SetPixel(i,0,palette[0]);o.SetPixel(i,h-1,palette[0]);o.SetPixel(0,i,palette[0]);o.SetPixel(w-1,i,palette[0]);}}
 else{
 using(var copy=(Bitmap)o.Clone())for(int y=0;y<h;y++)for(int x=0;x<w;x++)if(copy.GetPixel(x,y).A>0){
 bool edge=x==0||y==0||x==w-1||y==h-1||copy.GetPixel(Math.Max(0,x-1),y).A==0||copy.GetPixel(Math.Min(w-1,x+1),y).A==0||copy.GetPixel(x,Math.Max(0,y-1)).A==0||copy.GetPixel(x,Math.Min(h-1,y+1)).A==0;
 if(edge)o.SetPixel(x,y,palette[0]);
 }
 }
 System.IO.Directory.CreateDirectory(System.IO.Path.GetDirectoryName(dst));
 o.Save(dst,ImageFormat.Png);
 }
 }
}
'@
"'$rows = @'"'
salamander|nest/creature_spear_fire.png|32|32|26|24|fire|C:\\Users\\pc\\.codex\\generated_images\\01a21bc7-8db6-71f2-ae4d-11b30cdf36e1\\exec-2e3c794e-8966-4747-8875-95995f1233c7.png
otter|nest/creature_spear_water.png|32|32|26|24|water|C:\\Users\\pc\\.codex\\generated_images\\01a21bc7-8db6-71f2-ae4d-11b30cdf36e1\\exec-55de01b7-e084-4322-b11e-4bb48837e339.png
hedgehog|nest/creature_spear_earth.png|32|32|26|24|earth|C:\\Users\\pc\\.codex\\generated_images\\01a21bc7-8db6-71f2-ae4d-11b30cdf36e1\\exec-9dfe4b80-ef13-4a90-8da0-038bcd758afb.png
bat|nest/creature_archer_fire.png|32|32|26|24|fire|C:\\Users\\pc\\.codex\\generated_images\\01a21bc7-8db6-71f2-ae4d-11b30cdf36e1\\exec-f3738ebf-1b9a-40eb-9998-7b91d4b5ba9d.png
jellyfish|nest/creature_archer_water.png|32|32|26|24|water|C:\\Users\\pc\\.codex\\generated_images\\01a21bc7-8db6-71f2-ae4d-11b30cdf36e1\\exec-2a416cdb-6a8d-4336-86cf-42a2ab2aec20.png
monkey|nest/creature_archer_earth.png|32|32|26|24|earth|C:\\Users\\pc\\.codex\\generated_images\\01a21bc7-8db6-71f2-ae4d-11b30cdf36e1\\exec-bf6dd076-2002-4b41-9e82-cb864ce2dc15.png
toad|nest/creature_shield_fire.png|32|32|26|24|fire|C:\\Users\\pc\\.codex\\generated_images\\01a21bc7-8db6-71f2-ae4d-11b30cdf36e1\\exec-5df3a733-985c-4b04-8d49-5621a7b6b10e.png
shellturtle|nest/creature_shield_water.png|32|32|26|24|water|C:\\Users\\pc\\.codex\\generated_images\\01a21bc7-8db6-71f2-ae4d-11b30cdf36e1\\exec-0b22ae28-0f49-42b7-95bc-c0fa3b8b0cd1.png
rockturtle|nest/creature_shield_earth.png|32|32|26|24|earth|C:\\Users\\pc\\.codex\\generated_images\\01a21bc7-8db6-71f2-ae4d-11b30cdf36e1\\exec-4e0f868a-b640-47d6-adc4-ec06917bc0bd.png
eggspear|nest/egg_spear.png|32|40|24|30|egg|C:\\Users\\pc\\.codex\\generated_images\\01a21bc7-8db6-71f2-ae4d-11b30cdf36e1\\exec-6e615b82-7f6d-419e-88d0-103a843e2bb6.png
eggarcher|nest/egg_archer.png|32|40|18|30|egg|C:\\Users\\pc\\.codex\\generated_images\\01a21bc7-8db6-71f2-ae4d-11b30cdf36e1\\exec-0a2258a2-09b1-4d84-aa76-64a946f0f018.png
eggshield|nest/egg_shield.png|32|40|27|26|egg|C:\\Users\\pc\\.codex\\generated_images\\01a21bc7-8db6-71f2-ae4d-11b30cdf36e1\\exec-a88f415b-6fe8-413c-8b87-25e79ef5dad5.png
goblin|enemy/goblin.png|32|32|26|25|enemy|C:\\Users\\pc\\.codex\\generated_images\\01a21bc7-8db6-71f2-ae4d-11b30cdf36e1\\exec-276f8f03-7b1a-4108-9029-41397576481f.png
imp|enemy/imp.png|32|32|23|25|imp|C:\\Users\\pc\\.codex\\generated_images\\01a21bc7-8db6-71f2-ae4d-11b30cdf36e1\\exec-1b1adda8-d854-4bfa-a404-c4b18765499d.png
brute|enemy/brute.png|48|48|40|40|enemy|C:\\Users\\pc\\.codex\\generated_images\\01a21bc7-8db6-71f2-ae4d-11b30cdf36e1\\exec-50cf57d0-7d41-4108-9ace-61c2935b9221.png
grassa|field/grass_a.png|32|32|32|32|grass|C:\\Users\\pc\\.codex\\generated_images\\01a21bc7-8db6-71f2-ae4d-11b30cdf36e1\\exec-1489156f-69b2-43b7-bdd7-4854ae5151b1.png
grassb|field/grass_b.png|32|32|32|32|grass|C:\\Users\\pc\\.codex\\generated_images\\01a21bc7-8db6-71f2-ae4d-11b30cdf36e1\\exec-7f4fc3fb-34d4-4461-8604-bbb60e4415b5.png
house|field/house.png|32|32|28|25|house|C:\\Users\\pc\\.codex\\generated_images\\01a21bc7-8db6-71f2-ae4d-11b30cdf36e1\\exec-d421a083-82f0-41a4-b535-4deb28126573.png
housebroken|field/house_broken.png|32|32|28|25|house|C:\\Users\\pc\\.codex\\generated_images\\01a21bc7-8db6-71f2-ae4d-11b30cdf36e1\\exec-733c665c-d51d-4c1e-a60f-a0c8bade7b27.png
'@
foreach("'$line in $rows.Trim().Split([char]10)) { $a=$line.Trim().Split('"'|'); "'$dest=Join-Path (Get-Location) ('"'assets/sprites/'+"'$a[1]); if(Test-Path -LiteralPath $dest){throw "Target already exists: $dest"}; [SpriteClean]::Make($a[7],$dest,[int]$a[2],[int]$a[3],[int]$a[4],[int]$a[5],$a[6]); Write-Output $a[1] }' in C:\Users\pc\Documents\game
 succeeded in 6834ms:
nest/creature_spear_fire.png
nest/creature_spear_water.png
nest/creature_spear_earth.png
nest/creature_archer_fire.png
nest/creature_archer_water.png
nest/creature_archer_earth.png
nest/creature_shield_fire.png
nest/creature_shield_water.png
nest/creature_shield_earth.png
nest/egg_spear.png
nest/egg_archer.png
nest/egg_shield.png
enemy/goblin.png
enemy/imp.png
enemy/brute.png
field/grass_a.png
field/grass_b.png
field/house.png
field/house_broken.png

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Add-Type -AssemblyName System.Drawing
$files=@'"'
nest/creature_spear_fire.png
nest/creature_spear_water.png
nest/creature_spear_earth.png
nest/creature_archer_fire.png
nest/creature_archer_water.png
nest/creature_archer_earth.png
nest/creature_shield_fire.png
nest/creature_shield_water.png
nest/creature_shield_earth.png
nest/egg_spear.png
nest/egg_archer.png
nest/egg_shield.png
enemy/goblin.png
enemy/imp.png
enemy/brute.png
field/grass_a.png
field/grass_b.png
field/house.png
field/house_broken.png
'@
"'$sheet=[System.Drawing.Bitmap]::new(960,760)
$g=[System.Drawing.Graphics]::FromImage($sheet)
$g.Clear([System.Drawing.Color]::FromArgb(58,56,53))
$font=[System.Drawing.Font]::new('"'Consolas',9)
"'$i=0
foreach($f in $files.Trim().Split([char]10)){
$b=[System.Drawing.Bitmap]::new((Join-Path (Get-Location) ('"'assets/sprites/'+"'$f.Trim())))
$cx=($i%5)*192;$cy=[int][Math]::Floor($i/5)*190;$s=4;if($b.Width -gt 32){$s=3}
$ox=$cx+[int]((192-$b.Width*$s)/2);$oy=$cy+10
for($y=0;$y -lt $b.Height;$y++){for($x=0;$x -lt $b.Width;$x++){$p=$b.GetPixel($x,$y);if($p.A -gt 0){$brush=[System.Drawing.SolidBrush]::new($p);$g.FillRectangle($brush,($ox+$x*$s),($oy+$y*$s),$s,$s);$brush.Dispose()}}}
$label=[System.IO.Path]::GetFileNameWithoutExtension($f.Trim()).Replace('"'creature_','')
"'$g.DrawString($label,$font,[System.Drawing.Brushes]::White,($cx+10),($cy+172));$b.Dispose();$i++
}
$g.Dispose();$font.Dispose();$ms=[System.IO.MemoryStream]::new();$sheet.Save($ms,[System.Drawing.Imaging.ImageFormat]::Png);[Convert]::ToBase64String($ms.ToArray());$ms.Dispose();$sheet.Dispose()' in C:\Users\pc\Documents\game
 succeeded in 1684ms:
iVBORw0KGgoAAAANSUhEUgAAA8AAAAL4CAYAAAC0iJ7vAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAJhNSURBVHhe7f2/q61Lmth59t8iOZqiaAqKQa2GZoRoBGXImLYkkFOqhBqmDQnaaWvMUrqS1X5Dk5mgP0AyBsboyjJmhMxpIVmZU213/QNnOPfefe5an73Wfnacd/1+vxs+oNrxRLzxRjwrVjznnLz6L/7r/+r//CVJkiRJklf3X/iLJEmSJEleUQVwkiRJkmQXKoCTJEmSJLtQAZwkSZIk2YUK4CRJkiTJLlQAJ0mSJEl2oQI4SZIkSbILFcBJkiRJkl2oAE6SJEmS7EIFcJIkSZJkFyqAkyRJkiS7UAGcJEmSJNmFCuAkSZIkyS5UACdJkiRJdqECOEmSJEmyCxXASZIkSZJdqABOkiRJkuxCBXCSJEmSZBcqgJMkSZIku1ABnCRJkiTZhQrgJEmSJMkuVAAnSZIkSXahAjhJkiRJsgsVwEmSJEmSXagATpIkSZLsQgVwkiRJkvzk7/ztv/Uh4/NcKoCTJEmS5CcWvDI+z6UCOEmSJEl+YsEr4/NcKoCTJEmS5CcWvDI+z6UCOEmSK/DCJOOTJI/B8/p/+V//5yO2y/HyWCqAkyS5Ai9EMj5J8hg8ryuAX0sFcJIkV+CFSMYnSR6D53UF8GupAE6S5Aq8EMn4JMlj8LyuAH4tFcBJklyBF6J//a/+5RHb7Z8kuQ/PZwvgif1XOZ9cVgVwkiRX4IWmAjhJnoPnswXuxP6rnE8uqwI4SZIr8EJTAZwkz8Hz2QJ3Yv9VzieXVQGcJMkVeKGpAE6S5+D5bIE7sf8q55PLqgBOkuQKvNBYAMt4x5ts7Z8kOc3z1YL30nzeKuefYxXASZJcgRcSC14Z73iTrf2TJKd5vlqwXprPW+X8c6wCOEmSK/BCYsEr4x1vsrV/kuQ0z1cL1kvzeaucf45VACdJcgVeSCx4ZbzjTbb2T5Kc5vlqwXppPm+V88+xCuAkyS54QZjYf9W78f7uHx+xANa7/iee8dHzZHyS5HM8Ty1Y9Tf/x//+IeMvzfn6PntXAZwk2QUvBBP7r3o3XgVwkjwlz1MLTlnwyvhLc76+z95VACdJdsELwcT+q96NVwGcJE/J89SCUxa8Mv7SnK/vs3cVwEmSXfBCMLH/qnfjVQAnyVPyPLXglAWvjL805+v77F0F8IMpYfPKzG8Zn1zSu3wbClLjJ6vP+6M//IMPTfOZnifjkySneX5aYFrQTux/a76P77s3FcAPpgTNKzO/ZXxySe/yrQI4SXKC56cFpQXuxP635vv4vntTAfxgStC8MvNbxieX9C7fKoCTJCd4flpQWuBO7H9rvo/vuzcVwA+mBM0rM79lfHJJ7/KtAjhJcoLnpwWlBe7E/rfm+/i+e1MBfGcmpIxPnpn53QGde3qXbxSoqxxPxk8sgG2fxn/XfmINks8yn2T8rT3afPJczB/vJxa0E/s/Gt/X9Xh1FcB3ZgLK+OSZmd8dyLmnd/l2oghd4XgyflIBnEdiPsn4W3u0+eS5mD/eTyxwJ/Z/NL6v6/HqKoDvzASU8ckzM787kHNP7/LtRBG6wvFk/KQCOI/EfJLxt/Zo88lzMX+8n1jgTuz/aHxf1+PVVQDfmQko45NnZn53IOee3uXbiSJ0hePJ+EkFcB6J+STjb+3R5pPnYv54P7HAndj/0fi+rserqwC+MxPwV//tf3XEdjle8sjMXw9kGe94Wo3Pvr3LlxNF6BbXHn/y57/4p0fezefEmiTnmD9/8vf/3hHb7X9pPu9f/LN/fMR2+2ffzA/vH6/uv/+f/scjrofr9WoqgO/MhKsAziszfz2QZbzjaTU++/YuX04UkVtce/xJBXAuyfypAM4zMz+8f7y6CuATv8ztmHAVwHll5q8Hsox3PK3GZ9/e5cuJInKLa48/qQDOJZk/FcB5ZuaH949XVwF84pe5HROuAjivzPz1QJbxjqfV+Ozbu3w5UURuce3xJxXAuSTzpwI4z8z88P7x6iqAT/zymbmBWzn+pfm8/8//7f+6xP6OnzwS8/Uf/vN/csQDWvZ3fBkv47Nv7/LjRFF5yHj/o1UyfhpPxq96N96JNUjOMX+8j0wFsRx/leNVAGeF+eF9Q8/2H7la5Xq4Xq+mAnjg+Jfm8/xCmdjf8ZNHYr5WAOeRvMuPE0XkRwWlBa+Mn8aT8avejXdiDZJzzB/vIxXAeSbmh/cNVQC/lgrggeNfms/zC2Vif8dPHon5WgGcR/IuP04UkR8VlBa8Mn4aT8avejfeiTVIzjF/vI9UAOeZmB/eN1QB/FoqgAeOf2k+zy+Uif0dP3kk5msFcB7Ju/w4UUR+VFBa8Mr4aTwZv+rdeCfWIDnH/PE+UgGcZ2J+eN9QBfBrefoC2A3zQJ7Yf+LzL83nOV//I1m229/xk1syHz1wtbUglgWIjHf+2RfzQRaUq8w/+bzJP/qTf3DEdp9v+8T1yb6ZH94/NBXEjj+xvwXvpZ+X12I+eJ/YO9fH9Xs1FcD0n/j8S/N5zrcCOM/EfPTAVQVw7sl8kAXlKvNPPm9SAZxbMj+8f+jSBan9K4CzwnzwPrF3ro/r92oqgOk/8fmX5vOcbwVwnon56IGrCuDck/kgC8pV5p983qQCOLdkfnj/0KULUvtXAGeF+eB9Yu9cH9fv1VQA03/i8y/N5znfCuA8E/PRA1cVwLkn80EWlKvMP/m8SQVwbsn88P6hSxek9q8AzgrzwfvE3rk+rt+reboC2A3ywNV4QTjxjI+eZ7u2xjt/C96J402cT3LIfFnlATuxILg15z9xvfJY3K/Jn//inx6xgJT9ZfxWjv9Hf/gHR6bvO03xrmf2zfzwvjKxYHW8VY7n84z3fbIv5oP3j//+f/ofj9j+aLy/yHj5/eH7u16u57OrAD7xjI+eZ7u2xjt/C9yJ402cT3LIfFnlgTvxAL815z9xvfJY3K9JBTDzP7Gm2S/zw/vKxILV8VY5ns8z3vfJvpgP3j8sAG1/NN5fZLz8/vD9XS/X89lVAJ94xkfPs11b452/Be7E8SbOJzlkvqzywJ14gN+a85+4Xnks7tekApj5n1jT7Jf54X1lYsHqeKscz+cZ7/tkX8wH7x8WgLY/Gu8vMl5+f/j+rpfr+ewqgE8846Pn2a6t8c7fAnfieBPnkxwyX1Z54E48wG/N+U9crzwW92tSAcz8T6xp9sv88L4ysWB1vFWO5/OM932yL+aD9w8LQNsfjfcXGS+/P3x/18v1fHZPXwD7BS7jHU/Ga4pfPYBtt6CV8b7vv/13/+aI7XI8Od/sm/nhgbr1P2LlAf6f/9N/OGL+Gn9tztf1yW25H7KglQXmxPEn9pcXEPNN0/iO5+fFeNvfjX9izbNf5of3Hf8jVFO7Baz5PpnmY7vvk9fm/nv/kAWgjL83z3s/X8bL/r6v6+f6PrsK4GF8TfGrB7DtFrwy3vetAM41mR8eqBXAuSX3Qxa8siCcOP7E/vICYr5pGt/x/LwYb/u78U+sefbL/PC+4wV8aq8AzjW5/94/ZAEo4+/N897Pl/Gyv+/r+rm+z64CeBhfU/zqAWy7Ba+M930rgHNN5ocHagVwbsn9kAWvLAgnjj+xv7yAmG+axnc8Py/G2/5u/BNrnv0yP7zveAGf2iuAc03uv/cPWQDK+HvzvPfzZbzs7/u6fq7vs6sAHsbXFL96ANtuwSvjfd8K4FyT+eGBWgGcW3I/ZMErC8KJ40/sLy8g5pum8R3Pz4vxtr8b/8SaZ7/MD+87XsCn9grgXJP77/1DFoAy/t487/18GS/7+76un+v77F6uALbd/pfm8zyAZbxWC95r8/m+f/bFfPBA3coLjvlo+635/q5Prsv1lwXeKsfbyvFlvPk2cbxVPt/1znNzfyf2l/Heb/78j//LI8Z7QbcA3srnyffJa3P/vW9Y8K1yvFuzgJXxMt73c/1c32dXAbyRz/MLQcarAjiPzHzwQN3KC775aPut+f6uT67L9ZcF3irH28rxZbz5NnG8VT7f9c5zc38n9pfx3m8qgPNI3H/vGxZ8qxzv1ixgZbyM9/1cP9f32VUAb+Tz/EKQ8aoAziMzHzxQt/KCbz7afmu+v+uT63L9ZYG3yvG2cnwZb75NHG+Vz3e989zc34n9Zbz3mwrgPBL33/uGBd8qx7s1C1gZL+N9P9fP9X12FcAb+Ty/EGS8KoDzyMwHD9StvOCbj7bfmu/v+uS6XH9Z4K1yvK0cX8abbxPHW+XzXe88N/d3Yn8Z7/2mAjiPxP33vmHBt8rxbs0CVsbLeN/P9XN9n10F8DC+jJfxFrR+YUx8v62cn+0T+/v+eW3uvwfqxP7ygr/V3/wf//uRrc+zv+uT+3J/ru3S/1Gt1QLB/o4v4+V65rG5fzKfNObT8DzvK7Y7/sT+Ml7GO//si/ngfcSC79acz725Xq7nq6kAHsaX8TK+AjivxP33AJ3YXxacW1UA74v7c20VwLkn90/mk8Z8Gp7nfcV2x5/YX8bLeOeffTEfvI9YkN6a87k318v1fDUVwMP4Ml7GVwDnlbj/HqAT+8uCc6sK4H1xf66tAjj35P7JfNKYT8PzvK/Y7vgT+8t4Ge/8sy/mg/cRC9Jbcz735nq5nq+mAngYX8bL+ArgvBL33wN0Yn9ZcG5VAbwv7s+1VQDnntw/mU8a82l4nvcV2x1/Yn8ZL+Odf/bFfPA+YkF6a87n3lwv1/PVPH0BPB3A9l/leDJexlsQTyxAt3J85yf7y3jfP8/N/fXAnPzDf/5PjthugbnqP/+n/3DEducv4yf2d73y2Nw/WdCusuCc+PypQPE/WuJ4U7v5LOfj+uW+3u0P++v3+8R807vnDfOR+Tuxv3+AabzsvzrfVY6fx+b+eR9ZLVCNn0z9bb8118f1ezUVwAPHk/Ey3i+giQXnVo7v/GR/Ge/757m5vx6YkwrgPBL3Txa0qyxIJj7fAsQL/lTgTu3ms5yP65f7erc/7K/f7xPzTe+eN8xH5u/E/hXAuST3z/vIakFq/GTqb/utuT6u36upAB44noyX8X4BTSw4t3J85yf7y3jfP8/N/fXAnFQA55G4f7KgXWVBMvH5FiBe8KcCd2o3n+V8XL/c17v9YX/9fp+Yb3r3vGE+Mn8n9q8AziW5f95HVgtS4ydTf9tvzfVx/V5NBfDA8WS8jPcLaGLBuZXjOz/ZX8b7/nlu7q8H5qQCOI/E/ZMF7SoLkonPtwDxgj8VuFO7+Szn4/rlvt7tD/vr9/vEfNO75w3zkfk7sX8FcC7J/fM+slqQGj+Z+tt+a66P6/dqnr4AtiCT8ZrG9wtjKrhlf9udr1bjJ9N8ZH8Z73rmubm/mg5QL9irLHDl82S8BYLtcjy5Xnks7/brRBF6aDV+4ngT8998tf3SnI/rmcfifvn9PrHgtd3xp+c7ngXq5N/+u39zxPGN39rufH1/2d/xXZ88NvfP+8x0/ho/8fvBdk0Fsp+X1fF9f9fn1VUAD+N7AFYAHzPe9cxzc381Hah+YayyIJXPk/F+odkux5Prlcfybr9OFKkfFay2r3K8iflvvtp+ac7H9cxjcb/8fp9MBaDjT893PAvGiRd6xzd+a7vz9f1lf8d3ffLY3D/vM9P5a/zE7wfbVQF8XRXAw/gegBXAx4x3PfPc3F9NB6pfGKssSOXzZLxfaLbL8eR65bG8268TRepHBavtqxxvYv6br7ZfmvNxPfNY3C+/3ydTAej40/Mdz4Jx4oXe8Y3f2u58fX/Z3/Fdnzw298/7zHT+Gj/x+8F2VQBfVwXwML4HYAXwMeNdzzw391fTgeoXxioLUvk8Ge8Xmu1yPLleeSzv9utEkfpRwWr7KsebmP/mq+2X5nxczzwW98vv98lUADr+9HzHs2CceKF3fOO3tjtf31/2d3zXJ4/N/fM+M52/xk/8frBdFcDX9XQFsNxACzQPONvt74Fnu6aC2OfJA9X2iR9IGb/K95H7kX0xH8y/VY5nQarV+MnqeMa7Prmtd/txoij9iP1XOZ5W46cL2MTneWEyXvZ3vfNY3C/vM96HbJfxjj893/uNvD/JeE3xzsfPl+/n+8vx5Hrkubifnpcynyb2l/Ge/7bbX8b7fr7/3lQA03/1wPMAtt3nyQPb9okXFhm/yveR+5F9MR/Mv1WOZ8Gp1fjJ6njGuz65rXf7ceIS8hH7r3I8rcZ7AfLzMvF5XpCMl/1d7zwW98v7jPch22W840/P934j708yXlO88/Hz5fv5/nI8uR55Lu6n56XMp4n9Zbznv+32l/G+n++/NxXA9F898DyAbfd58sC2feKFRcav8n3kfmRfzAfzb5XjWXBqNX6yOp7xrk9u691+nLiEfMT+qxxPq/FegPy8THyeFyTjZX/XO4/F/fI+433Idhnv+NPzvd/I+5OM1xTvfPx8+X6+vxxPrkeei/vpeSnzaWJ/Ge/5b7v9Zbzv5/vvTQUw/VcPPA9g232ePLBtn3hhkfGrfB+5H9kX88H8W+V4FpxajZ+sjme865PbercfJy4hH7H/KsfTarwXID8vE5/nBcl42d/1zmNxv7zPeB+yXcY7/vR87zfy/iTjNcU7Hz9fvp/vL8eT65Hn4n56Xsp8mthfxnv+225/Ge/7+f578/IFsAek7atWx/NAlgew/ScmuLzQrHJ95X7kulx/Gb+V48t80fQfXTB+Yn8L0lV+Hh1/4nrltt7tx4kz8KMLwKVNF5aJ45n/qxxPxk/sL/cnt+V+WMCt8n4y5avnqfkj47ea5uP7TRzP9c59uT+rpvHMVxlvAXpr0/x8372rAF60Op4HsPyCsf/ELyT5gVjl+sr9yHW5/jJ+K8eX+aIK4FzTu/04cQZ+dGG/tArg93uU23E/LOhWeT+Z8tXz1PyR8VtN8/H9Jo7neue+3J9V03jmq4y3IL21aX6+795VAC9aHc8DWH7B2H/iF5L8QKxyfeV+5Lpcfxm/lePLfFEFcK7p3X6cOAM/urBfWgXw+z3K7bgfFnSrvJ9M+ep5av7I+K2m+fh+E8dzvXNf7s+qaTzzVcZbkN7aND/fd+8qgBetjucBLL9g7D/xC0l+IFa5vnI/cl2uv4zfyvFlvqgCONf0bj9OnIEfXdgvrQL4/R7ldtwPC7pV3k+mfPU8NX9k/FbTfHy/ieO53rkv92fVNJ75KuMtSG9tmp/vu3cvVwB74FkwWsD++R//l0dsl+N5YNquaX5T+8QPgFyvieudx+J+XZr5M7G/BbCMdzwLVg98OZ78fPk8413v3Jf7c2mepzLegmCy2n+KN39lfxk/sb/cr9yW+7HK+8wqxzN/Jp7PMt4CfeJ8Zbzv43rnvtyf6T4w9Te/ZPzqeLb7B6bG225/4213fjlWAVwB/CHXO4/F/bo082difwteGe94FcA55P5cmuepjLcgnaz2n+LNX9lfxk/sL/crt+V+rPI+s8rxzJ+J57OMt2CdOF8Z7/u43rkv92e6D0z9zS8Zvzqe7Ra4xttuf+Ntd345VgFcAfwh1zuPxf26NPNnYn8LXhnveBXAOeT+XJrnqYy3IJ2s9p/izV/ZX8ZP7C/3K7flfqzyPrPK8cyfieezjLdgnThfGe/7uN65L/dnug9M/c0vGb86nu0WuMbbbn/jbXd+OVYBXAH8Idc7j8X9ujTzZ2J/C14Z73gVwDnk/lya56mMtyCdrPaf4s1f2V/GT+wv9yu35X6s8j6zyvHMn4nns4y3YJ04Xxnv+7jeuS/3Z7oPTP3NLxm/Op7tFrjG225/4213fjn29AWwTAATxAvNKgtiD1Djr833k+vheuW5ub9//ot/uonjmU8T+1vw6h/+839yxIJXji/nM7G/65vn9m5/KSA9T42X/W2frPY3Xy/N501c3zyWrftlf+83Mt4C8tLfL3I+E58/cX3yWNwv82MqiG23v/HT8x3P9mv3l/E5VgG8qAI4j8T99cKxyvHMp4n9LXhVAZxrere/FcBHfN7E9c1j2bpf9vd+I+MrgHNL7pf5MRWUttvf+On5jmf7tfvL+ByrAF5UAZxH4v564VjleObTxP4WvKoAzjW9298K4CM+b+L65rFs3S/7e7+R8RXAuSX3y/yYCkrb7W/89HzHs/3a/WV8jlUAL6oAziNxf71wrHI882lifwteVQDnmt7tbwXwEZ83cX3zWLbul/2938j4CuDckvtlfkwFpe32N356vuPZfu3+Mj7HXq4Algkh/yMLXoiuzfnYLj+gcjzXI6/N/fdANd9lPm01Fby2O3/5vjJ+mo/s7/h5Lu/2c7EA9fMxtcv4if1Xme+2+zzXKzlkvsiC1/uKLIhtN39t9/maCl7fL6/F/V7l94P3J+Ntl/HTfLf2l/E5VgHMBcED99qcj+3yC0KO53rktbn/Hqjmu8ynrSwwK4BzS+/2swL4iOuVHDJfVAGcR+J+r/L7wfuT8bbL+Gm+W/vL+ByrAOaC4IF7bc7HdvkFIcdzPfLa3H8PVPNd5tNWFpgVwLmld/tZAXzE9UoOmS+qAM4jcb9X+f3g/cl422X8NN+t/WV8jlUAc0HwwL0252O7/IKQ47keeW3uvweq+S7zaSsLzArg3NK7/awAPuJ6JYfMF1UA55G436v8fvD+ZLztMn6a79b+Mj7HXr4AnpgwHrgyXh7gtsvxZbz8wE79ff+8NvdfHrjmr+yv6T9aZcHphch432eV460W4I6X5+J+aoq3gNQf/eEfHLF9dbzJ9Dz5fN832cL8siC23fuK5//W+8tqfHLI/PF+JOPleW37NN7q/Gy3f45VAJMwHsAyXqsFg+PLePmFMvX3/fPa3H95gJq/sr8qgPNI3E9N8RaU8oJj++p4k+l58vm+b7KF+VUBnGdm/ng/kvHyvLZ9Gm91frbbP8cqgEkYD2AZr9WCwfFlvPxCmfr7/nlt7r88QM1f2V8VwHkk7qemeAtKecGxfXW8yfQ8+XzfN9nC/KoAzjMzf7wfyXh5Xts+jbc6P9vtn2MVwCSMB7CM12rB4PgyXn6hTP19/7w2918eoOav7K8K4DwS91NTvAWlvODYvjreZHqefL7vm2xhflUA55mZP96PZLw8r22fxludn+32z7EKYBJm9QC2XVO8z5Px1x4v+2I+TOwv4ydegGS8z5vY3/FlvOPltbn/FpQyfpUFg+PL/rbLeN832cL80hRv/ttu/+SWzEcZL+NXC1bbV/vnYxXAJNBqwWi7pnifJ+OvPV72xXyY2F/GTyxAZbzPm9jf8WW84+W1uf8WlDJ+lQWA48v+tst43zfZwvzSFG/+227/5JbMRxkv41cLWNtX++djFcAk0GrBaLumeJ8n4689XvbFfJjYX8ZPLEBlvM+b2N/xZbzj5bW5/xaUMn6VBYDjy/62y3jfN9nC/NIUb/7bbv/klsxHGS/jVwtY21f752MVwCTQasFou6Z4nyfjrz1e9sV8mNhfxk8sQGW8z5vY3/FlvOPltbn/FpQyfpUFgOPL/rbLeN832cL80hRv/ttu/+SWzEcZL+NXC1jbV/vnY7srgE2Yif1l/OTS/WX8xP7ZF/NhleOtcryJ/Vc53irHy2txv1c53sT+k0v3T27JfJTxyTMzv2X8ZGv/HKsAHthfxk8u3V/GT+yffTEfVjneKseb2H+V461yvLwW93uV403sP7l0/+SWzEcZnzwz81vGT7b2z7EK4IH9Zfzk0v1l/MT+2RfzYZXjrXK8if1XOd4qx8trcb9XOd7E/pNL909uyXyU8ckzM79l/GRr/xyrAB7YX8ZPLt1fxk/sn30xH1Y53irHm9h/leOtcry8Fvd7leNN7D+5dP/klsxHGZ88M/Nbxk+29s+x3RXASZIkSZJ9qgBOkiRJkuxCBXCSJEmSZBcqgJMkSZIku1ABnCRJkiTZhQrgJEmSJMkuVAAnSZIkSXahAjhJkiRJsgsVwEmSJEmSXagATpIkSZLsQgVwkiRJkmQXKoCTJEmSJLtQAZwkSZIk2YUK4CRJkiTJLlQAJ0mSJEl2oQI4SZIkSbILFcBJkiRJkl2oAE6SJEmS7EIFcJIkSZJkFyqAkyRJkiS7UAGcJEmSJNmFCuAkSZIkyS5UACdJkiRJdqECOEmSJEmyCxXASZIkSZJdqABOkiRJkuxCBXCSJEmSZBcqgJMkSZIku1ABnCRJkiTZhQrgJEmSJMkuVAAnSZIkSXahAjhJkiRJsgsVwEmSJEmSXagATpIkSZLsQgVwkiRJkmQXKoCTJEmSJLtQAZwkSZIk2YUK4CRJkiTJLlQAJ0mSJEl2oQI4SZIkSbILFcBJkiRJkl2oAE6SJEmS7EIFcJIkSZJkFyqAkyRJkiS7UAGcJEmSJNmFCuAkSZIkyS5UACdJkiRJdqECOEmSJEmyCxXASZIkSZJdqABOkiRJkuxCBXCSJEmSZBcqgJMkSZIku7DTAvhPv/zm91++/P7Xf3qiLUmSZG/+4stfffny5a9+6e+T5LW8dgH8Z7/68vsvbz9/+eWX39oqgJNTfvnbLj/Je1+/M3735Td/5u+/FgyH3y3Jmnucub/49e++3Yy+/PYvDtoqgHNb98j/defO/zyzly6An+ODlTyOPjPJKecuQBXA2eb2Z245m8dx+/z/HufO/zyz7yuAf/mXP//p4ZeDpPj6N66//dUPf7v648/xIXv2Tx2Pxjv+MPzw4fj1wd/kHv1p5UfOJOzBs/wb4K/z+/2vf/XDn4D+GPCrL7/41v7jn4z++HNi3OzHQ+f/qbw/+N3Rv4o4+Awwhx9/Dud/Lv9/GvvX5z9XeTEPnf8nxjw8x8/l/wfn/9G8aXsrJn7zLcbPXl7N15z8+ccz8jAXuNgf5d7PeWKOH5+fVzh3v87j6G7zo8M8tyBxjkefw7P/0i6v6Gnz/1TeH/7uzPfQx+e/77WwHrm77yiAT12wf/JTIhwlzttB+TW5Dg7Nr0l/OmGP/3Tyhw/bt2T74NkHjj+gP/74rB8vO+9/d5jAP//JFM/94T076Pfpgxx8mPz/KebbM8/9if/78U7/aexH+f+17fBCdO5ZeQ3vc+abB8l/LzpH8zhyPN758/997M9+uqD9NP75Z+UlHeX1j7nwLa+P8vBr26n8ebuv/JR3787WS567h8XE28/7OZ36Djj/OeS5X9fDIiOv69ny/6f5fMtxvpeOYo/G++j8P5f/H61HHsF3FMA/F5geku82+OD//rAoPfoTlK8/5y4hK84l7I/OFcD+7gfv5nc8x+zLo+f/W5+vhfDXv5H7xcHB//4S9IkC+N38vv6c+ZLKy3v0/D/5J/Zc0n7+OS6AT57/PziX5ycuQCcvVHkV7/LrM5fwD/LiOMcPxnj3ufj6c4Fz188pTn3mTv3uB6f+5dAHY+f5PW/+v4399T70uy9/9fWs/+Vffup76OzzPsz/D9YjD+G7CuA37y5CHqwHfxpy9gD96U9yfr54HCfN+X6TMwn7k1OXnVO/+4HvlTxw/v+Yx3/x5Te//dWXX/76L7/85pdf/2nqj18+P8z52xfR+8/Iyef5Xkfej5F9eOz8P3GOD/n/UT9jf1YBvCs/XJIP8uDd34CdufB+kBcfFgDXOHc/HNf5nP/dDz54r7ygp87/n/r88ldf/urb/eh3Pz374++hs8/74L3ej5FHs6kA/uro0kDCfk3sb21H/zTg0I+J9/YB+Pifoa04k7A/OXXZOfW7n8f63nnklT1k/v9wKH/935789Cecv//5n2W+m9OJvwF+/xn4KP8//pzltT1k/v9wSTt98Xg3p6W/AT41lwrgXTnKrR9z4lMFgIXDgbMFwNmce2s7Pd7ow8LC+Zz/3Y++zvc755Hn8+T5/8Ozvv53Kv7s6//7d19+/238j7+HbP/ZR/n/wXrkIXxHAfx1Uw9/Djb4hyQ/+OEi8DX5fv7hT5F++vnxP0Ky8QL0g9MfkHf/fIP/zdrZC9DwbtmLJ8j/n+bxY78f53tUpLw97If/YBGfkaN3+My7nf6c5VU9Qf6fOOe/jfFB/n94/n91MM+z/8ytAvjl/ZzHP/1HeD5TAHx1mD8H+X++APjoM7Xh3D1TAB9/Pr/+nJsjjt7r1B+g5pU8c/4fFbb+BcAH30O2H/1h7tn8H9Yjd/cdBfAHzhysyS6U/9mz8j9JkjyBJy2A/VuIg5/+9D33Uv5nz8r/5L78G7ODn/5mNi+v/M+CyxbASZIkSZI8qArgJEmSJMkuVAAnSZIkSXahAjhJkiRJsgsVwEmSJEmSXagATpIkSZLsQgVwkiRJkmQXKoCTJEmSJLtQAZwkSZIk2YUK4CRJkiTJLlQAJ0mSJEl2oQI4SZIkSbILFcBJkiRJkl2oAE6SJEmS7EIFcJIkSZJkFyqAkyRJkiS7UAGcJEmSJNmFCuAkSZIkyS5UACdJkiRJdqECOEmSJEmyCxXASZIkSZJdqABOkiRJkuxCBXCSJEmSZBcqgJMkSZIku1ABnCRJkiTZhQrgJEmSJMkuVAAnSZIkSXahAjhJkiRJsgsVwEmSJEmSXagATpIkSZLsQgVwkiRJkmQXKoCTJEmSJLtQAZwkSZIk2YUK4CRJkiTJLlQAJ0mSJEl2oQL4xv7O3/5bmzhekiTJrXk/2crxk+RaKoBvzAN/leMlSZLcmveTrRw/Sa6lAvjGPPBXOV6SJMmteT/ZyvGT5FoqgG/MA3+V4yVJktya95OtHD9JrqUC+M78AvgX/+wff8h4x0uSJLk07x//9t/9m03+0Z/8gyOO7/OTZ/bv//2//5Dxua4K4DvzwLfglfGOlyRJcmnePyxoV1UAZ08seGV8rqsC+M488C14ZbzjJUmSXJr3DwvaVRXA2RMLXhmf66oAvjMPfAteGe94SZIkl+b9w4J2VQVw9sSCV8bnuiqAN/LAXmWBu8rx5HyTJNfh+bvK8ZJHYr5a0MoCd5XPcz7JM7HglfG5rgrgjTygV1nQrnI8Od8kyXV4/q5yvOSRmK8WvLKgXeXznE/yTCx4ZXyuqwJ4Iw/oVRa0qxxPzjdJch2ev6scL3kk5qsFryxoV/k855M8EwteGZ/rqgDeyAN6lQXtKseT802SXIfn7yrHSx6J+WrBKwvaVT7P+STPxIJXxue6dlcAe6BO7D+xvwXrKr8QbJ84H+ebbGF+TeyfPBLzVVP8f/5P/2GJ/afxZXxySeabBe5//Xf/+Ij3lUtzPnL+yT1Z4Ppjuxwvl1UBPLD/xP4WpKv8ArB94nycb7KF+TWxf/JIzFdN8Ra4E/tP48v45JLMtwrg5PMsaP2xXY6Xy6oAHth/Yn8L0lV+Adg+cT7ON9nC/JrYP3kk5qumeAvcif2n8WV8cknmWwVw8nkWtP7YLsfLZVUAD+w/sb8F6Sq/AGyfOB/nm2xhfk3snzwS81VTvAXuxP7T+DI+uSTzrQI4+TwLWn9sl+Plsl6+APaAtED8k7//9z5kf8eX8T5PHvC2r5qeb7vzTz5i/vzqv/2vlth/Gn9i/2SF+WSBqineAkHGaxpfxvt+ySHzZWL+WvBOvN9cmvP1fZNLskCd/PVf//WHjF/l/LKmAvhE0VsBnJxm/ljgTuw/jT+xf7LCfLLA1BRvwSDjNY0v432/5JD5MjF/LXAn3m8uzfn6vsklWYBOLHhl/CrnlzUVwCeK3grg5DTzxwJ3Yv9p/In9kxXmkwWmpngLBhmvaXwZ7/slh8yXiflrgTvxfnNpztf3TS7JAnRiwSvjVzm/rKkAPlH0VgAnp5k/FrgT+0/jT+yfrDCfLDA1xVswyHhN48t43y85ZL5MzF8L3In3m0tzvr5vckkWoBMLXhm/yvllzcsVwB6If/SHf3DEA9qCV443Pc+CcysPfBm/yvn7fskh8+XP//i//JAFsKbxpnjnl3zE/LGgXGWBsMrx/vW/+pdHbJfv4/tm38wP80/Ge1/ayvvLxP5yvhPXJ1lhAfo3f/M3Ryxwp/atnI/zzccqgE8UvRXAyWnmiwWrLGA1jTfFO7/kI+aPBeUqC4hVjlcBnEsyP8w/Ge99aSvvLxP7y/lOXJ9khQXnVOBO7Vs5H+ebj1UAnyh6K4CT08wXC1ZZwGoab4p3fslHzB8LylUWEKscrwI4l2R+mH8y3vvSVt5fJvaX8524PskKC86pwJ3at3I+zjcfqwA+UfRWACenmS8WrLKA1TTeFO/8ko+YPxaUqywgVjleBXAuyfww/2S896WtvL9M7C/nO3F9khUWnFOBO7Vv5Xycbz728gWwvGBY8Fow218e2LLgvDXnI9/H9cxrW91/4y1Yt7Lglc/XNF8Zn9fybr+5QFtQygJBfp/Yfm3O1/eV65PX5v6bP3/+i396xHg/L4/G+XqfG9/vxJplvywoZUG7+mMBu5Xzk++XYxXAFcBHXM+8ttX9N94CdisLXvl8TfOV8Xkt7/abC7QFpCwY5PeJ7dfmfH1fuT55be6/+TMWiCeKzkfifL3Pje93Ys2yXxaQqgB+LRXAFcBHXM+8ttX9N94CdisLXvl8TfOV8Xkt7/abC7QFpCwY5PeJ7dfmfH1fuT55be6/+TMWiCeKzkfifL3Pje93Ys2yXxaQqgB+LRXAFcBHXM+8ttX9N94CdisLXvl8TfOV8Xkt7/abC7QFpCwY5PeJ7dfmfH1fuT55be6/+TMWiCeKzkfifL3Pje93Ys2yXxaQqgB+LS9fAE8XFOM1jW9Bqakgndqd78TxbJfxvp/vn+fm/q4WmBastsvxJ/aX8doa73rlubifFoiavh8m9nd8Tf1tn9jf58n1cf3y3NxfC8CJ/c037yfGW6BO7D+Z5lsBnC0sIC04t/443lb/8T/+xyPO3/fLsQrgE4fsRwek7X4hyAJztd35ThzPdhnv+/n+eW7u71QQqgI4j8z9tADU9P0wsb/ja+pv+8T+Pk+uj+uX5+b+WgBO7G++eT8x3gJ3Yv/JNN8K4GxhAWnBufXH8baqAN6mAvjEIfvRAWm7XwiywFxtd74Tx7Ndxvt+vn+em/s7FYSqAM4jcz8tADV9P0zs7/ia+ts+sb/Pk+vj+uW5ub8WgBP7m2/eT4y3wJ3YfzLNtwI4W1hAWnBu/XG8rSqAt6kAPnHIfnRA2u4XgiwwV9ud78TxbJfxvp/vn+fm/k4FoSqA88jcTwtATd8PE/s7vqb+tk/s7/Pk+rh+eW7urwXgxP7mm/cT4y1wJ/afTPOtAM4WFpAWnFt/HG+rCuBtXq4AlgeeF4bVAtB2+YXh8/wC8fn2nzi+jHe+Pt923z/Pxf20AJwKWuNXOb6M9/nGy/4Tx/fzaLvrmcfiflnwyfNwYn953to+mfo7H89r4yeul+uZ5+b+TgWg+SXPx4njTwWv85Pj2+54siB2PONdz7w2C0YLzEv/OP4qC96J7+f7710F8GIBaLv8AvF5HsA+3/4Tx5fxztfn2+7757m4nxaEFpRT/CrHl/E+33jZf+L4fh5tdz3zWNwvCz55Hk7sL89b2ydTf+fjeW38xPVyPfPc3N+pYDS/5Pk4cfwK4DwyC0QLzkv/OP4qC9yJ7+f7710F8GIBaLv8AvF5HsA+3/4Tx5fxztfn2+7757m4nxaEFpRT/CrHl/E+33jZf+L4fh5tdz3zWNwvCz55Hk7sL89b2ydTf+fjeW38xPVyPfPc3N+pYDS/5Pk4cfwK4DwyC0QLzkv/OP4qC9yJ7+f7710F8GIBaLv8AvF5HsA+3/4Tx5fxztfn2+7757m4nxaEFpRT/CrHl/E+33jZf+L4fh5tdz3zWNwvCz55Hk7sL89b2ydTf+fjeW38xPVyPfPc3N+pYDS/5Pk4cfwK4DwyC0QLzkv/OP4qC9yJ7+f7793uCmAPQC8Uxk/jeYGZDlzjbfcLSD5ff/SHf3DE5xk/8f3zXNxPC0jbLRhXOb6M9/l+Huy/yufJ58n5yfXObbkfFnyenxPPS8fTavxWzneV6+V65rm4n+73Vp6Hq5yf7Ra0Ewtq+bxVrm9emwXipX8sYLeywJ34fnI99qYCuAL4Q75/nov7aYFouwXiKseX8T7fz4P9V/k8+Tw5P7neuS33Y2vB6HnpeFqN38r5rnK9XM88F/fT/d7K83CV87PdAndiwSuft8r1zWuzILz0jwXsVha4E99PrsfeVABXAH/I989zcT8tEG23QFzl+DLe5/t5sP8qnyefJ+cn1zu35X5sLRg9Lx1Pq/FbOd9VrpfrmefifrrfW3kernJ+tlvgTix45fNWub55bRaEl/6xgN3KAnfi+8n12JsK4ArgD/n+eS7upwWi7RaIqxxfxvt8Pw/2X+Xz5PPk/OR657bcj60Fo+el42k1fivnu8r1cj3zXNxP93srz8NVzs92C9yJBa983irXN6/NgvDSPxawW1ngTnw/uR578/IFsDzwLBhlvLwAyQLbA9svBPv7hSTnY/sqx3P98lzcT1kQTiwwV5nvq5z/lL/aOh/Hc71zW+6H5635YUGp1fhVzs92+X1gu/OduF6uZ56L++l5JfNBxm/l/LxfTbwvTfwLCD9vE+freue5WQBaYK7+2P/SLGi38v1dn72pAD5x6B4yXl5Q5AHrge0Xhv39gpLzsX2V47l+eS7upyxwJxaQq8z3Vc5/yl9tnY/jud65LffD89b8sIDUavwq52e7/D6w3flOXC/XM8/F/fS8kvkg47dyft6vJt6XJhXA+YgFoAXn6o/9L80Cdivf3/XZmwrgE4fuIePlBUUesB7YfmHY3y8oOR/bVzme65fn4n7KAndiAbnKfF/l/Kf81db5OJ7rndtyPzxvzQ8LSK3Gr3J+tsvvA9ud78T1cj3zXNxPzyuZDzJ+K+fn/WrifWlSAZyPWABacK7+2P/SLGC38v1dn72pAD5x6B4yXl5Q5AHrge0Xhv39gpLzsX2V47l+eS7upyxwJxaQq8z3Vc5/yl9tnY/jud65LffD89b8sIDUavwq52e7/D6w3flOXC/XM8/F/fS8kvkg47dyft6vJt6XJhXA+YgFoAXn6o/9L80Cdivf3/XZm5crgD3ANMV7AHug2+4XiBcW+TwPYDn+Kr8Q5Hxcnzw2909eEGy3INRqAez4E8f38+Xnz/7mu+1yPK0+3/3Idbn+FoTy/LV9srW/+bk63mr86vNcT9c7j8X9cr89r+T3gYxf5fnpfG1f5XwdX96nnO/E8dyPPDYLPgtMrf7Y/9IsYLdyPeT6vboKYNo9cD0QbfcLyAuHfJ4HtBx/lQWvnI/rk8fm/mm6MFjAygLVdjn+xPH9fPn5s7/5brscT6vPdz9yXa6/BZ08f22fbO1vfq6Otxq/+jzX0/XOY3G/3G/PK/l9IONXeX46X9tXOV/Hl/cp5ztxPPcjj80CzwJTqz/2vzQL2K1cD7l+r64CmHYPXA9E2/0C8sIhn+cBLcdfZcEr5+P65LG5f5ouDBawskC1XY4/cXw/X37+7G++2y7H0+rz3Y9cl+tvQSfPX9snW/ubn6vjrcavPs/1dL3zWNwv99vzSn4fyPhVnp/O1/ZVztfx5X3K+U4cz/3IY7PAs8DU6o/9L80CdivXQ67fq6sApt0D1wPRdr+AvHDI53lAy/FXWfDK+bg+eWzun6YLgwWsLFBtl+NPHN/Pl58/+5vvtsvxtPp89yPX5fpb0Mnz1/bJ1v7m5+p4q/Grz3M9Xe88FvfL/fa8kt8HMn6V56fztX2V83V8eZ9yvhPHcz/y2CzwLDC1+mP/S7OA3cr1kOv36p6+APaA8sCT8dN4HsAy3i8kLyDOR/bXFG+B6/Pl/F2PPDb3T36hy3gL2onjTSx45XzkeLbL+Evzee5PLsv1tqDzPJTnn/3leWu7fJ6m8Vbnp6m/BYRcX7kfuS33w/NI7u/E/qscz/l6f9rK8b3/yHg/LzJe7k8eiwWeBab8sf3WLGC3+pu/+ZsPuV5yfZ9dBfAwngeujPfC44HqfGR/TfEe+D5fzt/1yGNz/+QFRcZb4E4cb2LBK+cjx7Ndxl+az3N/clmutwWe56E8/+wvz1vb5fM0jbc6P039LVDk+sr9yG25H55Hcn8n9l/leM7X+9NWju/9R8b7eZHxcn/yWCzgLDDlj+23ZgG7lQWvXC+5vs+uAngYzwNXxnvh8UB1PrK/pngPfJ8v5+965LG5f/KCIuMtcCeON7HglfOR49ku4y/N57k/uSzX2wLP81Cef/aX563t8nmaxludn6b+FihyfeV+5LbcD88jub8T+69yPOfr/Wkrx/f+I+P9vMh4uT95LBZwFpjyx/Zbs4DdyoJXrpdc32dXATyM54Er473weKA6H9lfU7wHvs+X83c98tjcP3lBkfEWuBPHm1jwyvnI8WyX8Zfm89yfXJbrbYHneSjPP/vL89Z2+TxN463OT1N/CxS5vnI/clvuh+eR3N+J/Vc5nvP1/rSV43v/kfF+XmS83J88Fgs4C0z5Y/utWcBuZcEr10uu77N7ugLYA8gLhe0Tx5fxHvirHE/Ge4FaNX0B+L55Lu6n+WO7BaeMn/g8Ge/zLKgnjufzVjmeF6CJ/d2fXJbr7Xm3yv20YFzl+DL+0nwfn2/7Ktdf7lcuy/WezjML0lWOd2kWtJOp/3TfMZ+3cnz3K/dlAWeBeW8WqJe2+v7Gu56vpgL4xDM+ep5fOKscT8Z7gVk1fSH4vnku7qf5Y7sFqIyf+DwZ7/MscCeO5/NWOZ4XnIn93Z9cluvtebfK/bSgXOX4Mv7SfB+fb/sq11/uVy7L9Z7OMwvaVY53aRawk6n/dN8xn7dyfPcr92VBZ8F3bxasl7b6/sa7nq+mAvjEMz56nl84qxxPxnuBWTV9Ifi+eS7up/ljuwWojJ/4PBnv8yxwJ47n81Y5nhecif3dn1yW6+15t8r9tKBc5fgy/tJ8H59v+yrXX+5XLsv1ns4zC9pVjndpFrCTqf903zGft3J89yv3ZUFnwXdvFqyXtvr+xruer6YC+MQzPnqeXzirHE/Ge4FZNX0h+L55Lu6n+WO7BaiMn/g8Ge/zLHAnjufzVjmeF5yJ/d2fXJbr7Xm3yv20oFzl+DL+0nwfn2/7Ktdf7lcuy/WezjML2lWOd2kWsJOp/3TfMZ+3cnz3K/dlQWfBd28WrJe2+v7Gu56v5uULYPtv5fiavpCcr6b+0wFsf8eX/eX757G4X+6/Becqx1vl/CxoZX5PHF/GX5rPc39yWa73f/8//Y8fsgCcuL8TC1DHk/Gex7avsoBxvhMLCtvlfrhfuS7XX+bDKseb/Pkv/umHpgLV/LNd03jmq4yX8TLe/cltWcBNPxaAt2bBemmux8T1fHUVwIscX1MB4Hw19Z8OYPs7vuwv3z+Pxf1y/y1oVzneKudnwSvze+L4Mv7SfJ77k8tyvS14ZQE6cX8nFqCOJ+M9j21fZQHjfCcWILbL/XC/cl2uv8yHVY43seDVVLCaf7ZrGs98lfEyXsa7P7ktC7rpx4L01ixYL831mLier64CeJHjayoAnK+m/tMBbH/Hl/3l++exuF/uvwXtKsdb5fwseGV+Txxfxl+az3N/clmutwWvLEAn7u/EAtTxZLznse2rLGCc78QCxHa5H+5Xrsv1l/mwyvEmFryaClbzz3ZN45mvMl7Gy3j3J7dlQTf9WJDemgXrpbkeE9fz1VUAL3J8TQWA89XUfzqA7e/4sr98/zwW98v9t6Bd5XirnJ8Fr8zviePL+Evzee5PLsv1tuCVBejE/Z1YgDqejPc8tn2VBYzznViA2C73w/3Kdbn+Mh9WOd7EgldTwWr+2a5pPPNVxst4Ge/+5LYs6KYfC9Jbs2C9NNdj4nq+uqcvgGX8rTkfLzhTuxemVdP4fsHILyzHk++f63L9LTgtYGXBOXH8rZy/F4pH5/zdn9yW+2EBPPH8lPsvC1DbPX+neG3tv8rvA9vl+rs/uSzXe5UFroyfeF/wvJcF68T+Pt94281XTfGr7e5XbsuCzoJzar82C9Rr830nruerqwC+MOfjBWZq9wK2ahrfC478QnM8+f65LtffC4IFryxwJ46/lfP3QvHonL/7k9tyPyxwJ56fcv81FaSev1O8tvZf5feB7XL93Z9cluu9yoJXxk+8L3jey4J1Yn+fb7zt5qum+NV29yu3ZUFnATq1X5sF6rX5vhPX89VVAF+Y8/ECM7V7AVs1je8FR36hOZ58/1yX6+8FwYJXFrgTx9/K+XuheHTO3/3JbbkfFrgTz0+5/5oKUs/fKV5b+6/y+8B2uf7uTy7L9V5lwSvjJ94XPO9lwTqxv8833nbzVVP8arv7lduyoLMAndqvzQL12nzfiev56iqAL8z5eIGZ2r2ArZrG94Ijv9AcT75/rsv194JgwSsL3Injb+X8vVA8Oufv/uS23A8L3Innp9x/TQWp5+8Ur639V/l9YLtcf/cnl+V6r7LglfET7wue97Jgndjf5xtvu/mqKX613f3KbVnQWYBO7ddmgXptvu/E9Xx1T18Ae0Gw3f6rHG/ifGS8B7wXsInjTfP3giPjnb+M9/m5LNdb04XGAlfGm5+2ayq4Hc8LjBeMe/P93I88FvfL/fyH//yfHLEglv2vzfPVdvl5t32yWlC7vq5/rsv19zyV8Vs5vvknz/eJz1tlvl6bz3e/cl8WeLJA3coC9Np8n0tzPV9NBfDA8SbOR8b7hWKBO3G8af4WvDLe+ct4n5/Lcr3lBcR2C1IZb37argrg3JP75X5WAB+rAH4urr/nqYzfyvHNP3m+T3zeKvP12ny++5X7sqCTBexWFqjX5vtcmuv5aiqAB443cT4y3i8UC9yJ403zt+CV8c5fxvv8XJbrLS8gtluQynjz03ZVAOee3C/3swL4WAXwc3H9PU9l/FaOb/7J833i81aZr9fm892v3JcFnSxgt7JAvTbf59Jcz1dTATxwvInzkfF+oVjgThxvmr8Fr4x3/jLe5+eyXG95AbHdglTGm5+2qwI49+R+uZ8VwMcqgJ+L6+95KuO3cnzzT57vE5+3yny9Np/vfuW+LOhkAbuVBeq1+T6X5nq+mqcrgOUB5AXCdvuvcjyfJwvWVdOBK+cr4+X8V9t9Xi7L9ZYXFBmvKd52C96J48n8kp+HS3M+cj/y2Nw/99uCWFNBPOXn1D5xPv/L//o/H7HgsL8F7irXT653rsv19zw2H6b4VY6/yvnI/6iW/DzJ+crPh5zPxP3JY7Ggs2BdZQF6a77Ptbmer6YCeJHj+TxZ0K5aPaCdr4yX819t93m5LNdbfuHLeE3xtlvgThxP5pf8PFya85H7kcfm/rnfFpiqAH7/GejzcD+uv+ex+TDFr3L8Vc5HFrzy8yTnKz8fcj4T9yePxYLOgnaVBemt+T7X5nq+mgrgRY7n82RBu2r1gHa+Ml7Of7Xd5+WyXG/5hS/jNcXbboE7cTyZX/LzcGnOR+5HHpv7535bYKoC+P1noM/D/bj+nsfmwxS/yvFXOR9Z8MrPk5yv/HzI+UzcnzwWCzoL2lUWpLfm+1yb6/lqKoAXOZ7PkwXtqtUD2vnKeDn/1Xafl8tyveUXvozXFG+7Be7E8WR+yc/DpTkfuR95bO6f+22BqQrg95+BPg/34/p7HpsPU/wqx1/lfGTBKz9Pcr7y8yHnM3F/8lgs6CxoV1mQ3prvc22u56t5+gJYHlAekLavcryJB/BU4Mr+ji/n6/pM7L/K8XJdrr/5MrH/dGGZ+lvw+h/Bst38lZ+Hif0nzt/3c77Gux95bO6fBeVUcJpvxlswy3jHt93n+fn0P2Jo/GpBK9cvj8X9ujTzy/ybOJ4scM1f4z2/Pa9tt/80P9c3z82CzoJ2lQXprfk+1+Z6vpoK4EWON/GArgDOJbn+5svE/tMFYepvwVgBnEfi/k0FqO3mm/EWvDLe8W33eX4+LVCMrwB+be7XpZlf5t/E8VQBnGuyoLOgXWVBemu+z7W5nq+mAniR4008oCuAc0muv/kysf90QZj6WzBWAOeRuH9TAWq7+Wa8Ba+Md3zbfZ6fTwsU4yuAX5v7dWnml/k3cTxVAOeaLOgsaFdZkN6a73NtruerqQBe5HgTD+gK4FyS62++TOw/XRCm/haMFcB5JO7fVIDabr4Zb8Er4x3fdp/n59MCxfgK4Nfmfl2a+WX+TRxPFcC5Jgs6C9pVFqS35vtcm+v5al6uAJYH3MQDdDpgJ44/8QvA8SaO53rktbjf5quMn/LHdseT/S2AbTffr83nO38Z7/rnubm/5osFqhdo2yeO73gTC9qJ7+f757W5/+afBajsv5XjOx/Z3+8jGe/zZLzrl+diAWcBaUE7sf+9+X7X5vq+mgpgeKB6IbZ94vgTvwAcb+J4rkdei/ttvsr4KX9sdzzZvwI4j8z9NV8sYC1IbZ84vuNNLHAnvp/vn9fm/pt/FoSy/1aO73xkf7+PZLzPk/GuX56LBZwFpAXuxP735vtdm+v7aiqA4YHqhdj2ieNP/AJwvInjuR55Le63+Srjp/yx3fFk/wrgPDL313yxgLUgtX3i+I43scCd+H6+f16b+2/+WRDK/ls5vvOR/f0+kvE+T8a7fnkuFnAWkBa4E/vfm+93ba7vq6kAhgeqF2LbJ44/8QvA8SaO53rktbjf5quMn/LHdseT/SuA88jcX/PFAtaC1PaJ4zvexAJ34vv5/nlt7r/5Z0Eo+2/l+M5H9vf7SMb7PBnv+uW5WMBZQFrgTux/b77ftbm+r+blC+BVHoheiGW8HH9if3ngT/Nx/LwW93s1H2zXlG+rHN8Lj8+T8XJ8WVCsejfeiT3J43L/zJ+JBab5oek/ImS7z9PU33bf1/XIa3G/zZ+JBaLnt+fxxPk4vs+fOJ78PKw+z/Fc3zw2CzgLyEfjfB+N6/tqKoDhAegXgIyX40/sL79gpvk4fl6L+72aD7ZryrdVju8FxOfJeDm+LBBWvRvvxJ7kcbl/5s+kAjiPzP02fyYWjJ7fnscT5+P4Pn/iePLzsPo8x3N989gs4Cw4H43zfTSu76upAIYHoF8AMl6OP7G//IKZ5uP4eS3u92o+2K4p31Y5vhcQnyfj5fiyQFj1brwTe5LH5f6ZP5MK4Dwy99v8mVgwen57Hk+cj+P7/Injyc/D6vMcz/XNY7OAs+B8NM730bi+r6YCGB6AfgHIeDn+xP7yC2aaj+Pntbjfq/lgu6Z8W+X4XkB8noyX48sCYdW78U7sSR6X+2f+TCqA88jcb/NnYsHo+e15PHE+ju/zJ44nPw+rz3M81zePzQLOgvPRON9H4/q+mt0XwB54Hogy3vEuzef5heT8ZH/Hz3NxP6f9nto1PU/m42r7pTl/Ga+t8/V5eSzul58PGe8Feyo4JxYMPl8+z3b5PNcjr8X99jzTv/13/+aI7Y63lfnp82R/31fGWwA7vuzv+HlsFnAWnI/G+T4a1/fVVAAPB7SMd7xL83ke2M5P9nf8PBf3c9rvqV3T82Q+rrZfmvOX8do6X5+Xx+J++fmQ8RXAeWTut+eZKoC3PS+PxQLOgvPRON9H4/q+mgrg4YCW8Y53aT7PA9v5yf6On+fifk77PbVrep7Mx9X2S3P+Ml5b5+vz8ljcLz8fMr4COI/M/fY8UwXwtuflsVjAWXA+Guf7aFzfV1MBPBzQMt7xLs3neWA7P9nf8fNc3M9pv6d2Tc+T+bjafmnOX8Zr63x9Xh6L++XnQ8ZXAOeRud+eZ6oA3va8PBYLOAvOR+N8H43r+2p2VwB7wF2az1vleJfm8/Jc3M9L83kT+2/l+Jfm8y7N5+WxuF+T1f7GT+x/bT4/r8X9vjSfN7H/pV37eY6f52JBZwG6leM/m7/+678+Yrvr+WoqgC/M561yvEvzeXku7uel+byJ/bdy/EvzeZfm8/JY3K/Jan/jJ/a/Np+f1+J+X5rPm9j/0q79PMfPc7Ggs4DdyvGfTQXwiV++Mg+4S/N5qxzv0nxenov7eWk+b2L/rRz/0nzepfm8PBb3a7La3/iJ/a/N5+e1uN+X5vMm9r+0az/P8fNcLOgsYLdy/GdTAXzil6/MA+7SfN4qx7s0n5fn4n5ems+b2H8rx780n3dpPi+Pxf2arPY3fmL/a/P5eS3u96X5vIn9L+3az3P8PBcLOgvYrRz/2VQAn/hlkiRJkjwjCzpZ0K5yvGdjASzjXd9nVwGcJEmS5GVYwMmCdpXjPRsLXhnv+j67CuAkSZIkL8MCTha0qxzv2VjwynjX99lVACdJkiR5GRZwsqBd5XjPxoJXxru+z64COEmSJMnLsICbCrwccz1fTQVwkiRJkpdhQVcBvMb1fDUVwEmSJElehgVdBfAa1/PVVAAnSZIkeRkWdBXAa1zPV1MBnCRJkuRpWcBljev56iqAkyRJkjwtC7qscT1fXQVwkiRJkqdlQZc1ruerqwBOkiRJ8rQs6LLG9Xx1FcBJkiRJXpYF3965PntTAZwkSZLkZVkA7p3rszcVwEmSJElelgXg3rk+e1MBnCRJkuRlWQDuneuzNxXASZIkSXbDgvDV+f57VwGcJEmSZDcsEF+d7793FcBJkiRJdsMC8dX5/ntXAZwkSZJkNywQX53vv3cVwEmSJEl2y4Lx2fl+OVYBnCRJkmS3LCCfne+XYxXASZIkSXbLAvLZ+X45VgGcJEmSZLcsIJ+d75djFcBJkiRJ8hMLykfn/POxCuAkSZIk+YkF5qNz/vlYBXCSJEmS/MQC89E5/3ysAjhJkiRJfmKB+eicfz5WAZwkSZIk38mC9NJ8XrapAE6SJEmS72TBemk+L9tUACdJkiTJd7JgvTSfl20qgJMkSZLkO1mwXprPyzYVwEmSJEmSXagATpIkSZLsQgVwkiRJkmQXKoCTJEmSJLtQAZwkSZIk2YUK4CRJkiTJLlQAJ0mSJEl2oQI4SZIkSbILFcBJkiRJkl2oAE6SJEmS7EIFcJIkSZJkFyqAkyRJkiS7UAGcJEmSJNmFCuAkSZIkyS5UACdJkiRJdqECOEmSJEmyCxXASZIkSZJdqABOkiRJkuxCBXCSJEmSZBcqgJMkSZIku1ABnNzQL3/75cuX3/7Fu98/jr/48ldfvnz5q1/6+2S7x8//5HrK/yR5DA9RAH/9UnjuC/fXouEvv/zS3//Zr778/ve/+vILf5/X9In9Xr0A/RD/w8/vvvzmz963f/PLv1wa9xe//t3bwPSrAM53eqL8X/enX37z+2EO2beXzv+PdP9J8nwqgC+iL4Bcc78/cfleugCdyddki6fJ/+/xiTlk3146/z9y5vvkauuRJNt9VwH8859Kfv05PPh+PAh/c/C3S0eF7dcD8VvLzwf6DwXwr39u+/2v//TgeT/+jZR9vn0p/Povv7Ue9zvvcP5Hfb5+iRz8HM7dOb592RyvxXHb2xfAb77FnPiSyPM5ypODnPxovw9z/91F5WsufxvwxB8GnbkAHX2eTo17xpmLyeHfCjuHc/n/bbxvPcvxl/es+X8q7w9/d+b8P/rXEm8/h+Oczf/h+zDP6Vnz/yfdf7LJ2fPu1Fn5c/u7XPEsPoUc/zkn/+LLXx3lFp+Pw1w+e1Yf5//Xuf/+17/6ud74zPzy1L6rAD5y9CePPxar35Lq6MLxte3EIf7tg/HTB+WHBH370HDwv2s7PPTP/Ckkfkzyt6T/cYz3Xzjvx/thjt/exS+kM8/+6cP29ryvY3y2SM+jcu8PfGa/T/xJ/fG/gDj1OTn1TOJOjPve4R8mvf04rvP5+Xen85/c/zqPvjhe2Klc/Mkz5P9PufntmWf7eaafmsOJuKP8/+j7MM/pXB48Q/53/8lWH5x3J+7n33Lr3bloPp926i7y8zwO8sl5HJyzPxTlJz8bx3n8Y/F+nPOnn51X8V0F8Ls/5flMEfrBAf3+C+CwGPbnTHH8KT8Vzfx8e/a75332w3DmvU98EPsCeH4/XAZO/Un9Z/b73efgx4P8+Me8PpHrjuP//ZHhIn4q10/97gdfn+vPB2Pn+T1v/r+d018L4d99+auvc/vlXx4XqEfz+EQB/GH+n/leyFN73vzv/pONPjrvrlAAv9Ua7/PGnPv5/35Xn3z9OapRDn+OC+D3z8krWy+Af0jyc3/yaFIe+OCA/rAAPnuZPvGlMPqoz48f2J8/AMfv0hdA9O4i9Jn9fvc5OJM7R07kreP4f3/kw8/V6Vw/9bsfrDw3L+X58v+ncX75qy9/9eu/+PKb3/7qyy9//buf5v/x+X9yDuNzHSOv5Gnz3xz+1nY+/8+e/ydiv/nMeuS5fJhnFJeHcfzhymoevC+EybmD4vujPPvhM/ttXsefh4/65TV9ZwF8/Kc8nyqALZwPnC2A/VOkIx8d5uf98EE6+QE+ftaPH7iVL4ATc+kL4OUd7eln9vvEF8jX3HoXd+RErh99Dn/64jmZ1ydcsgA+l/vZhWfL/x/y+Le/+mGsX/72d19+/+3M//j8t/1nH+X/B9+HeQnPlv/df7LNmb3+6kRuv7nI3h+Nf3y2HuX10Wfj2NFn7et4/Q3wrq0XwAd/8vlD8nz9j1CdScp3fki4g74/Jd75Avj9nxyd+9Obz/upaP/2c/Csg/n9+D+G/+wXwNsXxk8/hx/EvgBeDH/Kaa6e2++j3P/x5+dcYMxvY5irX3+Oc/Lb7z748nnnTAH883hvP+c+o+DdyvFX9tz5f3Sx5wL00flv+9E/8z+b/8P3YZ7Qc+f/+zG7/2TRh+cdP0dF6fHPnAvm6uF9/9xn5kdH+ei/0nj75dc/CO1vgHftuwrgJEmSJHlXQB78Tey7P0D5WkSf+EP4z+sPF7Pd6xXAJ/6k6e2nP93Jyyv/s2flf/as/M+9vMu90/+65sefnwvj0z9TcVsBnO1erwBOkiRJkuSECuAkSZIkyS5UACdJkiRJdqECOEmSJEmyCxXASZIkSZJdqABOkiRJkuxCBXCSJEmSZBcqgJMkSZIku1ABnCRJkiTZhQrgJEmSJMkuVAAnSZIkSXahAjhJkiRJsgsVwEmSJEmSXagATpIkSZLsQgVwkiRJkmQXKoCTJEmSJLtQAZwkSZIk2YUK4CRJkiTJLlQAJ0mSJEl2oQI4SZIkSbILFcBJkiRJkl2oAE6SJEmS7EIFcJIkSZJkFyqAkyRJkiS7UAGcJEmSJNmFCuAkSZIkyS5UACdJkiRJdqECOEmS7/B3/vbf+pDxSc77P/3x/+VDxif5nNXvJb/LTrHPs6kATpLkO3ghkPFJzrPglfFJPmf1e8nvslPs82wqgJMk+Q5eCGR8kvMseGV8ks9Z/V7yu+wU+zybCuAkSb6DFwIZn+Q8C14Zn+S8w++iP/n7f+8bv6dOOYz/oz/8g29e6futAjhJku/gpUFb47Uan9yTBezk//X//f99yHj5/GTPDr8rKoDfqwBOkuQ7eGnQ1nitxif3ZIE6seCV8fL5yZ4dfldUAL9XAZwkyXfw0qCt8VqNT+7JAnViwSvj5fOTS/nMuev5PMVfm/N4c1jcbvEI77hFBXCSJN/Bi4W2xms1PrknC9SJBa+Ml89PLuUz567n8xR/bc7jjYXs93qEd9yiAjhJkk/wIvGf/9N/OGL7xAu87Vs5/+SWzO+poP1X/+b/ecR42d/nJ5fymXPV83eKvzbn8cZC9ns9wjtuUQGcJMkneJGoAE7OM7+nArYCOI/E83Q6V407FW/bqZjPsP8pFqwrDsc5/N8An4txfs+gAjhJkk/wglEBnJxnfk8FbAVwHonn6XSuGncq3rZTMZ9h/1MsalccjlMBnCTJjnnBqABOzjO/pwK2AjiPxPN0OleNOxVv26mYz7D/KRa1Kw7HqQDORfz7f//vP2R8kuQxeMH41//qXx6x3Qv6avtqge18k3syvzXF/9//H788YgFswWx/x09WnDuLPXdPxfzbf/dvvjmMOczP1bP7MP7c/9dEhwXqucL1Glbf5RFUAN+YBa+MT5I8hsMv+a8qgJPzzG9N8RXAuadzZ7Hn7qmYCuDHVwF8Yxa8Mj5J8hgOv+S/qgBOzjO/NcVXAOeezp3FnrunYiqAH18F8I1Z8Mr4JMljOPyS/6oCODnP/NYUXwGce/rorH5zWGQeFr2HDmMO+3p+T84VnBajp5yLP/f7zxTP54pw1/FRVQBfmAWt/uZv/uZDxsvnJUkuwwuHvJBP7V6WZH9ZYNtf9pfvm1yT+SnjZXwFcG7p8Ow0t95UAFcA5ycWrLLglfHyeUmSy/DCIQvcqd3LkuyvCuA8M/NTxsv4CuDc0uHZaW69qQCuAM5PLFhlwSvj5fOSJJfhhUMWuFO7lyXZXxXAeWbmp4yX8RXAubbD89J8WrFlHAvNFauF66rDcZ79u6UC+MIsWGXBK+Pl85Ikl2HBKAvcqd2LjeyvCuA8M/NTxsv4CuBc2+F5aT6t2DKOBeuKc8XquZhVh+M8+3dLBfCFWbD6Y8E7cTyflyS5DAvGiRcXrcavmsa3feJ6ZN/MJxl/aT5vtQCW4yf66DxdsWUcC9YV54rVczGrDsd59u+OCuALs2D1xwJ34ng+L0lyGRaEEy8uWo1fNY1v+8T1yL6ZTzL+0nxeBXCu4dwZevj7wyLw3L/yOTfOuZjPxJ/ra1F7isXrm3Pvdc4rFb2HKoAvzILVHwvcieP5vCTJZXgpmXhB0Wr8qml82yeuR/bNfJLxl+bzKoBzDefO0MPfHxaEFcA/ch2fTQXwhVmw+mOBO3E8n5ckuQwvJRMvKFqNXzWNb/vE9ci+mU8y/tJ8XgVwruHcGXr4+8OCsAL4R67js6kA3sgCdfqxwJ38x//4H4/4POeTJPk+Xkr8j1rZ/tEF5TOm/rbL+MnU3/XIvpgfFpy2238rx/f5Frwy3vF8XqLD8/Dc2X/u94e5dvj7/+a/+9NvVvseOlfcHsac+/1qzGfiXbtnUwG8kQXp9GOBO6kATpLb8Iu/Ajh7Yn7cuqB0fJ9vwSvjHc/nJTo8D8+d/ed+f5hrh7+vAH5MFcAbWZBOPxa4kwrgJLkNv/grgLMn5setC0rH9/kWvDLe8XxeosPz8NzZf+73h7l2+PsK4MdUAbyRBen0Y4E7qQBOktvwi78COHtifty6oHR8n2/BK+Mdz+cl8kx887/9v/+Hb/xeeHOYa7ad+g4xP085F3+uKF3l+5+yGv8sKoAXWYBasE4/xq+qIE6Sy/Ay4OVDxk8+uvx8pn3i/GT8xPXJvpg/Ml7Gr7KAlQWvjHd855vIM/FNBfDn459FBfAiC04L1OnH+FUVwElyGV4GvHzI+MlHl5/PtE+cn4yfuD7ZF/NHxsv4VRawsuCV8Y7vfBN5Jr6pAP58/LOoAF5kwWmBOv0Yv6oCOEkuw8uAlw8ZP/no8vOZ9onzk/ET1yf7Yv7IeBm/ygJWFrwy3vGdb/LV4Rl4eB4f/m9uPatPndmHufaZmHO/P8fz+o3vk8+pAF5kwWmBOv0Yv6oCOEkuw4uEFw4ZP/nosvSZ9onzk/ET1yf7Yv7IeBm/ygJWFrwy3vGdb/LV4Rl4eB5XAL+2CuBFFpyrPxa0qyqAk+Q6vFis+uhydMoUP12Apv6rXI+8NvPLAlLGaypIVzmezH/7Oz/fP/nq8Aw8zKcK4NdWAbzIgnP1x4J2VQVwklyHF4tVH12OTpnipwvQ1H+V65HXZn5ZQMp4WaDaf5Xjyfy3v/Pz/fP6PONOOSx0bXvzn//Tf/jmMOfMsTeHfT/z+3Mx53wm3rXIsQrgRRacqz8WtKsqgJPkOrxArPJCbrum+OliNPVf5XrktZlfFpAyXhao9l/leDL/7e/8fP+8Ps+4UyqA96kCeJEF5+qPBe2qCuAkuQ4vEKu8kNuuKX66GE39V7keeW3mlwWkjJcFqv1XOZ7Mf/s7P98/r88z7pQK4H2qAB5YYFqQTj/Gb2UBLOfr+yTXZP5dms9LLskLxOrFxAu57Yf/X2mc+v9Ow3g5n9X+cjzbXZ+8NvPBglIWpDLefJX9J47v/H2/vC7Prjfm2JvD/2+EzhXA9jnFnDt1lp77/bmYz7D/KefWx7XbqwrggRdwC9Lpx/itLHjlfH2f5JrMv0vzeckleYFYvXR4ObK9AjiPzHywwJQFqYw3X2X/ieM7f98vr8uz64059qYCOBXAAy/gFqTTj/FbWfDK+fo+yTWZf5fm85JL8gKxeunwcmR7BXAemflggSkLUhlvvsr+E8d3/r5fXpdn1xtz7E0FcCqAB17ALUinH+O3suCV8/V9kmsy/y7N5yWX5AVi9dLh5cj2CuA8MvPBAlMWpDLefJX9J47v/H2/vJbDs8pcmhwWwOfOxMPf/zf/3Z9+cy7mHPPyFPuc6ntYqJ8r2j/DddyrCuCBF/DVHwvYrSx45Xx9n+SSzLe//uu/vijHnzi/ZIUXhYmXqsNL0ldT/GcvQef6267V8V2P7Iv5YoFpAToxX+X4E+en6X0m9s9jOzy7zK1JBXAqgAdesFd/LGC3suCV8/V9kksy3yxgt3L8ifNLVnhRmHipqgDOMzNfLEAtcCfmqxx/4vw0vc/E/nlsh2eXuTWpAE4F8MAL9uqPBexWFrxyvr5PcknmmwXsVo4/cX7JCi8KEy9VFcB5ZuaLBagF7sR8leNPnJ+m95nYP4/n8Lw6dxaeO4PPxZ8b3/x4c+5Zq0XyuZjP/P6cw3c8N45rulcVwAMv2Ks/FrBbWfDK+fo+ySWZbxawWzn+xPklK7ygTLzQewma4r28GC/7267V8V2P7Iv5YgFqgTsxX+X4E+en6X0m9s/jOTyvzp2F587gc/Hnxjc/3px7VgXwc6kAHnjBXv2xgN3KglfO1/dJVphPMv8sYGW8jPd5q3yf7IsXDhkv4//1v/qXR2z3gu8/VfOSZLzj3Zrvn9fiZVkWnLLAnZjfjjexv/P1/WS849sux8v9HZ5X587OCuD3n5fDcVzTvaoAHnihXv2xgN3KgkHO1/dJVphPMv8sYGW8jPd5q3yf7IsXDhkv4yuA88y8LMsCURa4E/Pb8Sb2d76+n4x3fNvleLkdz6Y35/63r58pei911nqOnzrPD/PI/m8O/3fI5/oe2hJz+FzXeq8qgAdeqFd/LGC3smCQ8/V9khXmk8w/C1gZL+N93irfJ/vihUPGy/gK4DwzL8uyQJQF7sT8dryJ/Z2v7yfjHd92OV5ux7PpTQXw98UcPte13qsK4IEX6tUfC9itLBjkfH2fZIX5JPPPAlbGy3ift8r3yb544ZDxMr4COM/My7IsEGWBOzG/HW9if+fr+8l4x7ddjpfb8Wx6UwH8fTGHz3Wt96oCGF6gLUCnH+O3skCYOH/5vtk380PX/rHgnazm+8T1yHPzgvEv/tk/PnJ44fD/+4tTFwPb//N/+g9HvFTJ59sunzf56PLzPeP5/nkt5osFoSxoVznexPyV8/f9ZLyMz+M4PJfOFb2HzJVTzsWbF2/sf8q5Mc/9/tC5AvjQufkc/n61CHet96oCGF6QLUinH+O38sI/cf7yfbNv5oeu/WOBO1nN94nrkefmpcgCtAL4Y75/Xov5YgEqC9pVjjcxf+X8fT8ZL+PzOA7PpQrg9/M5/H0F8PepAIYXZAvS6cf4rbzwT5y/fN/sm/mha/9Y4E5W833ieuS5eSmyAK0A/pjvn9divliAyoJ2leNNzF85f99Pxsv4PI7Dc6kC+P18Dn9fAfx9KoDhBdmCdPoxfisv/BPnL983+2Z+6No/FriT1XyfuB55bl6KLEArgD/m++e1mC8WoLKgXeV4E/NXzt/3k/EyPo/Ds+nUGWXbG/PmXP68OYz5zDi35FxPzXk1/tx67k0FMLwgW5D6Y/uleeGfOH/5vtkX88EC89Y/5u8q52+77ztxvfJcvAj5H6GS8dN4W/kfTZHxXm5sl5ce232/vDbzwYJTFrAyXqvx5vfULt9PzkfGu365H8+uU2eYbW/MkylfDmM+M84tOddTc16NP7eee1MBDC/EFqT+2H5pXugnzl++b/bFfLCAvPWP+bvK+dvu+05crzwXL0IWvDJ+Gm8rC14Z7+XGdnnpsd33y2szHywwZYEo47Uab35P7fL95HxkvOuX+/HsOnWG2fbGPJny5TDmM+PcknM9NefV+HPruTcVwPBCbEHqj+2X5oV+4vzl+2ZfzAcLyFv/mL+rnL/tvu/E9cpz8SJkwSvjp/G2suCV8V5ubJeXHtt9v7w288ECUxaIMl6r8eb31C7fT85Hxrt+eTwfnY+Tc2elcZNr9zUvv9e5MQ9/v+fvhwpgeCG2IPXH9kvzQj9x/vJ9sy/mgwXkrX/M31XO33bfd+J65blY8FnwyvhpvK0seGW8FyPb5QXIdt8vr818sMCUBaKM12q8+T21y/eT85Hxrl8ez0fn4+TcWWnc5Np9zcvvdW7Mw9/v+fuhAhheiC1Ir80L/CrnL983r839t2DUpX/Mz1vz/Ve5nnlsFnz+R68uXQB7cdnq0uN7IXJ83zevxf23wJQFou0yfmJ/mb9yvK1cH9cvj2fL+XjY91xB+BnX7mtefq9zYx7+fs/fBxXA8AJsgXptXuBXOX/5vnlt7r8Fry79Y37emu+/yvXMY7PAqwA+vhA5vu+b1+L+W3DKAtF2GT+xv8xfOd5Wro/rl8ez5Xw8dxYad8ph38PfH45zLuYzLjW3VXv+PqgAhhdgC9Rr8wK/yvnL981rc/8teHXpH/Pz1nz/Va5nHtvhl/lXFcDnLzun3jevxf234JQFou0yfmJ/mb9yvK1cH9cvj2fL+XjuLDTulMO+h78/HOdczGdcam6r9vx9UAEML8AWqNfmBX6V85fvm9fm/lvw6tI/5uet+f6rXM88tsMv868qgM9fdk69b16L+2/BKQtE22X8xP4yf+V4W7k+rl8ez5bz8dxZaNwph30Pf384zrmYz7jU3Fbt+fugAhhegC1Qr80L/CrnL983r8X9tsDVtX/MT58v47dyPVa5vnkuh1/uX1kAWyAbP4330WXiVLsXFxkvx7f/xP6+X56b+WKBuZUF5MT+5uMqx5/YX66X65nHc+58dW9Pcb/fbBnzM86Nf+73W+Zg/2mcPX8fVADDC7AF6rV5gV/l/OX75rW43xaYuvaP+enzZfxWrscq1zfP5fDL/asK4I/fL8/NfLEA3coCc2J/83GV40/sL9fL9czjOXe+urenuN9vtoz5GefGP/f7LXOw/zTOnr8PKoDhBdgC9dq8wK9y/vJ981rcbwtMXfvH/PT5Mn4r12OV65vncvjl/lUF8Mfvl+dmvliAbmWBObG/+bjK8Sf2l+vleubxnDtf3dtT3O83W8b8jHPjn/v9ljnYfxpnz98HFcDwAmyBem1e4Fc5f/m+eS3utwWmrv1jfvp8Gb+V67HK9c1zOfxy/6oC+OP3y3MzXyxAt7LAnNjffFzl+BP7y/VyPfN4Pjpf35zb43N9zYtTfW2bHP7/727bKb7D9z73M86Nv7fvhgpgeAG2QL02L/AT5zvxffPc3F9ZYGrrz9b83cr3vTTXO8/NAnBrAezF4tam+UyXKfv7vnlu7r8F6f/2//4fjthuQSnjt3L8Vea3XA/XK4/v8LxyP0+dc4e/P9fXPDnV17ZJBfDjqwCGF2Av+NfmBX/ifCe+b56b+ysLXm392Zq/W/m+l+Z657lZ8FUAf/y+eW7uvwVnBfD7NctjOzyv3M9T59zh78/1NU9O9bVtUgH8+CqA4QXYC/61ecGfON+J75vn5v7Kgldbf7bm71a+76W53nluFnwVwB+/b56b+2/BWQH8fs3y2A7PK/dzxUfn5jUdzsG2UzGXmqfvf8revgsqgOEF2Av+tXnBnzjfie+b5+b+yoJXW3+25u9Wvu+lud55bhZ8FcAfv2+em/tvwVkB/H7N8tgOzyv3c8VH5+Y1Hc7BtlMxl5qn73/K3r4Ldl8Ae+H1Qn9tXuhXOf9Vrkeei/tpfly64HX8e/P9r831z3OzAJwc/rO2r2z30iEvHLZP/vW/+pdHpuf7PNnf9clzcX+nAndqX7VakK5aHd/1cL3yfA7PK/d3xUfn5jUdzsG2UzGXmqfvf8revgsqgLngWqBemxf6Vc5/leuR5+J+mh8VwJfl+ue5WQBOKoDzyNzfqcCd2letFqirVsd3PVyvPDfPrxXmyj0c5ua53x/yHaZ3sf+pZ51zOL7r/ioqgLngWqBemxf6Vc5/leuR5+J+mh8VwJfl+ue5eZGYVADnkbm/U4E7ta9aLVBXrY7verheeW6eXyvMlXs4zM1zvz/kO0zvYv9TzzrncHzX/VVUAHPBtUC9Ni/0q5z/Ktcjz8X9ND8qgC/L9c9z8yIxqQDOI3N/pwJ3al+1WqCuWh3f9XC98tw8v1aYK/dwmJvnfn/Id5jexf6nnnXO4fiu+6uoAOaCa4F6bV7oVzn/Va5Hnov7aX5o64/j3Zvvf22uf57bdJGw3QLYgnTieDL+X/yzf/wh+8v38SJkvOuT5+L+WqBe2mpBav9Vjiff3/VJ3nx0Tt6beXzqvP7Mu9j/zbmYw9+fe9YrqQDmgmuBem1e6Fc5/1WuR56L+2l+aOuP492b739trn+emwWgFxHbK4DzyNxfC8hLqwDOs/ronLw38/jUef2Zd7H/m3Mxh78/96xXUgHMBdcC9dq80K9y/qtcjzwX99P80NYfx7s33//aXP88NwtALyK2VwDnkbm/FpCXVgGcZ/XROXlv5vGp8/oz72L/N+diDn9/7lmvpAKYC64F6rV5oV/l/Fe5Hnku7qf5oa0/jndvvv+1uf55bhaAXkRsrwDOI3N/LSAvrQI4z+qjc/KU1fjPMF/f+D1w6vvjM+/iuG+cx6n4c896JRXAXHAtUC/NC/xWzn+V65Hn4n6aH5p+jL833+/RuB95Lodf8l4eTjHeC4osWGW8fN40H9tlvOuR1+LF14JylQWv7eab7doaL9/X9UjerJybX63Gf4b5+sbvgVPfB595F8d94zxOxZ971iupAOZCa8F6aV7wt3L+q1yPPBf30/zQ9GP8vfl+j8b9yHM5/JL38nCK8V5QZMEr4+XzpvnYLuNdj7wWL74WlKsqgPMqVs7Nr1bjP8N8feP3wKnvg8+8i+O+cR6n4s8965VUAHOhtWC9NC/4Wzn/Va5Hnov7aX5o+jH+3ny/R+N+5Lkcfsl7eTjFeC8osuCV8fJ503xsl/GuR16LF18LylUVwHlm587uw/9Zizl1TZ735879U869l89YUQG8M15oLVgvzQv+Vs5/leuR5+J+mh+afoy/N9/v0bgfeS5eKrwQyHgvLrLglfHyedN8bJfxrkdeiwWhBeWqCuA8s3NndwXwjyqAd8YLrQXrVl7ot3K+W7keeWzun/nxanzfR+P+5Ll5yZAFrP9RLOO92MjxbHd8Lyw+z3YLAuN9/7w288ECc5UFsfk3sb/jy/7y/Xz/7Nu5s/mjM/aaPO/feE6fcu69fMaKc98VruOrqADmQmsBu5UX+q2c71auRx6b+2d+vBrf99G4P3luXjJkwWqBarwXGzme7Y7vhcXn2W5BYLzvn9dmPlhgrrKANf8m9nd82V++n++ffTt3lp87sw9//9E5/Mbz9dSY53yUx6fOb9/t1Ds6v1NWx38lFcBcaC1gt/JCv5Xz3cr1yGNz/8yPV+P7Phr3J8/Ni4ssWC1QjfeSI8ez3fG9vPg82z+6QH3l++e1mQ8WmKssYM2/if0dX/aX7+f7Z9/OneXnzuzD3390Dr/xfD015jkf5fGp89t3O/WOzu+U1fFfSQUwF1oL2K280G/lfLdyPfLY3D/z49X4vo/G/clz8+IiC1YLVOO95MjxbHd8Ly8+z/aPLlBf+f55beaDBeYqC1jzb2J/x5f95fv5/tm3c2f5uTP78PcfncNvPF9PjXnOR3l86vz23U69o/M7ZXX8V1IBzIXWAnaVF/hLc75buR55bO6f+fFsfJ9n4/7ktXmx8TJhu7z0yHjHn9hfvk/2xQu1LEhlQbpqdTzzW87f900Oz7/PFL2H/uTv/71vbFvxmXEO52Nen+LZ/sbPyIrDcVzHV1QBzIXWgnaVF/xLc75buR55bO6f+fFsfJ9n4/7ktU2XDdvlpUfGO/7E/vJ9si9eomWBKgvUVavjmd9y/r5vcnj+VQB/7HAc1/EVVQBzobWgXeUF/9Kc71auRx6b+2d+PBvf59m4P3lt02XDdnnpkfGOP7G/fJ/si5doWaDKAnXV6njmt5y/75scnn8VwB87HMd1fEUVwFxoLWhXecG/NOe7leuRx+b+mR/Pxvd5Nu5PXtt02bBdXnpkvONP7C/fJ/viJVoWqLJAXbU6nvkt5+/7Jofnn/ny5vAM/qM//INvPlO4HjrMzcO+h7+3z5vD+Zz73xsfxmz5njhnb98VFcBcaL2g35vzuzTXI4/F/ZL58mic76tz//JaLCi9QMj4yerzbLd/ssLCwIL10ix4/Y++OR85/0SH56P58+awEK0A3s93SQUwF1gv8Pfm/C7N9chjcb9kvjwa5/vq3L+8FgtOLxAyfrL6PNvtn6ywMLBgvbQK4Fzb4flo/rw5LEQrgPfzXVIBzAXWC/y9Ob9Lcz3yWNwvmS+Pxvm+Ovcvr8WC0wuEjJ+sPs92+ycrLAwsWC+tAjjXdu78PFdMWphewmcKaXP7lHNnv98L32tv3yUVwFxgvcDfm/O7NNcjj8X9kvnyaJzvq3P/8losOL1AyPjJ6vNst3+ywgu3BeulVQDn2s6dn4d5dBhjYXoJFcCPafcFsLzQeqG/Neezle+bx+b+yXx5NM731bl/eS0WnB9dIC5xiXA8nyfjHS9Z4QVcFrQT+0+cT7Lq3Pl5mGeHMRaml1AB/JgqgOGF1gv9rTmfrXzfPDb3T+bLo3G+r879y2uxwPzoAnGJS4Tj+TwZ73jJCi/gssCd2H/ifJLPODwDV/5FwVcWpitF7GfiD+fms98cnumf+f3Kd8Sp74m9fl9UAMMLrRf6W3M+W/m+eWzun8yXR+N8X537l9fihWG6WNh/leP5PBnveMkKL+aywJ3Yf+J8ks84PAMrgN/ze2Kv3xcVwPBC64X+1pzPVr5vHpv7J/Pl0TjfV+f+5bV4YZguFvZf5Xg+T8Y7XrLCi7kscCf2nzif5DMOz8AK4Pf8ntjr90UFMLzQeqG/Neezle+bx+b+rTKftnL8HHP/8ty8IGzl+BP7b+X4yRZe3Cf2T67h8Mw7VwCfKybPFaufKW4/E+Nn4hQL1lPzPHeue+avcB1fXQUwvNBaANya89nK981jc/9WmU9bOX6OuX95bl4QtnL8if23cvxkCy/uE/sn13B45lUAf57r+OoqgOGF1gLg1pzPVr5vHpv7t8p82srxc8z9y3PzgrCV40/sv5XjJ1t4cZ/YP7mGwzOvAvjzXMdXVwEML7QWALfmfLbyffPY3L9V5tNWjp9j7l+emxeErRx/Yv+tHD/Zwov7xP7JNRyeeYf5Z0F5qrA8xwL3e11qPoc6479PBTC80FoAXJvPvzTfN4/N/Vtlfm3l+Dnm/iVJktupAM5nVADDC60FwLX5/EvzffPY3L9V5tdWjp9j7l+SJLmdCuB8RgUwvNBaAFybz7803zePzf1bZX5t5fg55v4lSZL7OFcMH/5vg8857HuOBe4p9nlj4Ts5nP/h7w/H9P1zXgUwvNBaAFybz7803zePzf1bZX5t5fg55v4lSZL7OCwOK4BzqAIYXmgtAFY53r35vnls7l8em/uXJEnu47A4rADOoQpgeKG1oF3lePfm++axuX95bO5fkiS5j88UnIdF72cKy8PfHxa6/+Kf/eNvzvU9N85hcXuu0D3nM8/KexXA8EJrQbvK8e7N981jc//y2Ny/JElyH4fFoYXjmwrgfaoAhhdaC9pVjndvvm8em/uXx+b+JUmS+zgsDi0c31QA71MF8MALrgWujL833yfPzf3Nfbk/SZLkMRwWhxaOpxwWn58pLA9jPhN/zmHfCuDbqAAeeOG14JXx9+b75Lm5v7kv9ydJkjyGw+LQwvGUCuD9qAAeeOG14JXx9+b75Lm5v7kv9ydJkjyGw+LQwvGUCuD9qAAeeOG14JXx9+b75Lm5v7kv9ydJkjyGw+LQwvF7i95z49v2vT4z5wrg7SqAB154n43vk9fifue6XP8kSfKYPlNMVgDvUwXwwAvws/F98lrc71yX658kSR7TZ4rJCuB9qgAeeAF+Nr5PXov7nety/ZMkyX0dFoHnnCsaz/3eZ9zKZ+b2mRjHzbEK4IEX4Gfj++S1uN+5Ltc/SZLcl0XhKecKxXO/9xm38pm5fSbGcXOsAniRF+JH43zz2tz/XJbrnSRJHotF4SnnCsVzv/cZt/KZuX0mxnFzrAJ4kRfkR+N889rc/1yW650kSR6LReEl+IxbcR6X4DNSAbzMC/Kjcb55be5/Lsv1TpIkj8WC7xJ8xq04j0vwGakAXuYF+dE437w29z+X5XonSZLHYsF3CT7jVpzHJfiMVABv5oX51pxP9s38yDaub5IkSZ5bBfBGXphvzflk38yPbOP6JkmS5LlVAG/khfnWnE/2zfzINq5vkiRJnlsF8EZemG/N+WTfzI9s4/omSZLkuVUAX5gX6EvzeckW5ter8/2TJEmyLxXAF+aF+9J8XrKF+fXqfP8kSZLsSwXwhXnhvjSfl2xhfr063z9JkiT7UgF8YV64L83nJVuYX6/O90+SJMm+VADfmBdyGZ/ck/n56Jx/kiRJcqgC+Ma8sMv45J7Mz0fn/JMkSZJDFcA35oVdxif3ZH4+OuefJEmSHKoAvjEv7DI+uSfz89E5/yRJkuRQBXCSJEmSZBcqgJMkSZIku1ABnCRJkiTZhQrgJEmSJMkuVAAnSZIkSXahAjhJkiRJsgsVwEmSJEmSXagATpIkSZLsQgVwkiRJkmQXKoCTJEmSJLtQAZwkSZIk2YUK4CRJkiTJLlQAJ0mSJEl2oQI4SZIkSbILFcBJkiRJkl2oAE6SJEmS7EIFcJIkSZJkFyqAkyRJkiS7UAGcJEmSJNmFCuAkSZIkyS5UACcv6he//t2XL7//1ZdfnGhLnsaf/erL77/87stv/uxEW3IPv/zLL1++/OWXX/r7JMlT2F0B/LUo+P2v//Td75Pn8hdf/mq4gK0WwD/E//TzV7983/7N14JkYdzkh4Lht3/x/vefybsK4DyaCuDs0nzv+B6//O2Zsz+5ogrg5Cld54voq/HLqAI4qz4ogN+MeZckuaPr3Ds6+3MP31cA//An8m8/xx+Gwz/Nt/1rkh/9fOISfTze4d8C/OmX3/z+d19+8+uvfxL703BHhe3XD+rPP28frh8L4F/93HZ0Kfs65vs+b3P/q18fvPdwmcsLu2H+Hz/rMCd//CL6zbfnHX42DnL/xDMO53HqD4NOfxkdf55OjZud+OFvvw5/fs69o/w/zJEfCuBf/Xy+nsifU3n3c676N8B/8eWvfv+rL785255cw+Ed4fjs/yF/f/vjZ+PbHeMtz3/5l8f3jhP5nzy+6d5x2HZwnvMHoN/O+nffJV9/Dj9Xh/eOzvhc1ncUwPwJ0NcEfjvMf7isv7X9+EVx9AH4duh/HeM7kvnob55++iL69qE6nBfPPvDjBe3t2cfzOL6AvW/7ef4/Fd+r888LuG3+nyoKfp7Hz/n/Q177hzIn/qb2+F9AnP6cvH8mcSfGzV68Pxe/5dNRjpOTP1x0zvT7yfu8e3PqvP0x/9/GOJn/ydXwPXB4R/iW6wcxn8j/5PEdn7vv7zUHbYf3hHMF8Jn/+0ec+0f3q2S79QL41J/YXLEAePe8zxShH1zQ3xcAh8WwP+eK4+yW+fj154r5//Y3au8vSycKcQuAd5+D43/h8PZjXr/Ldcfx/86OnC+A3/3PSz64AL37v0/l3TenzvpP5H9yNacL4B/y91suUgAP+Z88PvP+8P+27cD3FMD867cff86Mn3yH7yuAzx7cFJGHcSTz+wv9KT+Od/pvnk5dik7FHfu4AD7/4Tr5Ac3+3DT/f/a+EP5EAfDuc/DBZ+bAu1x3HP/v7Ah/iHKQBysF8LvYU3l39Ezz9hP5n1zN+/vCSgHcv1jIcyLvj+4C7z8T33xvAdw9I1e0XgD/kOReRn7ywSXk1IVndvysrx+ST/0NsIXzgfMF8PHfZujkBzQ7dMv8x9H4nygATnyBfObi9T7XD9/5pwKoL6Z9OpFT33zNwYO2H87rt1w7yk/+dcRBvL/7Od7P3CfyP7ma95f9zxfAp/M/eXzHeX98n3j/mfjm8Lvh6//7xH9j5/39qM9Jrus7CuCfE/jbXwIc/a0UP28fjhP/nOF9wr/39jdfX39++I9QfaoAfv+8tw/RRwXwu/lzmeuDmB/cLP/9J8vm6pkC4MSzvHz9/PPzGD8ULEc/Pz/v58/h77785pcfFEF5cebP+3Py1O/Pf2Y+yrsTz/qWrx/kf3I1J874n/J8LIAPu4xnf/KIzt+R353JRw7O8p/+44VH9+mjOwt/w/zt9/3HZ3NZ31cAn/Hub7l+SN4fk/ldAcnfFiTPrvzPy3tXaB7+64AkJ7373CRJ7umiBfC7P605vBjxJ6Bvf8rz/k//337O/UlS8qDK/7y8938D1r+MSQYVwEnyUC5bACdJkiRJ8qAqgJMkSZIku1ABnCRJkiTZhQrgJEmSJMkuVAAnSZIkSXahAjhJkiRJsgsVwEmSJEmSXagATpIkSZLsQgVwkiRJkmQXKoCTJEmSJLtQAZwkSZIk2YUK4CRJkiTJLlQAJ0mSJEl2oQI4SZIkSbILFcBJkiRJkl24ewH8d/7238qOmQ9743pkX8yHJEmSXFcFcO7KfNgb1yP7Yj4kSZLkuiqAc1fmw964HtkX8yFJkiTXVQGcuzIf9sb1yL6YD0mSJLmuCuBc1T/6k39wxHbzYW9cjz/6wz/4kPG39mjzeXbmQ5IkSa6rAjhXVQH8MdfDAlPG39qjzefZmQ9JkiS5rgrgXFUF8MdcDwtMGX9rjzafZ2c+JEmS5LoqgHNVFcAfcz0sMGX8rT3afJ6d+ZAkSZLrqgDOXZkPe+N6PBoLXhmv1fhb8w9oVue7Gi/zIUmSJNdVAZy7Mh/2xvV4NBZ4Ml6r8bdWAZwkSbIvFcC5K/Nhb1yPR2OBJ+O1Gn9rFcBJkiT7UgGcuzIf9sb1eDQWeDJeq/G3VgGcJEmyLxXAG3mBtv3a7v38rcyHvXE9ns2l82+1oFyN1737mw9JkiS5rgrgjS5dAKy69/O3Mh/2xvV4NpfOv9WCcjVe9+5vPiRJkuS6KoA3unQBsOrez9/KfNgb1+PZXDr/VgvK1Xjdu7/5kCRJkuuqAN7o0gXAqns/fyvzYW9cj2dz6fxbLShX43Xv/uZDkiRJrqsC+MVcuiC5NvNhb1yPVY+231NBOLWvuvR4t2Y+JEmS5LoqgF/MoxVEE/Nhb1yPVY+231NBOrWvuvR4t2Y+JEmS5LoqgF/MoxVEE/Nhb1yPVY+231NBOrWvuvR4t2Y+JEmS5LoqgF/MoxVEE/Nhb1yPVY+231NBOrWvuvR4t2Y+JEmS5LoqgHNX5sPeuB579+gF7fQHDs5fxpsPSZIkua4K4NyV+bA3rsfeTQXjvVUAJ0mSPLcK4NyV+bA3rsfeTQXjvVUAJ0mSPLcK4NyV+bA3rsfeTQXjvVUAJ0mSPLcK4NyV+bA3rkfWTAXmra3Ox3xIkiTJdVUA567Mh71xPbJmteC8ttX5mA9JkiS5rgrg3JX5sDeuR9asFpzXtjof8yFJkiTXVQGcuzIf9sb1yJrVgvPaVudjPiRJkuS6KoAfzPQf2Xk15sPeuB4WUDJ+7269Ppd+nvmQJEmS66oAfjAVwPvielhgyfi9u/X6XPp55kOSJEmuqwL4wVQA74vrYYEl4/fu1utz6eeZD0mSJLmuCuAHUwG8L66HBZaM37tbr8+ln2c+JEmS5LoqgHNX5sPeuB6P5tIF31aPNh+tzs98SJIkyXVVAOeuzIe9cT0ezWpBd22PNh+tzs98SJIkyXVVAOeuzIe9cT0ezWpBd22PNh+tzs98SJIkyXVVAOeuzIe9cT0ezWpBd22PNh+tzs98SJIkyXVVAOeuzIe9cT2ezWrBtxq/yvH9j8rJ/lv5fNtlPuS23A8Z/+x8Pxmf1+b+y/hn5/vJ+CSvqwI4d2U+7I3r8WxWC77V+FWOb8Er+2/l822X+ZDbcj9k/LPz/WR8Xpv7L+Ofne8n45O8rgrg3JX5sDeux7NZLfhW41c5vgWv7L+Vz7dd5kNuy/2Q8c/O95PxeW3uv4x/dr6fjE/yuiqAc1fmw964Hs9mteBbjV/l+Ba8sv9WPt92mQ+5LfdDxj8730/G57W5/zL+2fl+Mj7J66oAzl2ZD3vjeqxaLbhu7dHnN7n2/M2H3Jb78S/+2T8+Yvuz+/Nf/NMjtrs+eW3u/7/+V//yiO3PbvoDUNcnyeuqAM5dmQ9743qsunaBttWjz29y7fmbD7kt96MC+P0a5XW5/xXA79coyWuqAM5dmQ9743qsunaBttWjz29y7fmbD7kt96MC+P0a5XW5/xXA79coyWuqAM5dmQ9743qsunaBttWjz29y7fmbD7kt96MC+P0a5XW5/xXA79coyWt6uQL4v/67f3zE9jwW82FvXI/JVJBN7ZPV/qvx2tr/3rbO33zIbbkf8sL87CqAc8j99zwzf57dVOC7PkleVwVw7sp82BvXY+IFZbV9stp/NV5b+9/b1vmbD7kt90NeoJ9dBXAOuf+eZ+bPs6sATvKmAjh3ZT7sjesx8YKy2j5Z7b8ar639723r/M2H3Jb7IS/Qz64COIfcf88z8+fZVQAneVMBnLsyH/bG9Zh4QVltn6z2X43X1v73tnX+5kNuy/2QF+hnVwGcQ+6/55n58+wqgJO8ebkCOM/FfNgb12OVFxYZP1ntvxqfY+ZDbsv98MIs/4DV9okFqO2a4qd2P5/G+/6uT16b+2/+mC9T/k/tjme7pvipvfxPck4FcO7KfNgb12OVX/AyfrLafzU+x8yH3Jb74QVa0wV/4gXcdk3xU7ufT+N9f9cnr839N3/Mlyn/p3bHs11T/NRe/ic5pwI4d2U+7I3rscoveBk/We2/Gp9j5kNuy/3wAq3pgj/xAm67pvip3c+n8b6/65PX5v6bP+bLlP9Tu+PZril+ai//k5xTAZy7Mh/2xvVY5Re8jJ+s9l+NzzHzIbflfniB1nTBn3gBt11T/NTu59N439/1yWtz/80f82XK/6nd8WzXFD+1l/9JzqkAzhG/QGT8VubD3rgeW/mFv9q+yvE0xa+2r5rG29q+lfmQ63L93V/POy/Mq+2a4m3fWlD4vvL9bXf98tzcX/ff/Jnya2rXFG+7+e/8/Y9aOZ7tju/7O77rl+R1VADniF8gMn4r82FvXI+tpi/0qX2V42mKX21fNY23tX0r8yHX5fq7v553XphX2zXF224BMMXb7vvK97fd9ctzc3/df/Nnyq+pXVO87ea/87fAdTzbHd/3d3zXL8nrqADOEb9AZPxW5sPeuB5bTV/oU/sqx9MUv9q+ahpva/tW5kOuy/V3fz3vvDCvtmuKt90CYIq33feV72+765fn5v66/+bPlF9Tu6Z4281/52+B63i2O77v7/iuX5LXUQGcI36ByPitzIe9cT22mr7Qp/ZVjqcpfrV91TTe1vatzIdcl+vv/nreeWFebdcUb7sFwBRvu+8r39921y/Pzf11/82fKb+mdk3xtpv/zt8C1/Fsd3zf3/FdvySvowIY04GYyzIf9sb12Gpr/trfC4Xx9+Z8bX905kMuy/X2Amx+e2H2Am6845mP9tfqeHI8rb6P7a7fKvcjt+V+mF/u/2q+OJ75OZnGcz6+z7/4Z//4iO0Tn+/8jJfrneR5VABj9QDMNubD3rgeW23NX/t7QTD+3pyv7Y/OfMhlud5esM1vL9xbCwD7a3U8OZ5W38d212+V+5Hbcj/ML/d/NV8cz/ycTOM5H9+nAjjJ96oAxuoBmG3Mh71xPbbamr/294Jg/L05X9sfnfmQy3K9vWCb3164txYA9tfqeHI8rb6P7a7fKvcjt+V+mF/u/2q+OJ75OZnGcz6+TwVwku9VAYzVAzDbmA9743pstTV/7e8Fwfh7c762PzrzIZflenvBNr+9cG8tAOyv1fHkeFp9H9tdv1XuR27L/TC/3P/VfHE883Myjed8fJ8K4CTfqwL4xXig2/5ozIe9cT2e3eoFYiufJ+MvbevzzIescT01XeC9YHsBn+L/5O//vSPGT+Npmu80nvmoaXxN7+d6y/3KZbnecv/dP/N5yi/jp3yaxnO+qxxPxk/rscrx5X4leRwVwC9m9YC+N/Nhb1yPZ+cFw/ZL83ky/tK2Ps98yBrXU9MF3Qv9dGE3fioQp/E0zXcaz3zUNL6m93O95X7lslxvuf/un/k85ZfxUz5N4znfVY4n46f1WOX4cr+SPI4K4BezekDfm/mwN67Hs/OCYful+TwZf2lbn2c+ZI3rqemC7oV+urAbPxWI03ia5juNZz5qGl/T+7necr9yWa633H/3z3ye8sv4KZ+m8ZzvKseT8dN6rHJ8uV9JHkcF8ItZPaDvzXzYG9fj2XnBsP3SfJ6Mv7StzzMfssb11HRB90I/XdiNnwrEaTxN853GMx81ja/p/VxvuV+5LNdb7r/7Zz5P+WX8lE/TeM53lePJ+Gk9Vjm+3K8kj6MCOHdlPuyN63FtXgBsn0z9p/YcMx9yzPWSF+zVC7mM9z+yY7z5brvzmeJt1xTv84yX/X1/Ge9+uH/ZxvWV++l+yQLW/v6Bh+2OZz4Ybz7a3/fx86apv/O3Xc7fduc/xcv9TPI4KoBzV+bD3rge17b6Ba6p/9SeY+ZDjrleWr1wGy/jvYAbb77b7nymeNs1xfs842V/31/Gux/uX7ZxfeV+ul+qAD7m/G13/lO83M8kj6MCOHdlPuyN63Ftq1/gmvpP7TlmPuSY66XVC7fxMt4LuPHmu+3OZ4q3XVO8zzNe9vf9Zbz74f5lG9dX7qf7pQrgY87fduc/xcv9TPI4KoBzV+bD3rge17b6Ba6p/9SeY+ZDjrleWr1wGy/jvYAbb77b7nymeNs1xfs842V/31/Gux/uX7ZxfeV+ul+qAD7m/G13/lO83M8kj6MC+MqmA3vvzIe9cT2ubfULfNWlx9863tb+12Y+5GOunxduTRd+z2fZ33atjj/F2+6FfIp3vWT/1Xb3J9fl+rvf5quMd39lf9s1jT8VtPb3fY233fEdT8b7+XJ8uT9JnkcF8JVNB/bemQ9743pc27ULwkuPv3W8rf2vzXzIx1w/L7TyAm+757Psb7tWx5/ibfeCPsW7XrL/arv7k+ty/d1v81XGu7+yv+2axrfgtN3+vq/xtju+48l4P1+OL/cnyfOoAL6y6cDeO/Nhb1yPa7t2QXjp8beOt7X/tZkP+Zjr54VWXuBt93yW/W3X6vhTvO1e0Kd410v2X213f3Jdrr/7bb7KePdX9rdd0/gWnLbb3/c13nbHdzwZ7+fL8eX+JHkeFcBXNh3Ye2c+7I3rcW3XLggvPf7W8bb2vzbzIR9z/bzQygu87Z7Psr/tWh1/irfdC/oU73rJ/qvt7k+uy/V3v81XGe/+yv62axrfgtN2+/u+xtvu+I4n4/18Ob7cnyTP4+UK4OmAvLVHv4Dr1utnPuyN6zExn3Tr/ZPzsf3Sbv28SzMfssb11Op/FGfiBdp2Ge+Fe4r382y7pvHl+LbL9c9tuR+TS+e/BfE0/mp+Op79jV8dz/ap//T94v4keR4VwFc2HaCP5tbrZz7sjesxMZ906/2T87H90m79vEszH7LG9dR0AV41Xchl/HThNt7Ps+2axpfj2y7XP7flfkwunf8VwMft7k+S51EBfGXTAfpobr1+5sPeuB4T80m33j85H9sv7dbPuzTzIWtcT00X4FXThVzGTxdu4/08265pfDm+7XL9c1vux+TS+V8BfNzu/iR5HhXAVzYdoI/m1utnPuyN6zExn3Tr/ZPzsf3Sbv28SzMfssb11HQBXjVdyGX8dOE23s+z7ZrGl+PbLtc/t+V+TC6d/xXAx+3uT5Ln8XIFcJ6L+bA3rsdk+kK+ttXnGz+Z+ntht93+1+bzZbzMh1yW6+0FfpXjecE2fmJ/xzd+td3x/fxYAMjxXN88NvfPfFnleOaX8ZMp34yX8do6P8dzfZM8rwrg3JX5sDeux2S1wLq01ecbP5n6e4G33f7X5vNlvMyHXJbr7QV3leNtvWDb3/GNX213fD8/FiByPNc3j839M19WOZ75ZfxkyjfjZby2zs/xXN8kz6sCOHdlPuyN6zFZLbAubfX5xk+m/l7gbbf/tfl8GS/zIZflenvBXeV4Wy/Y9nd841fbHd/PjwWIHM/1zWNz/8yXVY5nfhk/mfLNeBmvrfNzPNc3yfOqAM5dmQ9743pMVgusS1t9vvGTqb8XeNvtf20+X8bLfMhlud5ecFc53tYLtv0d3/jVdsf382MBIsdzffPY3D/zZZXjmV/GT6Z8M17Ga+v8HM/1TfK8KoCfjBcY25+N+bA3rocsqHTpeNu3cvyJ/c33KX6ra48v8yGX5Xp74V516fHkhd32VdN4tk/57/rmsbl/7v+qS4+n//rv/vER21eZ3xa48v3k+iZ5XhXAT8aCwPZnYz7sjeshL6S6dLztWzn+xP7m+xS/1bXHl/mQy3K9vSCvuvR48sJu+6ppPNun/Hd989jcP/d/1aXHUwVwklupAH4yFgS2PxvzYW9cD3kh1aXjbd/K8Sf2N9+n+K2uPb7Mh1yW6+0FedWlx5MXdttXTePZPuW/65vH5v65/6suPZ4qgJPcSgXwk7EgsP3ZmA9743rIC6kuHW/7Vo4/sb/5PsVvde3xZT7kslxvL8irLj2evLDbvmoaz/Yp/13fPDb3z/1fdenxVAGc5FYqgHNX5sPeuB6aLqRb2+/N+cn4VdN4W9u3Mh9yWa73v/13/+ZDXqBtl39A44Xb/DHe5xlv+3/+T//hQ17o7e/8ZH/Xz/XNY3P/3N8p36b+xptP9p/y3/ipXdP8bLe/8ba7vkmeVwVw7sp82BvXQ15QLt1+b85Pxq+axtvavpX5kMtyvS1g5QXYdnmhtwAwf4z3ecbbbsErL/j2d36yv+vn+uaxuX/u75RvU3/jzSf7T/lv/NSuaX622994213fJM+rAjh3ZT7sjeshLyiXbr835yfjV03jbW3fynzIZbneFrDyAmy7vNBbAJg/xvs842234JUXfPs7P9nf9XN989jcP/d3yrepv/Hmk/2n/Dd+atc0P9vtb7ztrm+S51UBnLsyH/bG9ZAXlEu335vzk/GrpvG2tm9lPuSyXG8LWHkBtl1e6C0AzB/jfZ7xtlvwygu+/Z2f7O/6ub55bO6f+zvl29TfePPJ/lP+Gz+1a5qf7fY33nbXN8nzergC2APZ9rwW82FvXI8p/6f2ydR/apfxMl7GT+x/bdd+vvmQy3K9LWAtIL0A225/473gmz/Ga/qPADmfv/k//vcj0/wsACxYbHf9XN88NvfP/LDdfLHd/sab//Y3XlO87TJ/V/tPXN8kz6sCOHdlPuyN6zHl/9Q+mfpP7TJexsv4if2v7drPNx9yWa63F3gLSi/MttvfeAsA88d4VQDnktw/88N288V2+xtv/tvfeE3xtsv8Xe0/cX2TPK8K4NyV+bA3rseU/1P7ZOo/tct4GS/jJ/a/tms/33zIZbneXuAtKL0w225/4y0AzB/jVQGcS3L/zA/bzRfb7W+8+W9/4zXF2y7zd7X/xPVN8rwqgHNX5sPeuB5T/k/tk6n/1C7jZbyMn9j/2q79fPMhl+V6e4G3oPTCbLv9jbcAMH+MVwVwLsn9Mz9sN19st7/x5r/9jdcUb7vM39X+E9c3yfN6uAL41Xkhsv3Spi+kezMf9sb1mJg/Mv7R3Hu+l/48+D4yXuZDLsv1ni7wk6m/+WU+GC8LYMeT/af5WSBYAPt818/1zWNz/6b8mEz9zSefb7ymeNtlfttfU3/bXd8kz6sC+Ma8ENl+aV6YbL8382FvXI+J+SPjH82953vpz4PvI+NlPuSyXO/pAj+Z+ptf5oPxsgB1PNl/mp8XfAsWn+/6ub55bO7flB+Tqb/55PON1xRvu8xv+2vqb7vrm+R5VQDfmBci2y/NC5Pt92Y+7I3rMTF/ZPyjufd8L/158H1kvMyHXJbrPV3gJ1N/88t8MF4WoI4n+0/z84JvweLzXT/XN4/N/ZvyYzL1N598vvGa4m2X+W1/Tf1td32TPK8K4BvzQmT7pXlhsv3ezIe9cT0m5o+MfzT3nu+lPw++j4yX+ZDLcr2nC/xk6m9+mQ/GywLU8WT/aX5e8C1YfL7r5/rmsbl/U35Mpv7mk883XlO87TK/7a+pv+2ub5LnVQGcuzIf9sb18MJ86Xatxq9yfE3xtk/sryne9mszH3JZrrcXeC+8E/t7obZANb+Ml/E+f9U0vgWL8a6f65vH5v6Zv+aLjJf5Yv77fONlvM9zfpNpfONlvOub5HlVAOeuzIe9cT28oF66XavxqxxfU7ztE/trirf92syHXJbrvfVCbX8v2BYA5pfxMt7nr5rGrwB+be6f+Wu+yHiZL+a/zzdexvs85zeZxjdexru+SZ5XBXDuynzYG9fDC+ql27Uav8rxNcXbPrG/pnjbr818yGW53lsv1Pb3gm0BYH4ZL+N9/qpp/Arg1+b+mb/mi4yX+WL++3zjZbzPc36TaXzjZbzrm+R5VQDnrsyHvXE9vKBeul2r8ascX1O87RP7a4q3/drMh1yW6731Qm1/L9gWAOaX8TLe56+axq8Afm3un/lrvsh4mS/mv883Xsb7POc3mcY3Xsa7vkmeVwVwlkz/kZRV5sPeuB4TL7Cr7aumC41Wn2+8jNdq/GR1vNV4mQ+5LNfbgk9egG2XF+ytPF8tAOR8bXf8aT1sl+ubx+b+ud8yf8xH482vrZyv85n8+S/+6RHH97y23efL9U3yvCqAs8QvRNtXmQ9743pM/AJfbV9VAfw+Zku8zIdcluvtBV4WlLbLC/RWnq9e8OV8bXf8aT1sl+ubx+b+ud8yf8xH482vrZyv85lUACf5rArgLPEL0fZV5sPeuB4Tv8BX21dVAL+P2RIv8yGX5Xp7gZcFpe3yAr2V56sXfDlf2x1/Wg/b5frmsbl/7rfMH/PRePNrK+frfCYVwEk+qwI4S/xCtH2V+bA3rsfEL/DV9lUVwO9jtsTLfMhlud5e4GVBabu8QG/l+eoFX87Xdsef1sN2ub55bO6f+y3zx3w03vzayvk6n0kFcJLPqgDOXZkPe+N6TPwC39o+sf+qS4+31aPNx3zIZbneW1lweoFe5fia4p3Partcvzw393cr83Erx9dqvFb7u35JXlcFcO7KfNgb12MyFXCr7RP7r7r0eFs92nzMh1yW672VBaUX7FWOryne+ay2y/XLc3N/tzIft3J8rcZrtb/rl+R1VQDnrsyHvXE9JlMBt9o+sf+qS4+31aPNx3zIZbneW1lQesFe5fia4p3Partcvzw393cr83Erx9dqvFb7u35JXlcFcO7KfNgb12MyFXCr7RP7r7r0eFs92nzMh1yW672VBaUX7FWOryne+ay2y/XLc3N/tzIft3J8rcZrtb/rl+R1VQDnrsyHvXE9JlMBN7VPpv62a4q3Xavx9zbNd2o3H/LY3L+tHF9T/Nb2ZIX5tJXjazVeW/sneV0VwLkr82FvXI/JVFBN7ZOpv+2a4m3Xavy9TfOd2s2HPDb3byvH1xS/tT1ZYT5t5fhajdfW/kleVwVw7sp82BvXYzIVVFP7ZOpvu6Z427Uaf2/TfKd28yGPzf3byvE1xW9tT1aYT1s5vlbjtbV/ktdVAZy7Mh/2xvWYTAXV1D6Z+tuuKd52rcbf2zTfqd18yGNz/7ZyfE3xW9uTFebTVo6v1Xht7Z/kdT1dAfyP/uQfHLE9z8V82BvXY2L+W2CtcnzbNcXbPpn6T+2rHE/GX5v5kCRJkuuqAM5dmQ9743pMzH8LuFWOb7umeNsnU/+pfZXjyfhrMx+SJElyXRXAuSvzYW9cj4n5bwG3yvFt1xRv+2TqP7WvcjwZf23mQ5IkSa6rAjh3ZT7sjesxMf8t4FY5vu2a4m2fTP2n9lWOJ+OvzXxIkiTJdT1dAfzsvHBb0Bj/6syHvXE9VplPtms1Xvaf2P/S+T49b7Vdxq+axjMfkiRJcl0VwDfmhfjSBcGzMR/2xvVYZT7ZrtV42X9i/0vn+/S81XYZv2oaz3xIkiTJdVUA35gX4ksXBM/GfNgb12OV+WS7VuNl/4n9L53v0/NW22X8qmk88yFJkiTXVQF8Y16IL10QPBvzYW9cj1Xmk+1ajZf9J/a/dL5Pz1ttl/GrpvHMhyRJklxXBfDg0hf2W3v0+ZsPe+N6TAXTZOpv+yrHk/EyXsZP7D/Z+nmYnj+1y3xIkiTJdVUAD7ZemO/t0edvPuyN67FaQGnqb/sqx5PxMl7GT+w/2fp5mJ4/tct8SJIkyXVVAA+2Xpjv7dHnbz7sjeuxWkBp6m/7KseT8TJexk/sP9n6eZieP7XLfEiSJMl1VQAPtl6Y7+3R528+7I3rsVpAaepv+yrHk/EyXsZP7D/Z+nmYnj+1y3xIkiTJdVUA567Mh71xPbIv5kOSJEmuqwI4d2U+7I3rkX0xH5IkSXJdFcC5K/Nhb1yP7Iv5kCRJkuuqAM5dmQ9743pkX8yHJEmSXNfdC+AkSZIkSW6hAjhJkiRJsgsVwEmSJEmSXagATpIkSZLsQgVwkiRJkmQXKoCTJEmSJLtQAZwkSZIk2YUK4CRJkiTJLlQAJ0mSJEl2oQI4SZIkSbILFcBJkiRJkl2oAE6SJEmS7EIFcJIkSZJkFyqAkyRJkiS7UAGcJEmSJNmFCuAkSZIkyS5UACdJkiRJdqECOEmSJEmyCxXASZIkSZJdqABOkiRJkuxCBXCSJEmSZBcqgJMkSZIku1ABnCRJkiTZhQrgJEmSJMkuVAAnSZIkSXahAjhJkiRJsgsVwEmSJEmSXagATpIkSZLsQgVwkiRJkmQXKoCTJEmSJLtQAZwkSZIk2YUK4CRJkiTJLlQAJ0mSJEl2oQI4SZIkSbILFcBJkiRJkl2oAE6SJEmS7EIFcJIkSZJkFyqAk1fzZ7/68vvf/+rLL/x9stlffPmrL3/55Zfvfp/swRPk/8XP/z/98pvf/+7Lb/7M3yfJ86oATl7NxS9AyZsnKACSq3mC/L/4+V8BnOT1fF8B/Mu//HL883Y4/vjl8Jtf/+5by1/98q3f17aDn9/+xcGYx22///Wf/tz29TA/aPt5vI98PbAPB7zkl0F279Hz/6cL0G9++9brwS9seSLm+PHF+BcHuX907n79zBzk/C9/e/6zcZT/R21dwnNvT5D/H53/P8zjVwf3o8PvhuN5/Dy/4wL469yP+h19R/H7s89Kkvv6jgL46yF5fBj+fGD/eIB++78/+JPIwy+Ar18ax4f+6bjv9dH4yZonyP+fLiSH4x8X3Mn3+umS/FM+HeXW18v1Qb6/aztTAJzPf/7m6Ye87hKde3qC/P/o/P/hD29/HvPnZ//4lwbHRflb3M/z+GGso++0H/9A4KjAfmtnHsfflUlyX1cogM8d0Pyt7OGfML79jdqJS/rbn6iuHpw//inlzz+r/ZPTniD/Lbz9v5PvduLCe1AMHOXpYd59UACczX/+9cOPP+c+X8ktPEH+e95/MI+fvf/u+nmOB99dfo+8zf3w57AA5g8Elr7HkuSKvqMA/uifF78/RN/4J4cn/2br3BfBaiHwwzg/z6ODN5fzBPnvBejspSdZdYUC4HCsw/w3j5O7e4L8t9/hs89+F7z/7jougH/35Te/Pr5XfTze+3m8W58kuaP1AtjD9cj7Q/TN0T/D+elPNt99AUzjf3TYGvdtjB//yVIHby7io/x8lPxnjP7pWS7nfAFwfO7+9K9wTrX9dNGf899/lpnc2xPk/0fn/9nvEJ71w3fU+38C/ePcD7/jjv9F1EfzqABO8kjWC2D/Buzrz1GxeboAeCtE3+K//gca3g5b/7nyzwe+zzpz0L5z2O/H/2BFB28uw5x8wPz/qcD+9nPywpN8jw8KAHP56A9yjv8Z5efyv1zOo3mC/P+oz9kC+H2/4++h4//d8NF30U8F/dvPt7tWBXCSB7ZeAL87QD/4E8Dk1ZT/SZIkydNaL4AP/ybrp5/lf6Kz2fs5fPs596ebyUW8z73yP0lyG53/SbLVdxTASZIkSZI8nwrgJEmSJMkuVAAnSZIkSXahAjhJkiRJsgsVwEmSJEmSXfj/AxnbQ75y2dZlAAAAAElFTkSuQmCC

codex
축소본에서 도깨비의 노란 눈이 약해지고 풀밭 두 장의 무늬 밀도가 달라진 부분을 확인했습니다. 눈 색과 풀밭의 명암을 보정하고, 정상 집과 부서진 집의 창 밝기도 구분하겠습니다.

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Add-Type -AssemblyName System.Drawing
foreach($f in @('"'enemy/goblin.png','enemy/brute.png','nest/creature_spear_fire.png','field/house.png','field/house_broken.png')){
"'$b=[System.Drawing.Bitmap]::new((Join-Path (Get-Location) ('"'assets/sprites/'+"'$f))); Write-Output $f
$cs=@{};for($y=0;$y -lt $b.Height;$y++){ $line='"'';for("'$x=0;$x -lt $b.Width;$x++){ $p=$b.GetPixel($x,$y);$s='"'.';if("'$p.A -gt 0){$h='"'{0:X2}{1:X2}{2:X2}' -f "'$p.R,$p.G,$p.B;if(-not $cs.ContainsKey($h)){$cs[$h]=[char](65+$cs.Count)};$s=$cs[$h]};$line+=$s};Write-Output ('"'{0:D2} {1}' -f "'$y,$line)}; $cs.GetEnumerator() | Sort-Object Value | ForEach-Object {Write-Output "$($_.Value)=$($_.Key)"};$b.Dispose()
}' in C:\Users\pc\Documents\game
 succeeded in 462ms:
enemy/goblin.png
00 ................................
01 ................................
02 ................................
03 ............AA..................
04 ............AA.AA..A............
05 ...........ABAAACAAAAA..........
06 ...........ADACACABAA...........
07 .........AAEAECCAADCCAA.........
08 .........AAACCACCCCCACAAA.......
09 .........AEACAAACACCAAACA.......
10 ........ACCAAAEAEAAACCAAA.......
11 .........AAAAEAAEACAEAAAA.......
12 .........ACAAEAFEAACEAAACA......
13 .........AAAEGAECAAEAACAA.......
14 ......AA..ADAEHGEAAAAAAAA.......
15 .....AIJA.ABEEIEEAAACEAAA.......
16 .....AHHA.AAAAAGGAEAACA.........
17 .....AJHA.AAEEEEEAEEEECA........
18 ......AHJA.ACACEECCAEEEA........
19 .......AJA.AEEEEEEEEAECEA.......
20 ........AAAGAEECEEEDAECCA.......
21 ........AEAGDDDAADIIAAECA.......
22 ........AEEADDIIDDAEAEEA........
23 .........AAIGADDIDGEAECA........
24 ...........AEAADDAEEEAA.........
25 ...........AEEAAA.AEA...........
26 ...........AEA....AEEA..........
27 ..........AAAAA...AAAAA.........
28 ................................
29 ................................
30 ................................
31 ................................
A=282322
B=DDDCD0
C=29333F
D=929187
E=6A7E88
F=D9CC73
G=3D5261
H=494039
I=706258
J=302C2A
enemy/brute.png
00 ................................................
01 ................................................
02 ................................................
03 ................................................
04 .................................A...AAA........
05 ................................ABAAABCA........
06 .................A..AA..........AABBBBBBA.......
07 ................AA..AA.AA....AAABBBBBACBA.......
08 ................ADAADEAFA...ACABCBBBBBBBBA......
09 ................AFFCEECFAAAABABBBABABCBBCA......
10 ...............AFFFFFAFFFFBBBBBCBBCCCCCBA.......
11 ..............AFACGFAFFAAFFFABBBCCACCCBA........
12 ...............AGAGAFAHGAFAABCACAACAAACA........
13 ...............AAIGGFGGAFFFAFCAAAAA...A.........
14 ..............AGBGGAFGAFAFFFAA..................
15 ...........AAABAADGFFAFAFFAAAFAA................
16 .........AAGGCBAGGGFFAFAAFFFFAAA.A..............
17 ........AGGGGCAFAHFAAAFFFAAFBBAAAA..............
18 .......AGAHAGA.AFFAHHFAAFAFAFFFGFA..............
19 .....AABAHAGGAAAAAHHGFAACGFFGFFGFA..............
20 .....ABAAGGGAGFFGGGAGAGGCGGFGFHGFA..............
21 .....AA.AAGGFFGAGGGGGGGGGGGFFGGFFGA.............
22 .......AGGGGAFGGGGFGGGGFGGFFFFFFGFGA............
23 .......AGGGGFAGGGFGAFGGGGFAGGGFFFFFA............
24 .......AFGGGFFAFGGGGGGAFAFFGGGGFFGGA............
25 .......AFFGFAFGGFGGGGHGGGFFGGGGGGGFGA...........
26 .......AFFFFFAGGGGGGGGGFGGFAGGGGGFFFA...........
27 ........AAAAAGGGGGGGGGGGFGFFAAGGFFGGGA..........
28 .............AGGGGGGGGGGGGFFA.AGFFGFGA..........
29 .............AGGGAGGGGGGFFJJA.AGFFGGFA..........
30 ............AJHGGGGGGGGGJJAAA.AGGGGGFA..........
31 ............AKAJAHGGAAJJJGFFA..AGGGFA...........
32 ...........AKAJJBJJJJJBJJAFFFAAGGGGGA...........
33 ...........AFFJCBJJJGBGJJFHGFAGGGGGGA...........
34 ...........AGFAJJJJJJJBJJFFFGAGGGGGGA...........
35 ..........AHFFFJJBJJJBJAFFGFGFAGGGAA............
36 ..........AHFGFJAJBJJBJFFFGGFA.AAAAA............
37 ..........AFGGFFFJJJJJJFGGFFFFA.................
38 ...........AFHHHAAAJJJAAGGGGFGA.................
39 ...........AGGHGA.AJKA..AFFGGGA.................
40 ...........AGGGFA..AA....AFGGGA.................
41 ...........AGGFA...A......AGGGA.................
42 .........AAAGAGA..........AGAAGA................
43 .........AAAAAAA..........AAAAAAA...............
44 ................................................
45 ................................................
46 ................................................
47 ................................................
A=282322
B=494039
C=302C2A
D=DDDCD0
E=B9BAAD
F=29333F
G=6A7E88
H=3D5261
I=D9CC73
J=929187
K=706258
nest/creature_spear_fire.png
00 ................................
01 ................................
02 ................................
03 ................................
04 ................................
05 ................................
06 ................................
07 ................................
08 ................................
09 .................A..............
10 ................AA..............
11 ................ABAA............
12 .....AAAAA......ACCCA...........
13 ....ACCCAAA......ACBCA..........
14 ...ACCDA..A..A..ACBBBAAA........
15 ...ADDA..AA.ACA.ABBADEDDAA......
16 ...ADA......ACCAABADDDDDDDA.....
17 ...ADA...AA..ABCCCDDDDDADDDA....
18 ...ACA....AA..ABBBDDDDDBAADDA...
19 ...ADDAA.ABCAABADDADDDDBAADDA...
20 ....ADFDABAACADDGDDDHHDDDDAA....
21 ....ADCDDDDCDDGGFDDDIIHHHHAA....
22 ....AGDCJCCDBDDGDGDDDHHAAA......
23 .....AHDDDDCBDDDDDDDHHA.........
24 ......AAGDDDDDDDADDHHA..........
25 ........ADDAAHAADDAAIDA.........
26 ........ADA.AA.ADDA.ADDA........
27 .......AAA..AAA.AAA..AAA........
28 ................................
29 ................................
30 ................................
31 ................................
A=282322
B=A84438
C=CD6851
D=4D4942
E=B9BAAD
F=494039
G=706258
H=929187
I=3A3733
J=67332E
field/house.png
00 ................................
01 ................................
02 ................................
03 ................................
04 ................................
05 ................................
06 ................................
07 ................................
08 ................................
09 ........AA.............AA.......
10 ........ABAAAAAAAAAAAAACA.......
11 ........AADDDDDDDDDDDDDCA.......
12 ........ADDEDDDCDDCDCDFCA.......
13 .......AFDCDCDDCDCEDCDAAFA......
14 ......ACDGEDCFEEDCFFEEGEDEAAAA..
15 ....AAEDGCDGHDCDDEDCDFFEDDHDAA..
16 ..AACEDCCDBCFCEFCFFCFECCFDDFA...
17 ...ACCGCDDGDDCDDCDCEDCAADADA....
18 ....AAHAAAACAACBACDCCBAADAA.....
19 ......AGGGGAHGGGHAGAGAHDBBA.....
20 ......ABBBBABBBBBHBBBBHBHFA.....
21 ......AIIBIIDHFDBFBJJGBHHGA.....
22 ......AIJBJIBDFBBEBJKIBGHGA.....
23 ......AIBBBIBDFBBEDDBIBGHEA.....
24 ......AIGGGIBDFBBFGGGGBFHBA.....
25 ......AHHGHHBBBBBEIIGIBAHAA.....
26 ......AAAAAGBBBBAABAGAGAA.......
27 ...........AAAAA..A.A.A.........
28 ................................
29 ................................
30 ................................
31 ................................
A=282322
B=706258
C=67645C
D=4D4942
E=3A3733
F=302C2A
G=929187
H=494039
I=B9BAAD
J=DDDCD0
K=F2F1E7
field/house_broken.png
00 ................................
01 ................................
02 ................................
03 ................................
04 ................................
05 ................................
06 ................................
07 ................................
08 ................................
09 ........AA.............AA.......
10 ........ABAAAAAAAAAAAAACA.......
11 ........ADCCCCCCCCCCCCCBA.......
12 ........ACEFCFCECCECECDEA.......
13 .......ADCECECCECEFABCBEDA......
14 ......AECBFCEDDDCEBAGAAACDAA....
15 ....AADCBECBFCECAAAACCADCCCCAA..
16 ..AAECCBEHECDEFCAGGCAHAADAFDAA..
17 ...AEBBECCBCCECGCEACAGEEGFAA....
18 ...AAAHAAAABHAEGAHEAGAHAGADA....
19 ......ABBBBAHBBBGABBAAHBBBA.....
20 ......AGGGGAGGGGGFGGGGHBBAA.....
21 ......ABDGABGHACGAGAABGBAGA.....
22 ......AIAGAIGCAGGAGAABGAAAA.....
23 ......AIGGGIGHAGGAGAABGGABA.....
24 ......AIBBIIGCAGGAIBBBGABBA.....
25 ......AHHIFHGGGGGAIIIEGDGAA.....
26 ......AAAAAGGGGGAAGAAAGAA.......
27 ...........AAAAA..A...A.........
28 ................................
29 ................................
30 ................................
31 ................................
A=282322
B=929187
C=4D4942
D=302C2A
E=67645C
F=3A3733
G=706258
H=494039
I=B9BAAD

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Add-Type -AssemblyName System.Drawing
Add-Type -ReferencedAssemblies System.Drawing -TypeDefinition @'

using System;
using System.Drawing;
using System.Drawing.Imaging;
using System.Collections.Generic;
public class SpriteClean {
 public static Color C(string s){return Color.FromArgb(255,Convert.ToInt32(s.Substring(0,2),16),Convert.ToInt32(s.Substring(2,2),16),Convert.ToInt32(s.Substring(4,2),16));}
 public static Color[] Palette(string kind) {
 string s=\"282322 302C2A 3A3733 494039 4D4942 67645C 706258 929187 B9BAAD DDDCD0 F2F1E7\";
 if(kind==\"fire\")s+=\" 67332E A84438 CD6851\";
 if(kind==\"water\")s+=\" 304B42 466F59 6B9878 A6C5A3\";
 if(kind==\"enemy\")s=\"282322 29333F 3D5261 6A7E88 302C2A 494039 706258 929187 B9BAAD DDDCD0 D9CC73\";
 if(kind==\"imp\")s=\"29333F 3D5261 6A7E88 91ADBE C1D8E5 D9CC73\";
 if(kind==\"egg\")s=\"CECECE DADADA E6E6E6 F2F2F2 FFFFFF\";
 if(kind==\"grass\")s=\"282322 302C2A 3A3733 4D4942 304B42\";
 var list=new List<Color>();foreach(string h in s.Split(' '))list.Add(C(h));return list.ToArray();
 }
 public static Color Match(Color c,Color[] p){Color best=p[0];double bd=1e20;foreach(var q in p){double d=(c.R-q.R)*(c.R-q.R)+(c.G-q.G)*(c.G-q.G)+(c.B-q.B)*(c.B-q.B);if(d<bd){bd=d;best=q;}}return best;}
 public static void Make(string src,string dst,int w,int h,int mw,int mh,string kind){
 using(var b=new Bitmap(src))using(var o=new Bitmap(w,h,PixelFormat.Format32bppArgb)){
 int x0=b.Width,y0=b.Height,x1=-1,y1=-1;
 for(int y=0;y<b.Height;y++)for(int x=0;x<b.Width;x++){if(b.GetPixel(x,y).A>=128){x0=Math.Min(x0,x);x1=Math.Max(x1,x);y0=Math.Min(y0,y);y1=Math.Max(y1,y);}}
 if(x1<0)throw new Exception(\"Empty source\");
 bool tile=kind==\"grass\";
 if(tile){int side=Math.Min(768,Math.Min(b.Width,b.Height));x0=(b.Width-side)/2;y0=(b.Height-side)/2;x1=x0+side-1;y1=y0+side-1;}
 double scale=Math.Min((double)mw/(x1-x0+1),(double)mh/(y1-y0+1));
 int dw=Math.Max(1,(int)Math.Round((x1-x0+1)*scale)),dh=Math.Max(1,(int)Math.Round((y1-y0+1)*scale));
 int ox=(w-dw)/2,oy=tile?0:h-4-dh;
 var palette=Palette(kind);
 for(int y=0;y<dh;y++)for(int x=0;x<dw;x++){
 int sx=x0+Math.Min(x1-x0,(int)((x+0.5)*(x1-x0+1)/dw)),sy=y0+Math.Min(y1-y0,(int)((y+0.5)*(y1-y0+1)/dh));
 Color c=b.GetPixel(sx,sy);
 if(c.A>=128||tile){
 Color q=Match(c,palette);
 if(tile)q=(c.G>c.R+2 && c.G>c.B+4 && c.G>55)?(c.G>72?C(\"4D4942\"):C(\"3A3733\")):C(\"282322\");
 if(kind==\"enemy\"||kind==\"imp\"){
 int ny=0;
 for(int v=0;v<8;v++)for(int u=0;u<8;u++){
 int ax=x0+Math.Min(x1-x0,(int)((x+(u+.5)/8)*(x1-x0+1)/dw));
 int ay=y0+Math.Min(y1-y0,(int)((y+(v+.5)/8)*(y1-y0+1)/dh));
 Color t=b.GetPixel(ax,ay);
 if(t.A>=128 && t.R>120 && t.G>110 && t.B<t.R*.7 && t.B<t.G*.8)ny++;
 }
 if(ny>=5)q=C(\"D9CC73\");
 }
 o.SetPixel(ox+x,oy+y,q);
 }
 }
 if(tile){for(int i=0;i<w;i++){o.SetPixel(i,0,palette[0]);o.SetPixel(i,h-1,palette[0]);o.SetPixel(0,i,palette[0]);o.SetPixel(w-1,i,palette[0]);}}
 else{
 using(var copy=(Bitmap)o.Clone())for(int y=0;y<h;y++)for(int x=0;x<w;x++)if(copy.GetPixel(x,y).A>0){
 bool edge=x==0||y==0||x==w-1||y==h-1||copy.GetPixel(Math.Max(0,x-1),y).A==0||copy.GetPixel(Math.Min(w-1,x+1),y).A==0||copy.GetPixel(x,Math.Max(0,y-1)).A==0||copy.GetPixel(x,Math.Min(h-1,y+1)).A==0;
 if(edge)o.SetPixel(x,y,palette[0]);
 }
 }
 System.IO.Directory.CreateDirectory(System.IO.Path.GetDirectoryName(dst));
 o.Save(dst,ImageFormat.Png);
 }
 }
}
'@
"'$rows=@'"'
goblin|enemy/goblin.png|32|32|26|25|enemy|C:\\Users\\pc\\.codex\\generated_images\\01a21bc7-8db6-71f2-ae4d-11b30cdf36e1\\exec-276f8f03-7b1a-4108-9029-41397576481f.png
imp|enemy/imp.png|32|32|23|25|imp|C:\\Users\\pc\\.codex\\generated_images\\01a21bc7-8db6-71f2-ae4d-11b30cdf36e1\\exec-1b1adda8-d854-4bfa-a404-c4b18765499d.png
brute|enemy/brute.png|48|48|40|40|enemy|C:\\Users\\pc\\.codex\\generated_images\\01a21bc7-8db6-71f2-ae4d-11b30cdf36e1\\exec-50cf57d0-7d41-4108-9ace-61c2935b9221.png
grassa|field/grass_a.png|32|32|32|32|grass|C:\\Users\\pc\\.codex\\generated_images\\01a21bc7-8db6-71f2-ae4d-11b30cdf36e1\\exec-1489156f-69b2-43b7-bdd7-4854ae5151b1.png
grassb|field/grass_b.png|32|32|32|32|grass|C:\\Users\\pc\\.codex\\generated_images\\01a21bc7-8db6-71f2-ae4d-11b30cdf36e1\\exec-7f4fc3fb-34d4-4461-8604-bbb60e4415b5.png
'@
foreach("'$line in $rows.Trim().Split([char]10)){$a=$line.Trim().Split('"'|');[SpriteClean]::Make("'$a[7],(Join-Path (Get-Location) ('"'assets/sprites/'+"'$a[1])),[int]$a[2],[int]$a[3],[int]$a[4],[int]$a[5],$a[6])}
$p=Join-Path (Get-Location) '"'assets/sprites/nest/creature_spear_fire.png'
"'$b=[System.Drawing.Bitmap]::new($p);$o=[System.Drawing.Bitmap]::new($b);$b.Dispose();$o.SetPixel(23,17,[SpriteClean]::C('"'F2F1E7'));"'$o.Save($p,[System.Drawing.Imaging.ImageFormat]::Png);$o.Dispose()
Write-Output '"'Updated eye color retention and grass sampling; restored salamander eye highlight.'" in C:\Users\pc\Documents\game
 succeeded in 2267ms:
Updated eye color retention and grass sampling; restored salamander eye highlight.

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Add-Type -AssemblyName System.Drawing
$files=@'"'
nest/creature_spear_fire.png
nest/creature_spear_water.png
nest/creature_spear_earth.png
nest/creature_archer_fire.png
nest/creature_archer_water.png
nest/creature_archer_earth.png
nest/creature_shield_fire.png
nest/creature_shield_water.png
nest/creature_shield_earth.png
nest/egg_spear.png
nest/egg_archer.png
nest/egg_shield.png
enemy/goblin.png
enemy/imp.png
enemy/brute.png
field/grass_a.png
field/grass_b.png
field/house.png
field/house_broken.png
'@
"'$sheet=[System.Drawing.Bitmap]::new(960,760)
$g=[System.Drawing.Graphics]::FromImage($sheet)
$g.Clear([System.Drawing.Color]::FromArgb(58,56,53))
$font=[System.Drawing.Font]::new('"'Consolas',9)
"'$i=0
foreach($f in $files.Trim().Split([char]10)){
$b=[System.Drawing.Bitmap]::new((Join-Path (Get-Location) ('"'assets/sprites/'+"'$f.Trim())))
$cx=($i%5)*192;$cy=[int][Math]::Floor($i/5)*190;$s=4;if($b.Width -gt 32){$s=3}
$ox=$cx+[int]((192-$b.Width*$s)/2);$oy=$cy+10
for($y=0;$y -lt $b.Height;$y++){for($x=0;$x -lt $b.Width;$x++){$p=$b.GetPixel($x,$y);if($p.A -gt 0){$brush=[System.Drawing.SolidBrush]::new($p);$g.FillRectangle($brush,($ox+$x*$s),($oy+$y*$s),$s,$s);$brush.Dispose()}}}
$label=[System.IO.Path]::GetFileNameWithoutExtension($f.Trim()).Replace('"'creature_','')
"'$g.DrawString($label,$font,[System.Drawing.Brushes]::White,($cx+10),($cy+172));$b.Dispose();$i++
}
$g.Dispose();$font.Dispose();$ms=[System.IO.MemoryStream]::new();$sheet.Save($ms,[System.Drawing.Imaging.ImageFormat]::Png);[Convert]::ToBase64String($ms.ToArray());$ms.Dispose();$sheet.Dispose()' in C:\Users\pc\Documents\game
 succeeded in 1637ms:
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

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Add-Type -AssemblyName System.Drawing
Add-Type -ReferencedAssemblies System.Drawing -TypeDefinition @'

using System;
using System.Drawing;
using System.Drawing.Imaging;
using System.Collections.Generic;
public class SpriteClean {
 public static Color C(string s){return Color.FromArgb(255,Convert.ToInt32(s.Substring(0,2),16),Convert.ToInt32(s.Substring(2,2),16),Convert.ToInt32(s.Substring(4,2),16));}
 public static Color[] Palette(string kind) {
 string s=\"282322 302C2A 3A3733 494039 4D4942 67645C 706258 929187 B9BAAD DDDCD0 F2F1E7\";
 if(kind==\"fire\")s+=\" 67332E A84438 CD6851\";
 if(kind==\"water\")s+=\" 304B42 466F59 6B9878 A6C5A3\";
 if(kind==\"enemy\")s=\"282322 29333F 3D5261 6A7E88 302C2A 494039 706258 929187 B9BAAD DDDCD0 D9CC73\";
 if(kind==\"imp\")s=\"29333F 3D5261 6A7E88 91ADBE C1D8E5 D9CC73\";
 if(kind==\"egg\")s=\"CECECE DADADA E6E6E6 F2F2F2 FFFFFF\";
 if(kind==\"grass\")s=\"282322 302C2A 3A3733 4D4942 304B42\";
 var list=new List<Color>();foreach(string h in s.Split(' '))list.Add(C(h));return list.ToArray();
 }
 public static Color Match(Color c,Color[] p){Color best=p[0];double bd=1e20;foreach(var q in p){double d=(c.R-q.R)*(c.R-q.R)+(c.G-q.G)*(c.G-q.G)+(c.B-q.B)*(c.B-q.B);if(d<bd){bd=d;best=q;}}return best;}
 public static void Make(string src,string dst,int w,int h,int mw,int mh,string kind){
 using(var b=new Bitmap(src))using(var o=new Bitmap(w,h,PixelFormat.Format32bppArgb)){
 int x0=b.Width,y0=b.Height,x1=-1,y1=-1;
 for(int y=0;y<b.Height;y++)for(int x=0;x<b.Width;x++){if(b.GetPixel(x,y).A>=128){x0=Math.Min(x0,x);x1=Math.Max(x1,x);y0=Math.Min(y0,y);y1=Math.Max(y1,y);}}
 if(x1<0)throw new Exception(\"Empty source\");
 bool tile=kind==\"grass\";
 if(tile){int side=Math.Min(768,Math.Min(b.Width,b.Height));x0=(b.Width-side)/2;y0=(b.Height-side)/2;x1=x0+side-1;y1=y0+side-1;}
 double scale=Math.Min((double)mw/(x1-x0+1),(double)mh/(y1-y0+1));
 int dw=Math.Max(1,(int)Math.Round((x1-x0+1)*scale)),dh=Math.Max(1,(int)Math.Round((y1-y0+1)*scale));
 int ox=(w-dw)/2,oy=tile?0:h-4-dh;
 var palette=Palette(kind);
 for(int y=0;y<dh;y++)for(int x=0;x<dw;x++){
 int sx=x0+Math.Min(x1-x0,(int)((x+0.5)*(x1-x0+1)/dw)),sy=y0+Math.Min(y1-y0,(int)((y+0.5)*(y1-y0+1)/dh));
 Color c=b.GetPixel(sx,sy);
 if(c.A>=128||tile){
 Color q=Match(c,palette);
 if(tile){
 int green=0,light=0;
 for(int v=0;v<8;v++)for(int u=0;u<8;u++){
 int ax=x0+Math.Min(x1-x0,(int)((x+(u+.5)/8)*(x1-x0+1)/dw));
 int ay=y0+Math.Min(y1-y0,(int)((y+(v+.5)/8)*(y1-y0+1)/dh));
 Color t=b.GetPixel(ax,ay);
 if(t.G>t.R && t.G>t.B+4 && t.G>50){green++;light+=t.G;}
 }
 q=green>=5?(light/green>72?C(\"4D4942\"):C(\"3A3733\")):C(\"282322\");
 }
 if(kind==\"enemy\"||kind==\"imp\"){
 int ny=0;
 for(int v=0;v<8;v++)for(int u=0;u<8;u++){
 int ax=x0+Math.Min(x1-x0,(int)((x+(u+.5)/8)*(x1-x0+1)/dw));
 int ay=y0+Math.Min(y1-y0,(int)((y+(v+.5)/8)*(y1-y0+1)/dh));
 Color t=b.GetPixel(ax,ay);
 if(t.A>=128 && t.R>120 && t.G>110 && t.B<t.R*.7 && t.B<t.G*.8)ny++;
 }
 if(ny>=5)q=C(\"D9CC73\");
 }
 o.SetPixel(ox+x,oy+y,q);
 }
 }
 if(tile){for(int i=0;i<w;i++){o.SetPixel(i,0,palette[0]);o.SetPixel(i,h-1,palette[0]);o.SetPixel(0,i,palette[0]);o.SetPixel(w-1,i,palette[0]);}}
 else{
 using(var copy=(Bitmap)o.Clone())for(int y=0;y<h;y++)for(int x=0;x<w;x++)if(copy.GetPixel(x,y).A>0){
 bool edge=x==0||y==0||x==w-1||y==h-1||copy.GetPixel(Math.Max(0,x-1),y).A==0||copy.GetPixel(Math.Min(w-1,x+1),y).A==0||copy.GetPixel(x,Math.Max(0,y-1)).A==0||copy.GetPixel(x,Math.Min(h-1,y+1)).A==0;
 if(edge)o.SetPixel(x,y,palette[0]);
 }
 }
 System.IO.Directory.CreateDirectory(System.IO.Path.GetDirectoryName(dst));
 o.Save(dst,ImageFormat.Png);
 }
 }
}
'@
"'$rows=@'"'
grassa|field/grass_a.png|32|32|32|32|grass|C:\\Users\\pc\\.codex\\generated_images\\01a21bc7-8db6-71f2-ae4d-11b30cdf36e1\\exec-1489156f-69b2-43b7-bdd7-4854ae5151b1.png
grassb|field/grass_b.png|32|32|32|32|grass|C:\\Users\\pc\\.codex\\generated_images\\01a21bc7-8db6-71f2-ae4d-11b30cdf36e1\\exec-7f4fc3fb-34d4-4461-8604-bbb60e4415b5.png
'@
foreach("'$line in $rows.Trim().Split([char]10)){$a=$line.Trim().Split('"'|');[SpriteClean]::Make("'$a[7],(Join-Path (Get-Location) ('"'assets/sprites/'+"'$a[1])),[int]$a[2],[int]$a[3],[int]$a[4],[int]$a[5],$a[6])}
$p=Join-Path (Get-Location) '"'assets/sprites/field/house_broken.png'
"'$b=[System.Drawing.Bitmap]::new($p);$o=[System.Drawing.Bitmap]::new($b);$b.Dispose()
for($y=0;$y -lt 32;$y++){for($x=0;$x -lt 32;$x++){$c=$o.GetPixel($x,$y);if($c.ToArgb() -eq [SpriteClean]::C('"'929187').ToArgb()){"'$o.SetPixel($x,$y,[SpriteClean]::C('"'67645C'))}elseif("'$c.ToArgb() -eq [SpriteClean]::C('"'B9BAAD').ToArgb()){"'$o.SetPixel($x,$y,[SpriteClean]::C('"'929187'))}}}
foreach("'$x in @(8,9,10,19,20,21)){foreach($y in @(21,22)){$o.SetPixel($x,$y,[SpriteClean]::C('"'282322'))}}
"'$o.Save($p,[System.Drawing.Imaging.ImageFormat]::Png);$o.Dispose()
Write-Output '"'Grass detail retained; broken-house window interiors darkened.'" in C:\Users\pc\Documents\game
 succeeded in 1379ms:
Grass detail retained; broken-house window interiors darkened.

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Add-Type -AssemblyName System.Drawing
$files=@'"'
nest/creature_spear_fire.png
nest/creature_spear_water.png
nest/creature_spear_earth.png
nest/creature_archer_fire.png
nest/creature_archer_water.png
nest/creature_archer_earth.png
nest/creature_shield_fire.png
nest/creature_shield_water.png
nest/creature_shield_earth.png
nest/egg_spear.png
nest/egg_archer.png
nest/egg_shield.png
enemy/goblin.png
enemy/imp.png
enemy/brute.png
field/grass_a.png
field/grass_b.png
field/house.png
field/house_broken.png
'@
"'$sheet=[System.Drawing.Bitmap]::new(960,760)
$g=[System.Drawing.Graphics]::FromImage($sheet)
$g.Clear([System.Drawing.Color]::FromArgb(58,56,53))
$font=[System.Drawing.Font]::new('"'Consolas',9)
"'$i=0
foreach($f in $files.Trim().Split([char]10)){
$b=[System.Drawing.Bitmap]::new((Join-Path (Get-Location) ('"'assets/sprites/'+"'$f.Trim())))
$cx=($i%5)*192;$cy=[int][Math]::Floor($i/5)*190;$s=4;if($b.Width -gt 32){$s=3}
$ox=$cx+[int]((192-$b.Width*$s)/2);$oy=$cy+10
for($y=0;$y -lt $b.Height;$y++){for($x=0;$x -lt $b.Width;$x++){$p=$b.GetPixel($x,$y);if($p.A -gt 0){$brush=[System.Drawing.SolidBrush]::new($p);$g.FillRectangle($brush,($ox+$x*$s),($oy+$y*$s),$s,$s);$brush.Dispose()}}}
$label=[System.IO.Path]::GetFileNameWithoutExtension($f.Trim()).Replace('"'creature_','')
"'$g.DrawString($label,$font,[System.Drawing.Brushes]::White,($cx+10),($cy+172));$b.Dispose();$i++
}
$g.Dispose();$font.Dispose();$ms=[System.IO.MemoryStream]::new();$sheet.Save($ms,[System.Drawing.Imaging.ImageFormat]::Png);[Convert]::ToBase64String($ms.ToArray());$ms.Dispose();$sheet.Dispose()' in C:\Users\pc\Documents\game
 succeeded in 1765ms:
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

codex
19장 축소본을 나란히 열어 확인했고, 부서진 집의 꺼진 창도 보정했습니다. 마지막으로 파일 크기·색 수·투명도와 풀밭 타일의 반복 경계를 확인하겠습니다. 저장소 검사와 게임 화면 확인은 지시서대로 Claude에게 넘깁니다.

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Add-Type -AssemblyName System.Drawing
$rows=@'"'
salamander|nest/creature_spear_fire.png|32|32|26|24|fire
otter|nest/creature_spear_water.png|32|32|26|24|water
hedgehog|nest/creature_spear_earth.png|32|32|26|24|earth
bat|nest/creature_archer_fire.png|32|32|26|24|fire
jellyfish|nest/creature_archer_water.png|32|32|26|24|water
monkey|nest/creature_archer_earth.png|32|32|26|24|earth
toad|nest/creature_shield_fire.png|32|32|26|24|fire
shellturtle|nest/creature_shield_water.png|32|32|26|24|water
rockturtle|nest/creature_shield_earth.png|32|32|26|24|earth
eggspear|nest/egg_spear.png|32|40|24|30|egg
eggarcher|nest/egg_archer.png|32|40|18|30|egg
eggshield|nest/egg_shield.png|32|40|27|26|egg
goblin|enemy/goblin.png|32|32|26|25|enemy
imp|enemy/imp.png|32|32|23|25|imp
brute|enemy/brute.png|48|48|40|40|enemy
grassa|field/grass_a.png|32|32|32|32|grass
grassb|field/grass_b.png|32|32|32|32|grass
house|field/house.png|32|32|28|25|house
housebroken|field/house_broken.png|32|32|28|25|house
'@
"'$fail=@()
foreach($line in $rows.Trim().Split([char]10)){
$a=$line.Trim().Split('"'|');"'$p=Join-Path (Get-Location) ('"'assets/sprites/'+"'$a[1]);$b=[System.Drawing.Bitmap]::new($p);$colors=@{};$partial=0;$clear=0;$bottom=-1;$gray=$true;$edge=$true
for($y=0;$y -lt $b.Height;$y++){for($x=0;$x -lt $b.Width;$x++){$c=$b.GetPixel($x,$y);$colors[$c.ToArgb()]=1;if($c.A -eq 0){$clear++}else{$bottom=[Math]::Max($bottom,$y);if($c.A -ne 255){$partial++};if($a[6] -eq '"'egg' -and ("'$c.R -ne $c.G -or $c.G -ne $c.B -or $c.R -lt 200)){$gray=$false}};if($a[6] -eq '"'grass' -and ("'$x -eq 0 -or $y -eq 0 -or $x -eq 31 -or $y -eq 31) -and ($c.R -ne 40 -or $c.G -ne 35 -or $c.B -ne 34)){$edge=$false}}}
$ok=$b.Width -eq [int]$a[2] -and $b.Height -eq [int]$a[3] -and $colors.Count -le 24 -and $partial -eq 0 -and $gray -and $edge
if($a[6] -eq '"'grass'){"'$ok=$ok -and $clear -eq 0}else{$ok=$ok -and $clear -gt 0 -and ($b.Height-1-$bottom) -ge 3 -and ($b.Height-1-$bottom) -le 5}
if(-not $ok){$fail+=$a[1]}
Write-Output (('"'{0} | {1}x{2} | colors incl transparent={3} | partial alpha={4} | transparent pixels={5} | bottom gap={6} | OK={7}') -f "'$a[1],$b.Width,$b.Height,$colors.Count,$partial,$clear,($b.Height-1-$bottom),$ok);$b.Dispose()
}
if($fail.Count){throw ($fail -join '"',')}
Write-Output 'All 19 PNG checks passed; both grass tile borders match exactly.'" in C:\Users\pc\Documents\game
 succeeded in 510ms:
nest/creature_spear_fire.png | 32x32 | colors incl transparent=12 | partial alpha=0 | transparent pixels=734 | bottom gap=4 | OK=True
nest/creature_spear_water.png | 32x32 | colors incl transparent=12 | partial alpha=0 | transparent pixels=752 | bottom gap=4 | OK=True
nest/creature_spear_earth.png | 32x32 | colors incl transparent=10 | partial alpha=0 | transparent pixels=652 | bottom gap=4 | OK=True
nest/creature_archer_fire.png | 32x32 | colors incl transparent=13 | partial alpha=0 | transparent pixels=782 | bottom gap=4 | OK=True
nest/creature_archer_water.png | 32x32 | colors incl transparent=10 | partial alpha=0 | transparent pixels=682 | bottom gap=4 | OK=True
nest/creature_archer_earth.png | 32x32 | colors incl transparent=10 | partial alpha=0 | transparent pixels=660 | bottom gap=4 | OK=True
nest/creature_shield_fire.png | 32x32 | colors incl transparent=11 | partial alpha=0 | transparent pixels=627 | bottom gap=4 | OK=True
nest/creature_shield_water.png | 32x32 | colors incl transparent=11 | partial alpha=0 | transparent pixels=642 | bottom gap=4 | OK=True
nest/creature_shield_earth.png | 32x32 | colors incl transparent=10 | partial alpha=0 | transparent pixels=588 | bottom gap=4 | OK=True
nest/egg_spear.png | 32x40 | colors incl transparent=6 | partial alpha=0 | transparent pixels=813 | bottom gap=4 | OK=True
nest/egg_archer.png | 32x40 | colors incl transparent=5 | partial alpha=0 | transparent pixels=930 | bottom gap=4 | OK=True
nest/egg_shield.png | 32x40 | colors incl transparent=6 | partial alpha=0 | transparent pixels=784 | bottom gap=4 | OK=True
enemy/goblin.png | 32x32 | colors incl transparent=11 | partial alpha=0 | transparent pixels=676 | bottom gap=4 | OK=True
enemy/imp.png | 32x32 | colors incl transparent=7 | partial alpha=0 | transparent pixels=714 | bottom gap=4 | OK=True
enemy/brute.png | 48x48 | colors incl transparent=12 | partial alpha=0 | transparent pixels=1403 | bottom gap=4 | OK=True
field/grass_a.png | 32x32 | colors incl transparent=3 | partial alpha=0 | transparent pixels=0 | bottom gap=0 | OK=True
field/grass_b.png | 32x32 | colors incl transparent=2 | partial alpha=0 | transparent pixels=0 | bottom gap=0 | OK=True
field/house.png | 32x32 | colors incl transparent=12 | partial alpha=0 | transparent pixels=651 | bottom gap=4 | OK=True
field/house_broken.png | 32x32 | colors incl transparent=9 | partial alpha=0 | transparent pixels=651 | bottom gap=4 | OK=True
All 19 PNG checks passed; both grass tile borders match exactly.

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'git status --porcelain' in C:\Users\pc\Documents\game
 succeeded in 110ms:
 M assets/fonts/Galmuri11-Bold.ttf.import
 M assets/fonts/Galmuri11.ttf.import
 M project.godot
 M reports/boss/history.csv
 M "work/2026-11-27-\352\267\270\353\246\274/NOTES.md"
?? assets/sprites/enemy/
?? assets/sprites/field/
?? assets/sprites/kiln/kiln_body.png.import
?? assets/sprites/kiln/soldier_archer_earth.png.import
?? assets/sprites/kiln/soldier_archer_fire.png.import
?? assets/sprites/kiln/soldier_archer_water.png.import
?? assets/sprites/kiln/soldier_shield_earth.png.import
?? assets/sprites/kiln/soldier_shield_fire.png.import
?? assets/sprites/kiln/soldier_shield_water.png.import
?? assets/sprites/kiln/soldier_spear_earth.png.import
?? assets/sprites/kiln/soldier_spear_fire.png.import
?? assets/sprites/kiln/soldier_spear_water.png.import
?? assets/sprites/nest/
?? reports/boss/history-local-backup.csv
?? src/game/glow_layer.gd.uid
?? "work/2026-11-27-\352\267\270\353\246\274/handoff-03.report.md"
?? "work/2026-11-27-\352\267\270\353\246\274/screens-02b/"

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Add-Type -AssemblyName System.Drawing
$a=[System.Drawing.Bitmap]::new((Join-Path (Get-Location) '"'assets/sprites/field/grass_a.png'))
"'$b=[System.Drawing.Bitmap]::new((Join-Path (Get-Location) '"'assets/sprites/field/grass_b.png'))
"'$o=[System.Drawing.Bitmap]::new(256,256)
for($y=0;$y -lt 256;$y++){for($x=0;$x -lt 256;$x++){$tx=[int][Math]::Floor($x/2);$ty=[int][Math]::Floor($y/2);$choose=([int][Math]::Floor($tx/32)+[int][Math]::Floor($ty/32))%2;$src=$a;if($choose -eq 1){$src=$b};$o.SetPixel($x,$y,$src.GetPixel(($tx%32),($ty%32)))}}
$ms=[System.IO.MemoryStream]::new();$o.Save($ms,[System.Drawing.Imaging.ImageFormat]::Png);[Convert]::ToBase64String($ms.ToArray());$o.Dispose();$a.Dispose();$b.Dispose();$ms.Dispose()' in C:\Users\pc\Documents\game
 succeeded in 629ms:
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

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'git ls-files --others --exclude-standard assets/sprites/nest assets/sprites/enemy assets/sprites/field' in C:\Users\pc\Documents\game
 succeeded in 98ms:
assets/sprites/enemy/brute.png
assets/sprites/enemy/goblin.png
assets/sprites/enemy/imp.png
assets/sprites/field/grass_a.png
assets/sprites/field/grass_b.png
assets/sprites/field/house.png
assets/sprites/field/house_broken.png
assets/sprites/nest/creature_archer_earth.png
assets/sprites/nest/creature_archer_fire.png
assets/sprites/nest/creature_archer_water.png
assets/sprites/nest/creature_shield_earth.png
assets/sprites/nest/creature_shield_fire.png
assets/sprites/nest/creature_shield_water.png
assets/sprites/nest/creature_spear_earth.png
assets/sprites/nest/creature_spear_fire.png
assets/sprites/nest/creature_spear_water.png
assets/sprites/nest/egg_archer.png
assets/sprites/nest/egg_shield.png
assets/sprites/nest/egg_spear.png

codex
결과: 통과

바뀐 파일: 지정된 PNG 19장만 새로 작성했습니다.

- [assets/sprites/nest/](/C:/Users/pc/Documents/game/assets/sprites/nest) — 괴수 9장, 알 3장
- [assets/sprites/enemy/](/C:/Users/pc/Documents/game/assets/sprites/enemy) — goblin, imp, brute 3장
- [assets/sprites/field/](/C:/Users/pc/Documents/game/assets/sprites/field) — grass_a, grass_b, house, house_broken 4장

직접 확인한 것:

- 19장 확대 비교와 풀밭 교차 반복 배치를 열어 확인했습니다.
- 지정 크기, 색 수 24개 이하, 반투명 픽셀 없음 확인했습니다.
- 바닥 타일은 불투명, 나머지는 투명 배경이며 아래 여백은 4px입니다.
- 알은 밝은 무채색이며, 풀밭 두 장의 가장자리 색이 일치합니다.

그리는 데 쓴 방법:

- **둘 다** — 내장 image_gen으로 기준 그림과 개별 설명에 맞춰 생성한 뒤, 코드로 축소·팔레트 정리·투명도·외곽선·눈 색을 보정했습니다.

못 한 것 / 걱정되는 것:

- 저장소 Python 검사와 게임 화면 확인은 지시대로 Claude에게 넘깁니다.
- 기본 PNG 규격 검사는 통과했습니다. **재미·미술 판단은 사용자 몫입니다.**
- 기존 변경은 건드리지 않았으며 커밋·푸시는 하지 않았습니다.
tokens used
116,155
결과: 통과

바뀐 파일: 지정된 PNG 19장만 새로 작성했습니다.

- [assets/sprites/nest/](/C:/Users/pc/Documents/game/assets/sprites/nest) — 괴수 9장, 알 3장
- [assets/sprites/enemy/](/C:/Users/pc/Documents/game/assets/sprites/enemy) — goblin, imp, brute 3장
- [assets/sprites/field/](/C:/Users/pc/Documents/game/assets/sprites/field) — grass_a, grass_b, house, house_broken 4장

직접 확인한 것:

- 19장 확대 비교와 풀밭 교차 반복 배치를 열어 확인했습니다.
- 지정 크기, 색 수 24개 이하, 반투명 픽셀 없음 확인했습니다.
- 바닥 타일은 불투명, 나머지는 투명 배경이며 아래 여백은 4px입니다.
- 알은 밝은 무채색이며, 풀밭 두 장의 가장자리 색이 일치합니다.

그리는 데 쓴 방법:

- **둘 다** — 내장 image_gen으로 기준 그림과 개별 설명에 맞춰 생성한 뒤, 코드로 축소·팔레트 정리·투명도·외곽선·눈 색을 보정했습니다.

못 한 것 / 걱정되는 것:

- 저장소 Python 검사와 게임 화면 확인은 지시대로 Claude에게 넘깁니다.
- 기본 PNG 규격 검사는 통과했습니다. **재미·미술 판단은 사용자 몫입니다.**
- 기존 변경은 건드리지 않았으며 커밋·푸시는 하지 않았습니다.
