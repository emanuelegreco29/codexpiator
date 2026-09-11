# TDD Workflow

## Red, green, refactor

1. **Red** — write the smallest possible test for the next bit of
   behavior you want, and run it to confirm it actually fails (and
   fails for the reason you expect — a test that "passes" before the
   code exists, or fails with an unrelated error, isn't testing what
   you think it is).
2. **Green** — write the minimal code needed to make that test pass.
   Resist the urge to build more than the test requires yet — extra
   speculative code at this stage is exactly what YAGNI warns against.
3. **Refactor** — with the test passing as a safety net, clean up the
   implementation (naming, duplication, structure) without changing
   behavior. Re-run the test after refactoring to confirm it still
   passes.

Repeat this loop in small increments rather than writing a large batch
of implementation before the first test.

## Why smallest-first matters

A test that tries to cover too much at once is harder to get to green
quickly and harder to diagnose when it fails (which of the several
things it checks actually broke?). Small, focused tests each verify
one behavior, so a failure immediately tells you what's wrong.

## This is the standalone summary

For the full disciplined workflow, tooling integration, and edge cases
in applying TDD, use `superpowers:test-driven-development` when it's
available in the environment — this file is the condensed version
usable on its own when it isn't. The loop above is the same regardless
of which one you're following.

## Applying this alongside the mandatory testing gate

`codexpiator-frontend/SKILL.md` and `codexpiator-backend/SKILL.md`
both require real, run, passing tests — including edge cases — before
any change is considered done. Following red-green-refactor as you
build is how that requirement gets met naturally, rather than as a
separate step bolted on at the end after the implementation is
already "finished."
