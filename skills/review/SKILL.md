---
name: review
description: Use for explicit code or skill reviews, readiness and risk assessments, and closeout of substantive implementation or risk-bearing changes.
---

# Review

Use a skeptical, bug-focused stance. Findings come first; summaries are secondary. A routine lookup or trivial edit does not need a formal review report.

## Review Standard

- Check correctness, edge cases, regressions, ownership mistakes, hidden fallback behavior, weak tests, and verification gaps.
- Apply `style-coding-guidelines` when reviewing code shape. Ground every finding in a concrete location and consequence, not a hypothetical preference.
- For factual or repo-knowledge claims, use the relevant docs, scripts, or observed output. State conflicts and distinguish verified facts from inference.
- Report findings in severity order:
  - `blocking`: correctness, spec violation, security, data loss, or broken contract; must be fixed before shipping.
  - `advisory`: style, naming, non-critical structure, or test-strength suggestion; may be deferred with a reason.
- If there are no findings, say so without implying exhaustive proof. Mention remaining test gaps or residual risk.

## Closeout and Knowledge Capture

After substantive work, check whether newly discovered knowledge should survive the session. Recommend follow-ups; do not silently expand scope or manufacture a follow-up for every task.

- Human-facing behavior or setup belongs in README/docs.
- Recurring repository conventions belong in repo-local instructions.
- Multi-step or risky operational workflows belong in a repo-local skill or script.
- Cross-project preferences belong in personal skills, following `skill-authoring`.
- Missing behavioral coverage or unrelated structural cleanup belongs in a test/refactor follow-up.

Environment discoveries are especially worth capturing: the exact working directory, interpreter or runner, virtual environment, required environment variables, and temp/cache paths. Prefer the closest repository-owned source so future agents do not rediscover them. Use `verification` and `python-environment` for command rules rather than duplicating them here.

## Output

For a review request: findings, material assumptions/questions, brief summary if useful, and verification gaps. For implementation closeout: report actual changes and checks, plus any findings or capture recommendation worth acting on. Skip empty ceremony.
