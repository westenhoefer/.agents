---
name: agent-tools
description: Use when operating MCP Browser tabs or Mermaid diagrams, sending Switchboard progress/completion notices or questions, delegating Pi subagents or swarms, recovering delegated work, or using Git worktrees for agent tasks.
---

# Agent Tools

Use the tool that exists, within the authority already granted. A skill, role, instruction or worktree does not create capabilities, isolation or approval. Inspect returned permissions and outcomes instead of inferring them from a successful tool call.

Keep workflow judgment in `development-workflow` and artifact/check quality in `engineering-practices`. Read the relevant operational reference before using its tool family:

- [Browser](references/browser.md): tab access flags, ownership, revocation and background focus.
- [Diagrams](references/diagrams.md): logical component maps, source-backed Mermaid and persistent diagram delivery.
- [Switchboard](references/switchboard.md): availability, stable retry identity and pending-question handling.
- [Pi subagents](references/pi-subagents.md): fresh-context assignments, fixed swarms, evidence consumption and separate reviews.
- [Worktrees](references/worktrees.md): authorization, base/dirty-work inspection, actual runtime limits and exact-target cleanup.

## Pi wiring

MCP Browser tools use Pi's built-in MCP support and `codemode`. Use `searchTools(query)` for matching tool declarations, or list names with `describeNamespace("mcp__mcp_browser")` then use `describeTool(name)` for schemas; call `tools.mcp__mcp_browser__<tool>()` inside a codemode script. Tool references name operations, not copied schemas or advertisements. Do not change MCP configuration/advertisements merely to make an operation available.

Pi leaf subagents do not load MCP integrations. They return diagram source and evidence for the parent to publish. If a required integration is absent, report the limit rather than improvising an unapproved execution path.
