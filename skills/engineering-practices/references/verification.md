# Focused, honest verification

Read when choosing, prescribing or running tests, lint, formatting, static analysis or CI-like checks.

## Discover before invoking

Find native commands in repository instructions, README, package scripts, build files and CI. Identify the actual working directory, runner and focused target. Prefer the documented command over a plausible guess; report conflicting sources instead of silently combining them.

Use `python-environment` before invoking any Python-project CLI, including one-off scripts and version checks; it owns interpreter selection and local-tool isolation. A missing dependency/environment is a prerequisite to report, not permission to install or use a global fallback. Do not use runners that download tools or create environments without the required approval.

## Match the risk

Start with the smallest meaningful check of changed behavior. Expand for cross-component risk, inconclusive focused results or an explicit broader request. Use [Testing](testing.md) to decide what the test layer can actually prove.

Inspect side effects before execution: auto-fix/format-write, snapshots, generated files, caches, fixture cleanup, services and live calls may mutate state. A command called a check is not necessarily read-only. Only run mutations within authorization; choose non-mutating modes when available.

## State what happened

Report actual command, working directory, scope and result. Separate **ran**, **recommended** and **skipped/not run**. Include failures, skipped cases, missing prerequisites and remaining limits; reading a test is not running it. Explain evidence boundaries where material, especially mocked versus real integration and live behavior. Never turn a passing discovery/fixture test into a claim of runtime model compliance or end-to-end product correctness.
