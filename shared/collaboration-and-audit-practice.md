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

## Stay current via WebSearch, with permission

Any `codexpiator-*` skill's guidance can go stale — design trends,
OWASP's vulnerability categories, prompt-injection techniques, SEO/
GEO practices (see
`codexpiator-frontend/seo-strategy-and-ai-visibility.md` for why this
one specifically moves fast), and framework-specific best practices
all shift over time. When a task would clearly benefit from
up-to-date information beyond this skill's own content — a
fast-moving area, or a claim worth double-checking against current
sources — use `WebSearch` (when available) to check, but ask the
user's permission first rather than searching unprompted. Fold
genuinely new, confirmed information into the answer; don't treat a
single search result as more authoritative than this skill's
guidance without corroboration.

## Version bumps require asking first

When a change touches something versioned — a package's own version
(`package.json`/`pyproject.toml`/a plugin manifest), a public API's
version, a release tag — bump the version rather than leaving it
stale, but never decide the bump size or timing unilaterally: ask the
user (via `AskUserQuestion` when available) whether they want to
version-bump at all right now, and if so which part (major/minor/
patch, per `codexpiator-dx-git/git-workflow-and-branching.md`'s
semantic versioning guidance and, for a breaking API change,
`codexpiator-architecture/api-contracts-and-versioning.md`). Don't
silently pick a version number and move on — versioning decisions
often carry release-process and communication implications only the
user can judge.

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
