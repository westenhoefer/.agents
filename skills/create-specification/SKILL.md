---
name: create-specification
description: Use after architectural direction is agreed, when preparing or reviewing an implementation brief with ownership, contracts, constraints, risks, and verification expectations.
---

# Create Specification

A specification prevents architectural guessing, not all implementation judgment. Treat the implementer as a capable colleague: define the boundaries, contracts, invariants, rationale, and proof of completion; leave routine edits to them.

## Structure

Always state the goal, scope, relevant constraints, and verification expectations. Include the sections below where they carry real information. Combine related sections and omit irrelevant ones rather than filling eleven headings with boilerplate.

### Goal and Scope

State the user-visible or system-level outcome. Distinguish in-scope work from explicit non-goals.

### Architecture

Name the owning modules or layers, what crosses each boundary, and what must stay separate. Identify patterns to preserve or improve. Use `architecture-design` if those choices are still unresolved; do not hide architectural uncertainty in an implementation brief.

### Locked Decisions

Lock consequential ownership, behavior, compatibility, persistence, API, and verification decisions—not incidental implementation details. Give each lock a one-line rationale.

Require the implementer to check in with a concrete recommendation if reality diverges from a locked decision. They must neither silently deviate nor blindly preserve a constraint whose intent no longer holds.

### Interfaces and Contracts

Provide exact signatures, data shapes, schemas, events, routes, commands, or configuration keys where multiple plausible choices would be incompatible. Do not prescribe private helper names.

### Important Algorithms or Flows

Use pseudocode only where a wrong-but-plausible implementation exists: ordering, concurrency, idempotency, subtle state transitions, or non-obvious failure handling. Routine plumbing does not need pseudocode.

### Implementation Constraints

Describe the negative space: responsibilities that must not leak across a seam, tempting workarounds to reject, compatibility to preserve, and shared behavior tests must exercise. Explain why a strict constraint matters.

Avoid file-by-file edit scripts, exhaustive task lists that repeat the spec, or local wrappers compensating for weak shared defaults without a justification.

### Tests and Verification

Specify behavior to prove: successful operation, failure cases, regression coverage, and integration checks where behavior crosses boundaries.

Use `verification` to select concrete commands and `python-environment` for Python. Include the working directory, runner/interpreter, focused target, and what each check proves. Resolve prerequisites before claiming a command is implementation-ready; do not substitute a vague "run tests".

### Risks and Open Questions

Surface unresolved product, migration, compatibility, or data questions. Ask about decisions that would materially change implementation rather than writing "the implementer can decide".

### Delivery / Handoff

State the requested completion artifact: local changes with a verification report, a commit, or a PR. Do not infer authorization to commit, push, create PRs, or trigger external services from an implementation request.

If branch-based delivery is requested, record the actual agreed base branch at spec creation so a later session does not guess. Name a harness-specific handoff skill only when that harness provides it and the user requested that workflow. Shared specs must not require unavailable tools or Cursor-only reviewer agents.

## Requirement Strength

Use RFC 2119 keywords deliberately: `MUST` / `MUST NOT` for obligations, `SHOULD` / `SHOULD NOT` for recommendations, and `MAY` for options. Do not weaken a required boundary with "prefer X, otherwise Y" when Y is merely a shortcut.

## Final Pass

Could two capable implementers produce materially different architectures from this brief? Tighten those choices and public contracts. Check that locks have rationale, tricky flows are precise, verification is repo-correct, and delivery is explicitly authorized. Remove details a capable implementer can infer safely.

Do not enumerate automatically discovered skills unless a relevant skill would not self-trigger or the implementer lacks the same discovery mechanism.
