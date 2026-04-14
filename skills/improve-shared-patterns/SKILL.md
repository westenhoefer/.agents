---
name: improve-shared-patterns
description: Evaluates whether a new feature should improve an existing shared implementation instead of adding a compensating wrapper or local exception. Use when extending existing patterns, reusing shared readers/services/helpers, reviewing plans that preserve current code by default, or when a minor upstream refactor would likely improve maintainability.
---

# Improve Shared Patterns

Do not assume an existing implementation is best practice, architecturally fixed, or worth preserving unchanged just because it already exists.

When extending a pattern, first ask whether the shared implementation itself should be improved. Prefer a small upstream refactor over a new wrapper when the stronger default is broadly correct and the change reduces future complexity.

## When To Use

- Extending an existing reader, service, helper, base class, or reusable slice.
- Considering a wrapper, adapter, or special-case path to compensate for weak shared behavior.
- Reviewing a plan that says to "reuse the existing pattern" without testing whether the pattern itself should be tightened.
- Seeing duplication, awkward indirection, string-based behavior, or other signs that a default may be accidental rather than principled.

## Core Preference

Prefer updating the shared seam instead of preserving it with local compensation when all of these are true:

- The improved behavior is a better default for the abstraction, not just for one caller.
- The change makes the system simpler for future work.
- The refactor keeps boundaries intact instead of smearing domain logic across layers.
- The blast radius is understandable and can be verified.

## Do

- Treat existing implementations as inputs to evaluate, not rules to obey.
- Ask whether the current behavior is intentional or just the first version that happened to land.
- Refactor at the narrowest shared seam that fixes the real problem.
- State clearly when a local wrapper exists only to work around a weak default.
- Explain why a shared refactor is or is not justified.

## Do Not

- Preserve a weak default only because it is already in the codebase.
- Add a wrapper whose main purpose is to undo behavior that should be corrected at the source.
- Use "matches existing implementation" as the main justification.
- Turn a small improvement into a broad rewrite.
- Push domain-specific semantics into a shared abstraction unless they are truly part of that abstraction's contract.

## Decision Check

Before adding a new layer, answer these questions:

1. Is the current shared behavior actually a good default?
2. If not, can the shared implementation be improved safely?
3. Would that remove duplication or future one-off handling?
4. Is the reason to avoid the refactor architectural, or just inertia?

If the answer points to the shared seam, improve it there.
If the behavior is genuinely slice-specific, keep the specialization and explain why it should stay local.

## Example

Avoid this pattern:

- Keep a generic list reader with weaker string-based ordering.
- Add a document-specific sorting wrapper to repair the result downstream.

Prefer this pattern:

- Update the shared list reader to use the stronger timestamp-based default when that behavior is semantically better for the abstraction and safe to verify.
- Keep local sorting only if the ordering rule is truly document-specific.

## Expected Output

When proposing an approach, explicitly say one of these:

- `Refactor the shared implementation`
- `Keep the shared implementation and justify the local specialization`

Then give a short reason focused on maintainability, correctness, and scope.
