# Switchboard protocol

Read before routing an update/question through the `mcp__mcp_browser__switchboard_*` family. `development-workflow` owns progress, input-needed and completion-notice requirements.

Before each new update or question, call `switchboard_get_status`. Use `switchboard_notify_user` or `switchboard_ask_user` only when `available` is exactly `true`; otherwise use normal chat. Do not force routing or infer availability from an earlier call.

Use stable `agent_id`, `task_id` and `idempotency_key` for the same logical message on retries, avoiding duplicate interruptions. A notification's submission is not proof the human heard it, and a question's creation is not approval.

After asking, retain its `request_id`. If pending, continue `switchboard_wait_for_reply` with that same ID even if availability changes. A wait timeout or snooze leaves the question pending: neither is a reply, rejection or permission to proceed. Do not resubmit the question or switch to a duplicate chat question merely because a bounded wait expired.

Handle terminal outcomes explicitly: an **answered** request supplies the user's reply, whose actual content determines approval; **dismissed** or **cancelled** supplies no approval. Use `switchboard_get_reply` to inspect an existing request or `switchboard_cancel_request` when intentionally withdrawing one, not to evade a pending decision.

Switchboard does not automatically wake a finished Pi turn when the reply arrives. Keep the same-request wait active while awaiting the needed answer; do not end claiming it will resume automatically. If tool/browser failure prevents waiting, state the blocker and retain the request ID for recovery rather than treating failure as authorization.
