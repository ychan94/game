# 로고 (2026-11-28)

시작 때 git status --porcelain: (비어 있음)

- 2026-11-28 "KILNBORN 이거만 해서 이름 정하자" / "로고도 Codex 지시서로 만들어줘."
  → handoff-11.md: ui/logo.png (320×80) + ui/app_icon.png (64×64). 시작 화면은 logo.png 가 있으면 그것을 씀 (kiln_scene.gd _draw_title_front)
  → 앱 아이콘은 그림을 확인한 뒤 project.godot config/icon 에 연결할 것

## 2026-11-28 codex-check 검사 ("codex-check 올렸어. 검사해줘.")
- 지시서 09 (컷신 3장 + title_bg): 결과: 통과 보고. check_sprites — 크기·색 수 통과, 컷신 '배경 불투명'은 칸을 꽉 채우는 일러스트라 의도대로. 게임 화면(컷신·시작 화면) 확인 → main 반영
- 지시서 10·11: Codex 기록이 이미지 생성 중간에서 끊김 (handoff-10.log, handoff-11.log). 결과 그림 없음 → 다시 돌려야 함
- 브랜치의 project.godot(편집기 머리글·aspect 기본값), reports/boss, 예전 작업 스크린샷 폴더들은 넣지 않음
