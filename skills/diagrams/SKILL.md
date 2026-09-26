---
name: diagrams
description: Use when explaining how code works, tracing a request or data flow, decomposing a problem into components, debugging across components, designing a change that touches more than one component, or presenting an implementation for review, whether or not the user asks for a diagram.
---

# Diagrams

The user prefers to see structure and flow as diagrams. Draw one whenever an answer involves more than two components, an ordering, or a lifecycle; do not wait to be asked. A wrong diagram is worse than none, so draw from code you have read, never from names, comments, or memory.

## Pick the Diagram by the Question

- What happens when X, or how does a request travel: `sequenceDiagram`.
- What are the parts, who owns what, what depends on what: `flowchart`, with `subgraph` for module or service boundaries.
- What states can this be in and what moves it between them: `stateDiagram-v2`.

A question that needs two kinds gets two diagrams.

## When to Draw

- Explaining existing behavior: a `current` diagram of the path in question.
- Designing a change: the `current` path first, then a `proposed` or `mixed` diagram in which the change is visible. Agree the design on the diagram before writing a spec.
- Debugging across components: the failing path, with the point where observed and expected behavior diverge marked.
- After implementation: an as-built diagram of the changed paths, shown next to the agreed design. Whoever draws it must not have seen the proposed diagram; otherwise it shows the design, not the code. A match shows the structure is right, not that the code is correct or clean.

Skip the diagram when it would have three nodes or fewer, would restate one function line by line, or the question is a lookup.

## Drawing Well

- One question per diagram, titled with the question it answers. Several small diagrams beat one map of the system.
- Name nodes and participants as the code names them, so each maps back to a file or symbol. "Processing layer" maps to nothing.
- Back every node and edge that claims behavior with a reference. Draw inferred flowchart edges dashed (`-.->`); in sequence diagrams, where dashes mean replies, mark inferred messages in the label.
- Mark changed elements in `mixed` diagrams in their labels (`new`, `changed`, `removed`); the canvas rejects `classDef` and `style`.
- Include the failure, cancellation, or retry path when it is part of the question. A happy-path diagram of a failure-prone flow misleads.
- Stay near fifteen nodes or six participants. Past that, split or zoom out.
- The explanation states what the diagram covers, what it leaves out, and what is uncertain. Do not narrate the arrows.
- When understanding changes, update the same diagram id instead of adding a near-duplicate.

## Delivery

This skill is the user's standing request for diagrams. In pi, call `diagram_put`, then `diagram_open` if the canvas is not already open, then `diagram_status` to catch render errors. Without a canvas, use Mermaid blocks in the response. Subagents cannot reach the canvas; they return Mermaid source and references for the parent to show.
