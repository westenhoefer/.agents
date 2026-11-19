# Code style and ownership

Read when producing or reviewing code shape. These constraints address real structural pressure; they are not a reason to add layers to a small change.

## Proportion

- Justify each option, guard and layer by an actual caller, stated requirement or credible failure. Commit to one behavior unless real consumers need alternatives; do not invent modes, compatibility paths or configuration nobody varies.
- Trust types, controlled callers and framework guarantees. Validate untrusted input once at its boundary; let violated internal invariants fail visibly rather than hiding them with defensive defaults.
- Edit the owning implementation instead of wrapping a poor default. Use the standard library, framework idiom and sound project conventions, while questioning accidental complexity rather than copying it.
- Scale logging, comments, types and error machinery to the stakes. Explain non-obvious decisions and constraints; remove stale comments and comments that merely narrate code.

## Cohesive modules

A file has one public job. A genuinely new capability that a reader would look up by name deserves its own module; `load`/`validate`/`save` of one concept need not become three. Avoid junk drawers named `utils` or `helpers`.

Keep cohesive logic together. Extract a collaborator when its name explains a concept the reader would otherwise reconstruct, especially when orchestration obscures detailed work. Inline obvious glue and thin library calls. Do not flatten a function into a graveyard of private helpers; if collaborators have a different public job, move that job to its owner.

Small duplication can be cheaper than the wrong abstraction. Abstract only under real repetition or substitution pressure, without erasing legitimate slice-specific behavior. Prefer composition to inheritance unless inheritance is the intended contract. A single implementation or two-way branch does not need a protocol/strategy/factory stack.

## Extension points

Where the domain has a known axis of variation (pipeline stages, source connectors, formats), give it one protocol and one explicit ordered registration. Keep generic machinery (executor, scheduler, schema, API, UI) ignorant of individual implementations. Generic code that branches on an implementation's name, or a new implementation that needs a scheduler edit, migration or config copy, is a leaked boundary. Build only the seam: a hardcoded list is enough until someone must vary it at runtime, so no plugin discovery, dependency planner or configuration ahead of that need.

## Side-effect boundaries

Bind environment, runtime configuration, clocks and process-wide resources at the composition root; pass values or explicit dependencies inward. Keep domain logic pure where practical, with I/O in explicit repositories/adapters/clients wired there. Add a boundary module when the existing architecture or domain logic needs it, not for a short read-and-print script.

Do not read ambient policy deep inside logic or perform I/O/environment binding at import time: import is not a controlled lifecycle boundary. Do not locate runtime resources by walking upward through source layout; installed/bundled layouts differ. Pass configuration or use package-resource APIs. Keep true constants module-level without inventing injectable containers for every literal.

## Contracts and failures

Prefer explicit types/data shapes over runtime guessing. Handle failure near the failing call or at the layer able to make a real decision, adding useful context and returning/raising promptly. Narrow handling around expected filesystem/network failures is appropriate even after prechecks. Avoid catch-all whole-function handlers, silent recovery, fallback chains and invented Result/Either machinery in a language with idiomatic exceptions.

## Final diff pass

Read as the reviewer: remove lines whose absence breaks no realistic case, unused options, obsolete paths and compensating abstractions. Check mixed jobs, ambient dependencies and unnecessary fragmentation. Compare the diff's breadth with the kind of change: if a routine extension edited files or unrelated tests that only had to learn its name, report it and propose the boundary fix as a bounded follow-up. Keep the diff proportionate to the problem and fix in-scope style issues rather than turning them into a response checklist. Behavioral tests and scope preservation follow [Testing](testing.md) and [Refactoring](refactoring.md).
