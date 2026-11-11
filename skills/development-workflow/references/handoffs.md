# Self-contained implementation handoffs

Read when a fresh implementer will build an agreed design: a worker, new session or another tool. A trivial bounded action can be assigned directly; it does not need a spec file.

A handoff freezes decisions, not the whole conversation. Hand the implementer the spec file and require reading it, rather than replacing it with a summary. Keep it short enough to review more easily than the implementation diff.

## Suggested shape

````markdown
# <change>
<Goal; non-goals only where tempting.>

## Design
<Agreed Mermaid source, with changed elements marked and a short caption.>

## Decisions
- <decision>: <reason>. Mark unagreed decisions as (new).

## Must not
- <tempting wrong approach>: <reason>.

## Contracts
<Exact signatures, schemas, routes or config keys only where alternatives conflict.>

## Done when
- <behavior>: `<executable command>` in `<working directory>`.

## Open
<None at implementation handoff.>
````

Omit empty sections. Embed agreed diagram source so approval is pinned and independent of saved-diagram access. Say each thing once; use prose for decisions or guarantees the diagram cannot express. Pseudocode is useful for subtle ordering, concurrency or idempotency, not routine implementation.

Include the objective, relevant facts, writable or read-only scope, existing work to preserve, approvals/limits, deliverable and acceptance checks. State exact incompatible contracts, not private helper names or a file-by-file edit script. Choose executable checks using `engineering-practices` verification guidance.

Do not hide unresolved architecture behind permissive wording. Resolve material (new) decisions before handoff. Tell the implementer to stop with a recommendation if a decision's reason no longer holds: neither silently deviate nor blindly comply.

For multiple implementers, name non-overlapping ownership and dependencies, shared contracts and the integration owner. Tool-specific launch/context limits belong to `agent-tools`. The parent still validates returned evidence and integration; handing off work does not hand off accountability.
