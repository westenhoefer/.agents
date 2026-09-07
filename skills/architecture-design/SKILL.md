---
name: architecture-design
description: Use when exploring a larger or ambiguous change, defining ownership and module boundaries, comparing architectural options, or planning a cross-cutting refactor.
---

# Architecture Design

Prefer deliberate, durable structure over accidental reuse. Explore enough to establish the constraints before choosing a design; do not make a planning exercise out of a small, known edit.

## Evidence Before Structure

- Identify the question exploration must answer. Find the relevant owners, call flows, tests, configuration, and operational constraints; stop when the evidence is sufficient to decide.
- Treat existing code as evidence, not authority. Preserve strong patterns and name drift rather than copying it.
- Distinguish observed behavior from assumptions. Surface conflicting documentation or implementations instead of inventing a compromise.
- Ask when unresolved product intent, ownership, migration, compatibility, or risk would materially change the design. Routine implementation choices do not need escalation.

## Design Constraints

- State the problem, constraints, and invariants before proposing structure.
- Name who owns each behavior, which inputs and outputs cross each boundary, and which concerns must remain separate.
- Prefer the smallest change that improves the long-term shape. Apply the `style-coding-guidelines` skill for code shape rather than duplicating those rules here.
- Push back on mixed responsibilities, policy hidden in the wrong layer, and local wrappers that only compensate for a weak shared default.
- If several approaches are viable, briefly compare them, recommend one, and name its main tradeoff. Do not create abstractions merely to keep every option open.
- Lock decisions affecting ownership, contracts, persistence, compatibility, or public behavior. Record a one-line rationale so an implementer knows what each constraint protects.
- Use diagrams when placement or flow is clearer visually, and concrete signatures when a boundary needs precision. Neither is mandatory ceremony.

## Handoff

Report the recommended shape, supporting evidence, tradeoffs, locked decisions, and unresolved questions. For a refactor, explicitly identify the behavior and interfaces that must remain unchanged.

Use `create-specification` when an implementation brief is needed, after the main direction is agreed. Do not write a spec with architectural questions hidden behind permissive wording.
