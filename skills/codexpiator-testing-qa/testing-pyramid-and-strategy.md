# Testing Pyramid & Strategy

## The shape and why it matters

Many fast unit tests, fewer integration tests, a small number of
end-to-end tests. Each level trades speed for realism: unit tests are
fast and pinpoint failures precisely but test less of the real system
wiring; E2E tests exercise the real system closest to how a user
experiences it but are slow, more prone to incidental flakiness, and
expensive to maintain. Inverting the pyramid (mostly E2E, few unit
tests — sometimes called an "ice cream cone") produces a suite that's
slow to run and flaky enough that people start ignoring failures,
which defeats the purpose of having tests at all.

## Choosing the right level for a given piece of logic

- **Pure logic, calculations, validation rules, state transitions** →
  unit test. No I/O, no framework wiring needed to verify it.
- **Multiple components/modules wired together, real routing, a real
  (or realistic) database** → integration test. Verifies the pieces
  actually work together, not just in isolation.
- **A critical end-to-end user journey** (signup, checkout, core
  workflow completion) → E2E test, through a real browser/client.
  Reserve this level for journeys where an incident would be genuinely
  costly — not for every possible UI state, which integration/unit
  tests can usually cover faster and more reliably.

## Every case, not just the obvious one

For whatever is being tested, deliberately enumerate: the happy path,
empty/missing input, boundary values (zero, negative, maximum,
one-past-maximum), invalid/malformed input, and — where relevant —
permission-boundary and concurrent-access cases. A test suite that
only exercises the happy path gives false confidence; most real bugs
live in the edges.

## Flaky test triage

A test that fails intermittently without a code change is flaky, not
"probably fine" — quarantine it (mark it explicitly, track it) and fix
or remove it promptly. A flaky test left in the suite trains people to
re-run failures instead of investigating them, which eventually hides
a real failure behind "oh that test's just flaky."

## Test speed is a first-class requirement

A test suite people stop running because it's slow provides zero
protection. Keep the fast layers (unit tests) genuinely fast, run them
on every save/commit, and reserve the slower layers for CI or a
pre-push hook rather than blocking every local iteration.
