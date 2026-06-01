---
name: task-workflow-router
description: Classifies coding-agent requests into repo-knowledge lookup, minor known change, larger exploratory change, or miscellaneous work, then selects the right workflow phases. Use at the start of software tasks when deciding whether to answer from repo docs, execute narrowly, explore and plan, or ask for clarification.
---

# Task Workflow Router

Route the task before doing substantial work. Infer the mode from the user's request and ask only when confidence is low.

## Task Classes

- Repo-knowledge lookup: the user needs a concrete command, process, or documented detail that should exist in the repo.
- Minor known change: the user already knows what should happen and wants narrow execution.
- Larger exploratory change: the user needs context gathering, architecture discussion, locked decisions, and a spec before implementation.
- Miscellaneous task: the request does not fit cleanly; handle normally while checking whether a phase skill applies.

## Workflow Files

Read the matching file before acting:

- [repo-knowledge-lookup.md](repo-knowledge-lookup.md)
- [minor-known-change.md](minor-known-change.md)
- [larger-exploratory-change.md](larger-exploratory-change.md)
- [miscellaneous-task.md](miscellaneous-task.md)

## Phase Selection

Use top-level phase skills when the task calls for them:

- Exploration: `exploratory-context-gathering`
- Planning: `architecture-design`, then `create-specification`
- Execution: `style-coding-guidelines`
- Refactoring cleanup: `refactoring-cleanup`
- Running Python commands: `python-environment`
- Verification: `verification`
- Review: `review`
- Cleanup: `post-task-capture`

Simple known changes may skip exploration and cleanup when those phases would add noise. Larger changes should usually move through exploration, planning, execution, review, and cleanup.

## Low Confidence

Ask the user to choose a mode when classification is ambiguous enough that the workflow would materially change.
