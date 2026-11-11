# Review and PR coordination

Read when judging a change or planning reviewable delivery. Personal instructions govern approvals for publication, PR creation, merges, destructive/history-changing Git operations and external review services; use `agent-tools` for worktree authorization and preservation guidance.

## Slice by intent

Choose the repository and base explicitly; never assume `main`. Each slice should explain one useful intent, its contract and how it is verified. Optimize for reviewability, not an arbitrary line-count cap. Separate independent scopes; name dependencies and the integration plan before parallel work. Do not split a coherent change merely to satisfy a size target.

Prefer independent review before publishing a PR. For dependent work, confirm the prerequisite actually merged and inspect the resulting base before proceeding on that dependency; a planned merge or successful review is not a merged contract. Present readiness without publishing when publication is not authorized.

## Review evidence, not confidence

Give reviewers the requirements/spec, actual diff or changed paths, relevant diagrams and check evidence—not only the author's summary. Stabilize the scope before review. For a substantive delegated design whose structural fidelity matters, an independent scout that has not seen the design can map the changed paths as built. Compare that source-backed diagram beside the agreed design; a match establishes structure, not correctness. Do not require this supplement for every task.

Check correctness, regressions, ownership, hidden fallback behavior, credible failures and weak tests. Trace representative actions through transport, validation, state, UI and disposal/cancellation when relevant. HTTP success or passing a mocked layer is not proof of a completed user action. Use `engineering-practices` for code/test/documentation judgment and verification limits; use `agent-tools` for diagrams and reviewer-role operation.

Findings need a concrete location and consequence. Separate observed facts from inference and report in severity order:

- **blocking**: broken behavior/contract, spec violation, security or data-loss risk that must be fixed before shipping;
- **advisory**: naming, style, structure or test-strength improvement that can be deferred with a reason.

Explain design divergences and whether the implementation or agreed design needs correction. Read-only reviewers report; they do not fix. Authorized implementers address findings within scope, including style findings, and stop for new decisions or permissions. The parent owns independent acceptance and integration; a worker's successful exit is not approval.

## Human review and closeout

Prefer a diagram-assisted human PR review when structure or lifecycle is material: make the changed path and boundaries visible without substituting a diagram for the diff. Include behavior/risk, actual check results and important limits. No findings means no findings in the reviewed scope, not exhaustive proof.

Keep as-built comparisons and review supplements with the task/issue/PR. Capture durable knowledge only where an audience will use it: canonical docs for operation/contracts, repo instructions for recurring conventions, a local script/skill for repeatable risky work, personal skills for cross-project preferences. Skip empty debt/capture sections. Independent cleanup proposals follow `engineering-practices` refactoring guidance; they are not automatic new work.
