# CI Quality Gates

## What should block a merge

- The full test suite passes (not just the tests touched by the
  change).
- Lint/formatting checks pass (Ruff for Python, the project's linter/
  Prettier for JS/TS — see `shared/stack-recommendations.md` and
  `codexpiator-frontend/SKILL.md`'s pre-completion gate).
- Type checking passes, for any typed language/stack.
- A dependency vulnerability scan passes (see
  `codexpiator-security/dependency-and-supply-chain.md`).

Treat these as required status checks on the default branch, not
advisory — a check that can be merged past without being green stops
functioning as a gate.

## What should only warn

Things that are useful signal but not worth blocking every merge over:
code coverage percentage changes (a trend to watch, not a hard gate
unless it drops sharply), non-critical lint style suggestions the team
has decided are optional, performance benchmarks that fluctuate
naturally within a normal range. Blocking on too much makes CI noisy
enough that people start looking for ways around it — reserve hard
blocks for checks whose failure means something is actually broken.

## Keep CI fast enough that people don't route around it

If CI takes so long that it discourages running it before merging (or
encourages merging without waiting), that's a real problem to fix —
parallelize test suites, cache dependencies between runs, and
prioritize fast feedback for the checks most likely to catch a real
issue.

## Run the same checks locally that CI runs

Configure local pre-commit/pre-push checks (or at minimum, document
the exact commands) to mirror what CI actually runs, so a change that
passes locally doesn't then fail CI for a reason the author had no way
to see coming. A local-pass/CI-fail gap wastes cycles and erodes trust
in both.

## Fail closed, never open

A quality gate that's misconfigured to report success when it can't
actually run (a broken test-runner invocation, a linter that silently
no-ops on a config error) provides zero protection the moment it
breaks — see `codexpiator-security/dependency-and-supply-chain.md`'s
"checks fail open" item. Verify a gate's actual failure mode
deliberately (break something on purpose locally and confirm the gate
catches it) rather than assuming it does.
