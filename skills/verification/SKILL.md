---
name: verification
description: Runs or specifies repo-correct verification commands for Python tests, pytest, lint, typecheck, focused checks, broader suites, and CI-like validation. Use when the user asks to run tests, pytest, verify this, focused verification, test failure, lint, typecheck, CI, or when hidden/gitignored .venv or venv discovery matters.
---

# Verification

Use the project's native verification commands with the correct root, environment, and scope.

## Core Rules

- Prefer documented project commands when they exist.
- Run commands from the directory that makes imports, config, and scripts resolve correctly.
- Use the closest project virtual environment, tool runner, or documented interpreter.
- Treat local virtual environments such as `.venv` or `venv` as likely present even when file/glob checks do not list them; they are normally gitignored.
- Start with the smallest check that gives meaningful confidence.
- Expand to broader suites only when requested, risk requires it, or focused results are inconclusive.
- Do not run package installation commands as part of verification.

## Choosing Commands

Before running or writing verification commands, identify:

- project root for the changed code
- documented test, lint, typecheck, or CI command
- interpreter, virtual environment, package runner, or script entrypoint
- focused target that proves the changed behavior
- broader command needed for cross-cutting changes

## Python Guidance

Route every Python command through the `python-environment` skill; it owns the venv, wrapper, and runner rules.

## Default Order

1. Fast lint or formatting checks that do not modify files unless fixing is explicitly in scope.
2. Static analysis or type checking.
3. Focused tests for the changed area.
4. Broader suites when needed.

## Reporting

When reporting verification, say:

- command actually run or specified
- working directory
- whether scope was focused or broad
- what behavior the check proves
- what was not run
- failures, skips, or scope limitations
