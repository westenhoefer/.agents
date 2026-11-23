# Worktrees and workspace ownership

Read before proposing, creating, using or cleaning a worktree for agent work. Worktrees are optional coordination tools, not a universal workflow or security boundary. Creation/cleanup must already be authorized; this reference grants no permission.

## Launch in a separate checkout

Use `worktree: true` on `subagent_start` or `swarm_start` when authorized work needs separate checkouts. Pi provisions a detached worktree per admitted child from the trusted source checkout’s committed HEAD at submission; queued swarm members keep that base on resume. Without the option children share the launch cwd. A path in a task or CSV cell does not change it. If the loaded tool schema lacks the option, reload the updated extension before relying on it.

The child starts at the new worktree root, without the source checkout’s staged, unstaged or untracked files. If the task depends on those files, resolve the base with the user rather than silently starting from an older version or committing on their behalf. Review the retained checkout named in direct status or the item’s `worktreePath` in swarm results. A reported path is a planned destination, not proof that setup or execution succeeded; check the outcome and inspect the actual diff there. Pi does not merge or remove it.

## For supported, authorized Git work

Choose the repository and base explicitly, including dependency assumptions; do not assume `main`. Inspect `git status`, dirty/untracked work, local-only commits and existing worktrees before acting. Resolve actual paths, including symlinks/junctions, so an apparently local location does not hide an external target.

Use one writer per scope/worktree. Branch isolation is not filesystem/process isolation: shared user privileges, external files, linked paths and common Git state still matter. Preserve unrelated work, and do not run review against moving files. Publication, merge and destructive/history-changing Git operations retain their existing approval requirements.

## Cleanup is an exact-target operation

After writers have stopped and termination is confirmed, inspect the exact task-owned worktree/files. Preserve useful changes and local-only work before removal. Use only the approved operation on those exact targets; an external worktree needs specific approval for deletion outside the active repository boundary.

No force removal, discard, recursive broad cleanup, prune or branch deletion follows by implication from "clean up the worktree." If ownership, target resolution or preservation is uncertain, stop and ask. Temporary paths and task-created links do not bypass the boundary.
