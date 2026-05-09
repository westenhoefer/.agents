# Minor Known Change

Use this mode when the user already knows the desired change and wants narrow implementation.

## Instructions

1. Restate the intended change in one or two sentences before editing.
2. Do only enough exploration to avoid obvious mistakes.
3. Use `style-coding-guidelines` for implementation behavior.
4. Push back only for important correctness, data loss, security, architecture, or verification risks.
5. Use `verification` for focused checks that match the change.
6. Use `review` when the change is non-trivial or risk-bearing.

## Avoid

- Broad architecture detours.
- Opportunistic refactors outside the requested scope.
- Spec writing unless the simple change reveals a larger design decision.

## Output

Keep the final report concise: what changed, what was verified, and any known limitation.
