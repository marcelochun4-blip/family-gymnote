# AI 루틴 요청 처리 절차 (Claude 채팅에서 수동 처리)

앱에는 API 키가 없다. 가족이 앱에서 "Claude에게 루틴 요청"을 누르면 `gn_ai_requests`에 `status='pending'`으로 쌓이고,
시완이 Claude 채팅에서 "짐노트 AI 요청 처리해줘"라고 하면 Claude가 아래 순서로 처리한다.

1. 대기 목록: `select id, member_id, created_at, prompt, profile, recent, file_type, file_name, length(file_b64) from gn_ai_requests where status='pending' order by created_at;`
2. 첨부가 있으면 `file_b64`를 읽어 이미지/PDF 내용을 확인 (이미지는 앱에서 1100px JPEG로 줄여 저장됨)
3. index.html의 `EX` 운동 id만 사용해 루틴 JSON 작성
   `{"title","summary","notes","extracted":{"weight","bodyFat","muscle","other"},"days":[{"key":"A","dow"?,"title","focus","warmup","finisher","items":[{"ex","sets","min","max","weight","rest"}]}]}`
   - load: weight kg(덤벨은 한 손), assist: 보조 kg, bw/time: weight 0, time은 min/max가 초
4. 저장: `update gn_ai_requests set status='done', result='<json>'::jsonb, done_at=now() where id='<id>';`
5. 사용자가 앱에서 미리보기 확인 후 저장하면 `applied`, 버리면 `dismissed`로 바뀜
