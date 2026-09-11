# Collaboration & Audit Practice

Two behaviors every `codexpiator-*` skill should follow, referenced
from here rather than repeated in each skill's own file.

## Ask when it's genuinely useful, not by default

When a request has more than one reasonable approach, an ambiguous
requirement, or a decision only the user can actually make (a
trade-off between two valid designs, a missing piece of business
context), ask — using `AskUserQuestion` when that tool is available,
or a direct clarifying question otherwise. Don't ask for things
answerable by reading the code or already stated in the conversation,
and don't multiply questions past what's actually blocking — one
targeted question beats several vague ones. The goal is resolving
real ambiguity, not performing thoroughness.

## Suggest an audit after significant work

After completing a meaningful chunk of work (a feature, a non-trivial
refactor, a batch of related changes — not every single small edit),
suggest running `/codexpiator-audit` to catch what a focused
in-the-moment implementation pass can miss: bugs, logical
inconsistencies, unused dependencies, excessive boilerplate,
duplicated code, and security problems across what was just built.
This is a suggestion to make to the user, not something to run
unprompted — let them decide whether the scope of what just changed
warrants it.
