# Commit & PR Conventions

## Commit autonomy: ask, then remember

Before committing on behalf of the user in a project for the first
time — or whenever no stored preference exists yet for this project —
ask (via `AskUserQuestion` when available) how they want commits
handled:
1. Commit autonomously once work is verified, without asking each
   time.
2. Ask for confirmation before every individual commit.
3. Never commit directly — only suggest the commit command/message
   for the user to run themselves.

Persist the answer per
`shared/collaboration-and-audit-practice.md`'s preference-persistence
rule (the project's own `CLAUDE.md` by default, global only if the
user explicitly asks for that). Once recorded, follow it on every
later commit in that project without re-asking.

## No AI/assistant attribution, ever, by default

Never add an AI/assistant co-author line, never mention Claude,
Anthropic, or any AI tool by name in a commit message or PR
description created on a user's project — regardless of which tool
actually produced the change — unless that specific project's owner
has explicitly asked for it. Treat this as the default for every
project this toolkit is used on, not a preference to rediscover each
time.

**Be honest about what actually enforces this.** A host environment's
own default attribution instructions are injected fresh every
session and can outweigh a skill's prose guidance — writing "never do
this" here is necessary but not sufficient on its own; it can still
lose to a stronger, more recent instruction in context. The real,
deterministic enforcement is the plugin's `PreToolUse` hook
(`scripts/block-ai-attribution.sh`), which blocks any `git commit`/
`git tag`/`gh pr create`/`gh release create` command whose message
text contains Claude/Anthropic attribution, regardless of what
instructions are currently in context, and tells Claude to rewrite
the message without it. If a project genuinely wants attribution, its
owner can disable the check for that project only by creating an
empty `.codexpiator/allow-ai-attribution` file — don't create that
file, or otherwise route around the hook, on your own judgment.

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
