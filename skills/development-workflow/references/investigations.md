# Investigations

Read for a diagnosis or measurement task whose evidence must support a repair or another agent's next step. Personal instructions own mechanical-repair authorization; this reference does not widen it.

Start with the symptom, expected contract, affected scope and a question that would distinguish likely causes. Trace the actual path and mark where observation diverges from expectation. Use `agent-tools` when a diagram clarifies a multi-component failure; do not infer behavior from names or comments alone.

Prefer evidence that another person or agent can reproduce:

- exact working directory, environment, command, relevant inputs and preconditions;
- expected versus actual output, source locations and the smallest useful reproduction;
- for performance or intermittent behavior, a repeatable measurement command/script, baseline, workload, repetitions and meaningful variation;
- what the evidence establishes, plausible uncertainty, and the next discriminating check.

Use a small reusable script when it makes repetition reliable; do not build an investigation framework. Keep secrets out of evidence and obtain any required external-service approval. Use `engineering-practices` for environment selection, test boundaries and honest verification reporting.

Apply the smallest correction that restores the existing contract; do not mask the warning, add unrelated cleanup or introduce a workaround. Use focused, non-mutating checks where available. Report what changed, the evidence, what was actually verified and any durability limit (such as reinstalling an edited package). If the repair conditions are not met, explain the decision or permission needed and recommend a next step. Give delegated agents the same limits.

After two unsuccessful fixes, return to the original symptom and first failure. Identify the assumption both attempts left untested and check it read-only. Resume only for a verified, in-scope cause; otherwise report the goal, observations, assumption and missing decision to the user (or parent). Report before working around a constraint or widening scope to make an earlier fix hold.

A useful report has a brief human conclusion plus agent-ready reproduction/evidence when further work is likely. Separate verified cause from hypothesis and call out environmental limits or missing access. Do not label a mock reproduction as proof of a live system failure or fix.

Keep reports, raw measurements and diagnostic diagrams with the task/issue/PR unless an ongoing audience needs canonical operational documentation. Hand off an unresolved investigation with its facts, attempted checks, limits and next question; do not make the next agent rediscover the same path or present an unagreed repair as settled design.
