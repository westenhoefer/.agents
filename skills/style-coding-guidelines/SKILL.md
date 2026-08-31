---
name: style-coding-guidelines
description: Guides implementation style for one-job modules, one-altitude functions, typed code, clean error handling, composition, and behavior-focused tests. Use when writing or modifying code, especially for minor known changes or execution after a spec.
---

# Style Coding Guidelines

Prefer clear, typed, human-readable modules over generated-code defensiveness and over stuffing work into the nearest file.

A file has one public job, stated in one sentence. A function stays at one altitude: it either orchestrates named collaborators or it does the work. It does not do both.

## Module Shape

- Do not append a new capability to the nearest existing file to keep the diff small. A small extra module is cheaper than a file that mixes jobs. Humans read files; that is why extra files are worth the cost.
- Same job at a finer grain is not a new job. Do not split `load` / `validate` / `save` of one concept into three modules. A one-function file is only a module if someone would look it up as its own concept.
- Do not create a junk-drawer module (`utils`, `helpers`, "shared stuff") to hold leftovers.
- A file's public surface should be the interesting entry points (routes, services, types). It should not be two entry points and a graveyard of private helpers.
- Keep edits scoped to the request and the owning concern. That often means creating the right module rather than growing the file that already exists.

## Function Altitude

When adding behavior, decide in this order:

1. **Inline** if the next lines are still the same altitude, or a few lines of obvious glue.
2. **Named collaborator** if the caller would otherwise zoom in. The name must be a concept a reader would understand without seeing the caller, not `process_data` / `_helper`.
3. **Own module** if that collaborator is a different job than the file's public surface — even the first time.

- Do not flatten a long function into a pile of private helpers in the same file.
- Do not split code into many tiny helpers that duplicate validation or error handling.
- Use pure functions for deterministic transformations when they make code simpler and easier to test.
- Do not force purity where it makes orchestration awkward.

## Implementation Style

- Prefer composition over inheritance unless the existing design clearly expects inheritance.
- Do not introduce a strategy/DI seam for a single implementation or a two-way branch. A condition is cheaper than Protocol + strategies + factory. Add that seam only when two real implementations already exist or a test must substitute the behavior.
- Use proper type hints, explicit data shapes, and clear contracts instead of runtime guessing.
- Comment rarely, and only for non-obvious decisions. Do not narrate what the code already says. If an existing comment is wrong, fix or remove it. Keep a still-correct comment when the logic stays unintuitive.

## Error Handling

Handle errors Go-style: check the failing call (or the precondition that would make it fail), add context, return or raise immediately. Catch-alls hide which step failed and delay the decision.

- Prefer precondition checks and explicit handling at the call over attempt-and-recover.
- Do not wrap a function body in a catch-all `try` / `except` / `catch`. A narrow handler around one call is fine when the language has no error value to check.
- Do not invent a Result/Either type to simulate Go in a language that already has errors or exceptions.
- Handle errors at the layer that can add useful context or make a real decision.
- Avoid silent recovery and fallback chains that hide bad state.
- Prefer one clear failure path over nested fallbacks.

## Evolutionary Shared Patterns

- A new job or capability gets its own module on the first occurrence. Do not wait for a duplicate. Local-first dumping is how god-files start.
- Repeated *mechanical* patterns (the same retry, parse, or mapping) may still start locally; when the pattern appears again, prefer a small structural refactor instead of duplicating the local solution.
- Repeated pressure can move an abstraction upward one level at a time, as long as the higher-level abstraction remains honest.
- Do not drive-by improve a shared reader, service, helper, or base class. Upstream a change only when this work would otherwise wrap a bad default, or the user asked for the refactor. Unrelated cleanup hides the real diff.
- Keep local specialization only when the behavior is genuinely slice-specific, and explain why it should not live at the shared seam.

## Finish Check

Before finishing, inspect each touched file:

- What is this file's public job, in one sentence?
- Did I add a second job? If yes, move it. If I only split the same job finer, put it back.
- Does any function change altitude? If yes, the lower-altitude work is a collaborator, and if that is a different job, a different module.
- Do private helpers out-volume the public surface? Those helpers are either glue that should go back inline, or they are the module.

Reject these shapes:

- Two routes (or other entry points) and a graveyard of helpers in the same module.
- A function that starts at orchestration and drops into arithmetic, parsing, or persistence halfway through.
- A Protocol + strategies + factory that replaced a two-way branch.
- One-function modules that are a finer grain of the same job (`load_x` / `validate_x` / `save_x`).
- A function whose body is one catch-all `try` / `except` / `catch`.

## Tests As Style

Tests should prove behavior, not incidental structure.

- Prove the happy path works.
- Add regression coverage for surfaced errors or fixed bugs.
- Cover obvious failure cases.
- Avoid brittle tests that only assert config keys, object shapes, or private helpers without proving behavior.
- Do not replace a behavior test with a mock-collaboration script. Mocks are fine to isolate a boundary; `assert_called_once_with` on every collaborator is not the proof.

For the minor-known-change workflow (confirm, scope tightly, verify, report), follow the `task-workflow-router` skill's minor-known-change mode.
