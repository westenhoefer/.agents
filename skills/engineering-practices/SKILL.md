---
name: engineering-practices
description: Use when writing, editing or reviewing code, tests or documentation, refactoring behavior, or selecting and reporting verification checks.
---

# Engineering Practices

Judge artifacts by the behavior and understanding they protect. A guard, module, test, document or abstraction earns its place through a real caller, requirement, credible failure or operational need—not imagined flexibility.

- Keep ownership clear and side effects explicit. Use the language/framework's idioms rather than layering generic machinery over a simple job.
- Scale hardening to actual trust boundaries and consequences. Validate where untrusted data enters; do not defend every internal layer against states its contract excludes.
- Protect identifiable behavior and invariants. Passing checks are evidence with a scope, not a substitute for understanding the user-visible path.
- Before adding documentation or cleanup, identify its audience or benefit and keep it within the authorized work.

## Read only the relevant reference

- [Code style](references/code-style.md): proportion, module boundaries, dependencies, errors and a final diff pass.
- [Testing](references/testing.md): behavioral assertions, regressions, appropriate test layers, deterministic fixtures and external-service boundaries.
- [Documentation](references/documentation.md): whether an artifact should exist, canonical product docs versus task evidence, and useful precision.
- [Refactoring](references/refactoring.md): behavior preservation, dead paths, consequential decisions and bounded follow-ups.
- [Verification](references/verification.md): native commands, environment, focused scope, mutation awareness and honest results.

Use `development-workflow` for unresolved design, investigations, handoffs and review/PR coordination. Use `agent-tools` for operational SOPs. Use `python-environment` before any Python-project command and `skill-authoring` for this library's editorial rules.
