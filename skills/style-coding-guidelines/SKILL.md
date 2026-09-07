---
name: style-coding-guidelines
description: Use whenever writing, editing, implementing, or refactoring code, including test cleanup and behavior-preserving structural changes.
---

# Style Coding Guidelines

Prefer clear, typed, human-readable modules over generated-code defensiveness or stuffing work into the nearest file. A file has one public job. A function either orchestrates named collaborators or does the work; it does not mix those altitudes.

## Scope and Refactoring

- Keep small, known changes small. Do not add planning ceremony or unrelated cleanup to a narrow request.
- Refactoring preserves public behavior, persisted data, and stable interfaces unless redesign is explicitly in scope. Identify that invariant and use `verification` to prove it.
- If cleanup exposes an unresolved ownership, compatibility, or migration decision, use `architecture-design` before broadening the work.
- Do not drive-by improve a shared reader, service, helper, or base class. Upstream a change only when this work would otherwise wrap a bad default, or the user requested the refactor.

## Module Shape and Function Altitude

- Give a new public job its own module, even on its first occurrence. Do not append unrelated capabilities to the nearest file merely to minimize the diff; humans navigate by concepts.
- Same job at a finer grain is not a new job. Do not split `load` / `validate` / `save` of one concept into three modules. A one-function module must be a concept someone would look up independently.
- Do not create junk drawers named `utils`, `helpers`, or "shared stuff".
- Inline obvious glue and thin standard-library calls. A name such as `_exact` is worse than `os.environ.get` when it only hides that call. Real normalization deserves an informative name.
- Extract a named collaborator when the caller would otherwise drop an altitude. Its name must explain a concept without requiring the reader to open its caller; `process_data` and `_helper` do not.
- Do not flatten a long function into a graveyard of private helpers. If collaborators have a different job from the module's public surface, move that job to its own module.
- Repeated mechanical patterns can start locally. When repetition creates real pressure, move the abstraction upward one level without erasing legitimate slice-specific behavior.

## Side Effects

- Bind environment, runtime configuration, clocks, and process-wide resources at the composition root. Pass values or explicit dependencies inward; deep functions must not re-read ambient policy.
- Domain logic should be pure where practical. I/O belongs in explicit boundary modules such as repositories, filesystem adapters, and network clients, wired at the composition root—not all physically in `main`.
- Do not bind runtime to source layout by walking upward from the current file. Installed and bundled code may have a different layout; pass configuration or use an appropriate package-resource API.
- Do not perform I/O or environment binding at import time; import is not a controlled lifecycle boundary.
- Keep true invariants module-level. Do not invent containers to inject every literal or abstractions to disguise a function whose actual job is I/O.

## Implementation and Errors

- Prefer composition over inheritance unless the design genuinely expects inheritance.
- Do not replace a single implementation or two-way branch with Protocol + strategies + factory. Add a substitution seam for real alternate implementations or a boundary a test needs to replace.
- Use type hints, explicit data shapes, and clear contracts rather than runtime guessing.
- Comment only non-obvious decisions and constraints. Correct stale comments; preserve useful explanations of unintuitive behavior.
- Handle failure near the failing call or at the layer that can make a real decision. Add useful context and raise or return promptly.
- Do not wrap entire function bodies in catch-all handlers. Narrow handling around one operation is appropriate, including expected filesystem/network failures that prechecks cannot rule out.
- Do not invent Result/Either to imitate Go in a language with idiomatic exceptions. Avoid silent recovery, fallback chains, and nested handlers that hide invalid state.

## Tests

- Prove successful behavior, obvious failure cases, and regressions for surfaced bugs.
- Do not substitute config-key, object-shape, private-helper, or mock-call assertions for observable behavior. Mocks may isolate boundaries; a script of `assert_called_once_with` calls is not the proof.
- Before finishing, inspect the touched modules for mixed jobs, altitude changes, accidental ambient dependencies, and unnecessary fragmentation. Fix those within scope rather than adding another checklist to the response.
