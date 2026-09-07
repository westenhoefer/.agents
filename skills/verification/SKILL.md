---
name: verification
description: Use when choosing, specifying, or running focused tests, lint, formatting checks, static analysis, typechecks, or CI-like verification.
---

# Verification

Use the project's native verification commands with the correct root, environment, and scope.

## Choose the Check

- Find documented commands in repo instructions, README files, package scripts, build files, and CI configuration. Prefer these over guessed invocations.
- Identify the working directory, runner, and focused target that proves the changed behavior. If sources conflict, report the conflict rather than silently combining them.
- Route Python command selection and execution through `python-environment`; it owns interpreter discovery and local-tool isolation.
- Do not install packages as part of verification. Report missing prerequisites rather than silently changing the environment.
- Start with the smallest meaningful check. Expand when cross-cutting risk requires it, focused results are inconclusive, or the user requests broader coverage.

## Execution

Typically run non-mutating lint/format checks, static analysis, and then focused tests. Use the order that gives useful feedback fastest for this project; do not run irrelevant stages merely to satisfy a sequence.

Formatting fixes and auto-fix modes must be in scope. A check that modifies files is not read-only verification.

## Reporting

State the actual command, working directory, scope, and result. Explain what it proves when that is not obvious. Distinguish commands run from commands merely recommended, and call out failures, skips, unrun broader checks, and remaining limitations.
