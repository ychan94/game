# Codex 작업 지시서

- 날짜: YYYY-MM-DD
- 작업 폴더: work/YYYY-MM-DD-작업이름/
- 지시서 번호: NN

## 먼저 읽을 것
1. AGENTS.md
2. art/rubric.md 와 art/references/ (우리 그림체)
3. work/…/NOTES.md (이 작업에서 정한 것)
4. (관련 파일 경로)

## 목표 (사용자 말 그대로)
> "여기에 사용자가 한 말을 한 글자도 바꾸지 않고 붙인다"

해석(참고용): …

## 고쳐도 되는 범위
- art/sprites/… (파일/폴더를 하나하나)

이 목록에 없는 파일은 만들거나 고치지 않는다.

## 보호 검사 결과 (Claude가 미리 확인함)
- `python3 scripts/protected.py <범위의 기존 파일>` → 걸린 파일 없음
- 이 검사는 Claude가 했다. Codex는 다시 돌리지 않는다.

## 하면 안 되는 일
- 범위 밖 파일 수정·삭제
- PROTECTED.txt 에 있는 파일 덮어쓰기
- 저장소의 Python 스크립트 실행 (검사·테스트는 Claude가 작업 후에 한다)
- art/references/, art/rubric.md, 검사 기준(test_map.json, art/loop_config.json) 수정
- git commit / push
- 못 했는데 했다고 보고하기

## 끝나면 이 형식으로 보고
```
결과: 통과 | 실패 | 못 돌림   ← 셋 중 하나만
바뀐 파일:
- 경로 — 무엇을
직접 확인한 것:
- 예) 그림 크기·투명 배경을 눈으로 확인 (Python 검사는 Claude 몫이므로 적지 않아도 됨)
만든 렌더/그림:
- 경로
못 한 것 / 걱정되는 것:
- …
```
- 통과: 목표대로 만들었다
- 실패: 만들었지만 목표에 못 미친다 (이유를 적는다)
- 못 돌림: 도구·권한·파일이 없어서 작업 자체를 하지 못했다 (무엇이 없었는지 적는다)
- 저장소의 Python 검사를 못 돌린 것만으로는 `못 돌림`이 아니다. 검사는 Claude가 한다.
