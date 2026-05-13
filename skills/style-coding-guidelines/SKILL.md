---
name: style-coding-guidelines
description: Guides implementation style for scoped edits, typed code, clean error handling, composition, strategy-pattern dependency injection, behavior-focused tests, and shared-pattern refactors. Use when writing or modifying code, especially for minor known changes or execution after a spec.
---

# Style Coding Guidelines

Prefer clear, typed, maintainable code over generated-code defensiveness.

## Implementation Style

- Keep edits scoped to the request and the owning modules.
- Prefer composition over inheritance unless the existing design clearly expects inheritance.
- Prefer strategy-pattern extension points with dependency injection when behavior varies by policy, backend, provider, or mode.
- Use pure functions for deterministic transformations when they make code simpler and easier to test.
- Do not force purity where it makes orchestration awkward.
- Use proper type hints, explicit data shapes, and clear contracts instead of runtime guessing.
- Add useful comments for non-obvious decisions; explanatory comment blocks are expected for complex or unintuitive logic.
- Treat existing explanatory comment blocks as intentional context. Do not remove them unless the underlying logic is simplified enough that the comment is no longer needed.

## Error Handling

- Handle errors at the layer that can add useful context or make a real decision.
- Avoid broad `try`/`except` wrappers, silent recovery, and fallback chains that hide bad state.
- Prefer one clear failure path over nested fallbacks.
- Do not split code into many tiny helpers that duplicate validation or error handling.

## Evolutionary Shared Patterns

- The first occurrence of a pattern may be implemented locally for the specific case.
- When the pattern appears again, prefer a small structural refactor instead of duplicating the local solution.
- Repeated pressure can move an abstraction upward one level at a time, as long as the higher-level abstraction remains honest.
- When extending readers, services, helpers, base classes, or reusable slices, ask whether the shared implementation should improve instead of adding a local wrapper.
- Prefer a small upstream refactor when the improved behavior is a better default, simplifies future work, keeps boundaries intact, and has a verifiable blast radius.
- Keep local specialization only when the behavior is genuinely slice-specific, and explain why it should not live at the shared seam.

## Tests As Style

Tests should prove behavior, not incidental structure.

- Prove the happy path works.
- Add regression coverage for surfaced errors or fixed bugs.
- Cover obvious failure cases.
- Avoid brittle tests that only assert config keys, object shapes, or private helpers without proving behavior.

## Minor Change Fast Path

For minor known changes:

1. Confirm the intended change briefly.
2. Avoid broad detours.
3. Push back only for important correctness, data, security, architecture, or verification risks.
4. Run focused verification.
5. Report what changed, what was verified, and any limitation.
