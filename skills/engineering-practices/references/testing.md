# Tests that protect behavior

Read when adding tests, repairing a bug or judging coverage. For each test, name the behavior, failure or invariant that a realistic regression would break. Counts and passing status alone do not establish quality.

## Choose meaningful assertions

Cover useful successful behavior, credible failures and boundaries. A bug fix needs regression coverage that exercises the failure and distinguishes the corrected behavior; use a reproduction or explicitly report why automated coverage is unavailable.

Expected results must be independently grounded in the contract. Deriving the expected value from the same production expression/constant can make a test agree with the bug. Prefer representative inputs and explicit expected outcomes.

Do not substitute incidental CSS, internal object structure, private-helper assertions or a script of mock calls for observable behavior. Configuration, shapes, mocks and fingerprints can themselves protect real contracts—such as tool registration, a persisted schema or output stability—when the test identifies that contract and its failure consequence. There is no blanket ban on them.

## Choose the proof boundary

- **Unit**: logic/invariants under controlled inputs; mocked boundaries cannot prove their real implementation.
- **Adapter/contract**: a real parser, registration, serialization or boundary translation; name which dependency is simulated.
- **Integration**: collaborating real components across the relevant boundary, with explicit setup and teardown.
- **Live smoke**: real external environment/service and credentials; explicit opt-in, authorization and bounded side effects, never an incidental verification step.

Use the smallest layer that protects the claim, adding a higher-layer check when lower layers cannot prove the user action. Do not call mock-only checks end-to-end proof. A successful transport response does not establish that validation, state, UI or lifecycle behavior is correct.

## Reliable fixtures

Make time, randomness, environment, ports and starting state deterministic where they affect the claim. Keep parallel tests independent. Register guaranteed cleanup when acquiring fixtures, including on failure; stop writers/processes before cleanup. Use only task-owned, inspected locations within the approved boundary, not broad temporary/cache cleanup. Cleanup failure is evidence to report, not a reason to force removal.

External services remain opt-in; offline checks should not download dependencies or silently reach a live service. Command/environment selection and result limits belong to [Verification](verification.md).
