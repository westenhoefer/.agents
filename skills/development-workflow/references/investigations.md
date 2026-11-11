# Investigations

Read for a diagnosis or measurement task whose evidence must support a repair or another agent's next step. Personal instructions own mechanical-repair authorization; this reference does not widen it.

Start with the symptom, expected contract, affected scope and a question that would distinguish likely causes. Trace the actual path and mark where observation diverges from expectation. Use `agent-tools` when a diagram clarifies a multi-component failure; do not infer behavior from names or comments alone.

Prefer evidence that another person or agent can reproduce:

- exact working directory, environment, command, relevant inputs and preconditions;
- expected versus actual output, source locations and the smallest useful reproduction;
- for performance or intermittent behavior, a repeatable measurement command/script, baseline, workload, repetitions and meaningful variation;
- what the evidence establishes, plausible uncertainty, and the next discriminating check.

Use a small reusable script when it makes repetition reliable; do not build an investigation framework. Keep secrets out of evidence and obtain any required external-service approval. Use `engineering-practices` for environment selection, test boundaries and honest verification reporting.

A useful report has a brief human conclusion plus agent-ready reproduction/evidence when further work is likely. Separate verified cause from hypothesis and call out environmental limits or missing access. Do not label a mock reproduction as proof of a live system failure or fix.

Keep reports, raw measurements and diagnostic diagrams with the task/issue/PR unless an ongoing audience needs canonical operational documentation. Hand off an unresolved investigation with its facts, attempted checks, limits and next question; do not make the next agent rediscover the same path or present an unagreed repair as settled design.
