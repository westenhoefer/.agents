---
name: review
description: Reviews implemented changes, plans, or repo-knowledge findings for correctness, risks, tests, and readiness. Use after execution, verification, repo lookups, PR work, or when the user asks for review, code review, readiness, risks, or missed issues.
---

# Review

Use a skeptical, bug-focused stance. Findings come first; summaries are secondary.

## Check

- correctness and edge cases
- behavior regressions
- ownership and boundary mistakes
- over-defensive fallback logic
- missing or weak tests
- verification gaps
- docs, README, skill, or rule follow-ups
- risky assumptions in repo-knowledge answers

## For Code Reviews

Report findings first, ordered by severity. Ground each finding in concrete code or behavior.

If there are no issues, say so clearly and mention remaining test gaps or residual risk.

## For Repo-Knowledge Lookups

Check whether the answer is supported by docs or scripts. If sources conflict, report the conflict instead of smoothing it over.

## Output

Use this order:

1. Findings
2. Open questions or assumptions
3. Brief summary, only if useful
4. Verification gaps or residual risk
