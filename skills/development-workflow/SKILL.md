---
name: development-workflow
description: Use when coordinating engineering work, investigating issues, resolving design uncertainty, preparing agent handoffs, planning PR slices, reviewing implementation readiness, or communicating significant progress, blockers, or task completion.
---

# Development Workflow

Choose the next useful action, not a preset pipeline. Prefer collaboration while material uncertainty remains and execution when the intent and constraints are settled. A lookup, known edit or mechanical repair does not need a design exercise.

- Identify the outcome, relevant evidence, unresolved decisions and authorization boundary. Ask when product behavior, ownership, compatibility, persistence or migration would materially change the work; decide routine implementation details directly.
- Use diagrams to reason about structure, ordering or lifecycle, and delegation for useful parallel evidence, fresh context or independence. Neither is mandatory for every task; neither grants permission or replaces the parent's judgment.
- Prefer a clear best solution over manufactured alternatives. Existing complexity is evidence to examine, not a constraint to preserve without a reason.
- Keep decomposition, dependencies, integration and acceptance explicit. Choose review and verification effort for the actual risk, not the size or apparent importance of the task.

## Read only the relevant reference

- [Design](references/design.md): unresolved boundaries or behavior, evidence-based choices and decision records.
- [Investigations](references/investigations.md): diagnosis, repeatable measurements, reproductions and evidence handoffs.
- [Handoffs](references/handoffs.md): an agreed design needs a fresh implementer, another session or tool.
- [Review and PR coordination](references/review-and-prs.md): review findings, independent acceptance, intent-driven slices, base/dependency choices and closeout.

Use `engineering-practices` for artifact quality and checks; use `agent-tools` for diagram delivery, delegation, browser, Switchboard and worktree operations. Specialists such as `python-environment`, `hf-cli` and `skill-authoring` retain their own contracts.

## Communication

Use normal chat for quick questions and short interactive exchanges. Proactively use Switchboard for relevant, significant progress and for blockers or needed human input during longer work—not every tool call.

Before ending a completed task, always check Switchboard availability and send a concise completion notice when available, so the user knows they can continue rather than waiting elsewhere. Report the actual outcome, verification and any remaining limitation; do not announce completion while background/delegated work or unconsumed results remain. During a goal loop, send before the final `loop_checkpoint`, which must remain the last tool call. Follow the `agent-tools` Switchboard protocol for availability, chat fallback, delivery and replies. Leaf agents without the integration return results to the parent, which owns the user-facing notice.

Keep human summaries brief and actionable. Preserve detailed reproduction, measurements and review evidence as scoped task/issue/PR artifacts when useful, not as product documentation by default.
