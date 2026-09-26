---
name: create-specification
description: Use after a design is agreed, when freezing it into an implementation brief for an implementer, or when reviewing such a brief.
---

# Create Specification

A spec freezes an agreed design so a fresh implementer can build it and the user can approve it quickly. The user has already agreed to the design in discussion, usually on diagrams; the spec must not retell it. It carries those diagrams plus only what they cannot show. If reading the spec would take longer than reviewing the resulting diff, it is too long.

## Format

````markdown
# <change>

<Goal in two or three sentences. Non-goals only where they are tempting.>

## Design
<The agreed Mermaid diagrams, verbatim, with changed elements marked. One-line caption each.>

## Decisions
- <decision>: <why>. Tag any decision the user has not explicitly agreed to as (new).

## Must not
- <tempting wrong approach, or a concern leaking across a boundary>: <why>.

## Contracts
<Exact signatures, schemas, routes, or config keys, only where two plausible choices would be incompatible.>

## Done when
- <behavior>: `<command>` in `<working directory>`.

## Open
<Unresolved questions. Empty at handoff.>
````

Omit any section with nothing to say.

## Rules

- Embed the diagram source in the file. Canvas diagrams do not survive reload, and a fresh implementer cannot see them.
- Say each thing once. A boundary drawn in Design does not reappear under Decisions unless the decision is why it sits there.
- Give every decision its reason, so an implementer who hits divergent reality can tell whether it still holds. State in the spec that they must then stop with a recommendation, neither silently deviating nor blindly complying.
- Use pseudocode only where a wrong-but-plausible implementation exists: ordering, concurrency, idempotency, subtle state transitions. A state diagram often says it better.
- Choose Done-when commands with `verification`; they must run as written.
- Do not prescribe private helper names, file-by-file edit scripts, routine edits a capable implementer infers, or skills the implementer discovers anyway.
- Write plain sentences, not RFC 2119 keywords; Must not carries the hard constraints.

## Final Pass

Could two capable implementers build materially different architectures from this? Tighten those choices. Then delete everything a capable implementer would infer, and check that every (new) tag is still accurate.
