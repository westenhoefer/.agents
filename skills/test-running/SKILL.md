---
name: test-running
description: Runs Python tests with the correct virtual environment, working directory, and pytest invocation. Use when the user asks to run pytest, verify a change with targeted tests, or troubleshoot why tests behave differently across environments.
---

# Test Running

Use the closest project environment and the working directory that matches the code under test.

## Core Rules

- Invoke pytest via `python -m pytest`.
- Prefer the closest project virtual environment or the project's documented Python runner.
- Run from the project directory that makes imports and config resolve correctly.
- Start with the narrowest relevant target before expanding to a broader suite.

## Workflow

1. Identify the project root for the tests you need to run.
2. Choose the matching interpreter or virtual environment.
3. Run the smallest relevant test target.
4. Expand scope only if the user asked for broader verification or the failure requires it.
5. If the result differs from the user's, compare:
   - working directory
   - interpreter or virtual environment
   - environment variables
   - config discovery
   - import roots

## Command Guidance

- In PowerShell, invoke local Python executables with `&`.
- If the project documents a preferred command, use that command.
- If the project uses a local venv, common patterns are:

```powershell
& ".\.venv\Scripts\python.exe" -m pytest tests/path/to/test_file.py
```

```powershell
& ".\venv\Scripts\python.exe" -m pytest tests/path/to/test_file.py
```

## Expected Output

When reporting test execution:

- say which command you ran
- say which working directory you ran it from
- say whether you ran a focused target or a broader suite
