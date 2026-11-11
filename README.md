# .agents

Shared, harness-neutral coding skills live in `skills/`. The Cursor-specific UI/UX developer agent lives in `~/.cursor/agents/ui-ux-developer.md`; it is not part of this shared library.

## Shared Skills

Three core entry points contain useful principles and select on-demand references:

- [development-workflow](skills/development-workflow/SKILL.md): advancing and coordinating work; references cover design, investigations, handoffs, review and PR slices.
- [engineering-practices](skills/engineering-practices/SKILL.md): judging and producing artifacts; references cover code style, testing, documentation, refactoring and verification.
- [agent-tools](skills/agent-tools/SKILL.md): operational guidance for browser access, diagrams, Switchboard, Pi subagents and worktrees. Pi-specific wiring is identified in its references.

Read the matching entry point, then only the references relevant to the task. Reference files are not separate discoverable skills. This is guidance ownership, not a required workflow sequence: small settled changes stay small, while uncertainty and risk determine collaboration, design, delegation and review.

Specialists retain their own contracts:

- `python-environment`: project-local interpreter and tool selection, with shell-specific wrappers below.
- `hf-cli`: Hugging Face Hub and related model/dataset operations.
- `skill-authoring`: editorial standards for this library.

Skills guide tool use without enabling integrations or granting permissions. There is no mandatory cross-harness PR automation.

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
