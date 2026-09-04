---
name: post-task-capture
description: Use near task closeout after implementation, verification, review, or refactoring, or when setup, venv, temp-path, command, or CI details had to be rediscovered.
---

# Post Task Capture

Do a short closeout check after substantive work. Recommend follow-ups; do not silently expand scope.

## Check For

- README or docs that should mention the new behavior or command.
- Tests that should be added or strengthened.
- A personal skill that should be created or updated.
- A repo-local skill that should capture deployment, setup, release, CI, or operational knowledge.
- A repo-local rule that should preserve a recurring convention or working workflow.
- A brittle or repeated workflow that should become a documented command.
- Cleanup that should be separated into a follow-up refactor.

## Environment Workflows

If you had to discover how to run the project correctly, treat that as capture-worthy. Examples:

- where the virtual environment lives when it is not at the repository root
- which interpreter, wrapper script, package runner, shell, or working directory is required
- which temp/cache path must be set for tests, builds, or tools
- environment variables needed for local verification
- commands that fail unless run from a subdirectory or with a repo-specific setup step

Prefer a repo-local rule for guidance future agents should automatically follow while working in that repository. Prefer README/docs when humans need the instruction too. Prefer a repo-local skill when the workflow is multi-step, operationally risky, or benefits from reusable scripts.

## When To Skip

Skip or keep to one sentence for tiny tasks where there is clearly nothing to capture.

## Output

If follow-up is useful, say:

- what should be captured
- where it belongs: README, docs, personal skill, repo-local skill, rule, test, or refactor
- why it matters

For environment workflows, include the exact discovered command, working directory, env vars, venv path, temp path, or wrapper to capture.

If nothing stands out, say that no docs, skill, rule, or test follow-up is needed.
