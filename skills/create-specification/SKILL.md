---
name: create-specification
description: Use after architecture decisions are clear, or when work needs an implementation brief with boundaries, contracts, algorithms, risks, or verification commands.
---

# Create Specification

A specification should prevent architectural guessing, not remove all implementation judgment.

Treat the implementing agent like a capable colleague: give it the system shape, ownership boundaries, contracts, invariants, the rationale behind locked decisions, and verification expectations. Let it choose routine edits that naturally follow from the codebase.

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

## RFC 2119 Language

Use RFC 2119 style language for requirement strength:

- Obligatory requirements MUST use `MUST` or `MUST NOT`.
- Recommended guidance SHOULD use `SHOULD` or `SHOULD NOT`.
- Optional guidance MAY use `MAY`.

Use these keywords deliberately for implementation requirements, constraints, and verification expectations. Do not weaken required behavior with vague alternatives.

## Required Sections

1. Goal
2. Scope
3. Architecture
4. Locked Decisions
5. Interfaces / Contracts
6. Important Algorithms or Flows
7. Relevant Skills (optional)
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

Record a one-line rationale for each lock. The intent behind a constraint tells the implementer what must survive a redesign; the bare rule does not.

Instruct the implementer: when reality diverges from a locked decision mid-implementation, check in with the user with a concrete recommendation. Do not silently deviate, and do not push through a constraint whose intent no longer holds.

Do not lock incidental implementation details unless choosing freely would produce materially different designs.

### Interfaces / Contracts

Include concrete signatures, DTOs, schema shapes, events, route shapes, command names, or configuration keys when they matter.

Prefer code blocks for contracts that must be exact.

### Important Algorithms or Flows

Use pseudocode only where a wrong-but-plausible implementation exists. Capable agents infer routine control flow reliably; pseudocode earns its place for genuinely subtle logic such as ordering constraints, concurrency, or non-obvious state transitions.

When used, pseudocode should capture:

- ordering
- branching
- error handling
- state transitions
- idempotency or concurrency rules
- fallback behavior, if any

Do not write pseudocode for straightforward plumbing.

### Relevant Skills

Optional. If the implementing agent has the same skill auto-discovery, listing skills that would trigger from their own descriptions is ceremony — omit the section.

Include it only for skills that would not self-trigger: name the skill and explain why it applies in one short phrase.

### Implementation Notes

This section owns negative space: what must not happen, and what the implementer will be tempted to do but should not. Anti-requirements pull more weight than instructions — current agents over-deliver more often than under-deliver.

Prefer notes like:

- "this seam must not learn about X"
- "reject this tempting workaround, because ..."
- ownership that must stay fixed
- a risky area that needs attention
- a specific shared seam tests must cover

Avoid file lists and exhaustive "edit this file, then this file" instructions unless the user explicitly asks for a mechanical handoff.

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

Use the `verification` skill when choosing commands, and the `python-environment` skill for any Python command so it runs through the project's local virtual environment. Do not write a bare command if the repo requires a local `.venv`, `venv`, project runner, script, or non-root working directory. Treat local virtual environments as possibly present even when ignored file listings do not show them.

### Risks and Open Questions

Call out unresolved product, architecture, migration, compatibility, or data questions.

If a decision is unknown, ask rather than hiding uncertainty behind permissive wording.

## Anti-Patterns

- File-by-file instructions for obvious implementation work.
- TODO lists that restate every section as a task.
- "The implementer can decide" for architecture, ownership, public contracts, or algorithms.
- "Prefer X, otherwise Y" when Y is only a shortcut around the right design.
- Local wrappers that compensate for weak shared behavior without justifying why the shared seam should not change.
- Locked decisions recorded without their rationale.
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
8. Does every locked decision carry its rationale?
9. Do implementation notes name what must not happen, not just what should?
10. Does requirement strength use RFC 2119 style language consistently?

Tighten architecture, contracts, and algorithms. Remove unnecessary low-level instructions.