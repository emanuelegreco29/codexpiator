# Frontend Testing

## The pyramid, applied to frontend

Most tests should be fast unit/component tests, fewer should be
integration tests (multiple components wired together, real routing),
and only a small number should be full end-to-end tests through a real
browser. Each level catches a different class of bug at a different
cost — inverting the pyramid (mostly E2E) produces a slow, flaky suite
that people stop trusting and start skipping.

## What to unit-test in a component

Test the component's observable behavior and output — what a user
would see or what it renders given certain props/state — not its
internal implementation details (which internal function it called,
what its internal state variable is named). A test tied to
implementation details breaks on refactors that don't change behavior,
which trains people to treat failing tests as noise rather than
signal.

## Snapshot-test pitfalls

Snapshot tests (asserting rendered output matches a saved snapshot)
are cheap to write but low-signal when overused: a snapshot diff on
every unrelated change trains reviewers to reflexively approve
snapshot updates without reading them, at which point the test
provides no real protection. Use snapshots sparingly, for things
genuinely well-suited to "did the output change at all" (e.g. a stable
design-system component), not as a default substitute for asserting
specific behavior.

## E2E test selection

End-to-end tests are expensive to write, run, and maintain — spend
that budget on the handful of critical user journeys that would be a
real incident if broken (sign-up, checkout, core workflow completion),
not on exhaustively covering every UI state. If a behavior can be
verified faster and more reliably at the component or integration
level, test it there instead.

## Where TDD fits

For the general red-green-refactor loop and how to apply it while
building a component, see `codexpiator-testing-qa/tdd-workflow.md` —
that file covers the discipline itself; this file is about what kind
of test to reach for once you're following it on the frontend.
