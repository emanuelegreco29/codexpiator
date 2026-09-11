---
name: codexpiator-testing-qa
description: Testing strategy and quality gates - testing pyramid, TDD workflow, mocking and test data, and CI quality gates. Use whenever writing tests, deciding what to test, following TDD, or deciding what should block a merge.
---

# Codexpiator Testing & QA

Single-purpose reference files for testing strategy and discipline.

| File | Read this when... |
|---|---|
| `testing-pyramid-and-strategy.md` | Deciding what level to test something at, avoiding a flaky/slow suite |
| `tdd-workflow.md` | Following red-green-refactor while building a feature |
| `mocking-and-test-data.md` | What to mock, test data setup, avoiding over-mocking |
| `ci-quality-gates.md` | What should block a merge vs. only warn |

## Non-negotiable baseline (applies everywhere in Codexpiator)

Every piece of frontend or backend work created or changed gets real
tests — written, run, and passing — covering edge cases and not just
the happy path, with the *full* suite run before the work is
considered done. Security-relevant behavior gets tested as explicit
attack-attempt cases, not just functional ones (see
`codexpiator-security/security-testing.md`). This isn't a suggestion
for especially important code — it's the default for anything
created. `codexpiator-frontend/SKILL.md` and
`codexpiator-backend/SKILL.md` both restate this as a mandatory
pre-completion gate; this skill is where the discipline and detail
live.
