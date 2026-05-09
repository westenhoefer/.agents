---
name: refactoring-cleanup
description: Cleans up codebases that drift from preferred style, testing, and architecture patterns. Use for refactoring tests, reducing fallback-heavy code, improving type hints, removing duplicated error handling, or planning architectural cleanup with simple or exploratory modes.
---

# Refactoring Cleanup

Use this skill to improve existing code without changing behavior unless the user explicitly asks for a redesign.

## Choose A Mode

### Simple Cleanup

Use for known, localized improvements:

- cleaning brittle or low-value tests
- improving type hints and data contracts
- reducing fallback-heavy code
- removing duplicated validation or error handling
- replacing awkward helpers with clearer control flow
- applying composition, DI, or pure functions where the improvement is obvious

Keep scope tight. Name the behavior that must remain unchanged and run focused verification.

### Exploratory Refactor

Use for architectural cleanup:

- unclear ownership or boundaries
- repeated pattern drift across modules
- shared abstractions that may need to move upward
- broad testing strategy changes
- risky behavior-preserving refactors

First use `exploratory-context-gathering`, then `architecture-design`, then `create-specification` before implementation.

## Rules

- Prefer small behavior-preserving refactors unless the user asks for broader redesign.
- Preserve public behavior, persisted data, and stable interfaces unless changing them is in scope.
- Apply `style-coding-guidelines` for code shape and tests.
- Use `verification` to prove unchanged behavior and any improved behavior.
- If cleanup reveals a larger decision, stop and move to exploratory refactor mode.

## Output

State:

- cleanup mode used
- scope and non-goals
- behavior expected to remain unchanged
- verification needed or performed
- any follow-up refactor that should be handled separately
