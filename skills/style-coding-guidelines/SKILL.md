---
name: style-coding-guidelines
description: Use whenever writing, editing, implementing, or refactoring code, including test cleanup and behavior-preserving structural changes.
---

# Style Coding Guidelines

## Proportion

Generated code fails in a predictable direction: it solves the problems it can imagine rather than the ones that exist. Writing costs you nothing, so every guard, option, and layer looks locally justified; the sum is code no one would have typed by hand. Correct for that bias: write what a confident senior engineer on a deadline would write, the least code that fully solves the problem as it stands.

- Justify every line by a real caller, a stated requirement, or a failure that can actually occur. Hypothetical reuse, future flexibility, and "just in case" are not justifications.
- Trust the types, the callers, and the framework. Validate untrusted input once where it enters; do not re-check it in each layer below. Let impossible states fail loudly instead of guarding them.
- Commit to one behavior. No parameters, flags, or config for values nobody varies; no second format, mode, or legacy path unless one exists today.
- Edit in place rather than wrapping or branching around existing code. Delete what the change makes obsolete, including compatibility shims for code with no other callers. A good diff often removes more than it adds.
- Scale ceremony to stakes. A one-off script, a test fixture, and a payment path do not get the same logging, docstrings, data classes, or error handling. Comment only non-obvious decisions and constraints; fix stale comments and keep useful explanations of unintuitive behavior.
- Use the standard library, the framework's idiom, and the project's existing code before writing new code. Match the surrounding code's density, naming, and comment level.

## Scope and Refactoring

- Keep small, known changes small. Do not add planning ceremony or unrelated cleanup to a narrow request.
- Refactoring preserves public behavior, persisted data, and stable interfaces unless redesign is explicitly in scope. Identify that invariant and use `verification` to prove it.
- If cleanup exposes an unresolved ownership, compatibility, or migration decision, use `architecture-design` before broadening the work.
- Do not drive-by improve a shared reader, service, helper, or base class. Upstream a change only when this work would otherwise wrap a bad default, or the user requested the refactor.

## Module Shape

These rules shape code under real structural pressure. They are not a reason to add modules, layers, or helpers to a small change.

- A file has one public job. A genuinely new capability, one a reader would look up by name, gets its own module even on its first occurrence; do not append it to the nearest file to minimize the diff. Humans navigate by concepts.
- Same job at a finer grain is not a new job. Do not split `load` / `validate` / `save` of one concept into three modules.
- Do not create junk drawers named `utils`, `helpers`, or "shared stuff".
- Keep cohesive logic together. Extract a named collaborator only when its name explains a concept the reader would otherwise reconstruct; `process_data` and `_helper` do not. A change in abstraction level alone does not require extraction, but a long function that both orchestrates and does detailed work should be split.
- Inline obvious glue and thin standard-library calls. A name such as `_exact` is worse than `os.environ.get` when it only hides that call.
- Do not flatten a long function into a graveyard of private helpers. If collaborators have a different job from the module's public surface, move that job to its own module.
- Small duplication is cheaper than the wrong abstraction. When repetition creates real pressure, move the abstraction upward one level without erasing legitimate slice-specific behavior.

## Side Effects

- Bind environment, runtime configuration, clocks, and process-wide resources at the composition root. Pass values or explicit dependencies inward; deep functions must not re-read ambient policy.
- Keep domain logic pure where practical, with I/O in explicit boundary modules such as repositories, filesystem adapters, and network clients, wired at the composition root rather than all physically in `main`. Add such a module only when the codebase already has that layer or domain logic needs protecting from the I/O; a short script that reads a file and prints a result needs none.
- Do not bind runtime to source layout by walking upward from the current file. Installed and bundled code may have a different layout; pass configuration or use an appropriate package-resource API.
- Do not perform I/O or environment binding at import time; import is not a controlled lifecycle boundary.
- Keep true invariants module-level. Do not invent containers to inject every literal or abstractions to disguise a function whose actual job is I/O.

## Implementation and Errors

- Prefer composition over inheritance unless the design genuinely expects inheritance.
- Do not replace a single implementation or two-way branch with Protocol + strategies + factory. Add a substitution seam for real alternate implementations or a boundary a test needs to replace.
- Use type hints, explicit data shapes, and clear contracts rather than runtime guessing.
- Handle failure near the failing call or at the layer that can make a real decision. Add useful context and raise or return promptly.
- Do not wrap entire function bodies in catch-all handlers. Narrow handling around one operation is appropriate, including expected filesystem/network failures that prechecks cannot rule out.
- Do not invent Result/Either to imitate Go in a language with idiomatic exceptions. Avoid silent recovery, fallback chains, and nested handlers that hide invalid state.

## Tests

- Prove successful behavior, obvious failure cases, and regressions for surfaced bugs.
- Do not substitute config-key, object-shape, private-helper, or mock-call assertions for observable behavior. Mocks may isolate boundaries; a script of `assert_called_once_with` calls is not the proof.

## Finish Check

Reread the diff as its reviewer, not its author:

- Delete each line whose removal breaks no realistic case: guards for impossible states, unused parameters and options, code the change made obsolete, comments that restate the code.
- Check that the diff is no larger than the problem. If it adds much more than the request implies, find what can go before reporting.
- Inspect the touched modules for mixed jobs, accidental ambient dependencies, and unnecessary fragmentation.

Fix these within scope rather than adding another checklist to the response.
