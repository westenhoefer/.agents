# .agents

Personal coding-agent skills live in `./skills`.

## Workflow

The skill setup is organized around a router plus reusable workflow phases:

- `task-workflow-router`: classifies requests as repo-knowledge lookup, minor known change, larger exploratory change, or miscellaneous work.
- `exploratory-context-gathering`: gathers codebase context before architecture or planning.
- `architecture-design`: defines boundaries, ownership, tradeoffs, and locked architectural decisions.
- `create-specification`: turns approved direction into an implementation brief with concrete verification commands.
- `style-coding-guidelines`: guides one-job modules, one-altitude functions, side effects at entrypoints, shared-pattern evolution, error handling, typing, and tests.
- `refactoring-cleanup`: applies preferred style and architecture patterns to drifted codebases.
- `verification`: selects repo-correct test, lint, typecheck, and CI-like checks.
- `review`: checks correctness, risks, tests, and readiness.
- `post-task-capture`: checks whether docs, README, skills, rules, tests, or repo-local operational knowledge should be updated.

Simple known changes can skip exploration and cleanup when those phases would add noise. Larger changes should usually move through exploration, planning, execution, review, and cleanup.

## Verification Scripts

The verification skill includes wrappers for projects with gitignored virtual environments:

- `skills/verification/scripts/verify.ps1`
- `skills/verification/scripts/verify.sh`

Run them from the target project root. They check for `venv` first, then `.venv`, prepend the environment to `PATH`, and pass through the requested tool arguments.
