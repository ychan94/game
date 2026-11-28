# 로고 (2026-11-28)

시작 때 git status --porcelain: (비어 있음)

- 2026-11-28 "KILNBORN 이거만 해서 이름 정하자" / "로고도 Codex 지시서로 만들어줘."
  → handoff-11.md: ui/logo.png (320×80) + ui/app_icon.png (64×64). 시작 화면은 logo.png 가 있으면 그것을 씀 (kiln_scene.gd _draw_title_front)
  → 앱 아이콘은 그림을 확인한 뒤 project.godot config/icon 에 연결할 것

## Codex 작업 시작 2026-11-28

- 2026-11-28 "로고 시안은 3개 이상 만들어 work/2026-11-28-로고/logo_options.png 비교 시트로 남기고, 고른 것과 이유를 보고에 적어 줘. 로고에는 KILNBORN 한 단어만 넣어."
  → 시안 3개, 비교 시트, 최종 로고와 아이콘. 이미지 생성 후 코드 보정. 허용 범위만 기록·출력.

시작 때 git status --porcelain:
```text
 M reports/boss/history.csv
 M "work/2026-11-27-\352\267\270\353\246\274/NOTES.md"
 M "work/2026-11-27-\352\267\270\353\246\274/handoff-03.md"
?? assets/sprites/fx/cutin_earth.png
?? assets/sprites/fx/cutin_earth.png.import
?? assets/sprites/fx/cutin_fire.png
?? assets/sprites/fx/cutin_fire.png.import
?? assets/sprites/fx/cutin_water.png
?? assets/sprites/fx/cutin_water.png.import
?? assets/sprites/ui/title_bg.png
?? assets/sprites/ui/title_bg.png.import
?? reports/boss/history-local-backup.csv
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
?? "work/2026-11-28-\353\241\234\352\263\240/handoff-11.log"
?? "work/2026-11-28-\355\221\234\354\247\200/NOTES.md"
?? "work/2026-11-28-\355\221\234\354\247\200/handoff-10.log"
?? "work/2026-11-28-\355\221\234\354\247\200/reference-contact.png"
?? "work/2026-11-29-\354\212\244\355\202\254\354\247\204\354\230\201/handoff-07.report.md"
?? "work/2026-11-29-\354\212\244\355\202\254\354\247\204\354\230\201/screens-07/"
?? "work/2026-11-29-\354\212\244\355\202\254\354\247\204\354\230\201/sheet-07a.png"
?? "work/2026-11-29-\354\212\244\355\202\254\354\247\204\354\230\201/sheet-07b.png"
?? "work/2026-11-30-UI\352\267\270\353\246\274/handoff-08.report.md"
?? "work/2026-11-30-UI\352\267\270\353\246\274/handoff-09-run1/"
?? "work/2026-11-30-UI\352\267\270\353\246\274/handoff-09-run2.log"
?? "work/2026-11-30-UI\352\267\270\353\246\274/handoff-09.report.md"
?? "work/2026-11-30-UI\352\267\270\353\246\274/screens-08/"
?? "work/2026-11-30-UI\352\267\270\353\246\274/screens-09/"
?? "work/2026-11-30-UI\352\267\270\353\246\274/sheet-08.png"
?? "work/2026-11-30-UI\352\267\270\353\246\274/sheet-09.png"
?? work/art-ui08/
?? work/art-ui09/
```

