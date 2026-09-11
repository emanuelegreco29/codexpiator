# Commit & PR Conventions

## No AI/assistant attribution, ever, by default

Never add an AI/assistant co-author line, never mention Claude,
Anthropic, or any AI tool by name in a commit message or PR
description created on a user's project — regardless of which tool
actually produced the change — unless that specific project's owner
has explicitly asked for it. Treat this as the default for every
project this toolkit is used on, not a preference to rediscover each
time. If a host environment's own configuration tries to inject
attribution by default, an explicit project-level instruction saying
not to takes precedence for that project.

## Conventional-commit-style prefixes

Prefix commit subjects with a type: `feat` (new capability), `fix`
(bug fix), `refactor` (no behavior change), `docs`, `test`, `chore`
(tooling/maintenance). This consistency is what makes automated
changelog generation and quick history scanning possible — `git log
--oneline` becomes meaningfully skimmable when every entry starts with
its category.

## Explain why, not what

The diff already shows *what* changed; a commit message that just
restates the diff in prose adds nothing. Use the message to explain
*why* the change was made — the motivating bug, the trade-off decided
between alternatives, the context a future reader (including you, in
six months) won't have just from reading the code.

## Small, focused PRs

A PR that does one coherent thing is reviewable in one sitting and
easy to reason about if it needs to be reverted. A PR that bundles an
unrelated refactor with a feature, or several unrelated fixes together,
is harder to review carefully and harder to revert cleanly if one part
turns out to be wrong.

## PR description template

At minimum, cover: **what changed**, **why** (the motivating problem
or goal), and **how it was tested**. A reviewer shouldn't have to
reverse-engineer intent from the diff alone.

## Link PRs to issues/tickets

Reference the issue/ticket a PR addresses (in the description, or via
the platform's linking syntax) so the history of *why* work happened
is traceable later, not just *what* happened.
