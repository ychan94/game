OpenAI Codex v0.172.0
--------
workdir: C:\Users\pc\Documents\game
model: gpt-6-astra
provider: openai
approval: never
sandbox: workspace-write [workdir, /tmp, $TMPDIR]
reasoning effort: high
reasoning summaries: none
session id: 01a21c5b-c3ae-7720-9c03-20b9378c7bb3
--------
user
# Codex 작업 지시서 — 실감 나는 배경과 이펙트 (HD-2D)

- 날짜: 2026-11-27
- 작업 폴더: work/2026-11-27-실감/
- 지시서 번호: 04

## 먼저 읽을 것
1. AGENTS.md
2. art/references/ — 정한 그림체 (캐릭터는 이 픽셀 그림체 그대로)
3. docs/그림-목록.md, art/sprite_list.json 의 "실감 (배경·이펙트)" 묶음
4. work/2026-11-27-실감/NOTES.md (왜 이 작업을 하는지)

## 목표 (사용자 말 그대로)
> "전체적으로 잘 비교가 되기는 하는데, 아직도 배경이나 스킬 에셋, 파이프라인이 너무 어색해. 실물 같은 느낌으로 보완해야할 것 같아."

해석(참고용): 'HD-2D' 방향. 캐릭터는 지금 픽셀 그림 그대로 두고, **배경은 한 장짜리 그림으로 깊이와 공기가 있게**, **스킬·타격 이펙트는 여러 장면짜리 애니메이션으로** 바꾼다. 게임은 이미 이 그림들을 재생할 준비가 되어 있다 (파일만 넣으면 지금의 코드 효과 대신 쓰인다). 빛·안개·반딧불·등불·비네트는 게임이 코드로 더한다.

## 정한 그림체 (반드시 따른다)
- 캐릭터와 어울리는 픽셀 아트 (흐리게 다듬지 않음). 배경은 색을 더 써도 된다 (96색 이하)
- 바탕은 먹색·흙 회색조로 차분하게, 강한 색은 유약·기운에만: 청자 비취 초록(물) / 진사 구리 빨강(불) / 흑유 검은 갈색 + 기름 광택(땅)
- 금색은 요변 기운(legend_aura)에만
- 배경은 캐릭터가 잘 보이도록 어둡고 채도 낮게. 집·캐릭터는 배경에 그리지 않는다

## 그리는 방법 (사용자가 정한 것)
- [x] 이미지 생성 후 코드로 다듬기 (크기 맞추기·배경 투명·색 줄이기) — 사용자가 handoff-01 에서 정함 (2026-11-27)

정한 방법을 쓸 수 없으면 다른 방법으로 바꾸지 말고 `결과: 못 돌림` 으로 보고한다.

## 만들 것 (11장)

| 파일 | 크기 | 내용 |
|---|---|---|
| `assets/sprites/field/battlefield.png` | 640×260 | 밤의 전장 배경 한 장 (위에서 비스듬히 내려다봄). 왼쪽 끝(가로 0~112px)은 마을 마당(다져진 흙, 듬성한 풀 — 집 6채와 돌담은 게임이 그 위에 그리므로 비워 둔다), 가운데를 가로질러 마을로 이어지는 흙길, 길 양옆은 밤 풀밭·돌·풀 포기, 오른쪽 끝은 어두운 숲 가장자리. 달빛은 오른쪽 위에서. 캐릭터가 잘 보이도록 전체적으로 어둡고 채도 낮게, 큰 물체(나무·바위)는 위쪽·아래쪽 가장자리에만. 집과 캐릭터는 그리지 않는다 (게임이 그 위에 그림). 픽셀 아트, 흐림 없음. |
| `assets/sprites/fx/fire_wall.png` | 384×48 (8장면 × 48×48) | 합동 기술 '화염 파도'의 불기둥 한 칸. 아래에서 위로 넘실대는 불길, 하얀 노랑 심지 → 주황 → 붉은 끝. 8장면이 이어지면 계속 타오르는 고리. 한 장면 48×48, 가로로 8장면 이어 붙인 한 줄 (전체 384×48). 투명 배경. 빛나는 부분은 밝게 (게임이 빛을 더하는 방식으로 겹쳐 그림). |
| `assets/sprites/fx/water_wave.png` | 384×48 (8장면 × 48×48) | 합동 기술 '해일'의 물마루 한 칸. 왼쪽에서 오른쪽으로 부서지는 파도, 청자 비취색 물 + 하얀 물보라. 8장면 고리. 한 장면 48×48, 가로로 8장면 이어 붙인 한 줄 (전체 384×48). 투명 배경. 빛나는 부분은 밝게 (게임이 빛을 더하는 방식으로 겹쳐 그림). |
| `assets/sprites/fx/earth_crack.png` | 288×48 (6장면 × 48×48) | 합동 기술 '지진'. 땅이 세로로 갈라지며 흙과 돌조각이 튀어 오름, 흑유 검갈색 + 갈라진 틈의 주황빛. 6장면 (열렸다 가라앉음). 한 장면 48×48, 가로로 6장면 이어 붙인 한 줄 (전체 288×48). 투명 배경. 빛나는 부분은 밝게 (게임이 빛을 더하는 방식으로 겹쳐 그림). |
| `assets/sprites/fx/hit_spark.png` | 128×32 (4장면 × 32×32) | 속성 없는 타격 섬광. 하얀 십자·별 모양 섬광이 번쩍였다 사라짐. 4장면. 한 장면 32×32, 가로로 4장면 이어 붙인 한 줄 (전체 128×32). 투명 배경. 빛나는 부분은 밝게 (게임이 빛을 더하는 방식으로 겹쳐 그림). |
| `assets/sprites/fx/slash.png` | 240×48 (5장면 × 48×48) | 창 찌르기·베기 궤적. 오른쪽을 향한 하얀 초승달 궤적이 그어졌다 흩어짐. 5장면. 한 장면 48×48, 가로로 5장면 이어 붙인 한 줄 (전체 240×48). 투명 배경. 빛나는 부분은 밝게 (게임이 빛을 더하는 방식으로 겹쳐 그림). |
| `assets/sprites/fx/fire_burst.png` | 192×32 (6장면 × 32×32) | 불 속성 타격: 작은 불꽃 폭발과 불티. 6장면. 한 장면 32×32, 가로로 6장면 이어 붙인 한 줄 (전체 192×32). 투명 배경. 빛나는 부분은 밝게 (게임이 빛을 더하는 방식으로 겹쳐 그림). |
| `assets/sprites/fx/splash.png` | 192×32 (6장면 × 32×32) | 물 속성 타격: 물보라와 물방울이 튀었다 떨어짐. 6장면. 한 장면 32×32, 가로로 6장면 이어 붙인 한 줄 (전체 192×32). 투명 배경. 빛나는 부분은 밝게 (게임이 빛을 더하는 방식으로 겹쳐 그림). |
| `assets/sprites/fx/dust.png` | 192×32 (6장면 × 32×32) | 땅 속성 타격: 흙먼지와 작은 돌조각. 6장면. 한 장면 32×32, 가로로 6장면 이어 붙인 한 줄 (전체 192×32). 투명 배경. 빛나는 부분은 밝게 (게임이 빛을 더하는 방식으로 겹쳐 그림). |
| `assets/sprites/fx/death_poof.png` | 192×32 (6장면 × 32×32) | 도깨비가 쓰러질 때: 푸른 도깨비불 연기가 피어올랐다 흩어짐. 6장면. 한 장면 32×32, 가로로 6장면 이어 붙인 한 줄 (전체 192×32). 투명 배경. 빛나는 부분은 밝게 (게임이 빛을 더하는 방식으로 겹쳐 그림). |
| `assets/sprites/fx/legend_aura.png` | 384×48 (8장면 × 48×48) | 요변 병사 발밑에서 맴도는 금빛 기운 (원 모양 빛 고리 + 반짝이). 8장면 고리. 한 장면 48×48, 가로로 8장면 이어 붙인 한 줄 (전체 384×48). 투명 배경. 빛나는 부분은 밝게 (게임이 빛을 더하는 방식으로 겹쳐 그림). |

### 이펙트 그림 형식 (중요)
- 한 파일 = **정사각형 장면들을 가로 한 줄로 이어 붙인 것** (예: 48×48 장면 8개 → 384×48). 게임이 (가로 ÷ 세로) 로 장면 수를 센다
- 장면 순서 = 재생 순서. 게임은 초당 20장면으로 재생한다
- 투명 배경, 빛나는 부분은 밝게 (게임이 빛을 더하는 방식으로 겹쳐 그린다). 마지막 장면은 거의 사라진 모습
- 모든 이펙트는 오른쪽을 향해 그린다 (왼쪽 방향은 게임이 뒤집는다)

## 고쳐도 되는 범위
- `assets/sprites/field/battlefield.png` (새 파일)
- `assets/sprites/fx/fire_wall.png` (새 파일)
- `assets/sprites/fx/water_wave.png` (새 파일)
- `assets/sprites/fx/earth_crack.png` (새 파일)
- `assets/sprites/fx/hit_spark.png` (새 파일)
- `assets/sprites/fx/slash.png` (새 파일)
- `assets/sprites/fx/fire_burst.png` (새 파일)
- `assets/sprites/fx/splash.png` (새 파일)
- `assets/sprites/fx/dust.png` (새 파일)
- `assets/sprites/fx/death_poof.png` (새 파일)
- `assets/sprites/fx/legend_aura.png` (새 파일)

이 목록에 없는 파일은 만들거나 고치지 않는다.

## 보호 검사 결과 (Claude가 미리 확인함)
- `python3 scripts/protected.py <위 파일들>` → 걸린 파일 없음 (모두 새 파일)
- 이 검사는 Claude가 했다. Codex는 다시 돌리지 않는다.

## 하면 안 되는 일
- 범위 밖 파일 수정·삭제 (특히 `src/`, `tests/`, `art/references/`, `art/rubric.md`, 다른 `assets/sprites/`)
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
- 예) 크기·장면 수·투명 배경을 눈으로 확인
그리는 데 쓴 방법:
- 이미지 생성 / 코드 / 둘 다 (무엇을 어떻게)
못 한 것 / 걱정되는 것:
- …
```
- 저장소의 Python 검사를 못 돌린 것만으로는 `못 돌림`이 아니다. 검사는 Claude가 한다.

## Claude가 받은 뒤 할 일
1. `git status` — 바뀐 파일이 위 범위뿐인지
2. `python3 scripts/check_sprites.py --group "실감 (배경·이펙트)" --sheet work/2026-11-27-실감/sheet-04.png` — 크기·장면 수·빈 장면·색 수
3. 게임 화면 스크린샷 (`tests/screens_proto.gd`): 전투 중·합동 기술 파도·타격·쓰러짐을 찍어 직접 본다. 이펙트는 움직임이 중요하니 가능하면 사용자에게 직접 해 보게 한다
4. `python3 scripts/test.py --stage all`
5. 사용자에게 보여 주고 "검사는 통과, 미술 판단은 사용자 몫" — 허락을 받은 뒤 커밋

warning: Codex is ignoring 1 unrecognized configuration setting. Check for typos or deprecated settings.
  user (C:\Users\pc\.codex\config.toml): `computer_use.windows.always_allowed_app_ids` is ignored.
warning: Codex is ignoring 1 unrecognized configuration setting. Check for typos or deprecated settings.
  user (C:\Users\pc\.codex\config.toml): `computer_use.windows.always_allowed_app_ids` is ignored.
codex
지정된 그림체와 작업 메모를 읽고, 이미지 생성 후 크기·투명도·색 수를 다듬는 방식으로 진행하겠습니다. 수정 범위는 요청하신 PNG 11개로 제한하겠습니다.

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content AGENTS.md; Get-Content PROTECTED.txt; Get-Content 'C:\\Users\\pc\\.codex\\skills\\.system\\imagegen\\SKILL.md'; Get-Content 'work/2026-11-27-실감/NOTES.md'; Get-Content 'docs/그림-목록.md'; Get-Content art/sprite_list.json; rg --files art/references; git status --porcelain" in C:\Users\pc\Documents\game
 succeeded in 524ms:
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
# 2026-11-27 ?ㅺ컧 ?섎뒗 諛곌꼍쨌?ㅽ궗쨌洹몃━??諛⑹떇 (HD-2D)

## ?묒뾽 ?쒖옉 ??git status --porcelain
(蹂寃??놁쓬. 而댄벂??履쎌뿉 handoff-03 洹몃┝쨌6bf5447 ???꾩쭅 ???щ씪??

## ?ъ슜??留?(洹몃?濡?
- 2026-11-27 "?꾩껜?곸쑝濡???鍮꾧탳媛 ?섍린???섎뒗?? ?꾩쭅??諛곌꼍?대굹 ?ㅽ궗 ?먯뀑, ?뚯씠?꾨씪?몄씠 ?덈Т ?댁깋?? ?ㅻЪ 媛숈? ?먮굦?쇰줈 蹂댁셿?댁빞??寃?媛숈븘."
  ??吏꾨떒: ??諛곌꼍 = 32px ? ???諛섎났(源딆씠쨌鍮쎛룰났湲??놁쓬) ???ㅽ궗 = 肄붾뱶濡?洹몃┛ ?몃え쨌????洹몃━??諛⑹떇 = 640횞400 ??댁긽?꾨? ?섎젮??鍮쎛룹뿰湲곌퉴吏 怨꾨떒泥섎읆 源⑥쭚
  ??諛⑺뼢 HD-2D: 罹먮┃?곕뒗 ?쎌? 洹몃?濡? 諛곌꼍쨌鍮쎛룹씠?숉듃???ㅺ컧 ?섍쾶
  ??肄붾뱶: 怨좏빐?곷룄濡?洹몃━湲?project.godot ??而댄벂??履?而ㅻ컠怨?寃뱀튂吏 ?딄쾶 ?ㅽ뻾 以묒뿉 諛붽퓞), ?꾩옣 遺꾩쐞湲??숆만쨌?щ튆쨌?덇컻쨌諛섎뵩遺댟룸벑遺댟룸퉬?ㅽ듃), ?댄럺???좊땲硫붿씠???ъ깮 ?μ튂
  ??Codex(吏?쒖꽌 04): 諛??꾩옣 諛곌꼍 洹몃┝, ?댄럺???좊땲硫붿씠??

## ??寃?(肄붾뱶, ?ㅽ겕由곗꺑 1280횞800 ?쇰줈 ?뺤씤)
- 洹몃━湲? 1280횞800 (?ㅽ뻾 以?canvas_items), 痢?5媛???諛붾떏 / ?룹링(洹몃┝?먃룸뮮鍮쎛룹븞媛쑣룸떖鍮? / 湲곕낯(罹먮┃?걔톃I) / 鍮쏆링(媛?? / ?욎링(???덇컻쨌?몃Ⅸ 諛ㅒ룸퉬?ㅽ듃)
- 諛붾떏: 32px ? ???諛섎났 ??肄붾뱶濡?留뚮뱺 ????諛??諛?룸쭏?꾨줈 ?댁뼱吏???숆만쨌?먭컝쨌?뙿룸떎?몄쭊 留덈떦) + 留덉쓣 ?뚮떞. Codex 諛곌꼍(field/battlefield)???ㅻ㈃ 洹멸구 ?
- 怨듦린: ??? ?덇컻 ?먮쫫, ?щ튆, 諛섎뵩遺? 留덉쓣 ?깅텋(?쇰쟻?? 吏묒씠 遺?쒖?硫?爰쇱쭚)
- ?⑸룞 湲곗닠: ?몃え쨌?ㅻえ ???낆옄 (遺?= ??ㅻⅤ??遺덇만 踰? 臾?= 臾쇰낫??+ ?섏? 臾쇰쭏猷? ??= ?숇㉫吏쨌?뚯“媛?+ 媛덈씪吏?以?, 遺덇만 瑗щ━ 吏㏐쾶
- ?댄럺???좊땲硫붿씠???ъ깮 ?μ튂(play_fx): fx 洹몃┝???덉쑝硫??寃㈑룸쿋湲걔룹벐?ъ쭚쨌?⑸룞 湲곗닠 踰승룹슂蹂 湲곗슫???곌퀬, ?놁쑝硫?肄붾뱶 ?④낵. ?꾩떆 洹몃┝?쇰줈 ?ъ깮 ?뺤씤 ??吏?
- 洹몃┝ 紐⑸줉 +11 (諛곌꼍 1, ?댄럺??10), check_sprites: ?λ㈃ ?샕룸퉰 ?λ㈃쨌洹몃┝蹂??????쒕룄, ?댄럺?몃뒗 遺?쒕윭??媛?μ옄由??덉슜
- Codex 吏?쒖꽌: work/2026-11-27-?ㅺ컧/handoff-04.md
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

### 媛留덉쓽 蹂묒궗 ????蹂묒궗 4醫?(12?? 吏?쒖꽌 `work/2026-11-28-?ㅻ벉湲?handoff-05.md`)

戮묎린濡??섏삤??蹂묒궗媛 7醫낆씠 ?섎㈃??異붽? (2026-11-28). 洹몃┝???놁쑝硫?鍮꾩듂??蹂묒궗 洹몃┝ + 肄붾뱶 ?뚰뭹?쇰줈 ?꾩떆 ?쒖떆.

| ?뚯씪 | ?ш린 | ?댁슜 |
|---|---|---|
| `kiln/soldier_{axe,cavalry,healer,cannon}_{water,fire,earth}.png` | 32횞32 횞12 | ?꾨겮蹂??쒕Ь) 쨌 湲곕쭏蹂??쒕Ь, ??留먯뿉 ?? 쨌 臾대떦(洹?? 諛⑹슱쨌?ㅼ깋 泥? 쨌 ?붿감(洹?? ?좉린???섎젅 + 蹂묒궗). 湲곗〈 蹂묒궗 9?κ낵 ??踰?|

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

### ?ㅺ컧 (諛곌꼍쨌?댄럺?? ??HD-2D (吏?쒖꽌 `work/2026-11-27-?ㅺ컧/handoff-04.md`)

罹먮┃?곕뒗 ?쎌? 洹몃?濡? 諛곌꼍쨌?댄럺?몃뒗 ?ㅺ컧 ?섍쾶. 鍮쎛룹븞媛쑣룸컲?㏓텋쨌?깅텋쨌鍮꾨꽕?몃뒗 寃뚯엫??肄붾뱶濡??뷀븳??

| ?뚯씪 | ?ш린 | ?댁슜 |
|---|---|---|
| `field/battlefield.png` | 640횞260 | 諛??꾩옣 諛곌꼍 ????(?쇱そ 0~112px 留덉쓣 留덈떦? 鍮꾩썙 ?? ?숆만쨌?諛?룹댉 媛?μ옄由? 96???댄븯) |
| `fx/fire_wall.png` 쨌 `water_wave.png` | 48횞48 횞 8?λ㈃ | ?⑸룞 湲곗닠 ?붿뿼 ?뚮룄 쨌 ?댁씪 |
| `fx/earth_crack.png` | 48횞48 횞 6?λ㈃ | ?⑸룞 湲곗닠 吏吏?|
| `fx/hit_spark` 쨌 `slash` | 32횞32횞4 쨌 48횞48횞5 | ?寃??ш킅 쨌 李뚮Ⅴ湲?沅ㅼ쟻 |
| `fx/fire_burst` 쨌 `splash` 쨌 `dust` | 32횞32 횞 6?λ㈃ | 遺댟룸Ъ쨌???寃?|
| `fx/death_poof` 쨌 `legend_aura` | 32횞32횞6 쨌 48횞48횞8 | ?곕윭吏????곌린 쨌 ?붾? 湲덈튆 湲곗슫 |

?댄럺???뺤떇: ?뺤궗媛곹삎 ?λ㈃??媛濡???以꾨줈 ?댁뼱 遺숈엫. 寃뚯엫? 珥덈떦 20?λ㈃?쇰줈 ?ъ깮, ?ㅻⅨ履??μ쑝濡?洹몃━硫??쇱そ? 寃뚯엫???ㅼ쭛?붾떎.

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
    },
    {
      "path": "assets/sprites/field/battlefield.png",
      "size": [
        640,
        260
      ],
      "group": "?ㅺ컧 (諛곌꼍쨌?댄럺??",
      "tile": true,
      "max_colors": 96,
      "what": "諛ㅼ쓽 ?꾩옣 諛곌꼍 ????(?꾩뿉??鍮꾩뒪?ы엳 ?대젮?ㅻ큵). ?쇱そ ??媛濡?0~112px)? 留덉쓣 留덈떦(?ㅼ졇吏??? ?ъ꽦??? ??吏?6梨꾩? ?뚮떞? 寃뚯엫??洹??꾩뿉 洹몃━誘濡?鍮꾩썙 ?붾떎), 媛?대뜲瑜?媛濡쒖쭏??留덉쓣濡??댁뼱吏???숆만, 湲??묒쁿? 諛??諛?룸룎쨌? ?ш린, ?ㅻⅨ履??앹? ?대몢????媛?μ옄由? ?щ튆? ?ㅻⅨ履??꾩뿉?? 罹먮┃?곌? ??蹂댁씠?꾨줉 ?꾩껜?곸쑝濡??대몼怨?梨꾨룄 ??쾶, ??臾쇱껜(?섎Т쨌諛붿쐞)???꾩そ쨌?꾨옒履?媛?μ옄由ъ뿉留? 吏묎낵 罹먮┃?곕뒗 洹몃━吏 ?딅뒗??(寃뚯엫??洹??꾩뿉 洹몃┝). ?쎌? ?꾪듃, ?먮┝ ?놁쓬."
    },
    {
      "path": "assets/sprites/fx/fire_wall.png",
      "size": [
        384,
        48
      ],
      "frame": [
        48,
        48
      ],
      "frames": 8,
      "group": "?ㅺ컧 (諛곌꼍쨌?댄럺??",
      "fx": true,
      "max_colors": 32,
      "what": "?⑸룞 湲곗닠 '?붿뿼 ?뚮룄'??遺덇린????移? ?꾨옒?먯꽌 ?꾨줈 ?섏떎???遺덇만, ?섏? ?몃옉 ?ъ? ??二쇳솴 ??遺됱? ?? 8?λ㈃???댁뼱吏硫?怨꾩냽 ??ㅻⅤ??怨좊━. ???λ㈃ 48횞48, 媛濡쒕줈 8?λ㈃ ?댁뼱 遺숈씤 ??以?(?꾩껜 384횞48). ?щ챸 諛곌꼍. 鍮쏅굹??遺遺꾩? 諛앷쾶 (寃뚯엫??鍮쏆쓣 ?뷀븯??諛⑹떇?쇰줈 寃뱀퀜 洹몃┝)."
    },
    {
      "path": "assets/sprites/fx/water_wave.png",
      "size": [
        384,
        48
      ],
      "frame": [
        48,
        48
      ],
      "frames": 8,
      "group": "?ㅺ컧 (諛곌꼍쨌?댄럺??",
      "fx": true,
      "max_colors": 32,
      "what": "?⑸룞 湲곗닠 '?댁씪'??臾쇰쭏猷???移? ?쇱そ?먯꽌 ?ㅻⅨ履쎌쑝濡?遺?쒖????뚮룄, 泥?옄 鍮꾩랬??臾?+ ?섏? 臾쇰낫?? 8?λ㈃ 怨좊━. ???λ㈃ 48횞48, 媛濡쒕줈 8?λ㈃ ?댁뼱 遺숈씤 ??以?(?꾩껜 384횞48). ?щ챸 諛곌꼍. 鍮쏅굹??遺遺꾩? 諛앷쾶 (寃뚯엫??鍮쏆쓣 ?뷀븯??諛⑹떇?쇰줈 寃뱀퀜 洹몃┝)."
    },
    {
      "path": "assets/sprites/fx/earth_crack.png",
      "size": [
        288,
        48
      ],
      "frame": [
        48,
        48
      ],
      "frames": 6,
      "group": "?ㅺ컧 (諛곌꼍쨌?댄럺??",
      "fx": true,
      "max_colors": 32,
      "what": "?⑸룞 湲곗닠 '吏吏?. ?낆씠 ?몃줈濡?媛덈씪吏硫??숆낵 ?뚯“媛곸씠 ????ㅻ쫫, ?묒쑀 寃媛덉깋 + 媛덈씪吏??덉쓽 二쇳솴鍮? 6?λ㈃ (?대졇??媛?쇱븠??. ???λ㈃ 48횞48, 媛濡쒕줈 6?λ㈃ ?댁뼱 遺숈씤 ??以?(?꾩껜 288횞48). ?щ챸 諛곌꼍. 鍮쏅굹??遺遺꾩? 諛앷쾶 (寃뚯엫??鍮쏆쓣 ?뷀븯??諛⑹떇?쇰줈 寃뱀퀜 洹몃┝)."
    },
    {
      "path": "assets/sprites/fx/hit_spark.png",
      "size": [
        128,
        32
      ],
      "frame": [
        32,
        32
      ],
      "frames": 4,
      "group": "?ㅺ컧 (諛곌꼍쨌?댄럺??",
      "fx": true,
      "max_colors": 32,
      "what": "?띿꽦 ?녿뒗 ?寃??ш킅. ?섏? ??옄쨌蹂?紐⑥뼇 ?ш킅??踰덉찉????щ씪吏? 4?λ㈃. ???λ㈃ 32횞32, 媛濡쒕줈 4?λ㈃ ?댁뼱 遺숈씤 ??以?(?꾩껜 128횞32). ?щ챸 諛곌꼍. 鍮쏅굹??遺遺꾩? 諛앷쾶 (寃뚯엫??鍮쏆쓣 ?뷀븯??諛⑹떇?쇰줈 寃뱀퀜 洹몃┝)."
    },
    {
      "path": "assets/sprites/fx/slash.png",
      "size": [
        240,
        48
      ],
      "frame": [
        48,
        48
      ],
      "frames": 5,
      "group": "?ㅺ컧 (諛곌꼍쨌?댄럺??",
      "fx": true,
      "max_colors": 32,
      "what": "李?李뚮Ⅴ湲걔룸쿋湲?沅ㅼ쟻. ?ㅻⅨ履쎌쓣 ?ν븳 ?섏? 珥덉듅??沅ㅼ쟻??洹몄뼱議뚮떎 ?⑹뼱吏? 5?λ㈃. ???λ㈃ 48횞48, 媛濡쒕줈 5?λ㈃ ?댁뼱 遺숈씤 ??以?(?꾩껜 240횞48). ?щ챸 諛곌꼍. 鍮쏅굹??遺遺꾩? 諛앷쾶 (寃뚯엫??鍮쏆쓣 ?뷀븯??諛⑹떇?쇰줈 寃뱀퀜 洹몃┝)."
    },
    {
      "path": "assets/sprites/fx/fire_burst.png",
      "size": [
        192,
        32
      ],
      "frame": [
        32,
        32
      ],
      "frames": 6,
      "group": "?ㅺ컧 (諛곌꼍쨌?댄럺??",
      "fx": true,
      "max_colors": 32,
      "what": "遺??띿꽦 ?寃? ?묒? 遺덇퐙 ??컻怨?遺덊떚. 6?λ㈃. ???λ㈃ 32횞32, 媛濡쒕줈 6?λ㈃ ?댁뼱 遺숈씤 ??以?(?꾩껜 192횞32). ?щ챸 諛곌꼍. 鍮쏅굹??遺遺꾩? 諛앷쾶 (寃뚯엫??鍮쏆쓣 ?뷀븯??諛⑹떇?쇰줈 寃뱀퀜 洹몃┝)."
    },
    {
      "path": "assets/sprites/fx/splash.png",
      "size": [
        192,
        32
      ],
      "frame": [
        32,
        32
      ],
      "frames": 6,
      "group": "?ㅺ컧 (諛곌꼍쨌?댄럺??",
      "fx": true,
      "max_colors": 32,
      "what": "臾??띿꽦 ?寃? 臾쇰낫?쇱? 臾쇰갑?몄씠 ??덈떎 ?⑥뼱吏? 6?λ㈃. ???λ㈃ 32횞32, 媛濡쒕줈 6?λ㈃ ?댁뼱 遺숈씤 ??以?(?꾩껜 192횞32). ?щ챸 諛곌꼍. 鍮쏅굹??遺遺꾩? 諛앷쾶 (寃뚯엫??鍮쏆쓣 ?뷀븯??諛⑹떇?쇰줈 寃뱀퀜 洹몃┝)."
    },
    {
      "path": "assets/sprites/fx/dust.png",
      "size": [
        192,
        32
      ],
      "frame": [
        32,
        32
      ],
      "frames": 6,
      "group": "?ㅺ컧 (諛곌꼍쨌?댄럺??",
      "fx": true,
      "max_colors": 32,
      "what": "???띿꽦 ?寃? ?숇㉫吏? ?묒? ?뚯“媛? 6?λ㈃. ???λ㈃ 32횞32, 媛濡쒕줈 6?λ㈃ ?댁뼱 遺숈씤 ??以?(?꾩껜 192횞32). ?щ챸 諛곌꼍. 鍮쏅굹??遺遺꾩? 諛앷쾶 (寃뚯엫??鍮쏆쓣 ?뷀븯??諛⑹떇?쇰줈 寃뱀퀜 洹몃┝)."
    },
    {
      "path": "assets/sprites/fx/death_poof.png",
      "size": [
        192,
        32
      ],
      "frame": [
        32,
        32
      ],
      "frames": 6,
      "group": "?ㅺ컧 (諛곌꼍쨌?댄럺??",
      "fx": true,
      "max_colors": 32,
      "what": "?꾧묠鍮꾧? ?곕윭吏??? ?몃Ⅸ ?꾧묠鍮꾨텋 ?곌린媛 ?쇱뼱?щ옄???⑹뼱吏? 6?λ㈃. ???λ㈃ 32횞32, 媛濡쒕줈 6?λ㈃ ?댁뼱 遺숈씤 ??以?(?꾩껜 192횞32). ?щ챸 諛곌꼍. 鍮쏅굹??遺遺꾩? 諛앷쾶 (寃뚯엫??鍮쏆쓣 ?뷀븯??諛⑹떇?쇰줈 寃뱀퀜 洹몃┝)."
    },
    {
      "path": "assets/sprites/fx/legend_aura.png",
      "size": [
        384,
        48
      ],
      "frame": [
        48,
        48
      ],
      "frames": 8,
      "group": "?ㅺ컧 (諛곌꼍쨌?댄럺??",
      "fx": true,
      "max_colors": 32,
      "what": "?붾? 蹂묒궗 諛쒕컩?먯꽌 留대룄??湲덈튆 湲곗슫 (??紐⑥뼇 鍮?怨좊━ + 諛섏쭩??. 8?λ㈃ 怨좊━. ???λ㈃ 48횞48, 媛濡쒕줈 8?λ㈃ ?댁뼱 遺숈씤 ??以?(?꾩껜 384횞48). ?щ챸 諛곌꼍. 鍮쏅굹??遺遺꾩? 諛앷쾶 (寃뚯엫??鍮쏆쓣 ?뷀븯??諛⑹떇?쇰줈 寃뱀퀜 洹몃┝)."
    },
    {
      "path": "assets/sprites/kiln/soldier_axe_water.png",
      "size": [
        32,
        32
      ],
      "group": "媛留덉쓽 蹂묒궗 (??蹂묒궗 4醫?",
      "what": "?좎빟 諛붾Ⅸ ?꾩옄湲??명삎 蹂묒궗 (?щ엺???꾨땲??鍮싳? ?명삎: 留ㅻ걟??紐? ?쇱そ ????愿묓깮 1~2px, 諛쒕컩???묒? 諛쏆묠(援?)(?꾨겮蹂?. ???몃궇 ?꾨겮瑜????먯쑝濡???紐⑥뒿. 李쎈퀝蹂대떎 ?닿묠媛 ?볤퀬 ?щ컯?섎떎. 紐??꾩껜??泥?옄 ?좎빟 ??鍮꾩랬鍮?留묒? ?뱀깋. ?ㅻⅨ履쎌쓣 蹂몃떎."
    },
    {
      "path": "assets/sprites/kiln/soldier_axe_fire.png",
      "size": [
        32,
        32
      ],
      "group": "媛留덉쓽 蹂묒궗 (??蹂묒궗 4醫?",
      "what": "?좎빟 諛붾Ⅸ ?꾩옄湲??명삎 蹂묒궗 (?щ엺???꾨땲??鍮싳? ?명삎: 留ㅻ걟??紐? ?쇱そ ????愿묓깮 1~2px, 諛쒕컩???묒? 諛쏆묠(援?)(?꾨겮蹂?. ???몃궇 ?꾨겮瑜????먯쑝濡???紐⑥뒿. 李쎈퀝蹂대떎 ?닿묠媛 ?볤퀬 ?щ컯?섎떎. 紐??꾩껜??吏꾩궗 ?좎빟 ??援щ━鍮?源딆? 遺됱??? ?ㅻⅨ履쎌쓣 蹂몃떎."
    },
    {
      "path": "assets/sprites/kiln/soldier_axe_earth.png",
      "size": [
        32,
        32
      ],
      "group": "媛留덉쓽 蹂묒궗 (??蹂묒궗 4醫?",
      "what": "?좎빟 諛붾Ⅸ ?꾩옄湲??명삎 蹂묒궗 (?щ엺???꾨땲??鍮싳? ?명삎: 留ㅻ걟??紐? ?쇱そ ????愿묓깮 1~2px, 諛쒕컩???묒? 諛쏆묠(援?)(?꾨겮蹂?. ???몃궇 ?꾨겮瑜????먯쑝濡???紐⑥뒿. 李쎈퀝蹂대떎 ?닿묠媛 ?볤퀬 ?щ컯?섎떎. 紐??꾩껜???묒쑀 ?좎빟 ??寃? 媛덉깋??湲곕쫫 媛숈? 愿묓깮. ?ㅻⅨ履쎌쓣 蹂몃떎."
    },
    {
      "path": "assets/sprites/kiln/soldier_cavalry_water.png",
      "size": [
        32,
        32
      ],
      "group": "媛留덉쓽 蹂묒궗 (??蹂묒궗 4醫?",
      "what": "?좎빟 諛붾Ⅸ ?꾩옄湲??명삎 蹂묒궗 (?щ엺???꾨땲??鍮싳? ?명삎: 留ㅻ걟??紐? ?쇱そ ????愿묓깮 1~2px, 諛쒕컩???묒? 諛쏆묠(援?)(湲곕쭏蹂?. ?숈쑝濡?鍮싳? ?묒? 留먯뿉 ?щ씪??紐⑥뒿, 吏㏃? 李? 留먮룄 媛숈? ?좎빟 (32횞32 ?덉뿉 留먭낵 ?щ엺 紐⑤몢). 紐??꾩껜??泥?옄 ?좎빟 ??鍮꾩랬鍮?留묒? ?뱀깋. ?ㅻⅨ履쎌쓣 蹂몃떎."
    },
    {
      "path": "assets/sprites/kiln/soldier_cavalry_fire.png",
      "size": [
        32,
        32
      ],
      "group": "媛留덉쓽 蹂묒궗 (??蹂묒궗 4醫?",
      "what": "?좎빟 諛붾Ⅸ ?꾩옄湲??명삎 蹂묒궗 (?щ엺???꾨땲??鍮싳? ?명삎: 留ㅻ걟??紐? ?쇱そ ????愿묓깮 1~2px, 諛쒕컩???묒? 諛쏆묠(援?)(湲곕쭏蹂?. ?숈쑝濡?鍮싳? ?묒? 留먯뿉 ?щ씪??紐⑥뒿, 吏㏃? 李? 留먮룄 媛숈? ?좎빟 (32횞32 ?덉뿉 留먭낵 ?щ엺 紐⑤몢). 紐??꾩껜??吏꾩궗 ?좎빟 ??援щ━鍮?源딆? 遺됱??? ?ㅻⅨ履쎌쓣 蹂몃떎."
    },
    {
      "path": "assets/sprites/kiln/soldier_cavalry_earth.png",
      "size": [
        32,
        32
      ],
      "group": "媛留덉쓽 蹂묒궗 (??蹂묒궗 4醫?",
      "what": "?좎빟 諛붾Ⅸ ?꾩옄湲??명삎 蹂묒궗 (?щ엺???꾨땲??鍮싳? ?명삎: 留ㅻ걟??紐? ?쇱そ ????愿묓깮 1~2px, 諛쒕컩???묒? 諛쏆묠(援?)(湲곕쭏蹂?. ?숈쑝濡?鍮싳? ?묒? 留먯뿉 ?щ씪??紐⑥뒿, 吏㏃? 李? 留먮룄 媛숈? ?좎빟 (32횞32 ?덉뿉 留먭낵 ?щ엺 紐⑤몢). 紐??꾩껜???묒쑀 ?좎빟 ??寃? 媛덉깋??湲곕쫫 媛숈? 愿묓깮. ?ㅻⅨ履쎌쓣 蹂몃떎."
    },
    {
      "path": "assets/sprites/kiln/soldier_healer_water.png",
      "size": [
        32,
        32
      ],
      "group": "媛留덉쓽 蹂묒궗 (??蹂묒궗 4醫?",
      "what": "?좎빟 諛붾Ⅸ ?꾩옄湲??명삎 蹂묒궗 (?щ엺???꾨땲??鍮싳? ?명삎: 留ㅻ걟??紐? ?쇱そ ????愿묓깮 1~2px, 諛쒕컩???묒? 諛쏆묠(援?)(臾대떦). 諛⑹슱怨??ㅼ깋 泥쒖쓣 ??紐⑥뒿, 媛????怨좉퉼. 臾닿린 ?놁쓬. 紐??꾩껜??泥?옄 ?좎빟 ??鍮꾩랬鍮?留묒? ?뱀깋. ?ㅻⅨ履쎌쓣 蹂몃떎."
    },
    {
      "path": "assets/sprites/kiln/soldier_healer_fire.png",
      "size": [
        32,
        32
      ],
      "group": "媛留덉쓽 蹂묒궗 (??蹂묒궗 4醫?",
      "what": "?좎빟 諛붾Ⅸ ?꾩옄湲??명삎 蹂묒궗 (?щ엺???꾨땲??鍮싳? ?명삎: 留ㅻ걟??紐? ?쇱そ ????愿묓깮 1~2px, 諛쒕컩???묒? 諛쏆묠(援?)(臾대떦). 諛⑹슱怨??ㅼ깋 泥쒖쓣 ??紐⑥뒿, 媛????怨좉퉼. 臾닿린 ?놁쓬. 紐??꾩껜??吏꾩궗 ?좎빟 ??援щ━鍮?源딆? 遺됱??? ?ㅻⅨ履쎌쓣 蹂몃떎."
    },
    {
      "path": "assets/sprites/kiln/soldier_healer_earth.png",
      "size": [
        32,
        32
      ],
      "group": "媛留덉쓽 蹂묒궗 (??蹂묒궗 4醫?",
      "what": "?좎빟 諛붾Ⅸ ?꾩옄湲??명삎 蹂묒궗 (?щ엺???꾨땲??鍮싳? ?명삎: 留ㅻ걟??紐? ?쇱そ ????愿묓깮 1~2px, 諛쒕컩???묒? 諛쏆묠(援?)(臾대떦). 諛⑹슱怨??ㅼ깋 泥쒖쓣 ??紐⑥뒿, 媛????怨좉퉼. 臾닿린 ?놁쓬. 紐??꾩껜???묒쑀 ?좎빟 ??寃? 媛덉깋??湲곕쫫 媛숈? 愿묓깮. ?ㅻⅨ履쎌쓣 蹂몃떎."
    },
    {
      "path": "assets/sprites/kiln/soldier_cannon_water.png",
      "size": [
        32,
        32
      ],
      "group": "媛留덉쓽 蹂묒궗 (??蹂묒궗 4醫?",
      "what": "?좎빟 諛붾Ⅸ ?꾩옄湲??명삎 蹂묒궗 (?щ엺???꾨땲??鍮싳? ?명삎: 留ㅻ걟??紐? ?쇱そ ????愿묓깮 1~2px, 諛쒕컩???묒? 諛쏆묠(援?)(?붿감). 諛뷀??щ┛ ?섎Т ?섎젅(?붿감)???좉린???듭씠 ?щ윭 媛?苑귦? ?덇퀬 ?놁뿉 蹂묒궗 ?섎굹. ?섎젅 ?섎Т???숇튆, 蹂묒궗? ???앹뿉 ?좎빟. 紐??꾩껜??泥?옄 ?좎빟 ??鍮꾩랬鍮?留묒? ?뱀깋. ?ㅻⅨ履쎌쓣 蹂몃떎."
    },
    {
      "path": "assets/sprites/kiln/soldier_cannon_fire.png",
      "size": [
        32,
        32
      ],
      "group": "媛留덉쓽 蹂묒궗 (??蹂묒궗 4醫?",
      "what": "?좎빟 諛붾Ⅸ ?꾩옄湲??명삎 蹂묒궗 (?щ엺???꾨땲??鍮싳? ?명삎: 留ㅻ걟??紐? ?쇱そ ????愿묓깮 1~2px, 諛쒕컩???묒? 諛쏆묠(援?)(?붿감). 諛뷀??щ┛ ?섎Т ?섎젅(?붿감)???좉린???듭씠 ?щ윭 媛?苑귦? ?덇퀬 ?놁뿉 蹂묒궗 ?섎굹. ?섎젅 ?섎Т???숇튆, 蹂묒궗? ???앹뿉 ?좎빟. 紐??꾩껜??吏꾩궗 ?좎빟 ??援щ━鍮?源딆? 遺됱??? ?ㅻⅨ履쎌쓣 蹂몃떎."
    },
    {
      "path": "assets/sprites/kiln/soldier_cannon_earth.png",
      "size": [
        32,
        32
      ],
      "group": "媛留덉쓽 蹂묒궗 (??蹂묒궗 4醫?",
      "what": "?좎빟 諛붾Ⅸ ?꾩옄湲??명삎 蹂묒궗 (?щ엺???꾨땲??鍮싳? ?명삎: 留ㅻ걟??紐? ?쇱そ ????愿묓깮 1~2px, 諛쒕컩???묒? 諛쏆묠(援?)(?붿감). 諛뷀??щ┛ ?섎Т ?섎젅(?붿감)???좉린???듭씠 ?щ윭 媛?苑귦? ?덇퀬 ?놁뿉 蹂묒궗 ?섎굹. ?섎젅 ?섎Т???숇튆, 蹂묒궗? ???앹뿉 ?좎빟. 紐??꾩껜???묒쑀 ?좎빟 ??寃? 媛덉깋??湲곕쫫 媛숈? 愿묓깮. ?ㅻⅨ履쎌쓣 蹂몃떎."
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
art/references\soldier_spear_fire.png
art/references\soldier_shield_earth.png
art/references\soldier_archer_water.png
art/references\sheet.png
art/references\README.md
art/references\house.png
art/references\goblin.png
art/references\creature_shield_water.png
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

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -Encoding UTF8 'C:\\Users\\pc\\.codex\\skills\\.system\\imagegen\\SKILL.md'; Get-Content -Encoding UTF8 'work/2026-11-27-실감/NOTES.md'; Get-Content -Encoding UTF8 PROTECTED.txt; rg --files art/references; git status --porcelain; Get-Content -Encoding UTF8 'docs/그림-목록.md' | Select-String '실감' -Context 4,55; Get-Content -Encoding UTF8 art/sprite_list.json | Select-String '실감' -Context 0,145" in C:\Users\pc\Documents\game
 succeeded in 466ms:
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
# 2026-11-27 실감 나는 배경·스킬·그리는 방식 (HD-2D)

## 작업 시작 때 git status --porcelain
(변경 없음. 컴퓨터 쪽에 handoff-03 그림·6bf5447 이 아직 안 올라옴)

## 사용자 말 (그대로)
- 2026-11-27 "전체적으로 잘 비교가 되기는 하는데, 아직도 배경이나 스킬 에셋, 파이프라인이 너무 어색해. 실물 같은 느낌으로 보완해야할 것 같아."
  → 진단: ① 배경 = 32px 풀 타일 반복(깊이·빛·공기 없음) ② 스킬 = 코드로 그린 세모·선 ③ 그리는 방식 = 640×400 저해상도를 늘려서 빛·연기까지 계단처럼 깨짐
  → 방향 HD-2D: 캐릭터는 픽셀 그대로, 배경·빛·이펙트는 실감 나게
  → 코드: 고해상도로 그리기(project.godot 는 컴퓨터 쪽 커밋과 겹치지 않게 실행 중에 바꿈), 전장 분위기(흙길·달빛·안개·반딧불·등불·비네트), 이펙트 애니메이션 재생 장치
  → Codex(지시서 04): 밤 전장 배경 그림, 이펙트 애니메이션

## 한 것 (코드, 스크린샷 1280×800 으로 확인)
- 그리기: 1280×800 (실행 중 canvas_items), 층 5개 — 바닥 / 뒷층(그림자·뒷빛·안개·달빛) / 기본(캐릭터·UI) / 빛층(가산) / 앞층(앞 안개·푸른 밤·비네트)
- 바닥: 32px 풀 타일 반복 → 코드로 만든 한 장(밤 풀밭·마을로 이어지는 흙길·자갈·돌·다져진 마당) + 마을 돌담. Codex 배경(field/battlefield)이 오면 그걸 씀
- 공기: 낮은 안개 흐름, 달빛, 반딧불, 마을 등불(일렁임, 집이 부서지면 꺼짐)
- 합동 기술: 세모·네모 → 입자 (불 = 타오르는 불길 벽, 물 = 물보라 + 하얀 물마루, 땅 = 흙먼지·돌조각 + 갈라진 줄), 불길 꼬리 짧게
- 이펙트 애니메이션 재생 장치(play_fx): fx 그림이 있으면 타격·베기·쓰러짐·합동 기술 벽·요변 기운에 쓰고, 없으면 코드 효과. 임시 그림으로 재생 확인 후 지움
- 그림 목록 +11 (배경 1, 이펙트 10), check_sprites: 장면 수·빈 장면·그림별 색 수 한도, 이펙트는 부드러운 가장자리 허용
- Codex 지시서: work/2026-11-27-실감/handoff-04.md
# 사용자가 직접 고친 파일 / 덮어쓰면 안 되는 파일 (한 줄에 하나, glob 가능)
# Claude·Codex는 여기 적힌 파일을 덮어쓰지 않는다. 고쳐야 하면 바꿀 내용을 제안만 한다.
art/references/*
art/rubric.md
art/references\soldier_spear_fire.png
art/references\soldier_shield_earth.png
art/references\soldier_archer_water.png
art/references\sheet.png
art/references\README.md
art/references\house.png
art/references\goblin.png
art/references\creature_shield_water.png
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

  | `enemy/brute.png` | 48×48 | 큰 도깨비 — 같은 먹빛 남색, 방망이 |
  | `field/grass_a.png`, `grass_b.png` | 32×32 | 밤 풀밭 타일 (이어 붙여도 이음새 없이) |
  | `field/house.png`, `house_broken.png` | 32×32 | 초가집/한옥, 부서진 모습 |
  
> ### 실감 (배경·이펙트) — HD-2D (지시서 `work/2026-11-27-실감/handoff-04.md`)
  
> 캐릭터는 픽셀 그대로, 배경·이펙트는 실감 나게. 빛·안개·반딧불·등불·비네트는 게임이 코드로 더한다.
  
  | 파일 | 크기 | 내용 |
  |---|---|---|
  | `field/battlefield.png` | 640×260 | 밤 전장 배경 한 장 (왼쪽 0~112px 마을 마당은 비워 둠, 흙길·풀밭·숲 가장자리, 96색 이하) |
  | `fx/fire_wall.png` · `water_wave.png` | 48×48 × 8장면 | 합동 기술 화염 파도 · 해일 |
  | `fx/earth_crack.png` | 48×48 × 6장면 | 합동 기술 지진 |
  | `fx/hit_spark` · `slash` | 32×32×4 · 48×48×5 | 타격 섬광 · 찌르기 궤적 |
  | `fx/fire_burst` · `splash` · `dust` | 32×32 × 6장면 | 불·물·땅 타격 |
  | `fx/death_poof` · `legend_aura` | 32×32×6 · 48×48×8 | 쓰러질 때 연기 · 요변 금빛 기운 |
  
  이펙트 형식: 정사각형 장면을 가로 한 줄로 이어 붙임. 게임은 초당 20장면으로 재생, 오른쪽 향으로 그리면 왼쪽은 게임이 뒤집는다.
  
  ## 공통 규칙
  
  - PNG, 정확한 크기, 투명 배경 (바닥 타일만 꽉 채움)
  - 픽셀 아트: 흐리게 다듬지 않는다 (안티에일리어싱 없음), 한 장에 색 24개 이하
  - 외곽선 1px, 캐릭터는 가운데, 발은 아래에서 3~5px 위
  - 아군은 오른쪽, 적은 왼쪽을 본다
  - 요변·전설의 무지개 빛, 상품의 반짝임, 맞았을 때 하얗게 번쩍임은 **게임이 코드로** 그린다 — 그림에 넣지 않는다
>       "group": "실감 (배경·이펙트)",
        "tile": true,
        "max_colors": 96,
        "what": "밤의 전장 배경 한 장 (위에서 비스듬히 내려다봄). 왼쪽 끝(가로 0~112px)은 마을 마당(다져진 흙, 듬성한 풀 — 집 6채와 돌담은 게임이 그 위에 그리므로 비워 둔다), 가
운데를 가로질러 마을로 이어지는 흙길, 길 양옆은 밤 풀밭·돌·풀 포기, 오른쪽 끝은 어두운 숲 가장자리. 달빛은 오른쪽 위에서. 캐릭터가 잘 보이도록 전체적으로 어둡고 채도 낮게, 큰 물체(나무·바위)는 위쪽·아
래쪽 가장자리에만. 집과 캐릭터는 그리지 않는다 (게임이 그 위에 그림). 픽셀 아트, 흐림 없음."
      },
      {
        "path": "assets/sprites/fx/fire_wall.png",
        "size": [
          384,
          48
        ],
        "frame": [
          48,
          48
        ],
        "frames": 8,
>       "group": "실감 (배경·이펙트)",
        "fx": true,
        "max_colors": 32,
        "what": "합동 기술 '화염 파도'의 불기둥 한 칸. 아래에서 위로 넘실대는 불길, 하얀 노랑 심지 → 주황 → 붉은 끝. 8장면이 이어지면 계속 타오르는 고리. 한 장면 48×48, 가로로 8
장면 이어 붙인 한 줄 (전체 384×48). 투명 배경. 빛나는 부분은 밝게 (게임이 빛을 더하는 방식으로 겹쳐 그림)."
      },
      {
        "path": "assets/sprites/fx/water_wave.png",
        "size": [
          384,
          48
        ],
        "frame": [
          48,
          48
        ],
        "frames": 8,
>       "group": "실감 (배경·이펙트)",
        "fx": true,
        "max_colors": 32,
        "what": "합동 기술 '해일'의 물마루 한 칸. 왼쪽에서 오른쪽으로 부서지는 파도, 청자 비취색 물 + 하얀 물보라. 8장면 고리. 한 장면 48×48, 가로로 8장면 이어 붙인 한 줄 (전체 
384×48). 투명 배경. 빛나는 부분은 밝게 (게임이 빛을 더하는 방식으로 겹쳐 그림)."
      },
      {
        "path": "assets/sprites/fx/earth_crack.png",
        "size": [
          288,
          48
        ],
        "frame": [
          48,
          48
        ],
        "frames": 6,
>       "group": "실감 (배경·이펙트)",
        "fx": true,
        "max_colors": 32,
        "what": "합동 기술 '지진'. 땅이 세로로 갈라지며 흙과 돌조각이 튀어 오름, 흑유 검갈색 + 갈라진 틈의 주황빛. 6장면 (열렸다 가라앉음). 한 장면 48×48, 가로로 6장면 이어 붙인 
한 줄 (전체 288×48). 투명 배경. 빛나는 부분은 밝게 (게임이 빛을 더하는 방식으로 겹쳐 그림)."
      },
      {
        "path": "assets/sprites/fx/hit_spark.png",
        "size": [
          128,
          32
        ],
        "frame": [
          32,
          32
        ],
        "frames": 4,
>       "group": "실감 (배경·이펙트)",
        "fx": true,
        "max_colors": 32,
        "what": "속성 없는 타격 섬광. 하얀 십자·별 모양 섬광이 번쩍였다 사라짐. 4장면. 한 장면 32×32, 가로로 4장면 이어 붙인 한 줄 (전체 128×32). 투명 배경. 빛나는 부분은 밝
게 (게임이 빛을 더하는 방식으로 겹쳐 그림)."
      },
      {
        "path": "assets/sprites/fx/slash.png",
        "size": [
          240,
          48
        ],
        "frame": [
          48,
          48
        ],
        "frames": 5,
>       "group": "실감 (배경·이펙트)",
        "fx": true,
        "max_colors": 32,
        "what": "창 찌르기·베기 궤적. 오른쪽을 향한 하얀 초승달 궤적이 그어졌다 흩어짐. 5장면. 한 장면 48×48, 가로로 5장면 이어 붙인 한 줄 (전체 240×48). 투명 배경. 빛나는 부
분은 밝게 (게임이 빛을 더하는 방식으로 겹쳐 그림)."
      },
      {
        "path": "assets/sprites/fx/fire_burst.png",
        "size": [
          192,
          32
        ],
        "frame": [
          32,
          32
        ],
        "frames": 6,
>       "group": "실감 (배경·이펙트)",
        "fx": true,
        "max_colors": 32,
        "what": "불 속성 타격: 작은 불꽃 폭발과 불티. 6장면. 한 장면 32×32, 가로로 6장면 이어 붙인 한 줄 (전체 192×32). 투명 배경. 빛나는 부분은 밝게 (게임이 빛을 더하는 방
식으로 겹쳐 그림)."
      },
      {
        "path": "assets/sprites/fx/splash.png",
        "size": [
          192,
          32
        ],
        "frame": [
          32,
          32
        ],
        "frames": 6,
>       "group": "실감 (배경·이펙트)",
        "fx": true,
        "max_colors": 32,
        "what": "물 속성 타격: 물보라와 물방울이 튀었다 떨어짐. 6장면. 한 장면 32×32, 가로로 6장면 이어 붙인 한 줄 (전체 192×32). 투명 배경. 빛나는 부분은 밝게 (게임이 빛을 
더하는 방식으로 겹쳐 그림)."
      },
      {
        "path": "assets/sprites/fx/dust.png",
        "size": [
          192,
          32
        ],
        "frame": [
          32,
          32
        ],
        "frames": 6,
>       "group": "실감 (배경·이펙트)",
        "fx": true,
        "max_colors": 32,
        "what": "땅 속성 타격: 흙먼지와 작은 돌조각. 6장면. 한 장면 32×32, 가로로 6장면 이어 붙인 한 줄 (전체 192×32). 투명 배경. 빛나는 부분은 밝게 (게임이 빛을 더하는 방식
으로 겹쳐 그림)."
      },
      {
        "path": "assets/sprites/fx/death_poof.png",
        "size": [
          192,
          32
        ],
        "frame": [
          32,
          32
        ],
        "frames": 6,
>       "group": "실감 (배경·이펙트)",
        "fx": true,
        "max_colors": 32,
        "what": "도깨비가 쓰러질 때: 푸른 도깨비불 연기가 피어올랐다 흩어짐. 6장면. 한 장면 32×32, 가로로 6장면 이어 붙인 한 줄 (전체 192×32). 투명 배경. 빛나는 부분은 밝게 (
게임이 빛을 더하는 방식으로 겹쳐 그림)."
      },
      {
        "path": "assets/sprites/fx/legend_aura.png",
        "size": [
          384,
          48
        ],
        "frame": [
          48,
          48
        ],
        "frames": 8,
>       "group": "실감 (배경·이펙트)",
        "fx": true,
        "max_colors": 32,
        "what": "요변 병사 발밑에서 맴도는 금빛 기운 (원 모양 빛 고리 + 반짝이). 8장면 고리. 한 장면 48×48, 가로로 8장면 이어 붙인 한 줄 (전체 384×48). 투명 배경. 빛나는 
부분은 밝게 (게임이 빛을 더하는 방식으로 겹쳐 그림)."
      },
      {
        "path": "assets/sprites/kiln/soldier_axe_water.png",
        "size": [
          32,
          32
        ],
        "group": "가마의 병사 (새 병사 4종)",
        "what": "유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(도끼병). 큰 외날 도끼를 두 손으로 든 모습. 창병보다 
어깨가 넓고 투박하다. 몸 전체에 청자 유약 — 비취빛 맑은 녹색. 오른쪽을 본다."
      },
      {
        "path": "assets/sprites/kiln/soldier_axe_fire.png",
        "size": [
          32,
          32
        ],
        "group": "가마의 병사 (새 병사 4종)",
        "what": "유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(도끼병). 큰 외날 도끼를 두 손으로 든 모습. 창병보다 
어깨가 넓고 투박하다. 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다."
      },
      {
        "path": "assets/sprites/kiln/soldier_axe_earth.png",
        "size": [
          32,
          32
        ],
        "group": "가마의 병사 (새 병사 4종)",
        "what": "유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(도끼병). 큰 외날 도끼를 두 손으로 든 모습. 창병보다 
어깨가 넓고 투박하다. 몸 전체에 흑유 유약 — 검은 갈색에 기름 같은 광택. 오른쪽을 본다."
      },
      {
        "path": "assets/sprites/kiln/soldier_cavalry_water.png",
        "size": [
          32,
          32
        ],
        "group": "가마의 병사 (새 병사 4종)",
        "what": "유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(기마병). 흙으로 빚은 작은 말에 올라탄 모습, 짧은 창.
 말도 같은 유약 (32×32 안에 말과 사람 모두). 몸 전체에 청자 유약 — 비취빛 맑은 녹색. 오른쪽을 본다."
      },
      {
        "path": "assets/sprites/kiln/soldier_cavalry_fire.png",
        "size": [
          32,
          32
        ],
        "group": "가마의 병사 (새 병사 4종)",
        "what": "유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(기마병). 흙으로 빚은 작은 말에 올라탄 모습, 짧은 창.
 말도 같은 유약 (32×32 안에 말과 사람 모두). 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다."
      },
      {
        "path": "assets/sprites/kiln/soldier_cavalry_earth.png",
        "size": [
          32,
          32
        ],
        "group": "가마의 병사 (새 병사 4종)",
        "what": "유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(기마병). 흙으로 빚은 작은 말에 올라탄 모습, 짧은 창.
 말도 같은 유약 (32×32 안에 말과 사람 모두). 몸 전체에 흑유 유약 — 검은 갈색에 기름 같은 광택. 오른쪽을 본다."
      },
      {
        "path": "assets/sprites/kiln/soldier_healer_water.png",
        "size": [
          32,
          32
        ],
        "group": "가마의 병사 (새 병사 4종)",
        "what": "유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(무당). 방울과 오색 천을 든 모습, 갓 대신 고깔. 무기
 없음. 몸 전체에 청자 유약 — 비취빛 맑은 녹색. 오른쪽을 본다."
      },
      {
        "path": "assets/sprites/kiln/soldier_healer_fire.png",
        "size": [
          32,
          32
        ],
        "group": "가마의 병사 (새 병사 4종)",
        "what": "유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(무당). 방울과 오색 천을 든 모습, 갓 대신 고깔. 무기
 없음. 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다."
      },
      {
        "path": "assets/sprites/kiln/soldier_healer_earth.png",
        "size": [
          32,
          32
        ],
        "group": "가마의 병사 (새 병사 4종)",
        "what": "유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(무당). 방울과 오색 천을 든 모습, 갓 대신 고깔. 무기
 없음. 몸 전체에 흑유 유약 — 검은 갈색에 기름 같은 광택. 오른쪽을 본다."
      },
      {
        "path": "assets/sprites/kiln/soldier_cannon_water.png",
        "size": [
          32,
          32
        ],
        "group": "가마의 병사 (새 병사 4종)",
        "what": "유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(화차). 바퀴 달린 나무 수레(화차)에 신기전 통이 여러 
개 꽂혀 있고 옆에 병사 하나. 수레 나무는 흙빛, 병사와 통 끝에 유약. 몸 전체에 청자 유약 — 비취빛 맑은 녹색. 오른쪽을 본다."
      },
      {
        "path": "assets/sprites/kiln/soldier_cannon_fire.png",
        "size": [
          32,
          32
        ],
        "group": "가마의 병사 (새 병사 4종)",
        "what": "유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(화차). 바퀴 달린 나무 수레(화차)에 신기전 통이 여러 
개 꽂혀 있고 옆에 병사 하나. 수레 나무는 흙빛, 병사와 통 끝에 유약. 몸 전체에 진사 유약 — 구리빛 깊은 붉은색. 오른쪽을 본다."
      },
      {
        "path": "assets/sprites/kiln/soldier_cannon_earth.png",
        "size": [
          32,
          32
        ],
        "group": "가마의 병사 (새 병사 4종)",
        "what": "유약 바른 도자기 인형 병사 (사람이 아니라 빚은 인형: 매끈한 몸, 왼쪽 위 흰 광택 1~2px, 발밑에 작은 받침(굽))(화차). 바퀴 달린 나무 수레(화차)에 신기전 통이 여러 
개 꽂혀 있고 옆에 병사 하나. 수레 나무는 흙빛, 병사와 통 끝에 유약. 몸 전체에 흑유 유약 — 검은 갈색에 기름 같은 광택. 오른쪽을 본다."
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



2026-11-27T09:35:28.666099Z ERROR codex_memories_write::phase2::agent: memory consolidation artifacts are invalid: memory summary artifact does not start with v1: C:\Users\pc\.codex\memories_v2\memory_summary.md
codex
`imagegen` 스킬을 적용합니다. 기준 그림의 먹색·흙색을 배경에 맞추고, 이펙트는 속성별 색과 장면별 움직임을 구분하겠습니다. 이번 지시서의 파일 제한에 따라 NOTES.md도 수정하지 않겠습니다.

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -Encoding UTF8 'work/2026-11-27-실감/NOTES.md'; Get-Content -Encoding UTF8 art/references/README.md; Get-Content -Encoding UTF8 AGENTS.md | Select-Object -First 45; Get-Command magick,node -ErrorAction SilentlyContinue | Select-Object Name,Source; Get-ChildItem 'C:\\Users\\pc\\.codex\\generated_images' -ErrorAction SilentlyContinue | Select-Object -First 3 Name" in C:\Users\pc\Documents\game
 succeeded in 2561ms:
# 2026-11-27 실감 나는 배경·스킬·그리는 방식 (HD-2D)

## 작업 시작 때 git status --porcelain
(변경 없음. 컴퓨터 쪽에 handoff-03 그림·6bf5447 이 아직 안 올라옴)

## 사용자 말 (그대로)
- 2026-11-27 "전체적으로 잘 비교가 되기는 하는데, 아직도 배경이나 스킬 에셋, 파이프라인이 너무 어색해. 실물 같은 느낌으로 보완해야할 것 같아."
  → 진단: ① 배경 = 32px 풀 타일 반복(깊이·빛·공기 없음) ② 스킬 = 코드로 그린 세모·선 ③ 그리는 방식 = 640×400 저해상도를 늘려서 빛·연기까지 계단처럼 깨짐
  → 방향 HD-2D: 캐릭터는 픽셀 그대로, 배경·빛·이펙트는 실감 나게
  → 코드: 고해상도로 그리기(project.godot 는 컴퓨터 쪽 커밋과 겹치지 않게 실행 중에 바꿈), 전장 분위기(흙길·달빛·안개·반딧불·등불·비네트), 이펙트 애니메이션 재생 장치
  → Codex(지시서 04): 밤 전장 배경 그림, 이펙트 애니메이션

## 한 것 (코드, 스크린샷 1280×800 으로 확인)
- 그리기: 1280×800 (실행 중 canvas_items), 층 5개 — 바닥 / 뒷층(그림자·뒷빛·안개·달빛) / 기본(캐릭터·UI) / 빛층(가산) / 앞층(앞 안개·푸른 밤·비네트)
- 바닥: 32px 풀 타일 반복 → 코드로 만든 한 장(밤 풀밭·마을로 이어지는 흙길·자갈·돌·다져진 마당) + 마을 돌담. Codex 배경(field/battlefield)이 오면 그걸 씀
- 공기: 낮은 안개 흐름, 달빛, 반딧불, 마을 등불(일렁임, 집이 부서지면 꺼짐)
- 합동 기술: 세모·네모 → 입자 (불 = 타오르는 불길 벽, 물 = 물보라 + 하얀 물마루, 땅 = 흙먼지·돌조각 + 갈라진 줄), 불길 꼬리 짧게
- 이펙트 애니메이션 재생 장치(play_fx): fx 그림이 있으면 타격·베기·쓰러짐·합동 기술 벽·요변 기운에 쓰고, 없으면 코드 효과. 임시 그림으로 재생 확인 후 지움
- 그림 목록 +11 (배경 1, 이펙트 10), check_sprites: 장면 수·빈 장면·그림별 색 수 한도, 이펙트는 부드러운 가장자리 허용
- Codex 지시서: work/2026-11-27-실감/handoff-04.md
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

Name                                 Source                          
----                                 ------                          
node.exe                             C:\Program Files\nodejs\node.exe
01a17b34-065b-7263-b1ed-f66611ee2903                                 
01a19224-dfc5-7e80-a2af-ac7f0037c5a4                                 
01a1d80c-85ef-7bd3-925f-3e92bcdbe92e                                 



mcp: node_repl/js started
mcp: node_repl/js (failed)
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Get-Content -Encoding UTF8 AGENTS.md | Select-Object -Skip 45; Get-Content -Encoding UTF8 art/sprite_list.json | ConvertFrom-Json | Select-Object -ExpandProperty PSObject | Select-Object -ExpandProperty Properties | Select-Object Name; Get-ChildItem assets/sprites/fx -ErrorAction SilentlyContinue; Test-Path assets/sprites/field/battlefield.png' in C:\Users\pc\Documents\game
 succeeded in 625ms:

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
Select-Object : "PSObject" 속성을 찾을 수 없습니다.
위치 줄:2 문자:133
+ ... n | ConvertFrom-Json | Select-Object -ExpandProperty PSObject | Selec ...
+                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidArgument: (@{version=1; 공통...ystem.Object[]}:PSObject) [Select-Object], PSArgumen 
   tException
    + FullyQualifiedErrorId : ExpandPropertyNotFound,Microsoft.PowerShell.Commands.SelectObjectCommand
 
False

mcp: node_repl/js started
mcp: node_repl/js (failed)
codex
배경 원본과 불기둥 8장면을 생성했습니다. 생성된 시트는 게임 규격과 크기가 달라, 장면별 비율과 바닥 위치를 유지하며 정해진 칸에 맞추겠습니다.

mcp: node_repl/js started
mcp: node_repl/js (completed)
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-ChildItem 'C:\\Users\\pc\\.codex' -Directory | Select-Object Name; Get-ChildItem 'C:\\Users\\pc\\AppData\\Roaming\\npm\\node_modules' -Directory -ErrorAction SilentlyContinue | Select-Object Name" in C:\Users\pc\Documents\game
 succeeded in 357ms:

Name               
----               
.sandbox           
.sandbox-bin       
.sandbox-secrets   
.tmp               
ambient-suggestions
attachments        
browser            
cache              
computer-use       
generated_images   
log                
memories_v2        
node_repl          
pets               
plugins            
sessions           
skills             
sqlite             
thread-writer-locks
tmp                
vendor_imports     
visualizations     
@openai            



exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-ChildItem 'C:\\Program Files\\WindowsApps\\OpenAI.Codex_26.1117.4957.0_x64__2p2nqsd0c76g0\\app\\resources\\cua_node' -Directory; Get-ChildItem 'C:\\Users\\pc\\.codex\\node_repl' -Directory" in C:\Users\pc\Documents\game
 succeeded in 360ms:


    디렉터리: C:\Program Files\WindowsApps\OpenAI.Codex_26.1117.4957.0_x64__2p2nqsd0c76g0\app\resources\cua_node


Mode                 LastWriteTime         Length Name                                                                 
----                 -------------         ------ ----                                                                 
d-----        2026-11-21   오후 6:03                bin                                                                  


    디렉터리: C:\Users\pc\.codex\node_repl


Mode                 LastWriteTime         Length Name                                                                 
----                 -------------         ------ ----                                                                 
d-----        2026-11-27   오후 6:37                active_execs                                                         



mcp: node_repl/js started
mcp: node_repl/js (completed)
codex
합동 기술 3종과 타격·베기 원본까지 생성했습니다. 후처리에서는 밝은 핵심 형태를 살리고, 반투명 가장자리의 잡티와 색 수를 정리하겠습니다. 마지막 장면의 잔상이 충분히 줄어드는지도 확인하겠습니다.

codex
11종 원본 생성이 끝났습니다. 이제 배경은 640×260·96색 이하로, 이펙트는 지정된 장면 수와 크기·32색 이하로 맞추고 최종 PNG를 확대해서 확인하겠습니다.

mcp: node_repl/js started
mcp: node_repl/js (completed)
mcp: node_repl/js started
mcp: node_repl/js (completed)
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -Encoding UTF8 scripts/check_sprites.py | Select-String 'colors|alpha|frame' -Context 2,3; rg -n 'play_fx|fire_wall|water_wave|legend_aura|fx_frames' src/game/proto_base.gd" in C:\Users\pc\Documents\game
 succeeded in 371ms:

  
  ROOT = pathlib.Path(__file__).resolve().parents[1]
> MAX_COLORS = 24
  MAX_SEMI = 0.02   # 반투명 픽셀이 2% 넘으면 '흐린 가장자리'(픽셀 아트 아님)
  
  
      if not entry.get("fx") and semi > len(px) * MAX_SEMI:
          problems.append(f"흐린 가장자리 {semi * 100 // len(px)}% (픽셀 아트는 반투명이 거의 없어야)")
>     colors = len({p[:3] for p in px if p[3] > 200})
>     limit = entry.get("max_colors", MAX_COLORS)
>     if colors > limit:
>         problems.append(f"색 {colors}개 (최대 {limit})")
>     if entry.get("frames"):
>         fw, fh = entry["frame"]
>         for i in range(entry["frames"]):
              box = img.crop((i * fw, 0, (i + 1) * fw, fh))
              if box.getbbox() is None:
                  problems.append(f"{i + 1}번째 장면이 비어 있음")
      for i, (entry, big) in enumerate(rows):
          x, y = pad + (i % per_row) * col_w, pad + (i // per_row) * row_h
>         sheet.alpha_composite(big, (x, y))
          d.text((x, y + big.height + 4), pathlib.Path(entry["path"]).stem, fill=(220, 220, 220, 255))
      sheet.save(out)
  
91:func fx_frames(name: String) -> int:
98:func play_fx(name: String, pos: Vector2, scale_k := 1.0, add := true, flip := false) -> bool:
99:	if fx_frames(name) == 0:
110:		var n := fx_frames(a["name"])
191:		if u.team == "ally" and u.tier == "legend" and fx_frames("legend_aura") > 0:
192:			var at := tex("fx/legend_aura")
193:			var an := fx_frames("legend_aura")
510:			if not play_fx("fire_burst", a["to"], 2.2, true):
531:	anims = anims.filter(func(a): return a["frame_t"] * FX_FPS / 60 < fx_frames(a["name"]))
582:	if play_fx(sheet, pos, 1.5 if big else 1.0, element != "earth", dir.x < 0.0):
613:	# 합동 기술 파도: 벽 그림(fx/fire_wall·water_wave·earth_crack)이 있으면 세로로 이어 재생, 없으면 입자
616:		var wall: String = {"fire": "fire_wall", "water": "water_wave", "earth": "earth_crack"}[el]
617:		if fx_frames(wall) > 0:
620:					play_fx(wall, Vector2(w["x"], y), 1.0, el != "earth")
647:				if not play_fx("slash", e["to"] - m["dir"] * 6.0, 1.2 if e["team"] == "ally" else 0.9, true, m["dir"].x < 0.0):
685:				if not (e["team"] == "enemy" and play_fx("death_poof", e["pos"], 2.0 if e["big"] else 1.4, true)):



mcp: node_repl/js started
mcp: node_repl/js (completed)
mcp: node_repl/js started
mcp: node_repl/js (completed)
context compacted
mcp: node_repl/js started
mcp: node_repl/js (failed)
mcp: node_repl/js started
mcp: node_repl/js (completed)
mcp: node_repl/js started
mcp: node_repl/js (completed)
codex
확대해서 보니 배경의 왼쪽 마당과 중앙 이동 공간이 비어 있고, 이펙트는 장면별 형태 변화와 마지막 잔상이 구분됩니다. 이제 지정된 11개 PNG만 저장하고 크기·색 수·투명도·빈 장면 여부를 확인하겠습니다. 게임 안에서의 움직임과 미술 판단은 별도 확인이 필요합니다.

mcp: node_repl/js started
mcp: node_repl/js (completed)
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content scripts/check_sprites.py | Select-String -Pattern 'empty|alpha|palette|color|frame' -Context 1,1" in C:\Users\pc\Documents\game
 succeeded in 342ms:

  ROOT = pathlib.Path(__file__).resolve().parents[1]
> MAX_COLORS = 24
  MAX_SEMI = 0.02   # 諛섑닾紐??쎌???2% ?섏쑝硫?'?먮┛ 媛?μ옄由?(?쎌? ?꾪듃 ?꾨떂)
          problems.append(f"?먮┛ 媛?μ옄由?{semi * 100 // len(px)}% (?쎌? ?꾪듃??諛섑닾紐낆씠 嫄곗쓽 ?놁뼱??")
>     colors = len({p[:3] for p in px if p[3] > 200})
>     limit = entry.get("max_colors", MAX_COLORS)
>     if colors > limit:
>         problems.append(f"??{colors}媛?(理쒕? {limit})")
>     if entry.get("frames"):
>         fw, fh = entry["frame"]
>         for i in range(entry["frames"]):
              box = img.crop((i * fw, 0, (i + 1) * fw, fh))
          x, y = pad + (i % per_row) * col_w, pad + (i // per_row) * row_h
>         sheet.alpha_composite(big, (x, y))
          d.text((x, y + big.height + 4), pathlib.Path(entry["path"]).stem, fill=(220, 220, 220, 255))



exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Get-Content -Encoding UTF8 scripts/check_sprites.py | Select-Object -First 105' in C:\Users\pc\Documents\game
 succeeded in 336ms:
#!/usr/bin/env python3
"""Codex가 만든 그림 검사 (Claude가 Codex 작업 뒤에 돌린다).

    python3 scripts/check_sprites.py                 # art/sprite_list.json 의 모든 그림 검사
    python3 scripts/check_sprites.py --group "가마의 병사"
    python3 scripts/check_sprites.py --sheet <출력.png>   # 모든 그림을 4배로 키운 비교 시트도 만든다

검사: 파일 있음 · 크기 정확 · 투명 배경(타일 제외, 네 모서리 투명) · 색 수 (픽셀 아트) · 흐린 가장자리(반투명 픽셀 비율)
"""
import argparse
import json
import pathlib
import sys

from PIL import Image, ImageDraw

ROOT = pathlib.Path(__file__).resolve().parents[1]
MAX_COLORS = 24
MAX_SEMI = 0.02   # 반투명 픽셀이 2% 넘으면 '흐린 가장자리'(픽셀 아트 아님)


def check(entry):
    path = ROOT / entry["path"]
    problems = []
    if not path.exists():
        return ["없음"], None
    img = Image.open(path).convert("RGBA")
    w, h = entry["size"]
    if img.size != (w, h):
        problems.append(f"크기 {img.size[0]}×{img.size[1]} (필요 {w}×{h})")
    px = list(img.get_flattened_data() if hasattr(img, "get_flattened_data") else img.getdata())
    if not entry.get("tile"):
        corners = [img.getpixel((0, 0)), img.getpixel((img.width - 1, 0)),
                   img.getpixel((0, img.height - 1)), img.getpixel((img.width - 1, img.height - 1))]
        if any(c[3] > 10 for c in corners):
            problems.append("배경이 투명하지 않음")
        opaque = [p for p in px if p[3] > 200]
        if len(opaque) < len(px) * 0.05:
            problems.append("거의 비어 있음")
    semi = sum(1 for p in px if 20 < p[3] < 235)
    if not entry.get("fx") and semi > len(px) * MAX_SEMI:
        problems.append(f"흐린 가장자리 {semi * 100 // len(px)}% (픽셀 아트는 반투명이 거의 없어야)")
    colors = len({p[:3] for p in px if p[3] > 200})
    limit = entry.get("max_colors", MAX_COLORS)
    if colors > limit:
        problems.append(f"색 {colors}개 (최대 {limit})")
    if entry.get("frames"):
        fw, fh = entry["frame"]
        for i in range(entry["frames"]):
            box = img.crop((i * fw, 0, (i + 1) * fw, fh))
            if box.getbbox() is None:
                problems.append(f"{i + 1}번째 장면이 비어 있음")
                break
    return problems, img


def make_sheet(results, out):
    cell, pad = 4, 8
    rows = []
    for entry, img in results:
        if img is not None:
            rows.append((entry, img.resize((img.width * cell, img.height * cell), Image.NEAREST)))
    if not rows:
        return
    per_row = 6
    col_w = max(r[1].width for r in rows) + pad
    row_h = max(r[1].height for r in rows) + 24
    n_rows = (len(rows) + per_row - 1) // per_row
    sheet = Image.new("RGBA", (col_w * per_row + pad, row_h * n_rows + pad), (40, 36, 48, 255))
    d = ImageDraw.Draw(sheet)
    for i, (entry, big) in enumerate(rows):
        x, y = pad + (i % per_row) * col_w, pad + (i // per_row) * row_h
        sheet.alpha_composite(big, (x, y))
        d.text((x, y + big.height + 4), pathlib.Path(entry["path"]).stem, fill=(220, 220, 220, 255))
    sheet.save(out)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--group")
    ap.add_argument("--sheet")
    a = ap.parse_args()
    spec = json.loads((ROOT / "art" / "sprite_list.json").read_text(encoding="utf-8"))
    entries = [e for e in spec["files"] if not a.group or e["group"] == a.group]
    ok = missing = bad = 0
    results = []
    for e in entries:
        problems, img = check(e)
        results.append((e, img))
        if problems == ["없음"]:
            missing += 1
            print(f"  없음   {e['path']}")
        elif problems:
            bad += 1
            print(f"  문제   {e['path']}: " + " · ".join(problems))
        else:
            ok += 1
    print(f"\n그림 {len(entries)}개: 통과 {ok} · 문제 {bad} · 없음 {missing}")
    if a.sheet:
        make_sheet(results, a.sheet)
        print(f"비교 시트: {a.sheet}")
    return 0 if bad == 0 and missing == 0 else 1


if __name__ == "__main__":

mcp: node_repl/js started
mcp: node_repl/js (completed)
mcp: node_repl/js started
mcp: node_repl/js (completed)
mcp: node_repl/js started
mcp: node_repl/js (completed)
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'git status --porcelain' in C:\Users\pc\Documents\game
 succeeded in 143ms:
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
?? "work/2026-11-28-\353\213\244\353\223\254\352\270\260/handoff-05.report.md"

codex
결과: 통과

바뀐 파일 — 지정된 PNG 11개를 새로 만들었습니다:

- [battlefield.png](/C:/Users/pc/Documents/game/assets/sprites/field/battlefield.png) — 밤 전장·빈 마을 마당·흙길
- [fire_wall.png](/C:/Users/pc/Documents/game/assets/sprites/fx/fire_wall.png) — 불기둥 8장면
- [water_wave.png](/C:/Users/pc/Documents/game/assets/sprites/fx/water_wave.png) — 비취색 파도 8장면
- [earth_crack.png](/C:/Users/pc/Documents/game/assets/sprites/fx/earth_crack.png) — 지진 6장면
- [hit_spark.png](/C:/Users/pc/Documents/game/assets/sprites/fx/hit_spark.png) — 흰 타격 섬광 4장면
- [slash.png](/C:/Users/pc/Documents/game/assets/sprites/fx/slash.png) — 오른쪽 베기 궤적 5장면
- [fire_burst.png](/C:/Users/pc/Documents/game/assets/sprites/fx/fire_burst.png) — 불꽃 폭발 6장면
- [splash.png](/C:/Users/pc/Documents/game/assets/sprites/fx/splash.png) — 물보라 6장면
- [dust.png](/C:/Users/pc/Documents/game/assets/sprites/fx/dust.png) — 흙먼지 6장면
- [death_poof.png](/C:/Users/pc/Documents/game/assets/sprites/fx/death_poof.png) — 푸른 도깨비불 6장면
- [legend_aura.png](/C:/Users/pc/Documents/game/assets/sprites/fx/legend_aura.png) — 금빛 고리 8장면

직접 확인한 것:

- 배경과 모든 이펙트 장면을 확대해서 확인했습니다.
- 저장 파일을 다시 읽어 지정 크기·장면 수·투명 배경·빈 장면 없음을 확인했습니다.
- 배경 96색, 이펙트 각각 32색 이하입니다.

그리는 데 쓴 방법:

- **둘 다** — 이미지 생성 후 JavaScript로 크기 조정, 장면 분리·배치, 투명도·색 수·선명도를 보정했습니다.

못 한 것 / 걱정되는 것:

- 저장소 Python 검사와 게임 내 재생 확인은 실행하지 않았습니다. Claude의 후속 확인이 필요합니다.
- 작업 중 다른 범위의 변경도 관찰됐으며, 해당 파일은 건드리지 않았습니다.
- 파일 형식 확인은 통과했습니다. 재미·미술 판단은 사용자 몫입니다.
tokens used
126,701
결과: 통과

바뀐 파일 — 지정된 PNG 11개를 새로 만들었습니다:

- [battlefield.png](/C:/Users/pc/Documents/game/assets/sprites/field/battlefield.png) — 밤 전장·빈 마을 마당·흙길
- [fire_wall.png](/C:/Users/pc/Documents/game/assets/sprites/fx/fire_wall.png) — 불기둥 8장면
- [water_wave.png](/C:/Users/pc/Documents/game/assets/sprites/fx/water_wave.png) — 비취색 파도 8장면
- [earth_crack.png](/C:/Users/pc/Documents/game/assets/sprites/fx/earth_crack.png) — 지진 6장면
- [hit_spark.png](/C:/Users/pc/Documents/game/assets/sprites/fx/hit_spark.png) — 흰 타격 섬광 4장면
- [slash.png](/C:/Users/pc/Documents/game/assets/sprites/fx/slash.png) — 오른쪽 베기 궤적 5장면
- [fire_burst.png](/C:/Users/pc/Documents/game/assets/sprites/fx/fire_burst.png) — 불꽃 폭발 6장면
- [splash.png](/C:/Users/pc/Documents/game/assets/sprites/fx/splash.png) — 물보라 6장면
- [dust.png](/C:/Users/pc/Documents/game/assets/sprites/fx/dust.png) — 흙먼지 6장면
- [death_poof.png](/C:/Users/pc/Documents/game/assets/sprites/fx/death_poof.png) — 푸른 도깨비불 6장면
- [legend_aura.png](/C:/Users/pc/Documents/game/assets/sprites/fx/legend_aura.png) — 금빛 고리 8장면

직접 확인한 것:

- 배경과 모든 이펙트 장면을 확대해서 확인했습니다.
- 저장 파일을 다시 읽어 지정 크기·장면 수·투명 배경·빈 장면 없음을 확인했습니다.
- 배경 96색, 이펙트 각각 32색 이하입니다.

그리는 데 쓴 방법:

- **둘 다** — 이미지 생성 후 JavaScript로 크기 조정, 장면 분리·배치, 투명도·색 수·선명도를 보정했습니다.

못 한 것 / 걱정되는 것:

- 저장소 Python 검사와 게임 내 재생 확인은 실행하지 않았습니다. Claude의 후속 확인이 필요합니다.
- 작업 중 다른 범위의 변경도 관찰됐으며, 해당 파일은 건드리지 않았습니다.
- 파일 형식 확인은 통과했습니다. 재미·미술 판단은 사용자 몫입니다.
