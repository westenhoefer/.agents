---
name: architecture-design
description: Designs or reviews software architecture with explicit boundaries, tradeoffs, and pushback when a proposal weakens structure. Use when planning a new slice, defining module boundaries, evaluating patterns, or reviewing architectural plans and refactors.
---

# Architecture Design

Prefer deliberate, durable structure over accidental reuse or local convenience.

## When To Use

- Designing a new feature that introduces new modules, layers, or seams.
- Reviewing a plan or proposal that changes responsibilities or system boundaries.
- Deciding whether behavior belongs in a shared abstraction or a local specialization.
- Evaluating whether an existing pattern should be reused, tightened, or replaced.
- After exploratory context gathering and before creating a specification for larger work.

## Instructions

- State the problem, constraints, and invariants before proposing structure.
- Treat existing code as evidence, not authority. Reuse strong patterns; improve weak ones.
- Name boundaries explicitly:
  - who owns the behavior
  - which inputs and outputs cross the seam
  - which concerns must stay separate
- Prefer the smallest change that improves the long-term shape.
- Push back when a proposal:
  - mixes unrelated concerns
  - hides policy in the wrong layer
  - adds wrappers that only compensate for a weak shared default
- Surface tradeoffs plainly. If multiple approaches are viable, compare them briefly and choose one.
- Use diagrams for component placement and call flow when structure is easier to see than to describe.
- Use code snippets for interfaces, contracts, and signatures when precision matters.
- Separate locked decisions from open questions.
- Hand off to `create-specification` only after the main ownership, boundary, and contract decisions are clear.

## Review Checklist

- Is the boundary clear?
- Does each layer have one reason to change?
- Is the proposed abstraction stronger than the current one?
- Are we preserving existing code because it is correct, or just because it exists?
- Will this shape make the next similar change easier?

## Expected Output

When giving architectural guidance:

- name the recommended shape
- explain why it is the best fit
- call out the main tradeoff
- note any open questions that must be resolved before implementation
