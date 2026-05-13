---
name: create-specification
description: Turns an approved direction into an implementation brief for a capable coding agent, including concrete verification commands. Use after architecture decisions are clear, or when work needs precise boundaries, contracts, algorithms, risks, and repo-correct test, lint, typecheck, or CI commands.
---

# Create Specification

A specification should prevent architectural guessing, not remove all implementation judgment.

Treat the implementing agent like a talented junior engineer: give it the system shape, ownership boundaries, contracts, invariants, pseudocode for tricky logic, and verification expectations. Let it choose routine edits that naturally follow from the codebase.

## When To Use

- Turning a rough plan into an implementation-ready brief.
- Handing off multi-file, architectural, or cross-cutting work.
- Clarifying boundaries, APIs, data flow, algorithms, risks, or verification before implementation.
- Reviewing a plan that may let behavior land in the wrong layer.
- Capturing concrete verification commands after the repo environment and project root are understood.

## Core Standard

A good spec answers:

1. What are we building?
2. Where does the responsibility belong?
3. What public contracts or data shapes must exist?
4. What algorithm or control flow matters?
5. What must not happen?
6. How will we know the implementation is correct?

Do not over-specify routine edits that a capable agent can infer from existing patterns.

## Required Sections

1. Goal
2. Scope
3. Architecture
4. Locked Decisions
5. Interfaces / Contracts
6. Important Algorithms or Flows
7. Relevant Skills
8. Implementation Notes
9. Tests and Verification
10. Risks and Open Questions

## Section Guidance

### Goal

State the user-visible or system-level outcome in plain language.

### Scope

Separate in-scope from out-of-scope behavior. Keep this short.

### Architecture

Name the owning modules, layers, or services.

Be explicit about:

- where the behavior belongs
- what inputs and outputs cross boundaries
- what concerns must stay separate
- what existing pattern should be reused or improved

Use diagrams when structure or flow is easier to see visually.

### Locked Decisions

Lock decisions that affect architecture, public behavior, compatibility, persistence, APIs, or verification.

Do not lock incidental implementation details unless choosing freely would produce materially different designs.

### Interfaces / Contracts

Include concrete signatures, DTOs, schema shapes, events, route shapes, command names, or configuration keys when they matter.

Prefer code blocks for contracts that must be exact.

### Important Algorithms or Flows

Use pseudocode for non-trivial behavior.

Pseudocode should capture:

- ordering
- branching
- error handling
- state transitions
- idempotency or concurrency rules
- fallback behavior, if any

Do not write pseudocode for straightforward plumbing.

### Relevant Skills

Point out any skills the implementing agent should read and follow before starting work.

Include a skill when it materially affects implementation style, verification, review, architecture, cleanup, SDK usage, settings, hooks, rules, or other task-specific workflow.

Name the skill and explain why it applies in one short phrase. Do not list unrelated skills just because they are available.

### Implementation Notes

Give targeted guidance, not a file-by-file script.

Mention specific files only when:

- ownership must be fixed
- a public contract lives there
- a risky area needs attention
- a tempting local workaround must be rejected
- tests must cover a specific shared seam

Avoid exhaustive "edit this file, then this file" instructions unless the user explicitly asks for a mechanical handoff.

### Tests and Verification

Name the expected test coverage and concrete verification commands.

Specify behavior to prove, not only files to modify.

Include:

- targeted unit tests
- integration or workflow tests when behavior crosses boundaries
- regression tests for bugs
- the working directory for each command
- the interpreter, virtual environment, package runner, or project script to use
- typecheck, lint, test, or CI-like commands appropriate to the repo
- what each command proves

Use the `verification` skill when choosing commands. Do not write a bare command if the repo requires a local `.venv`, `venv`, project runner, script, or non-root working directory. Treat local virtual environments as possibly present even when ignored file listings do not show them.

### Risks and Open Questions

Call out unresolved product, architecture, migration, compatibility, or data questions.

If a decision is unknown, ask rather than hiding uncertainty behind permissive wording.

## Anti-Patterns

- File-by-file instructions for obvious implementation work.
- TODO lists that restate every section as a task.
- "The implementer can decide" for architecture, ownership, public contracts, or algorithms.
- "Prefer X, otherwise Y" when Y is only a shortcut around the right design.
- Local wrappers that compensate for weak shared behavior without justifying why the shared seam should not change.
- Vague phrases like "where appropriate", "as configured", "roughly", or "something like this" for important contracts.
- Vague verification such as "run tests" when the repo-correct command, root, and environment can be determined.
- Over-prescribing private helper names, internal ordering, or trivial refactors.

## Final Pass

Before handing off the spec, ask:

1. Could two capable agents implement materially different architectures from this?
2. Is the owner of each important behavior clear?
3. Are the public contracts precise enough?
4. Is the tricky logic captured as pseudocode or flow?
5. Are we micromanaging anything the agent can infer safely?
6. Are verification commands concrete and repo-correct?
7. Are tests focused on behavior and risk?
8. Are relevant skills named with clear instructions to follow them?

Tighten architecture, contracts, and algorithms. Remove unnecessary low-level instructions.
