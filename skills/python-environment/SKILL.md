---
name: python-environment
description: Use before invoking Python, pytest, pip, ruff, pyright, mypy, or another Python-project CLI, and when interpreter or missing-module errors suggest the wrong environment.
---

# Python Environment

Select the project's environment explicitly. A bare interpreter or CLI can silently use global packages, producing misleading failures or changing the wrong installation.

## Environment Selection

- Use the documented environment-owning runner (uv, Poetry, PDM, tox, Hatch, etc.), or an explicit project venv interpreter. An ordinary package script is not necessarily environment-owning.
- Inspect the target project directory for `venv/` and `.venv/`; ignored environments are absent from many code-search listings. Do not assume absence, and do not assume an environment exists without checking.
- Run from the root needed by the target code's imports and tool configuration, which may be below the Git repository root.
- Use the same environment for version checks, one-off scripts, test collection, and actual tests. A failed bare invocation is not a reason to install global packages.
- If no suitable environment or runner is available, report the missing prerequisite and ask. Do not silently create an environment or install dependencies during discovery or verification.

## Wrappers

Run from the target Python project root, not this skill directory:

```powershell
& "C:\Users\johan\.agents\skills\python-environment\scripts\run-in-venv.ps1" pytest tests/path
& "C:\Users\johan\.agents\skills\python-environment\scripts\run-in-venv.ps1" ruff check .
& "C:\Users\johan\.agents\skills\python-environment\scripts\run-in-venv.ps1" pyright .
```

```bash
bash "$HOME/.agents/skills/python-environment/scripts/run-in-venv.sh" pytest tests/path
bash "$HOME/.agents/skills/python-environment/scripts/run-in-venv.sh" ruff check .
bash "$HOME/.agents/skills/python-environment/scripts/run-in-venv.sh" pyright .
```

The wrappers prefer native shell layouts (`bin` for Bash, `Scripts` for PowerShell), checking `venv` before `.venv` within each layout. Avoid keeping conflicting environments; use an explicit interpreter if selection is ambiguous.

`python` uses the selected interpreter directly; `pytest` and `ruff` use that interpreter with `-m`. Other tools must be executable files in the selected environment's `bin`/`Scripts` directory. They cannot fall through to a global executable. Pass a tool name, not a path; invoke a documented external runner separately.

## Explicit Interpreter Alternative

```powershell
& ".\.venv\Scripts\python.exe" -m pytest tests/path
```

```bash
# Linux/macOS
./.venv/bin/python -m pytest tests/path
# Git Bash on Windows
./.venv/Scripts/python.exe -m pytest tests/path
```

Match syntax to the active shell. When a bare command fails with a missing-module or command-not-found error, correct the environment rather than retrying the same bare command. Keep package installation a separate, explicitly authorized action.
