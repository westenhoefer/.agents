# Design decisions

Read when uncertainty about behavior or boundaries could cause incompatible implementations. Exploration should answer a question, not inventory a repository indefinitely.

## Establish the evidence

Find the relevant owners, call paths, tests, configuration and operational constraints. Distinguish observed behavior, documented contracts and assumptions; surface conflicts rather than silently inventing a compromise. Stop gathering when the evidence is sufficient to decide.

State the problem, constraints and invariants. Question inherited constraints, including those assumed by previous code or agents; preserve them only for a real caller, contract or agreed need. Escalate consequential product, ownership, compatibility or migration choices rather than hiding them inside implementation.

## Make the boundary legible

- Name who owns each behavior, the inputs/outputs crossing boundaries and the concerns that must remain separate.
- Prefer the smallest complete design. Challenge mixed responsibilities, misplaced policy and wrappers compensating for a weak shared default; use `engineering-practices` for code shape.
- Recommend the clear best solution. Compare alternatives only when there is a material choice, explaining the main tradeoff rather than keeping every option open through abstractions.
- Lock consequential decisions with a one-line rationale: ownership, public behavior, contracts, persistence, compatibility and migration. The reason lets an implementer recognize when divergent reality needs a new decision.

For structural or flow questions, reason on current/proposed diagrams with `agent-tools`; show changes and relevant failure paths. Do not force a diagram onto a trivial edit. Precision such as a signature or schema belongs where two plausible choices would be incompatible.

Record agreed decisions and rationale on the corresponding issue (Linear when available). Without that integration, give the user the text to add; do not claim it was published. When fresh implementation needs a frozen design, use [Handoffs](handoffs.md), not an additional retelling of the discussion.
