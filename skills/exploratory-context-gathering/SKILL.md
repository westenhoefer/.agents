---
name: exploratory-context-gathering
description: Gathers codebase context before architecture or planning work. Use for larger changes, ambiguous requests, architectural refactors, debugging with unclear ownership, or when relevant behavior is documented or implemented across multiple files.
---

# Exploratory Context Gathering

Explore before deciding. The goal is to understand the current system shape, not to implement.

## When To Use

- The user is considering a larger change.
- Ownership, boundaries, or existing patterns are unclear.
- The work may affect multiple modules, services, or workflows.
- A refactor needs evidence before choosing a direction.

## Instructions

1. Identify the question the exploration must answer.
2. Search broadly enough to find relevant owners, flows, tests, docs, and scripts.
3. Prefer semantic search or focused code search over reading huge files end to end.
4. Treat existing code as evidence, not authority.
5. Summarize findings before proposing architecture or implementation.
6. Stop and ask when product intent, ownership, data migration, compatibility, or risk cannot be inferred safely.

## Output

Report:

- relevant files and owners
- current flow or data shape
- strong patterns worth preserving
- weak patterns or drift worth improving
- constraints and risks
- open questions

Do not write a spec until the main design decisions are clear.
