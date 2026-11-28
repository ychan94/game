OpenAI Codex v0.172.0
--------
workdir: C:\Users\pc\Documents\game
model: gpt-6-astra
provider: openai
approval: never
sandbox: workspace-write [workdir, /tmp, $TMPDIR]
reasoning effort: high
reasoning summaries: none
session id: 01a21c5c-6616-7c71-9c51-7fcd7dced2cf
--------
user
# Codex 작업 지시서 — 새 병사 4종 (도끼병·기마병·무당·화차)

- 날짜: 2026-11-28
- 작업 폴더: work/2026-11-28-다듬기/
- 지시서 번호: 05

## 먼저 읽을 것
1. AGENTS.md
2. art/references/ — 정한 그림체
3. 이미 있는 병사 그림 `assets/sprites/kiln/soldier_*.png` 9장 — **이것과 한 벌로 보여야 한다** (크기·받침·광택·외곽선·유약 색을 그대로 맞춘다)
4. docs/그림-목록.md, art/sprite_list.json 의 "가마의 병사 (새 병사 4종)" 묶음
5. work/2026-11-28-다듬기/NOTES.md (왜 이 작업을 하는지)

## 목표 (사용자 말 그대로)
> "병사 뽑는 것도 그냥 랜덤 뽑기로 하는게 나을 것 같아. 병사 종류랑 갯수도 좀 더 많아야 할 것 같아."

해석(참고용): 뽑기로 나오는 병사가 3종 → 7종이 됐다. 새 4종은 지금 비슷한 병사 그림 + 코드로 그린 소품(도끼·말·방울·수레)으로 임시로 보인다. 제 그림을 넣으면 게임이 바로 그 그림을 쓴다 (코드 연결은 이미 되어 있음).
드묾(도끼병·기마병)과 귀함(무당·화차)은 뽑았을 때 반가워야 하므로 실루엣이 한눈에 달라야 한다.

## 정한 그림체 (반드시 따른다)
- 가 + 다 섞음: 형태·표정은 또렷하게, 바탕은 먹색·흙 회색조
- 병사 = 유약 바른 **도자기 인형** (매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑 받침)
- 유약 색: 청자 비취 초록(물) / 진사 구리 빨강(불) / 흑유 검은 갈색 + 기름 광택(땅)
- 금색·무지개 빛은 넣지 않는다 (요변 빛은 게임이 코드로 그린다)
- 오른쪽을 본다. 32×32, 투명 배경, 색 24개 이하, 흐림(안티에일리어싱) 없음, 외곽선 1px

## 그리는 방법 (사용자가 정한 것)
- [x] 이미지 생성 후 코드로 다듬기 (크기 맞추기·배경 투명·색 줄이기) — 사용자가 handoff-01 에서 정함 (2026-11-27)

정한 방법을 쓸 수 없으면 다른 방법으로 바꾸지 말고 `결과: 못 돌림` 으로 보고한다.

## 만들 것 (12장)

| 파일 | 크기 | 내용 |
|---|---|---|
| `assets/sprites/kiln/soldier_axe_water.png` | 32×32 | 유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(도끼병). 큰 외날 도끼를 두 손으로 든 모습. 창병보다 어깨가 넓고 투박하다. 몸 전체에 청자 유약 — 비취빛 맑은 녹색. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_axe_fire.png` | 32×32 | 유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(도끼병). 큰 외날 도끼를 두 손으로 든 모습. 창병보다 어깨가 넓고 투박하다. 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_axe_earth.png` | 32×32 | 유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(도끼병). 큰 외날 도끼를 두 손으로 든 모습. 창병보다 어깨가 넓고 투박하다. 몸 전체에 흑유 유약 — 검은 갈색에 기름 같은 광택. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_cavalry_water.png` | 32×32 | 유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(기마병). 흙으로 빚은 작은 말에 올라탄 모습, 짧은 창. 말도 같은 유약 (32×32 안에 말과 사람 모두). 몸 전체에 청자 유약 — 비취빛 맑은 녹색. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_cavalry_fire.png` | 32×32 | 유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(기마병). 흙으로 빚은 작은 말에 올라탄 모습, 짧은 창. 말도 같은 유약 (32×32 안에 말과 사람 모두). 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_cavalry_earth.png` | 32×32 | 유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(기마병). 흙으로 빚은 작은 말에 올라탄 모습, 짧은 창. 말도 같은 유약 (32×32 안에 말과 사람 모두). 몸 전체에 흑유 유약 — 검은 갈색에 기름 같은 광택. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_healer_water.png` | 32×32 | 유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(무당). 방울과 오색 천을 든 모습, 갓 대신 고깔. 무기 없음. 몸 전체에 청자 유약 — 비취빛 맑은 녹색. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_healer_fire.png` | 32×32 | 유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(무당). 방울과 오색 천을 든 모습, 갓 대신 고깔. 무기 없음. 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_healer_earth.png` | 32×32 | 유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(무당). 방울과 오색 천을 든 모습, 갓 대신 고깔. 무기 없음. 몸 전체에 흑유 유약 — 검은 갈색에 기름 같은 광택. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_cannon_water.png` | 32×32 | 유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(화차). 바퀴 달린 나무 수레(화차)에 신기전 통이 여러 개 꽂혀 있고 옆에 병사 하나. 수레 나무는 흙빛, 병사와 통 끝에 유약. 몸 전체에 청자 유약 — 비취빛 맑은 녹색. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_cannon_fire.png` | 32×32 | 유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(화차). 바퀴 달린 나무 수레(화차)에 신기전 통이 여러 개 꽂혀 있고 옆에 병사 하나. 수레 나무는 흙빛, 병사와 통 끝에 유약. 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다. |
| `assets/sprites/kiln/soldier_cannon_earth.png` | 32×32 | 유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(화차). 바퀴 달린 나무 수레(화차)에 신기전 통이 여러 개 꽂혀 있고 옆에 병사 하나. 수레 나무는 흙빛, 병사와 통 끝에 유약. 몸 전체에 흑유 유약 — 검은 갈색에 기름 같은 광택. 오른쪽을 본다. |

## 고쳐도 되는 범위
- `assets/sprites/kiln/soldier_axe_water.png` (새 파일)
- `assets/sprites/kiln/soldier_axe_fire.png` (새 파일)
- `assets/sprites/kiln/soldier_axe_earth.png` (새 파일)
- `assets/sprites/kiln/soldier_cavalry_water.png` (새 파일)
- `assets/sprites/kiln/soldier_cavalry_fire.png` (새 파일)
- `assets/sprites/kiln/soldier_cavalry_earth.png` (새 파일)
- `assets/sprites/kiln/soldier_healer_water.png` (새 파일)
- `assets/sprites/kiln/soldier_healer_fire.png` (새 파일)
- `assets/sprites/kiln/soldier_healer_earth.png` (새 파일)
- `assets/sprites/kiln/soldier_cannon_water.png` (새 파일)
- `assets/sprites/kiln/soldier_cannon_fire.png` (새 파일)
- `assets/sprites/kiln/soldier_cannon_earth.png` (새 파일)

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
- 예) 크기·투명 배경·기존 병사 9장과 나란히 놓고 비교
그리는 데 쓴 방법:
- 이미지 생성 / 코드 / 둘 다 (무엇을 어떻게)
못 한 것 / 걱정되는 것:
- …
```
- 저장소의 Python 검사를 못 돌린 것만으로는 `못 돌림`이 아니다. 검사는 Claude가 한다.

## Claude가 받은 뒤 할 일
1. `git status` — 바뀐 파일이 위 범위뿐인지
2. `python3 scripts/check_sprites.py --group "가마의 병사 (새 병사 4종)" --sheet work/2026-11-28-다듬기/sheet-05.png`
3. 게임 화면 스크린샷 (`tests/screens_proto.gd`): 준비 화면 카드·가마 열기·전투에서 직접 본다
4. `python3 scripts/test.py --stage all`
5. 사용자에게 보여 주고 "검사는 통과, 미술 판단은 사용자 몫" — 허락을 받은 뒤 커밋

warning: Codex is ignoring 1 unrecognized configuration setting. Check for typos or deprecated settings.
  user (C:\Users\pc\.codex\config.toml): `computer_use.windows.always_allowed_app_ids` is ignored.
warning: Codex is ignoring 1 unrecognized configuration setting. Check for typos or deprecated settings.
  user (C:\Users\pc\.codex\config.toml): `computer_use.windows.always_allowed_app_ids` is ignored.
codex
이미지 생성 스킬을 사용해 기존 병사와 기준 그림을 먼저 확인하겠습니다. 생성한 그림을 픽셀 단위로 다듬어 지정된 새 PNG 12장만 추가하겠습니다.

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Get-Content AGENTS.md; Get-Content PROTECTED.txt; Get-Content C:/Users/pc/.codex/skills/.system/imagegen/SKILL.md; git status --porcelain; Get-Content work/2026-11-28-다듬기/NOTES.md; Get-ChildItem art/references; Get-ChildItem assets/sprites/kiln/soldier_*.png' in C:\Users\pc\Documents\game
 succeeded in 583ms:
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
 M assets/sprites/enemy/goblin.png
 M assets/sprites/field/house.png
 M reports/boss/history.csv
 M "work/2026-11-27-\352\267\270\353\246\274/NOTES.md"
 M "work/2026-11-27-\352\267\270\353\246\274/handoff-03.md"
?? assets/sprites/enemy/brute.png
?? assets/sprites/enemy/brute.png.import
?? assets/sprites/enemy/goblin.png.import
?? assets/sprites/enemy/imp.png
?? assets/sprites/enemy/imp.png.import
?? assets/sprites/field/grass_a.png
?? assets/sprites/field/grass_a.png.import
?? assets/sprites/field/grass_b.png
?? assets/sprites/field/grass_b.png.import
?? assets/sprites/field/house.png.import
?? assets/sprites/field/house_broken.png
?? assets/sprites/field/house_broken.png.import
?? assets/sprites/nest/
?? reports/boss/history-local-backup.csv
?? src/proto/kiln_run.gd.uid
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
?? "work/2026-11-28-\353\213\244\353\223\254\352\270\260/handoff-05.report.md"
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
-a----        2026-11-27   오후 3:30            420 soldier_shield_earth.png                                             
-a----        2026-11-27   오후 3:30            435 soldier_shield_fire.png                                              
-a----        2026-11-27   오후 3:30            449 soldier_shield_water.png                                             
-a----        2026-11-27   오후 3:30            426 soldier_spear_earth.png                                              
-a----        2026-11-27   오후 3:30            407 soldier_spear_fire.png                                               
-a----        2026-11-27   오후 3:30            449 soldier_spear_water.png                                              



exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Get-Content -Encoding UTF8 PROTECTED.txt; git status --porcelain; Get-Content -Encoding UTF8 work/2026-11-28-다듬기/NOTES.md; Get-ChildItem art/references | Select-Object Name; Get-ChildItem assets/sprites/kiln/soldier_*.png | Select-Object Name; Get-Content -Encoding UTF8 C:/Users/pc/.codex/skills/.system/imagegen/SKILL.md | Select-Object -Skip 130; rg -n -A 25 '새 병사 4종' docs/그림-목록.md art/sprite_list.json" in C:\Users\pc\Documents\game
 succeeded in 604ms:
# 사용자가 직접 고친 파일 / 덮어쓰면 안 되는 파일 (한 줄에 하나, glob 가능)
# Claude·Codex는 여기 적힌 파일을 덮어쓰지 않는다. 고쳐야 하면 바꿀 내용을 제안만 한다.
art/references/*
art/rubric.md
 M assets/sprites/enemy/goblin.png
 M assets/sprites/field/house.png
 M reports/boss/history.csv
 M "work/2026-11-27-\352\267\270\353\246\274/NOTES.md"
 M "work/2026-11-27-\352\267\270\353\246\274/handoff-03.md"
?? assets/sprites/enemy/brute.png
?? assets/sprites/enemy/brute.png.import
?? assets/sprites/enemy/goblin.png.import
?? assets/sprites/enemy/imp.png
?? assets/sprites/enemy/imp.png.import
?? assets/sprites/field/grass_a.png
?? assets/sprites/field/grass_a.png.import
?? assets/sprites/field/grass_b.png
?? assets/sprites/field/grass_b.png.import
?? assets/sprites/field/house.png.import
?? assets/sprites/field/house_broken.png
?? assets/sprites/field/house_broken.png.import
?? assets/sprites/nest/
?? reports/boss/history-local-backup.csv
?? src/proto/kiln_run.gd.uid
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
?? "work/2026-11-28-\353\213\244\353\223\254\352\270\260/handoff-05.report.md"
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

docs/그림-목록.md:44:### 가마의 병사 — 새 병사 4종 (12장, 지시서 `work/2026-11-28-다듬기/handoff-05.md`)
docs/그림-목록.md-45-
docs/그림-목록.md-46-뽑기로 나오는 병사가 7종이 되면서 추가 (2026-11-28). 그림이 없으면 비슷한 병사 그림 + 코드 소품으로 임시 표시.
docs/그림-목록.md-47-
docs/그림-목록.md-48-| 파일 | 크기 | 내용 |
docs/그림-목록.md-49-|---|---|---|
docs/그림-목록.md-50-| `kiln/soldier_{axe,cavalry,healer,cannon}_{water,fire,earth}.png` | 32×32 ×12 | 도끼병(드묾) · 기마병(드묾, 흙 말에 탐) · 무당(귀함, 방울·오색 천) · 화차(귀함, 신기전 수레 + 병사). 기존 병사 9장과 한 벌 |
docs/그림-목록.md-51-
docs/그림-목록.md-52-### 알을 품는 성 (12장)
docs/그림-목록.md-53-
docs/그림-목록.md-54-| 파일 | 크기 | 내용 |
docs/그림-목록.md-55-|---|---|---|
docs/그림-목록.md-56-| `nest/creature_{spear,archer,shield}_{fire,water,earth}.png` | 32×32 ×9 | 괴수 새끼 9종: 불꽃 도마뱀·물살 수달·가시 고슴도치 / 불씨 박쥐·물방울 해파리·돌팔매 원숭이 / 용암 두꺼비·조개 거북·바위 거북. 오른쪽을 본다 |
docs/그림-목록.md-57-| `nest/egg_{spear,archer,shield}.png` | 32×40 ×3 | 뾰족 돌기 알 / 길쭉한 알 / 넓적한 알. **밝은 흰색으로만** (게임이 기운 색으로 물들임) |
docs/그림-목록.md-58-
docs/그림-목록.md-59-### 공통 (7장)
docs/그림-목록.md-60-
docs/그림-목록.md-61-| 파일 | 크기 | 내용 |
docs/그림-목록.md-62-|---|---|---|
docs/그림-목록.md-63-| `enemy/goblin.png` | 32×32 | 도깨비 — 먹빛 남색 피부, 노란 눈 (왼쪽을 본다) |
docs/그림-목록.md-64-| `enemy/imp.png` | 32×32 | 도깨비불 (푸른 불꽃 정령) |
docs/그림-목록.md-65-| `enemy/brute.png` | 48×48 | 큰 도깨비 — 같은 먹빛 남색, 방망이 |
docs/그림-목록.md-66-| `field/grass_a.png`, `grass_b.png` | 32×32 | 밤 풀밭 타일 (이어 붙여도 이음새 없이) |
docs/그림-목록.md-67-| `field/house.png`, `house_broken.png` | 32×32 | 초가집/한옥, 부서진 모습 |
docs/그림-목록.md-68-
docs/그림-목록.md-69-### 실감 (배경·이펙트) — HD-2D (지시서 `work/2026-11-27-실감/handoff-04.md`)
--
art/sprite_list.json:453:      "group": "가마의 병사 (새 병사 4종)",
art/sprite_list.json-454-      "what": "유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(도끼병). 큰 외날 도끼를 두 손으로 든 모습. 창병보다 어깨가 넓고 투박하다. 몸 전체에 청자 유약 — 비취빛 맑은 녹색. 오른쪽을 본다."
art/sprite_list.json-455-    },
art/sprite_list.json-456-    {
art/sprite_list.json-457-      "path": "assets/sprites/kiln/soldier_axe_fire.png",
art/sprite_list.json-458-      "size": [
art/sprite_list.json-459-        32,
art/sprite_list.json-460-        32
art/sprite_list.json-461-      ],
art/sprite_list.json:462:      "group": "가마의 병사 (새 병사 4종)",
art/sprite_list.json-463-      "what": "유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(도끼병). 큰 외날 도끼를 두 손으로 든 모습. 창병보다 어깨가 넓고 투박하다. 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다."
art/sprite_list.json-464-    },
art/sprite_list.json-465-    {
art/sprite_list.json-466-      "path": "assets/sprites/kiln/soldier_axe_earth.png",
art/sprite_list.json-467-      "size": [
art/sprite_list.json-468-        32,
art/sprite_list.json-469-        32
art/sprite_list.json-470-      ],
art/sprite_list.json:471:      "group": "가마의 병사 (새 병사 4종)",
art/sprite_list.json-472-      "what": "유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(도끼병). 큰 외날 도끼를 두 손으로 든 모습. 창병보다 어깨가 넓고 투박하다. 몸 전체에 흑유 유약 — 검은 갈색에 기름 같은 광택. 오른쪽을 본다."
art/sprite_list.json-473-    },
art/sprite_list.json-474-    {
art/sprite_list.json-475-      "path": "assets/sprites/kiln/soldier_cavalry_water.png",
art/sprite_list.json-476-      "size": [
art/sprite_list.json-477-        32,
art/sprite_list.json-478-        32
art/sprite_list.json-479-      ],
art/sprite_list.json:480:      "group": "가마의 병사 (새 병사 4종)",
art/sprite_list.json-481-      "what": "유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(기마병). 흙으로 빚은 작은 말에 올라탄 모습, 짧은 창. 말도 같은 유약 (32×32 안에 말과 사람 모두). 몸 전체에 청자 유약 — 비취빛 맑은 녹색. 오른쪽을 본다."
art/sprite_list.json-482-    },
art/sprite_list.json-483-    {
art/sprite_list.json-484-      "path": "assets/sprites/kiln/soldier_cavalry_fire.png",
art/sprite_list.json-485-      "size": [
art/sprite_list.json-486-        32,
art/sprite_list.json-487-        32
art/sprite_list.json-488-      ],
art/sprite_list.json:489:      "group": "가마의 병사 (새 병사 4종)",
art/sprite_list.json-490-      "what": "유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(기마병). 흙으로 빚은 작은 말에 올라탄 모습, 짧은 창. 말도 같은 유약 (32×32 안에 말과 사람 모두). 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다."
art/sprite_list.json-491-    },
art/sprite_list.json-492-    {
art/sprite_list.json-493-      "path": "assets/sprites/kiln/soldier_cavalry_earth.png",
art/sprite_list.json-494-      "size": [
art/sprite_list.json-495-        32,
art/sprite_list.json-496-        32
art/sprite_list.json-497-      ],
art/sprite_list.json:498:      "group": "가마의 병사 (새 병사 4종)",
art/sprite_list.json-499-      "what": "유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(기마병). 흙으로 빚은 작은 말에 올라탄 모습, 짧은 창. 말도 같은 유약 (32×32 안에 말과 사람 모두). 몸 전체에 흑유 유약 — 검은 갈색에 기름 같은 광택. 오른쪽을 본다."
art/sprite_list.json-500-    },
art/sprite_list.json-501-    {
art/sprite_list.json-502-      "path": "assets/sprites/kiln/soldier_healer_water.png",
art/sprite_list.json-503-      "size": [
art/sprite_list.json-504-        32,
art/sprite_list.json-505-        32
art/sprite_list.json-506-      ],
art/sprite_list.json:507:      "group": "가마의 병사 (새 병사 4종)",
art/sprite_list.json-508-      "what": "유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(무당). 방울과 오색 천을 든 모습, 갓 대신 고깔. 무기 없음. 몸 전체에 청자 유약 — 비취빛 맑은 녹색. 오른쪽을 본다."
art/sprite_list.json-509-    },
art/sprite_list.json-510-    {
art/sprite_list.json-511-      "path": "assets/sprites/kiln/soldier_healer_fire.png",
art/sprite_list.json-512-      "size": [
art/sprite_list.json-513-        32,
art/sprite_list.json-514-        32
art/sprite_list.json-515-      ],
art/sprite_list.json:516:      "group": "가마의 병사 (새 병사 4종)",
art/sprite_list.json-517-      "what": "유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(무당). 방울과 오색 천을 든 모습, 갓 대신 고깔. 무기 없음. 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다."
art/sprite_list.json-518-    },
art/sprite_list.json-519-    {
art/sprite_list.json-520-      "path": "assets/sprites/kiln/soldier_healer_earth.png",
art/sprite_list.json-521-      "size": [
art/sprite_list.json-522-        32,
art/sprite_list.json-523-        32
art/sprite_list.json-524-      ],
art/sprite_list.json:525:      "group": "가마의 병사 (새 병사 4종)",
art/sprite_list.json-526-      "what": "유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(무당). 방울과 오색 천을 든 모습, 갓 대신 고깔. 무기 없음. 몸 전체에 흑유 유약 — 검은 갈색에 기름 같은 광택. 오른쪽을 본다."
art/sprite_list.json-527-    },
art/sprite_list.json-528-    {
art/sprite_list.json-529-      "path": "assets/sprites/kiln/soldier_cannon_water.png",
art/sprite_list.json-530-      "size": [
art/sprite_list.json-531-        32,
art/sprite_list.json-532-        32
art/sprite_list.json-533-      ],
art/sprite_list.json:534:      "group": "가마의 병사 (새 병사 4종)",
art/sprite_list.json-535-      "what": "유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(화차). 바퀴 달린 나무 수레(화차)에 신기전 통이 여러 개 꽂혀 있고 옆에 병사 하나. 수레 나무는 흙빛, 병사와 통 끝에 유약. 몸 전체에 청자 유약 — 비취빛 맑은 녹색. 오른쪽을 본다."
art/sprite_list.json-536-    },
art/sprite_list.json-537-    {
art/sprite_list.json-538-      "path": "assets/sprites/kiln/soldier_cannon_fire.png",
art/sprite_list.json-539-      "size": [
art/sprite_list.json-540-        32,
art/sprite_list.json-541-        32
art/sprite_list.json-542-      ],
art/sprite_list.json:543:      "group": "가마의 병사 (새 병사 4종)",
art/sprite_list.json-544-      "what": "유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(화차). 바퀴 달린 나무 수레(화차)에 신기전 통이 여러 개 꽂혀 있고 옆에 병사 하나. 수레 나무는 흙빛, 병사와 통 끝에 유약. 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다."
art/sprite_list.json-545-    },
art/sprite_list.json-546-    {
art/sprite_list.json-547-      "path": "assets/sprites/kiln/soldier_cannon_earth.png",
art/sprite_list.json-548-      "size": [
art/sprite_list.json-549-        32,
art/sprite_list.json-550-        32
art/sprite_list.json-551-      ],
art/sprite_list.json:552:      "group": "가마의 병사 (새 병사 4종)",
art/sprite_list.json-553-      "what": "유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(화차). 바퀴 달린 나무 수레(화차)에 신기전 통이 여러 개 꽂혀 있고 옆에 병사 하나. 수레 나무는 흙빛, 병사와 통 끝에 유약. 몸 전체에 흑유 유약 — 검은 갈색에 기름 같은 광택. 오른쪽을 본다."
art/sprite_list.json-554-    }
art/sprite_list.json-555-  ],
art/sprite_list.json-556-  "정한 그림체 (2026-11-27, 사용자 승인)": [
art/sprite_list.json-557-    "기준 그림: art/references/ (= art/style/mix 시안)",
art/sprite_list.json-558-    "형태·디테일·표정은 '가'처럼 — 32×32 에서도 무엇인지 한눈에",
art/sprite_list.json-559-    "바탕은 '다'처럼 먹색·흙 회색조로 차분하게, 강한 색은 유약·기운에만 (청자 비취 초록 / 진사 구리 빨강 / 흑유 검은 갈색 + 기름 광택)",
art/sprite_list.json-560-    "금색은 요변·전설 같은 특별한 것에만",
art/sprite_list.json-561-    "병사는 유약 바른 도자기 인형 (매끈한 몸, 흰 광택, 발밑 받침)",
art/sprite_list.json-562-    "도깨비 무리는 먹빛 남색·회청색 + 노란 눈 (진사 빨강 금지)",
art/sprite_list.json-563-    "외곽선 1px 진한 먹갈색, 전체 팔레트는 기준 그림을 따른다"
art/sprite_list.json-564-  ]
art/sprite_list.json-565-}
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
soldier_archer_earth.png 
soldier_archer_fire.png  
soldier_archer_water.png 
soldier_shield_earth.png 
soldier_shield_fire.png  
soldier_shield_water.png 
soldier_spear_earth.png  
soldier_spear_fire.png   
soldier_spear_water.png  

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



mcp: node_repl/js started
mcp: node_repl/js (failed)
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Get-Content -Encoding UTF8 art/references/README.md; Get-Content -Encoding UTF8 AGENTS.md' in C:\Users\pc\Documents\game
 succeeded in 296ms:
# 기준 그림

우리 그림체를 대표하는 그림을 이 폴더에 넣어 주세요 (png/jpg, 3~8장 권장).
검토자는 이 그림들과 `art/rubric.md`만 보고 채점합니다.
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

mcp: node_repl/js started
mcp: node_repl/js (failed)
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Get-Command node, magick -ErrorAction SilentlyContinue | Select-Object Name,Source; Get-Content -Encoding UTF8 C:/Users/pc/.codex/skills/.system/imagegen/SKILL.md | Select-Object -Skip 105 -First 28' in C:\Users\pc\Documents\game
 succeeded in 2180ms:

Name     Source                          
----     ------                          
node.exe C:\Program Files\nodejs\node.exe
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



codex
기존 병사는 어두운 1픽셀 외곽선, 작은 받침, 절제된 유약 색을 쓰고 있습니다. 새 병사도 이 기준에 맞추고, 큰 도끼·말·고깔과 방울·신기전 수레로 실루엣을 구분하겠습니다.

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Add-Type -AssemblyName System.Drawing; $names = Get-ChildItem assets/sprites/kiln/soldier_*.png; $out = New-Object System.Drawing.Bitmap 624,624; $g=[System.Drawing.Graphics]::FromImage($out); $g.Clear([System.Drawing.Color]::FromArgb(112,112,112)); $g.InterpolationMode='"'NearestNeighbor'; "'$g.PixelOffsetMode='"'Half'; "'$i=0; foreach($f in $names){$b=[System.Drawing.Bitmap]::FromFile($f.FullName); $g.DrawImage($b, (($i%3)*208), ([math]::Floor($i/3)*208), 192,192); $b.Dispose(); $i++}; $m=New-Object System.IO.MemoryStream; $out.Save($m,[System.Drawing.Imaging.ImageFormat]::Png); [Convert]::ToBase64String($m.ToArray()); $g.Dispose(); $out.Dispose()' in C:\Users\pc\Documents\game
 succeeded in 395ms:
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

codex
도끼병 3색과 청자 기마병 원본이 생성됐습니다. 원본에는 미세한 색 변화가 남아 있어, 최종 32×32 변환 때 기존 병사의 팔레트로 정리하고 반투명 가장자리를 제거하겠습니다.

codex
기마병은 말과 사람이 한 실루엣으로 나오도록 생성했고, 무당은 고깔과 방울로 구분했습니다. 무당 원본의 살색 부분은 몸과 같은 유약 색으로 바꿔 도자기 인형 표현에 맞추겠습니다.

codex
화차 원본은 옆의 병사, 바퀴 두 개, 여러 발사관이 보이는 형태로 나왔습니다. 남은 진사·흑유 화차를 생성한 뒤, 12장을 실제 크기로 줄여 기존 9장과 나란히 확인하겠습니다.

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Add-Type -AssemblyName System.Drawing; $names = Get-ChildItem assets/sprites/kiln/soldier_*.png; $out = New-Object System.Drawing.Bitmap 624,624; $g=[System.Drawing.Graphics]::FromImage($out); $g.Clear([System.Drawing.Color]::FromArgb(112,112,112)); $g.InterpolationMode='"'NearestNeighbor'; "'$g.PixelOffsetMode='"'Half'; "'$i=0; foreach($f in $names){$b=[System.Drawing.Bitmap]::FromFile($f.FullName); $g.DrawImage($b, (($i%3)*208), ([math]::Floor($i/3)*208), 192,192); $b.Dispose(); $i++}; $m=New-Object System.IO.MemoryStream; $out.Save($m,[System.Drawing.Imaging.ImageFormat]::Png); [Convert]::ToBase64String($m.ToArray()); $g.Dispose(); $out.Dispose()' in C:\Users\pc\Documents\game
 succeeded in 400ms:
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

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Add-Type -AssemblyName System.Drawing; foreach($e in @('"'water','fire','earth')){ "'$b=[System.Drawing.Bitmap]::FromFile((Join-Path $PWD "assets/sprites/kiln/soldier_spear_$e.png")); $colors=@{}; $minX=32; $minY=32; $maxX=0; $maxY=0; for($y=0;$y -lt 32;$y++){for($x=0;$x -lt 32;$x++){$c=$b.GetPixel($x,$y); if($c.A -gt 0){$h=('"'{0:X2}{1:X2}{2:X2}' -f "'$c.R,$c.G,$c.B); $colors[$h]++; $minX=[math]::Min($x,$minX); $minY=[math]::Min($y,$minY); $maxX=[math]::Max($x,$maxX); $maxY=[math]::Max($y,$maxY)}}}; Write-Output "$e bounds $minX $minY $maxX $maxY"; $colors.GetEnumerator() | Sort-Object Value -Descending | ForEach-Object {Write-Output "$($_.Key) $($_.Value)"}; $b.Dispose()}' in C:\Users\pc\Documents\game
 succeeded in 405ms:
water bounds 7 4 23 27
282322 92
6B9878 85
929187 34
466F59 26
304B42 11
3A3733 6
B9BAAD 6
706258 6
A6C5A3 4
302C2A 1
F2F1E7 1
4D4942 1
fire bounds 7 4 23 27
282322 104
A84438 69
67332E 39
929187 30
CD6851 25
706258 9
B9BAAD 3
F2F1E7 1
earth bounds 7 4 23 27
282322 118
494039 59
929187 33
302C2A 32
4D4942 15
706258 13
B9BAAD 5
3A3733 3
F2F1E7 1

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'git -c core.quotepath=false status --porcelain' in C:\Users\pc\Documents\game
 succeeded in 165ms:
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
 M work/2026-11-27-그림/NOTES.md
 M work/2026-11-27-그림/handoff-03.md
?? assets/sprites/enemy/brute.png
?? assets/sprites/enemy/brute.png.import
?? assets/sprites/enemy/goblin.png.import
?? assets/sprites/enemy/imp.png
?? assets/sprites/enemy/imp.png.import
?? assets/sprites/field/grass_a.png
?? assets/sprites/field/grass_a.png.import
?? assets/sprites/field/grass_b.png
?? assets/sprites/field/grass_b.png.import
?? assets/sprites/field/house.png.import
?? assets/sprites/field/house_broken.png
?? assets/sprites/field/house_broken.png.import
?? assets/sprites/nest/
?? reports/boss/history-local-backup.csv
?? src/proto/kiln_run.gd.uid
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
?? work/2026-11-28-다듬기/handoff-05.report.md

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Get-ChildItem assets/sprites/kiln/soldier_*.png | Get-FileHash -Algorithm SHA256 | Select-Object Path,Hash | ConvertTo-Json -Compress' in C:\Users\pc\Documents\game
 succeeded in 503ms:
[{"Path":"C:\\Users\\pc\\Documents\\game\\assets\\sprites\\kiln\\soldier_archer_earth.png","Hash":"271CB8D79198FEB62CCB55C93C18F92AE8CB2ACFB53A6B78E43AFD180275AEF4"},{"Path":"C:\\Users\\pc\\Documents\\game\\assets\\sprites\\kiln\\soldier_archer_fire.png","Hash":"C050E6CC8FC8FF5C1B2342038D582B53576B1181B19777001C623B8526EE9690"},{"Path":"C:\\Users\\pc\\Documents\\game\\assets\\sprites\\kiln\\soldier_archer_water.png","Hash":"2AAD5BFD0D181D65DA9C31F39802DC672B03A43F231F10B8301A6E4A266D8939"},{"Path":"C:\\Users\\pc\\Documents\\game\\assets\\sprites\\kiln\\soldier_shield_earth.png","Hash":"02072369E20CFB958CF20AF740C12ED4D9DD631C1FABB77938368A842E9523CF"},{"Path":"C:\\Users\\pc\\Documents\\game\\assets\\sprites\\kiln\\soldier_shield_fire.png","Hash":"D63671BB8D577CA801E065EE34934E3FA90D6A214309934CC16C503938DE1DB4"},{"Path":"C:\\Users\\pc\\Documents\\game\\assets\\sprites\\kiln\\soldier_shield_water.png","Hash":"956AC2E413C5E15CCEA1AB63E3C6E3E2FBE9B057BF9640EB4CBEBF9D6A9C8385"},{"Path":"C:\\Users\\pc\\Documents\\game\\assets\\sprites\\kiln\\soldier_spear_earth.png","Hash":"32A6BF9B5C4EAE93F1537073086C144551A7005F06EDCF9CE5D30DE64501EE51"},{"Path":"C:\\Users\\pc\\Documents\\game\\assets\\sprites\\kiln\\soldier_spear_fire.png","Hash":"32AF23B1A6010BFFFDDD3CA00F9764D548C7026400FF41778B6654C3AD935AB6"},{"Path":"C:\\Users\\pc\\Documents\\game\\assets\\sprites\\kiln\\soldier_spear_water.png","Hash":"9E1A2AFC340D3CD8EF282C2952A9323DF3768D7F29E7D21498F86077CF26A95E"}]

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Add-Type -AssemblyName System.Drawing
Add-Type -ReferencedAssemblies System.Drawing -TypeDefinition @'

using System;
using System.Drawing;
using System.Drawing.Imaging;
using System.Collections.Generic;
public class SpriteFinish {
 static Color H(string h){return Color.FromArgb(255,Convert.ToInt32(h.Substring(0,2),16),Convert.ToInt32(h.Substring(2,2),16),Convert.ToInt32(h.Substring(4,2),16));}
 public static string Run(string src,string dst,string id){
 using(var s=new Bitmap(src)) using(var b=new Bitmap(32,32,PixelFormat.Format32bppArgb)){
 int lx=s.Width,ly=s.Height,hx=0,hy=0;
 for(int y=0;y<s.Height;y+=2)for(int x=0;x<s.Width;x+=2)if(s.GetPixel(x,y).A>=192){lx=Math.Min(lx,x);ly=Math.Min(ly,y);hx=Math.Max(hx,x);hy=Math.Max(hy,y);}
 int sw=hx-lx+1,sh=hy-ly+1; double scale=Math.Min(24.0/sh,28.0/sw); int w=(int)Math.Round(sw*scale),h=(int)Math.Round(sh*scale),ox=(32-w)/2,oy=28-h;
 string e=id.Substring(id.LastIndexOf('_')+1);
 string p=\"282322,3A3733,4D4942,706258,929187,B9BAAD,F2F1E7,\";
 p+= e==\"water\"?\"304B42,466F59,6B9878,A6C5A3\":e==\"fire\"?\"67332E,A84438,CD6851\":\"302C2A,494039\";
 if(id.StartsWith(\"healer\"))p+=\",A84438,3C515E,96846A\";
 string[] hs=p.Split(','); Color[] pal=new Color[hs.Length];for(int i=0;i<pal.Length;i++)pal[i]=H(hs[i]);
 for(int y=0;y<h;y++)for(int x=0;x<w;x++){
 int sx=Math.Min(s.Width-1,lx+(int)((x+.5)*sw/w)),sy=Math.Min(s.Height-1,ly+(int)((y+.5)*sh/h)); Color c=s.GetPixel(sx,sy); if(c.A<128)continue;
 // Match neutral clay and glaze colors to the original soldiers.
 if(id==\"healer_water\" && y<h*.69 && c.R>170 && c.G>120 && c.R>c.G*1.07 && c.G>c.B*1.04)c=H(\"6B9878\");
 if(id.StartsWith(\"cannon\") && c.R>c.G*1.18 && c.G>c.B*1.10 && "'!(e=="fire" && c.R>c.G*1.6)){
 double v=.3*c.R+.59*c.G+.11*c.B; c= v>140?H("929187"):v>90?H("706258"):H("494039");
 }
 double best=double.MaxValue;Color match=pal[0];foreach(Color q in pal){double dr=c.R-q.R,dg=c.G-q.G,db=c.B-q.B;double d=dr*dr+dg*dg+db*db;if(d<best){best=d;match=q;}}b.SetPixel(ox+x,oy+y,match);
 }
 // Crisp single-pixel silhouette on the final native grid.
 using(var t=(Bitmap)b.Clone()){
 for(int y=1;y<31;y++)for(int x=1;x<31;x++)if(t.GetPixel(x,y).A>0 && (t.GetPixel(x-1,y).A==0||t.GetPixel(x+1,y).A==0||t.GetPixel(x,y-1).A==0||t.GetPixel(x,y+1).A==0))b.SetPixel(x,y,H("282322"));
 }
 // Keep a tiny upper-left ceramic highlight after reduction.
 bool done=false; for(int y=oy+2;y<oy+h/3&&!done;y++)for(int x=ox+1;x<ox+w/2&&!done;x++){Color c=b.GetPixel(x,y);if(c.A==255&&c.ToArgb()!=H("282322").ToArgb()&&b.GetPixel(x+1,y).A==255){b.SetPixel(x,y,H("F2F1E7"));done=true;}}
 b.Save(dst,ImageFormat.Png);
 var colors=new HashSet<int>();int semi=0,opaque=0;for(int y=0;y<32;y++)for(int x=0;x<32;x++){Color c=b.GetPixel(x,y);if(c.A>0){colors.Add(c.ToArgb());opaque++;}if(c.A!=0&&c.A!=255)semi++;}
 return id+" 32x32 colors="+colors.Count+" partialAlpha="+semi+" opaque="+opaque+" footprint="+w+"x"+h;
 }
 }
}
'"'@
"'$dest=Join-Path $PWD '"'assets/sprites/kiln/soldier_axe_water.png'
if(Test-Path -LiteralPath "'$dest){throw '"'Destination already exists'}
[SpriteFinish]::Run('C:\\Users\\pc\\.codex\\generated_images\\01a21c5c-6616-7c71-9c51-7fcd7dced2cf\\exec-ed4eb2b0-9e6f-48ca-a170-96b6dc559ae4.png',"'$dest,'"'axe_water')
"'$dest=Join-Path $PWD '"'assets/sprites/kiln/soldier_axe_fire.png'
if(Test-Path -LiteralPath "'$dest){throw '"'Destination already exists'}
[SpriteFinish]::Run('C:\\Users\\pc\\.codex\\generated_images\\01a21c5c-6616-7c71-9c51-7fcd7dced2cf\\exec-9ec84dc1-5f51-49d5-b50e-1fd64c3d8f51.png',"'$dest,'"'axe_fire')
"'$dest=Join-Path $PWD '"'assets/sprites/kiln/soldier_axe_earth.png'
if(Test-Path -LiteralPath "'$dest){throw '"'Destination already exists'}
[SpriteFinish]::Run('C:\\Users\\pc\\.codex\\generated_images\\01a21c5c-6616-7c71-9c51-7fcd7dced2cf\\exec-bb6a6d71-7e73-4696-a9bc-adb58f6f3cfc.png',"'$dest,'"'axe_earth')
"'$dest=Join-Path $PWD '"'assets/sprites/kiln/soldier_cavalry_water.png'
if(Test-Path -LiteralPath "'$dest){throw '"'Destination already exists'}
[SpriteFinish]::Run('C:\\Users\\pc\\.codex\\generated_images\\01a21c5c-6616-7c71-9c51-7fcd7dced2cf\\exec-3e613578-31a7-4bca-8eb7-cbaaf018106d.png',"'$dest,'"'cavalry_water')
"'$dest=Join-Path $PWD '"'assets/sprites/kiln/soldier_cavalry_fire.png'
if(Test-Path -LiteralPath "'$dest){throw '"'Destination already exists'}
[SpriteFinish]::Run('C:\\Users\\pc\\.codex\\generated_images\\01a21c5c-6616-7c71-9c51-7fcd7dced2cf\\exec-462fcb04-3da6-4b2f-a9bf-aab3c5cc5697.png',"'$dest,'"'cavalry_fire')
"'$dest=Join-Path $PWD '"'assets/sprites/kiln/soldier_cavalry_earth.png'
if(Test-Path -LiteralPath "'$dest){throw '"'Destination already exists'}
[SpriteFinish]::Run('C:\\Users\\pc\\.codex\\generated_images\\01a21c5c-6616-7c71-9c51-7fcd7dced2cf\\exec-2e2ad62c-4a66-4eee-8989-f6a0994a7622.png',"'$dest,'"'cavalry_earth')
"'$dest=Join-Path $PWD '"'assets/sprites/kiln/soldier_healer_water.png'
if(Test-Path -LiteralPath "'$dest){throw '"'Destination already exists'}
[SpriteFinish]::Run('C:\\Users\\pc\\.codex\\generated_images\\01a21c5c-6616-7c71-9c51-7fcd7dced2cf\\exec-2d24455e-11b0-466b-9566-59c0dd1152ad.png',"'$dest,'"'healer_water')
"'$dest=Join-Path $PWD '"'assets/sprites/kiln/soldier_healer_fire.png'
if(Test-Path -LiteralPath "'$dest){throw '"'Destination already exists'}
[SpriteFinish]::Run('C:\\Users\\pc\\.codex\\generated_images\\01a21c5c-6616-7c71-9c51-7fcd7dced2cf\\exec-7a493a78-3904-4c13-9424-3a1a09030bc7.png',"'$dest,'"'healer_fire')
"'$dest=Join-Path $PWD '"'assets/sprites/kiln/soldier_healer_earth.png'
if(Test-Path -LiteralPath "'$dest){throw '"'Destination already exists'}
[SpriteFinish]::Run('C:\\Users\\pc\\.codex\\generated_images\\01a21c5c-6616-7c71-9c51-7fcd7dced2cf\\exec-d5fd165a-9721-4d99-beca-e8b415b8d0f2.png',"'$dest,'"'healer_earth')
"'$dest=Join-Path $PWD '"'assets/sprites/kiln/soldier_cannon_water.png'
if(Test-Path -LiteralPath "'$dest){throw '"'Destination already exists'}
[SpriteFinish]::Run('C:\\Users\\pc\\.codex\\generated_images\\01a21c5c-6616-7c71-9c51-7fcd7dced2cf\\exec-efdbbe65-f81c-49dd-b423-9207459dffcb.png',"'$dest,'"'cannon_water')
"'$dest=Join-Path $PWD '"'assets/sprites/kiln/soldier_cannon_fire.png'
if(Test-Path -LiteralPath "'$dest){throw '"'Destination already exists'}
[SpriteFinish]::Run('C:\\Users\\pc\\.codex\\generated_images\\01a21c5c-6616-7c71-9c51-7fcd7dced2cf\\exec-8a8f46c7-fd84-47c6-90a1-8c269c8c7187.png',"'$dest,'"'cannon_fire')
"'$dest=Join-Path $PWD '"'assets/sprites/kiln/soldier_cannon_earth.png'
if(Test-Path -LiteralPath "'$dest){throw '"'Destination already exists'}
[SpriteFinish]::Run('C:\\Users\\pc\\.codex\\generated_images\\01a21c5c-6616-7c71-9c51-7fcd7dced2cf\\exec-28a0453c-693c-44cd-b50a-8e2cd1b8223e.png',"'$dest,'"'cannon_earth')" in C:\Users\pc\Documents\game
 succeeded in 1749ms:
axe_water 32x32 colors=9 partialAlpha=0 opaque=276 footprint=20x24
axe_fire 32x32 colors=8 partialAlpha=0 opaque=317 footprint=24x24
axe_earth 32x32 colors=8 partialAlpha=0 opaque=281 footprint=22x24
cavalry_water 32x32 colors=8 partialAlpha=0 opaque=260 footprint=22x24
cavalry_fire 32x32 colors=8 partialAlpha=0 opaque=255 footprint=20x24
cavalry_earth 32x32 colors=8 partialAlpha=0 opaque=262 footprint=22x24
healer_water 32x32 colors=11 partialAlpha=0 opaque=217 footprint=17x24
healer_fire 32x32 colors=10 partialAlpha=0 opaque=192 footprint=14x24
healer_earth 32x32 colors=12 partialAlpha=0 opaque=189 footprint=15x24
cannon_water 32x32 colors=9 partialAlpha=0 opaque=423 footprint=28x21
cannon_fire 32x32 colors=7 partialAlpha=0 opaque=467 footprint=28x22
cannon_earth 32x32 colors=7 partialAlpha=0 opaque=433 footprint=28x21

codex
12장을 32×32 PNG로 저장했습니다. 현재 파일별 불투명 색은 7~12개이고, 반투명 픽셀은 없습니다. 확대 비교로 축소 과정에서 눈·방울·말·발사관이 뭉개진 곳을 확인하겠습니다.

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
$out.Save($m,[System.Drawing.Imaging.ImageFormat]::Png)
[Convert]::ToBase64String($m.ToArray())
$g.Dispose();$out.Dispose();$font.Dispose()' in C:\Users\pc\Documents\game
 succeeded in 1631ms:
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

codex
비교해 보니 청자 원본 일부가 회색으로 치우치고, 같은 병종도 유약별 자세가 달랐습니다. 기존 병사처럼 병종마다 원형 하나를 골라 세 유약 팔레트로 통일하고, 무당의 천과 화차의 나무색은 따로 유지하겠습니다.

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Add-Type -AssemblyName System.Drawing
Add-Type -ReferencedAssemblies System.Drawing -TypeDefinition @'

using System;
using System.Drawing;
using System.Drawing.Imaging;
using System.Collections.Generic;
public class SpriteFinish2 {
 static Color H(string h){return Color.FromArgb(255,Convert.ToInt32(h.Substring(0,2),16),Convert.ToInt32(h.Substring(2,2),16),Convert.ToInt32(h.Substring(4,2),16));}
 public static string Run(string src,string dst,string id){
 using(var s=new Bitmap(src)) using(var b=new Bitmap(32,32,PixelFormat.Format32bppArgb)){
 int lx=s.Width,ly=s.Height,hx=0,hy=0;
 for(int y=0;y<s.Height;y+=2)for(int x=0;x<s.Width;x+=2)if(s.GetPixel(x,y).A>=192){lx=Math.Min(lx,x);ly=Math.Min(ly,y);hx=Math.Max(hx,x);hy=Math.Max(hy,y);}
 int sw=hx-lx+1,sh=hy-ly+1; double scale=Math.Min(24.0/sh,28.0/sw); int w=(int)Math.Round(sw*scale),h=(int)Math.Round(sh*scale);
 bool healer=id.StartsWith(\"healer\"),cannon=id.StartsWith(\"cannon\");if(healer)w=19;
 int ox=(32-w)/2,oy=28-h;
 string e=id.Substring(id.LastIndexOf('_')+1);
 string[] ramp=(e==\"water\"?\"304B42,466F59,6B9878,A6C5A3\":e==\"fire\"?\"67332E,67332E,A84438,CD6851\":\"302C2A,494039,494039,706258\").Split(',');
 string[] hs=\"282322,3A3733,4D4942,706258,929187,B9BAAD,F2F1E7\".Split(',');
 Color[] pal=new Color[hs.Length];for(int i=0;i<pal.Length;i++)pal[i]=H(hs[i]);
 for(int y=0;y<h;y++)for(int x=0;x<w;x++){
 int sx=Math.Min(s.Width-1,lx+(int)((x+.5)*sw/w)),sy=Math.Min(s.Height-1,ly+(int)((y+.5)*sh/h)); Color c=s.GetPixel(sx,sy);if(c.A<128)continue;
 Color match;
 bool green=c.G>c.R*1.035&&c.G>c.B*1.02&&c.G>80;
 bool red=c.R>c.G*1.55&&c.R>c.B*1.45&&c.R>75;
 bool skin=healer&&y<h*.70&&c.R>170&&c.G>120&&c.R>c.G*1.07&&c.G>c.B*1.04;
 if(("'!healer&&red)||(healer&&green)||skin){
 int tone=skin?2:healer?(c.G<125?1:c.G<182?2:3):(c.R<105?0:c.R<145?1:c.R<205?2:3);
 match=H(ramp[tone]);
 }else if(healer&&y>h*.64&&c.R>c.G*1.35&&c.R>80){match=H("A84438");}
 else if(healer&&y>h*.64&&c.B>c.R*1.12){match=H("3C515E");}
 else if(healer&&y>h*.64&&c.R>c.G*1.15&&c.G>c.B*1.3&&c.R>130){match=H("96846A");}
 else{
 double best=double.MaxValue;match=pal[0];
 foreach(Color q in pal){double dr=c.R-q.R,dg=c.G-q.G,db=c.B-q.B;double d=dr*dr+dg*dg+db*db;if(d<best){best=d;match=q;}}
 }
 b.SetPixel(ox+x,oy+y,match);
 }
 using(var t=(Bitmap)b.Clone()){
 for(int y=1;y<31;y++)for(int x=1;x<31;x++)if(t.GetPixel(x,y).A>0&&(t.GetPixel(x-1,y).A==0||t.GetPixel(x+1,y).A==0||t.GetPixel(x,y-1).A==0||t.GetPixel(x,y+1).A==0))b.SetPixel(x,y,H("282322"));
 }
 bool done=false;for(int y=oy+2;y<oy+h/3&&!done;y++)for(int x=ox+1;x<ox+w/2&&!done;x++){Color c=b.GetPixel(x,y);if(c.A==255&&c.ToArgb()!=H("282322").ToArgb()&&b.GetPixel(x+1,y).A==255){b.SetPixel(x,y,H("F2F1E7"));done=true;}}
 b.Save(dst,ImageFormat.Png);
 var colors=new HashSet<int>();int semi=0;for(int y=0;y<32;y++)for(int x=0;x<32;x++){Color c=b.GetPixel(x,y);if(c.A>0)colors.Add(c.ToArgb());if(c.A!=0&&c.A!=255)semi++;}
 return id+" colors="+colors.Count+" partialAlpha="+semi+" footprint="+w+"x"+h;
 }
 }
}
'"'@
[SpriteFinish2]::Run('C:\\Users\\pc\\.codex\\generated_images\\01a21c5c-6616-7c71-9c51-7fcd7dced2cf\\exec-9ec84dc1-5f51-49d5-b50e-1fd64c3d8f51.png',(Join-Path "'$PWD '"'assets/sprites/kiln/soldier_axe_water.png'),'axe_water')
[SpriteFinish2]::Run('C:\\Users\\pc\\.codex\\generated_images\\01a21c5c-6616-7c71-9c51-7fcd7dced2cf\\exec-9ec84dc1-5f51-49d5-b50e-1fd64c3d8f51.png',(Join-Path "'$PWD '"'assets/sprites/kiln/soldier_axe_fire.png'),'axe_fire')
[SpriteFinish2]::Run('C:\\Users\\pc\\.codex\\generated_images\\01a21c5c-6616-7c71-9c51-7fcd7dced2cf\\exec-9ec84dc1-5f51-49d5-b50e-1fd64c3d8f51.png',(Join-Path "'$PWD '"'assets/sprites/kiln/soldier_axe_earth.png'),'axe_earth')
[SpriteFinish2]::Run('C:\\Users\\pc\\.codex\\generated_images\\01a21c5c-6616-7c71-9c51-7fcd7dced2cf\\exec-462fcb04-3da6-4b2f-a9bf-aab3c5cc5697.png',(Join-Path "'$PWD '"'assets/sprites/kiln/soldier_cavalry_water.png'),'cavalry_water')
[SpriteFinish2]::Run('C:\\Users\\pc\\.codex\\generated_images\\01a21c5c-6616-7c71-9c51-7fcd7dced2cf\\exec-462fcb04-3da6-4b2f-a9bf-aab3c5cc5697.png',(Join-Path "'$PWD '"'assets/sprites/kiln/soldier_cavalry_fire.png'),'cavalry_fire')
[SpriteFinish2]::Run('C:\\Users\\pc\\.codex\\generated_images\\01a21c5c-6616-7c71-9c51-7fcd7dced2cf\\exec-462fcb04-3da6-4b2f-a9bf-aab3c5cc5697.png',(Join-Path "'$PWD '"'assets/sprites/kiln/soldier_cavalry_earth.png'),'cavalry_earth')
[SpriteFinish2]::Run('C:\\Users\\pc\\.codex\\generated_images\\01a21c5c-6616-7c71-9c51-7fcd7dced2cf\\exec-2d24455e-11b0-466b-9566-59c0dd1152ad.png',(Join-Path "'$PWD '"'assets/sprites/kiln/soldier_healer_water.png'),'healer_water')
[SpriteFinish2]::Run('C:\\Users\\pc\\.codex\\generated_images\\01a21c5c-6616-7c71-9c51-7fcd7dced2cf\\exec-2d24455e-11b0-466b-9566-59c0dd1152ad.png',(Join-Path "'$PWD '"'assets/sprites/kiln/soldier_healer_fire.png'),'healer_fire')
[SpriteFinish2]::Run('C:\\Users\\pc\\.codex\\generated_images\\01a21c5c-6616-7c71-9c51-7fcd7dced2cf\\exec-2d24455e-11b0-466b-9566-59c0dd1152ad.png',(Join-Path "'$PWD '"'assets/sprites/kiln/soldier_healer_earth.png'),'healer_earth')
[SpriteFinish2]::Run('C:\\Users\\pc\\.codex\\generated_images\\01a21c5c-6616-7c71-9c51-7fcd7dced2cf\\exec-8a8f46c7-fd84-47c6-90a1-8c269c8c7187.png',(Join-Path "'$PWD '"'assets/sprites/kiln/soldier_cannon_water.png'),'cannon_water')
[SpriteFinish2]::Run('C:\\Users\\pc\\.codex\\generated_images\\01a21c5c-6616-7c71-9c51-7fcd7dced2cf\\exec-8a8f46c7-fd84-47c6-90a1-8c269c8c7187.png',(Join-Path "'$PWD '"'assets/sprites/kiln/soldier_cannon_fire.png'),'cannon_fire')
[SpriteFinish2]::Run('C:\\Users\\pc\\.codex\\generated_images\\01a21c5c-6616-7c71-9c51-7fcd7dced2cf\\exec-8a8f46c7-fd84-47c6-90a1-8c269c8c7187.png',(Join-Path "'$PWD '"'assets/sprites/kiln/soldier_cannon_earth.png'),'cannon_earth')
" in C:\Users\pc\Documents\game
 succeeded in 1513ms:
axe_water colors=10 partialAlpha=0 footprint=24x24
axe_fire colors=9 partialAlpha=0 footprint=24x24
axe_earth colors=8 partialAlpha=0 footprint=24x24
cavalry_water colors=8 partialAlpha=0 footprint=20x24
cavalry_fire colors=7 partialAlpha=0 footprint=20x24
cavalry_earth colors=7 partialAlpha=0 footprint=20x24
healer_water colors=12 partialAlpha=0 footprint=19x24
healer_fire colors=11 partialAlpha=0 footprint=19x24
healer_earth colors=10 partialAlpha=0 footprint=19x24
cannon_water colors=9 partialAlpha=0 footprint=28x22
cannon_fire colors=8 partialAlpha=0 footprint=28x22
cannon_earth colors=8 partialAlpha=0 footprint=28x22

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
$out.Save($m,[System.Drawing.Imaging.ImageFormat]::Png)
[Convert]::ToBase64String($m.ToArray())
$g.Dispose();$out.Dispose();$font.Dispose()' in C:\Users\pc\Documents\game
 succeeded in 1583ms:
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

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Add-Type -AssemblyName System.Drawing
foreach($kind in @('"'axe','cavalry','healer','cannon')){
"'$b=[System.Drawing.Bitmap]::FromFile((Join-Path $PWD "assets/sprites/kiln/soldier_${kind}_water.png".Replace('"'"'${kind}'"',"'$kind)))
$palette=@{};$alphabet='"'ABCDEFGHIJKLMNOPQRSTUVWXYZ';"'$idx=0
Write-Output $kind
for($y=0;$y -lt 32;$y++){$line='"'';for("'$x=0;$x -lt 32;$x++){$c=$b.GetPixel($x,$y);if($c.A -eq 0){$line+='"'.'}else{"'$hex=('"'{0:X2}{1:X2}{2:X2}' -f "'$c.R,$c.G,$c.B);if(!$palette.ContainsKey($hex)){$palette[$hex]=[string]$alphabet[$idx];$idx++};$line+=$palette[$hex]}};Write-Output ("{0:D2} {1}" -f $y,$line)}
$palette.GetEnumerator()|Sort-Object Value|ForEach-Object {Write-Output "$($_.Value)=$($_.Key)"};$b.Dispose()
}' in C:\Users\pc\Documents\game
 succeeded in 388ms:
axe
00 ................................
01 ................................
02 ................................
03 ................................
04 ...........AA...................
05 ..........ABBA..................
06 ..........ACBA..................
07 .........ABBBBAA................
08 ........ABBBBBBA................
09 ........ADDDDDDDA...............
10 .......ABBBBBBBBBA..............
11 ........ABBBABBAA.....AAA.......
12 .......ABBBBABBAA....AEEEA......
13 .......ABBBBABBBA...AEEEFAAA....
14 ......AAABBBADDA.....AGFFEEA....
15 .....ABCBBAABAABAA...AFEEEEA....
16 ....ABBBBBABBBDBAAAAAFFEEEEA....
17 ....ABBBHBABBBBDBBAAAAEEEEEA....
18 ....ABBBBABAAFFDBBA...AEEEA.....
19 .....ADBABHBEFAADAA..AEEEA......
20 ......AAABBBABBBA...AEEAAA......
21 ......AFFDIADDBBA...AAA.........
22 .....ABBBBBBIDBBHA..............
23 .....AABBBBBDDBBAA..............
24 ......ABBDAAADBBA...............
25 ......ABBA...ABBBA..............
26 .....AGGGGAAAJGGIA..............
27 .....AAAAAAAAAAAAA..............
28 ................................
29 ................................
30 ................................
31 ................................
A=282322
B=6B9878
C=F2F1E7
D=466F59
E=929187
F=706258
G=4D4942
H=A6C5A3
I=304B42
J=3A3733
cavalry
00 ................................
01 ................................
02 ................................
03 ................................
04 ............AAA.................
05 ............ABA.................
06 ............AACAA...............
07 ...........ABBBBBA..............
08 ..........ABCBBBBA..............
09 ..........ABBBDDDDA.............
10 ..........ABBBABBA.....AAA......
11 ..........ABBBABAA....AEAA......
12 .........AABBABBBA..AAFA........
13 ...........ABBDAA..AA.A.........
14 ...........ADBAABAA..AA.........
15 ..........ABBABDAA.AABBA........
16 ...........AAADBBAABBBBA........
17 ...........ABBBBAABBBBBAA.......
18 ........AAAABBBBBBBBBAABA.......
19 .......ABABBBABBABBBBA.AA.......
20 ......ABBBCBBBAAABBBA...........
21 ......ABBBBBBBBBBBBBA...........
22 ......AAAABBBDDDGBBAA...........
23 ..........ABGAAAADBA............
24 ..........ABA....ABA............
25 ..........ABA....ABA............
26 .........AHHHAAAAHHHA...........
27 .........AAAAAAAAAAAA...........
28 ................................
29 ................................
30 ................................
31 ................................
A=282322
B=6B9878
C=F2F1E7
D=466F59
E=929187
F=3A3733
G=304B42
H=4D4942
healer
00 ................................
01 ................................
02 ................................
03 ................................
04 ..........AA....................
05 ..........ABA...................
06 ..........ACBA..................
07 ..........ABBA..................
08 .........ABBBA..................
09 .........ABBBBA.................
10 .........ABBBBDA.....AA.........
11 ........ABBBDBBA...AAAA.........
12 ........ABBBAEBBA..AA.AAA.......
13 ........AEEEABBAA..AAAFA........
14 ........AAEBBBBBA..AAAAA........
15 ........AEBBGBBA....AA..........
16 .........ABBBABBAAAABA..........
17 ........ACBBBBBBBBBHA...........
18 ........ABDDBBBBBBBHA...........
19 .......ADBBHBBBHHBBHA...........
20 .......ABBBEIGBBHHBHA...........
21 .......ABBBJICKBBLAA............
22 .......ABBAJICEKBA..............
23 .......AHHJJICGKBA..............
24 ......ABBBLICCEBBBA.............
25 ......ABBBBBBBBBBBA.............
26 .......AHBBBBBBBBA..............
27 ........AAAAAAAAAA..............
28 ................................
29 ................................
30 ................................
31 ................................
A=282322
B=6B9878
C=F2F1E7
D=A6C5A3
E=4D4942
F=929187
G=706258
H=466F59
I=3C515E
J=A84438
K=96846A
L=3A3733
cannon
00 ................................
01 ................................
02 ................................
03 ................................
04 ................................
05 ................................
06 .......AAA..............AA.AA...
07 .......ABA...........A.AA.AA....
08 ......ACDDA........AADAAAAAA....
09 .....ADCDDDA......AEEAEAEFA.AA..
10 ....ADDDDDDDA....AAEAADAADAAA...
11 ....ADDDDDDDA...AEGEAADEAAEAA...
12 ....ADDDAAAAAA.AEEEAEEAEAEAAAA..
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
$out.Save($m,[System.Drawing.Imaging.ImageFormat]::Png)
[Convert]::ToBase64String($m.ToArray())
$g.Dispose();$out.Dispose();$font.Dispose()' in C:\Users\pc\Documents\game
 succeeded in 1755ms:
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

context compacted
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command '
Add-Type -AssemblyName System.Drawing
function HexColor([string]$h){[System.Drawing.ColorTranslator]::FromHtml("#"+$h)}
foreach($e in @('"'water','fire','earth')){
 "'$path=Join-Path $PWD "assets/sprites/kiln/soldier_healer_$e.png"
 $original=[System.Drawing.Bitmap]::FromFile($path)
 $b=New-Object System.Drawing.Bitmap $original
 $original.Dispose()
 $dark=HexColor '"'282322';"'$gray=HexColor '"'929187';"'$base=HexColor '"'4D4942'
 foreach("'$p in @(@(22,11),@(20,13),@(24,13))){
  $cx=$p[0];$cy=$p[1]
  for($dy=-1;$dy -le 1;$dy++){
   for($dx=-1;$dx -le 1;$dx++){$b.SetPixel(($cx+$dx),($cy+$dy),$dark)}
  }
  $b.SetPixel($cx,$cy,$gray)
 }
 $b.SetPixel(22,14,$dark);$b.SetPixel(22,15,$base)
 $b.SetPixel(15,14,$dark)
 $cloth=@('"'A84438','3C515E','B9BAAD','3A3733','96846A')
 for("'$i=0;$i -lt 5;$i++){
  for($y=21;$y -le (23+($i%2));$y++){$b.SetPixel((11+$i),$y,(HexColor $cloth[$i]))}
 }
 for($x=9;$x -le 16;$x++){$b.SetPixel($x,26,$base)}
 $b.Save($path,[System.Drawing.Imaging.ImageFormat]::Png);$b.Dispose()
}
foreach($e in @('"'water','fire','earth')){
 "'$path=Join-Path $PWD "assets/sprites/kiln/soldier_cannon_$e.png"
 $original=[System.Drawing.Bitmap]::FromFile($path)
 $b=New-Object System.Drawing.Bitmap $original
 $original.Dispose()
 $dark=HexColor '"'282322';"'$wood=HexColor '"'706258';"'$hub=HexColor '"'929187'
 foreach("'$cx in @(17,26)){
  $rows=@('"'.OOO.','OWWWO','OWHWO','OWWWO','.OOO.')
  for("'$dy=0;$dy -lt 5;$dy++){
   for($dx=0;$dx -lt 5;$dx++){
    $ch=$rows[$dy][$dx]
    if($ch -ne '"'.'){
     "'$c=$dark
     if($ch -eq '"'W'){"'$c=$wood}
     if($ch -eq '"'H'){"'$c=$hub}
     $b.SetPixel(($cx+$dx-2),(21+$dy),$c)
    }
   }
  }
 }
 $b.SetPixel(10,14,$dark)
 $b.Save($path,[System.Drawing.Imaging.ImageFormat]::Png);$b.Dispose()
}
' in C:\Users\pc\Documents\game
 succeeded in 398ms:
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
$out.Save($m,[System.Drawing.Imaging.ImageFormat]::Png)
[Convert]::ToBase64String($m.ToArray())
$g.Dispose();$out.Dispose();$font.Dispose()' in C:\Users\pc\Documents\game
 succeeded in 1619ms:
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

codex
12장의 유약 색을 기존 병사 팔레트에 맞추고, 무당의 방울·천과 화차 바퀴를 정리했습니다. 기존 9장과 원래 크기·확대 크기로 나란히 확인했으며, 마지막으로 파일 규격과 변경 범위를 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command '
Add-Type -AssemblyName System.Drawing
$results=foreach($role in @('"'axe','cavalry','healer','cannon')){
 foreach("'$element in @('"'water','fire','earth')){
  "'$p="assets/sprites/kiln/soldier_${role}_${element}.png"
  $b=[System.Drawing.Bitmap]::FromFile((Join-Path $PWD $p))
  $colors=New-Object '"'System.Collections.Generic.HashSet[int]'
  "'$partial=0;$transparent=0;$borderOpaque=0
  for($y=0;$y -lt $b.Height;$y++){
   for($x=0;$x -lt $b.Width;$x++){
    $c=$b.GetPixel($x,$y)
    if($c.A -eq 0){$transparent++}else{
     [void]$colors.Add($c.ToArgb())
     if($c.A -ne 255){$partial++}
     if($x -eq 0 -or $y -eq 0 -or $x -eq 31 -or $y -eq 31){$borderOpaque++}
    }
   }
  }
  [pscustomobject]@{path=$p;width=$b.Width;height=$b.Height;colors=$colors.Count;partialAlpha=$partial;transparent=$transparent;borderOpaque=$borderOpaque}
  $b.Dispose()
 }
}
$results|ConvertTo-Json -Compress
' in C:\Users\pc\Documents\game
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'git status --porcelain' in C:\Users\pc\Documents\game
 succeeded in 0ms:
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
?? assets/sprites/field/grass_a.png
?? assets/sprites/field/grass_a.png.import
?? assets/sprites/field/grass_b.png
?? assets/sprites/field/grass_b.png.import
?? assets/sprites/field/house.png.import
?? assets/sprites/field/house_broken.png
?? assets/sprites/field/house_broken.png.import
?? assets/sprites/fx/
?? assets/sprites/kiln/soldier_axe_earth.png
?? assets/sprites/kiln/soldier_axe_fire.png
?? assets/sprites/kiln/soldier_axe_water.png
?? assets/sprites/kiln/soldier_cannon_earth.png
?? assets/sprites/kiln/soldier_cannon_fire.png
?? assets/sprites/kiln/soldier_cannon_water.png
?? assets/sprites/kiln/soldier_cavalry_earth.png
?? assets/sprites/kiln/soldier_cavalry_fire.png
?? assets/sprites/kiln/soldier_cavalry_water.png
?? assets/sprites/kiln/soldier_healer_earth.png
?? assets/sprites/kiln/soldier_healer_fire.png
?? assets/sprites/kiln/soldier_healer_water.png
?? assets/sprites/nest/
?? reports/boss/history-local-backup.csv
?? src/proto/kiln_run.gd.uid
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

 succeeded in 0ms:
[{"path":"assets/sprites/kiln/soldier_axe_water.png","width":32,"height":32,"colors":10,"partialAlpha":0,"transparent":707,"borderOpaque":0},{"path":"assets/sprites/kiln/soldier_axe_fire.png","width":32,"height":32,"colors":9,"partialAlpha":0,"transparent":707,"borderOpaque":0},{"path":"assets/sprites/kiln/soldier_axe_earth.png","width":32,"height":32,"colors":8,"partialAlpha":0,"transparent":707,"borderOpaque":0},{"path":"assets/sprites/kiln/soldier_cavalry_water.png","width":32,"height":32,"colors":8,"partialAlpha":0,"transparent":769,"borderOpaque":0},{"path":"assets/sprites/kiln/soldier_cavalry_fire.png","width":32,"height":32,"colors":7,"partialAlpha":0,"transparent":769,"borderOpaque":0},{"path":"assets/sprites/kiln/soldier_cavalry_earth.png","width":32,"height":32,"colors":7,"partialAlpha":0,"transparent":769,"borderOpaque":0},{"path":"assets/sprites/kiln/soldier_healer_water.png","width":32,"height":32,"colors":13,"partialAlpha":0,"transparent":769,"borderOpaque":0},{"path":"assets/sprites/kiln/soldier_healer_fire.png","width":32,"height":32,"colors":12,"partialAlpha":0,"transparent":769,"borderOpaque":0},{"path":"assets/sprites/kiln/soldier_healer_earth.png","width":32,"height":32,"colors":11,"partialAlpha":0,"transparent":769,"borderOpaque":0},{"path":"assets/sprites/kiln/soldier_cannon_water.png","width":32,"height":32,"colors":9,"partialAlpha":0,"transparent":557,"borderOpaque":0},{"path":"assets/sprites/kiln/soldier_cannon_fire.png","width":32,"height":32,"colors":8,"partialAlpha":0,"transparent":557,"borderOpaque":0},{"path":"assets/sprites/kiln/soldier_cannon_earth.png","width":32,"height":32,"colors":8,"partialAlpha":0,"transparent":557,"borderOpaque":0}]

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Get-ChildItem assets/sprites/kiln/soldier_*.png | Where-Object { $_.Name -match '"'"'^soldier_(spear|archer|shield)_'"' } | Get-FileHash -Algorithm SHA256 | Select-Object Path,Hash | ConvertTo-Json -Compress" in C:\Users\pc\Documents\game
 succeeded in 451ms:
[{"Path":"C:\\Users\\pc\\Documents\\game\\assets\\sprites\\kiln\\soldier_archer_earth.png","Hash":"271CB8D79198FEB62CCB55C93C18F92AE8CB2ACFB53A6B78E43AFD180275AEF4"},{"Path":"C:\\Users\\pc\\Documents\\game\\assets\\sprites\\kiln\\soldier_archer_fire.png","Hash":"C050E6CC8FC8FF5C1B2342038D582B53576B1181B19777001C623B8526EE9690"},{"Path":"C:\\Users\\pc\\Documents\\game\\assets\\sprites\\kiln\\soldier_archer_water.png","Hash":"2AAD5BFD0D181D65DA9C31F39802DC672B03A43F231F10B8301A6E4A266D8939"},{"Path":"C:\\Users\\pc\\Documents\\game\\assets\\sprites\\kiln\\soldier_shield_earth.png","Hash":"02072369E20CFB958CF20AF740C12ED4D9DD631C1FABB77938368A842E9523CF"},{"Path":"C:\\Users\\pc\\Documents\\game\\assets\\sprites\\kiln\\soldier_shield_fire.png","Hash":"D63671BB8D577CA801E065EE34934E3FA90D6A214309934CC16C503938DE1DB4"},{"Path":"C:\\Users\\pc\\Documents\\game\\assets\\sprites\\kiln\\soldier_shield_water.png","Hash":"956AC2E413C5E15CCEA1AB63E3C6E3E2FBE9B057BF9640EB4CBEBF9D6A9C8385"},{"Path":"C:\\Users\\pc\\Documents\\game\\assets\\sprites\\kiln\\soldier_spear_earth.png","Hash":"32A6BF9B5C4EAE93F1537073086C144551A7005F06EDCF9CE5D30DE64501EE51"},{"Path":"C:\\Users\\pc\\Documents\\game\\assets\\sprites\\kiln\\soldier_spear_fire.png","Hash":"32AF23B1A6010BFFFDDD3CA00F9764D548C7026400FF41778B6654C3AD935AB6"},{"Path":"C:\\Users\\pc\\Documents\\game\\assets\\sprites\\kiln\\soldier_spear_water.png","Hash":"9E1A2AFC340D3CD8EF282C2952A9323DF3768D7F29E7D21498F86077CF26A95E"}]

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'git -c core.quotepath=false status --porcelain' in C:\Users\pc\Documents\game
 succeeded in 120ms:
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
 M work/2026-11-27-그림/NOTES.md
 M work/2026-11-27-그림/handoff-03.md
?? assets/sprites/enemy/brute.png
?? assets/sprites/enemy/brute.png.import
?? assets/sprites/enemy/goblin.png.import
?? assets/sprites/enemy/imp.png
?? assets/sprites/enemy/imp.png.import
?? assets/sprites/field/battlefield.png
?? assets/sprites/field/grass_a.png
?? assets/sprites/field/grass_a.png.import
?? assets/sprites/field/grass_b.png
?? assets/sprites/field/grass_b.png.import
?? assets/sprites/field/house.png.import
?? assets/sprites/field/house_broken.png
?? assets/sprites/field/house_broken.png.import
?? assets/sprites/fx/
?? assets/sprites/kiln/soldier_axe_earth.png
?? assets/sprites/kiln/soldier_axe_fire.png
?? assets/sprites/kiln/soldier_axe_water.png
?? assets/sprites/kiln/soldier_cannon_earth.png
?? assets/sprites/kiln/soldier_cannon_fire.png
?? assets/sprites/kiln/soldier_cannon_water.png
?? assets/sprites/kiln/soldier_cavalry_earth.png
?? assets/sprites/kiln/soldier_cavalry_fire.png
?? assets/sprites/kiln/soldier_cavalry_water.png
?? assets/sprites/kiln/soldier_healer_earth.png
?? assets/sprites/kiln/soldier_healer_fire.png
?? assets/sprites/kiln/soldier_healer_water.png
?? assets/sprites/nest/
?? reports/boss/history-local-backup.csv
?? src/proto/kiln_run.gd.uid
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

codex
결과: 통과

바뀐 파일:
- `assets/sprites/kiln/soldier_axe_{water,fire,earth}.png` — 도끼병 3장
- `assets/sprites/kiln/soldier_cavalry_{water,fire,earth}.png` — 기마병 3장
- `assets/sprites/kiln/soldier_healer_{water,fire,earth}.png` — 무당 3장
- `assets/sprites/kiln/soldier_cannon_{water,fire,earth}.png` — 화차 3장

직접 확인한 것:
- 모두 32×32, 투명 배경, 불투명 색 7~13개, 반투명 픽셀 없음.
- 기존 병사 9장과 실제 크기·확대 화면으로 비교.
- 기존 9장 파일 해시가 작업 전과 동일함.

그리는 데 쓴 방법:
- **둘 다**: 내장 이미지 생성으로 원본 제작 후, 코드로 축소·투명 처리·기존 유약 팔레트 적용·픽셀 정리.

못 한 것 / 걱정되는 것:
- 저장소 Python 검사와 게임 화면 확인은 지시서대로 Claude의 후속 확인으로 남겼습니다.
- 작업 중 별도로 나타난 `battlefield.png`, `fx/`, `sheet-04.png`는 제가 만든 파일이 아닙니다.
- 자체 규격 확인은 통과했으며, **미술 판단은 사용자 몫입니다.**
tokens used
102,905
결과: 통과

바뀐 파일:
- `assets/sprites/kiln/soldier_axe_{water,fire,earth}.png` — 도끼병 3장
- `assets/sprites/kiln/soldier_cavalry_{water,fire,earth}.png` — 기마병 3장
- `assets/sprites/kiln/soldier_healer_{water,fire,earth}.png` — 무당 3장
- `assets/sprites/kiln/soldier_cannon_{water,fire,earth}.png` — 화차 3장

직접 확인한 것:
- 모두 32×32, 투명 배경, 불투명 색 7~13개, 반투명 픽셀 없음.
- 기존 병사 9장과 실제 크기·확대 화면으로 비교.
- 기존 9장 파일 해시가 작업 전과 동일함.

그리는 데 쓴 방법:
- **둘 다**: 내장 이미지 생성으로 원본 제작 후, 코드로 축소·투명 처리·기존 유약 팔레트 적용·픽셀 정리.

못 한 것 / 걱정되는 것:
- 저장소 Python 검사와 게임 화면 확인은 지시서대로 Claude의 후속 확인으로 남겼습니다.
- 작업 중 별도로 나타난 `battlefield.png`, `fx/`, `sheet-04.png`는 제가 만든 파일이 아닙니다.
- 자체 규격 확인은 통과했으며, **미술 판단은 사용자 몫입니다.**
