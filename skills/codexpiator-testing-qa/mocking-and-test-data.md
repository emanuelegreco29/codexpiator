# Mocking & Test Data

## Mock boundaries, not your own logic

Mock things that are genuinely external to what you're testing:
network calls, the current time, randomness, third-party services.
Don't mock your own domain logic just to make a test "simpler" — at
that point the test is verifying that a mock behaves like the mock was
told to behave, not that your code is correct.

## The over-mocking risk

A test built entirely against mocks can pass indefinitely even after
the real dependency's behavior has changed (a database's actual
constraint behavior, a third-party API's actual response shape) — the
mock and reality have quietly drifted apart. For anything whose
correctness genuinely depends on real behavior (see
`codexpiator-backend/backend-testing.md`'s integration-testing
section), test against a real or realistic instance instead of a
mock, and reserve mocks for the layers above that boundary.

## Test data builders over copy-pasted fixtures

Use a small builder/factory function to construct test data with
sensible defaults and explicit overrides for what each test actually
cares about, rather than copy-pasting a large fixture object into
every test file and editing it slightly each time. This makes each
test's intent clearer (only the overridden fields are what the test is
actually about) and avoids a sprawl of near-duplicate fixture objects
that all need updating together when the underlying shape changes.

## Deterministic test data

Never assert against real current time, real randomness, or any other
non-deterministic value directly — use a fixed seed, a fixed/frozen
date, or an injected deterministic value instead. A test that only
fails around midnight, or one time in a thousand runs, is a test
nobody can trust or debug reliably.
