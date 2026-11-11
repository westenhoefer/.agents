# Worktrees and workspace ownership

Read before proposing, creating, using or cleaning a worktree for agent work. Worktrees are optional coordination tools, not a universal workflow or security boundary. Creation/cleanup must already be authorized; this reference grants no permission.

## Match the runtime that exists

Pi's current direct-child/swarm tools expose no public per-child cwd or worktree parameter. A swarm uses one launch/cwd, shared by its children. Putting a different path or "use a worktree" in the task instruction does not implement isolated execution. Do not invent parameters, alternate launch protocols or automatic worktree management. If isolated execution is required, stop and request a supported, separately authorized arrangement; worktree-runtime implementation is separate work.

## For supported, authorized Git work

Choose the repository and base explicitly, including dependency assumptions; do not assume `main`. Inspect `git status`, dirty/untracked work, local-only commits and existing worktrees before acting. Resolve actual paths, including symlinks/junctions, so an apparently local location does not hide an external target.

Use one writer per scope/worktree. Branch isolation is not filesystem/process isolation: shared user privileges, external files, linked paths and common Git state still matter. Preserve unrelated work, and do not run review against moving files. Publication, merge and destructive/history-changing Git operations retain their existing approval requirements.

## Cleanup is an exact-target operation

After writers have stopped and termination is confirmed, inspect the exact task-owned worktree/files. Preserve useful changes and local-only work before removal. Use only the approved operation on those exact targets; an external worktree needs specific approval for deletion outside the active repository boundary.

No force removal, discard, recursive broad cleanup, prune or branch deletion follows by implication from "clean up the worktree." If ownership, target resolution or preservation is uncertain, stop and ask. Temporary paths and task-created links do not bypass the boundary.
