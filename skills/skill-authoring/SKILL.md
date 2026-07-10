---
name: skill-authoring
description: Applies the personal skill library's editorial principles when creating or revising skills in ~/.agents/skills. Use when editing a SKILL.md in this library, reviewing skill quality, or deciding whether guidance belongs in a skill body, a description, a script, or a reference file.
---

# Skill Authoring

Editorial principles for this skill library, calibrated for current-generation models.

## Principles

1. **Anti-goals over prescriptions.** Current models over-deliver, not under-deliver. Guidance about what must *not* happen ("reject this tempting workaround", "this seam must not learn about X") pulls more weight than step-by-step instructions. Trim prescriptive steps a capable model infers; keep and sharpen guardrails.
2. **Rationale on constraints.** When a skill locks a decision or imposes a strict rule, record *why* in one phrase. An agent hitting divergent reality mid-task should use the rationale to form a recommendation and check in with the user — not silently deviate, and not blindly comply when the constraint's intent no longer holds.
3. **Trust-calibrated specificity.** Low-freedom detail (exact commands, scripts, pseudocode) only where a wrong-but-plausible path exists — venv routing, verification commands, genuinely subtle algorithms. High freedom everywhere else.
4. **Cut ceremony.** Remove sections that duplicate what skill auto-discovery or the system prompt already provides.
5. **Single-source rules.** Each rule lives in exactly one skill; others name that skill instead of restating the rule.

## Revision Checklist

- Description states WHAT the skill does and WHEN to trigger it, in third person, with concrete trigger terms.
- Body matches the description after edits.
- Cross-references name the skill (e.g. "the `verification` skill"), not relative paths.
- Strict rules carry their rationale.
- Nothing restates a rule owned by another skill.
