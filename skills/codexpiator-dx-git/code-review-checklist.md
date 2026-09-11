# Code Review Checklist

What a human reviewer should confirm, whether or not an automated
first pass has already run:

- [ ] **Correctness** — does the change actually do what it claims,
  and are the non-obvious edge cases handled (not just the case the
  author was thinking about)?
- [ ] **Tests** — are there real tests for the new/changed behavior,
  covering edge cases (per
  `codexpiator-testing-qa/testing-pyramid-and-strategy.md`), not just
  coverage-percentage padding?
- [ ] **Readability** — would someone unfamiliar with this change
  understand it in six months without needing to ask the author?
- [ ] **Scope** — is this PR doing one coherent thing, or has
  unrelated work been bundled in (see
  `commit-and-pr-conventions.md`)?
- [ ] **Security red flags** — anything touching auth, user input,
  secrets, or infrastructure config gets a second look against
  `codexpiator-security`'s checklists (start with
  `codexpiator-security/secure-coding-checklist.md`), not just a
  functional read.
- [ ] **Performance red flags** — an obviously expensive operation
  introduced in a hot path (an N+1 query, an unbounded loop over
  external calls) worth flagging even if it's not the PR's main
  focus.

## Automated first pass vs. human judgment

Use `/code-review` (when available) for an automated first pass over
mechanical issues — this checklist is what a human reviewer should
still confirm on top of that, particularly correctness against actual
intent and readability, which automated review can't fully judge.

## No AI attribution in what gets merged

While reviewing, also confirm no commit or PR description was left
with unwanted AI/assistant attribution (see
`commit-and-pr-conventions.md`) before approving.
