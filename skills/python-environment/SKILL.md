---
name: python-environment
description: Runs Python commands through the project's local virtual environment instead of the global interpreter. Use BEFORE running any python, pytest, pip, ruff, pyright, mypy, python -m, or python-based CLI in a Python project, and whenever a command fails with ModuleNotFoundError, "No module named", "isn't on the global interpreter", "command not found" for a Python tool, or missing-dependency errors. Local .venv/ or venv/ is usually gitignored, so assume it exists even when file/glob listings do not show it.
---

# Python Environment

A Python project's dependencies live in its local virtual environment, not on the global interpreter. Running `python`, `pytest`, or a tool directly almost always uses the wrong interpreter and fails with import or module errors.

## Core Rule

Never invoke a Python interpreter or Python-based tool directly in a project. Always route it through the project's local environment using the wrapper script below, or an explicit venv interpreter path.

This applies even when:

- a glob or file listing does not show `.venv/` or `venv/` (they are normally gitignored — assume present)
- you are "just" listing tests, checking a version, or running a one-off script
- a documented project command exists — still run it through the venv unless the docs specify a different runner (uv, poetry, pdm, tox, hatch, etc.)

## Use the Wrapper

Run from the target project root, not from the skill directory. The wrapper checks the working directory for `venv/` first, then `.venv/`, prepends its `Scripts`/`bin` to `PATH`, and forwards the rest to the tool.

```powershell
& "C:\Users\johan\.agents\skills\python-environment\scripts\run-in-venv.ps1" python tests/path/to/test_file.py
& "C:\Users\johan\.agents\skills\python-environment\scripts\run-in-venv.ps1" pytest tests/path
& "C:\Users\johan\.agents\skills\python-environment\scripts\run-in-venv.ps1" ruff check .
& "C:\Users\johan\.agents\skills\python-environment\scripts\run-in-venv.ps1" pyright .
```

```bash
bash "$HOME/.agents/skills/python-environment/scripts/run-in-venv.sh" python tests/path/to/test_file.py
bash "$HOME/.agents/skills/python-environment/scripts/run-in-venv.sh" pytest tests/path
bash "$HOME/.agents/skills/python-environment/scripts/run-in-venv.sh" ruff check .
bash "$HOME/.agents/skills/python-environment/scripts/run-in-venv.sh" pyright .
```

The `python`, `pytest`, and `ruff` shortcuts run through `python -m` so the selected environment is always used. Other tools run from the environment-adjusted `PATH`.

## Or Call the Interpreter Directly

When you prefer not to use the wrapper, invoke the venv interpreter explicitly:

```powershell
& ".\.venv\Scripts\python.exe" -m pytest tests/path/to/test_file.py
& ".\venv\Scripts\python.exe" -m pytest tests/path/to/test_file.py
```

```bash
./.venv/bin/python -m pytest tests/path/to/test_file.py
./venv/bin/python -m pytest tests/path/to/test_file.py
```

## When a Command Already Failed

If a bare `python`/`pytest`/tool command failed with `ModuleNotFoundError`, `No module named`, `isn't on the global interpreter`, or a Python tool was "not recognized"/"command not found", do not retry the bare command. Re-run it through the wrapper or the explicit venv interpreter above.

## Shell Note

Match commands to the active shell. On PowerShell, do not use bash-only commands such as `head`, `tail`, `cat`, or `*` globbing in places PowerShell will not expand them; use the equivalent tools instead.

## Do Not

- Run `pip install` or any package installation as part of discovery or verification.
- Assume the global `python` has the project's packages.
