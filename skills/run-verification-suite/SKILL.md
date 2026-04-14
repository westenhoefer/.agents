---
name: run-verification-suite
description: Runs Python verification checks by selecting the correct project environment, working directory, and scope for linting, type checking, and tests. Use when validating a substantive change or when the user asks for broader verification beyond a single test target.
---

# Run Verification Suite

Prefer the project's native verification commands, but apply them with the same discipline as test execution: correct root, correct environment, and scope that matches the change.

## Core Rules

- Use the closest project virtual environment or documented tool runner.
- Run commands from the project directory they are meant for.
- Prefer project-native commands if the repository documents them.
- Run the smallest verification set that gives meaningful confidence, unless the user asked for full-suite verification.

## Default Order

1. Lint or formatting checks that fail quickly.
2. Static analysis or type checking.
3. Focused tests for the changed area.
4. Broader test suites only when needed.

## Python Defaults

If the project uses these tools and does not document a different entrypoint, common commands are:

```powershell
ruff check --fix
pyright .
python -m pytest tests/path/to/target
```

## Decision Check

Before running verification, confirm:

- which project root owns the changed code
- which interpreter or venv should be used
- whether the user wants targeted or broad verification
- whether the repo has its own scripted verification command

## Reporting

When you finish verification:

- list the commands you actually ran
- note the working directory
- say what you did not run
- call out any failures, skips, or scope limitations
