---
name: create-specification
description: Turns a plan into an execution-ready specification with locked decisions, file-by-file changes, explicit verification, and detailed TODOs. Use when drafting or refining plans for non-trivial work, or when the user asks for a specification instead of ad-hoc implementation.
---

# Create Specification

A plan becomes a specification when the implementing agent does not need to invent important design decisions during execution.

## When To Use

- Drafting or refining a plan for multi-file, architectural, or cross-cutting work.
- Turning a rough idea into a handoff document for implementation.
- Reviewing an existing plan that still leaves meaningful choices to the implementer.

## Storage

- If the project already has a canonical place for specs, use it.
- Otherwise prefer an in-repo plan under `.cursor/plans/`.
- If no convention is clear and the location matters, ask the user instead of creating a new convention silently.

## Specification Standard

- Lock important names and paths. Do not leave module names, file locations, API shapes, or public identifiers to implementer choice.
- Lock the intended architectural choice when there is an easy local workaround and a correct shared fix. Do not present both as acceptable implementation options.
- Ask questions instead of making assumptions. Put unresolved items in an explicit `Open Questions` section.
- Include diagrams when they clarify component placement, data flow, or ownership.
- Include code blocks for interfaces, signatures, DTOs, and pseudocode when precision matters.
- Include file-by-file modification instructions for every file to create or change.
- Include tests in the same file-by-file style.
- Include concrete verification commands.
- Include detailed TODOs that are ordered, granular, and executable without more design work.
- Rewrite vague phrases before finalizing: "prefer", "likely", "or", "if it gets crowded", "as configured", "where appropriate", and "the implementer can decide" usually signal that the spec still needs a locked decision.
- If the user has chosen a direction, state it as a requirement and remove softer alternatives from the plan.

## Required Sections

1. Scope
   - in scope
   - out of scope
2. Locked decisions
3. Architecture
4. Interfaces and behavior
5. File-by-file changes
6. Tests and verification
7. Risks
8. Open questions
9. TODOs

## File-By-File Guidance

For each file:

- use the full path
- describe the concrete edits
- specify key signatures, wiring changes, and removed assumptions
- list test updates alongside production changes
- say where behavior must not be implemented when that prevents a lazy workaround, e.g. "do not put access filtering in the router; implement it in the shared authorized reader."

## Anti-Patterns

- "Use something like ..."
- "Put this wherever it fits best"
- "The implementer can decide"
- "Prefer X, otherwise Y" when X is the correct architecture and Y is only easier.
- "Likely A or B" for public names, route shapes, CLI commands, module paths, or ownership boundaries.
- "As configured" without naming the exact argument, header, env var, setting, or dependency.
- Listing the correct shared refactor and a local workaround as peer options.
- file sections that omit tests
- TODOs that merely repeat section titles

## Ambiguity Pass

Before handing off a specification, do a final pass that asks:

1. Could an implementer satisfy this spec with a local workaround that preserves a weak shared default?
2. Are there any slash-separated choices, parenthetical alternatives, or optional paths that should be one locked decision?
3. Are ownership boundaries explicit enough to prevent behavior from landing in the router, adapter, DTO, or CLI just because that is convenient?
4. Would two capable agents implement materially different architectures from this text?

If any answer is yes, tighten the spec before presenting it. If the correct choice is unknown, ask the user and keep it in `Open Questions`; do not hide the uncertainty in permissive wording.

## Expected Output

A good specification should let a capable implementing agent execute without guessing about structure, naming, or verification scope.
