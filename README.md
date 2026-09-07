# .agents

Shared, harness-neutral coding skills live in `skills/`. Cursor-specific PR handoff lives in `~/.cursor/skills/implementation-handoff/`; it is deliberately not discoverable by pi as a shared skill.

## Shared Skills

- `architecture-design`: evidence gathering, ownership, boundaries, tradeoffs, and locked architectural decisions.
- `create-specification`: implementation briefs with precise constraints and repo-correct verification; section detail scales with the task.
- `style-coding-guidelines`: code shape, explicit side-effect boundaries, tests, and behavior-preserving refactoring.
- `python-environment`: project-local interpreter and tool selection, with shell-specific wrappers.
- `verification`: focused checks and honest reporting of results and gaps.
- `review`: concrete findings, readiness assessment, and capture of newly discovered operational knowledge.
- `skill-authoring`: editorial standards for this library.

Small known changes should remain small. Architectural work needs evidence and agreed boundaries before implementation, but not every task needs a spec. Repo-knowledge answers should come from the relevant docs or scripts, with exact working-directory and environment requirements.

The former router, exploration, refactoring, and post-task-capture skills were consolidated into the owning skills above. There is no mandatory cross-harness PR automation.

## Cursor Subagents

Custom subagent definitions remain in `agents/` and are exposed to Cursor through a link at `~/.cursor/agents`:

- `spec-conformance-reviewer`: read-only implementation review against a specification.
- `architecture-style-reviewer`: read-only ownership and code-shape review.
- `ui-ux-developer`: visual/interaction design and frontend implementation.

Cursor's `implementation-handoff` dispatches the reviewers when an explicitly requested PR workflow is available, adding the built-in security reviewer when appropriate. These definitions are not automatically pi subagents.

### Link Setup

Only create the link if `~/.cursor/agents` does not exist. If it already exists, inspect it and preserve its contents rather than deleting it blindly.

PowerShell (junction; normally no elevation needed):

```powershell
New-Item -ItemType Junction -Path "$HOME\.cursor\agents" -Target "$HOME\.agents\agents"
```

macOS / Linux:

```sh
ln -s "$HOME/.agents/agents" "$HOME/.cursor/agents"
```

Reload Cursor after adding or renaming agent definitions. Keep these files in this repository rather than accidentally duplicating the junction's contents into a future Cursor configuration repository.

## Python Environment Wrappers

Run from the target Python project root:

```bash
bash "$HOME/.agents/skills/python-environment/scripts/run-in-venv.sh" pytest tests/path
```

```powershell
& "$HOME\.agents\skills\python-environment\scripts\run-in-venv.ps1" pytest tests/path
```

The wrappers select a local `venv/` or `.venv/`. Python, pytest, and ruff execute through the selected interpreter; other tools must exist in that environment's executable directory. A missing tool fails rather than falling through to a global executable. A documented environment-owning runner such as uv, Poetry, or tox may be used directly instead; do not automatically install missing dependencies.

### Wrapper Regression Checks

From `~/.agents`, using Node's built-in test runner (no dependency installation):

```bash
node --test tests/run-in-venv.test.mjs
bash -n skills/python-environment/scripts/run-in-venv.sh
```

Tests exercise interpreter/tool selection, argument forwarding, exit codes, missing environments, path rejection, and refusal to use a global fallback. They use stand-ins rather than Python packages; the PowerShell tests run on Windows. Override `TEST_BASH` or `TEST_POWERSHELL` for nonstandard shell locations. Temporary fixtures live under ignored `.test-tmp/` and are removed after the suite.
