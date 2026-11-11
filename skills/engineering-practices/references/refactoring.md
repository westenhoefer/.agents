# Refactoring and bounded cleanup

Read for behavior-preserving structural changes or cleanup discovered during other work.

Identify the real invariants: observable behavior, public interfaces, persisted data, compatibility and operational guarantees. Preserve those unless redesign is explicitly authorized; use [Verification](verification.md) to choose evidence for them. An implementation detail is not automatically a contract just because old code or another agent assumed it was.

Keep a known small change small. Remove dead/redundant paths, stale comments and compatibility machinery made obsolete by the authorized change in the same scope. Do not leave a second path around the old implementation merely to avoid deciding which owns the behavior.

Do not drive-by refactor shared readers/services/base classes. Change the shared owner when this task would otherwise compensate for its bad default, or when the user requested that refactor. If a consequential ownership, compatibility, migration or public-behavior decision appears mid-task, stop and ask using `development-workflow` design guidance instead of silently expanding scope.

Offer worthwhile independent cleanup as a bounded follow-up, not an automatic obligation or a compulsory debt section. Make it ready for a separate authorized worktree/task: benefit, exact scope, dependencies/base assumptions and verification. Do not create a worktree or begin the follow-up without approval; operational checks belong to `agent-tools`.
