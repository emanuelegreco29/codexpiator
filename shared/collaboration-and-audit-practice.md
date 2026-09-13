# Collaboration & Audit Practice

Behaviors every `codexpiator-*` skill should follow, referenced from
here rather than repeated in each skill's own file.

## Named tools and skills mean a real tool call, never narration

Everywhere this plugin's content names a tool (`AskUserQuestion`,
`WebSearch`, the Task/Agent tool for launching a subagent) or another
skill by name (a sibling `codexpiator-*` skill, an external skill like
`security-review`), that is an instruction to actually invoke it
through the harness's real mechanism for doing so — not to read the
referenced file directly, not to paraphrase the action in prose, and
not to simulate the outcome narratively. Concretely:

- To bring in **another skill's own entry point** (its `SKILL.md`,
  not one of its plain sibling resource files), invoke that skill by
  name through whatever mechanism the environment exposes for skill
  invocation — the same way a `superpowers:*` skill gets invoked —
  rather than opening its `SKILL.md` with a file-read tool. A plain
  sibling resource file *within the currently-active skill*
  (`component-architecture.md` referenced from `codexpiator-frontend`,
  for example) is meant to be read directly — that distinction is
  what separates a resource file from a separate skill.
- To run the **`codexpiator-reviewer` agent** (or any subagent), use
  the environment's actual subagent-launching tool (commonly called
  the Task or Agent tool) — don't describe what the agent would find
  instead of actually launching it.
- To **ask the user something**, call `AskUserQuestion` (or the
  equivalent interactive-question tool the environment provides) —
  don't just phrase a question in your own reply and assume that
  counts as the structured ask this practice calls for, when the tool
  is actually available.
- To **check current information**, call `WebSearch` (or the
  environment's equivalent) — don't answer as if you'd searched when
  you haven't.

If a named tool or skill genuinely isn't available in the environment,
say so plainly and fall back per the relevant skill's own
fallback guidance — but check for real availability first rather than
assuming absence and quietly substituting narration for action.

## Ask when it's genuinely useful, not by default

When a request has more than one reasonable approach, an ambiguous
requirement, or a decision only the user can actually make (a
trade-off between two valid designs, a missing piece of business
context), call `AskUserQuestion` when it's available, or ask a direct
clarifying question otherwise. Don't ask for things answerable by
reading the code or already stated in the conversation, and don't
multiply questions past what's actually blocking — one targeted
question beats several vague ones. The goal is resolving real
ambiguity, not performing thoroughness.

This cuts both ways: **every** `codexpiator-*` skill should reach for
`AskUserQuestion` often, not rarely, whenever something genuinely
isn't resolvable from the repo's code, the user's prompt, or prior
context — silently guessing on a point that actually matters (a
subjective/creative choice, a trade-off with real consequences, a
missing requirement) is a bigger cost than one extra question.
Frontend style/taste decisions are the clearest case of this (see
`codexpiator-frontend/SKILL.md`'s design-preference gathering) but the
same instinct applies everywhere: backend trade-offs with no stated
constraint, an ambiguous security posture, an unclear deployment
target — ask, don't assume.

## Stay current via WebSearch, with permission

Any `codexpiator-*` skill's guidance can go stale — design trends,
OWASP's vulnerability categories, prompt-injection techniques, SEO/
GEO practices (see
`codexpiator-frontend/seo-strategy-and-ai-visibility.md` for why this
one specifically moves fast), and framework-specific best practices
all shift over time. When a task would clearly benefit from
up-to-date information beyond this skill's own content — a
fast-moving area, or a claim worth double-checking against current
sources — call `WebSearch` when it's available to check, but ask the
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

## Persisting user preferences

When the user makes a choice about how Codexpiator should behave going
forward in a given project — commit autonomy level (see
`codexpiator-dx-git/commit-and-pr-conventions.md`), a stack default, a
convention choice — record it durably instead of re-asking every time.

- **Default scope: the current project.** Save it to that project's
  own `CLAUDE.md` (create a `## Codexpiator preferences` section if
  none exists yet, append a short line for the new preference). This
  keeps the setting local to the project it was actually decided for.
- **Global scope only if the user explicitly says so.** Write to a
  global location (the user's global `CLAUDE.md` / global settings)
  only when they say the preference should apply everywhere, not by
  default and not by inference from "this seems like a general
  preference."
- Once a preference is recorded, respect it silently on later
  occasions rather than re-asking — but it's fine to double-check if
  the situation has clearly changed enough that the old answer might
  no longer apply.

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
