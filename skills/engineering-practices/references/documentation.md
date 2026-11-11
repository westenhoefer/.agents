# Documentation with a job

Read before creating or substantially updating docs. First justify the artifact: who needs it, what question or action it supports, and why existing canonical material is insufficient. If no ongoing audience/action exists, a short task response may be enough.

## Choose its home

- **Product docs** explain intent, public contracts, setup and operation: what a user/operator needs now.
- **Task/issue/PR evidence** holds investigations, completed-ticket details, as-built diagrams, review supplements, measurements and test-run results.
- **Repository instructions or skills** hold recurring development conventions or risky operational guidance, when that recurrence warrants an artifact.

Do not turn completed work histories, past test totals or review evidence into evergreen product docs. Promote a discovered fact only when it changes ongoing understanding or operation; retain the underlying task evidence in its scoped home.

Update the canonical source rather than adding a competing copy. Link to the owner of a rule instead of restating it. Remove stale or redundant text caused by the change within scope, preserving unrelated work.

Keep necessary precision: executable commands, working directory, environment, version-qualified facts, configuration keys and compatibility limits are useful when the reader needs them. Avoid both vague instructions and exhaustive dumps of commands or implementation files that do not serve the audience. Distinguish supported behavior from proposed or unverified behavior.

A final read should answer: can the intended reader act correctly, and can any sentence or artifact disappear without losing something they need? Use `skill-authoring` when the artifact is a skill in this library.
