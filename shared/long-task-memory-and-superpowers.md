# Long-Task Memory & Superpowers Usage

Two related practices for anything long or complex enough that losing
context mid-way would actually hurt: write resumable progress memory
to disk, and lean on the `superpowers:*` skill family instead of
improvising process from scratch.

## Progress memory for long/complex procedures

For any procedure substantial enough that a cancelled command or a
closed-and-reopened session would otherwise lose real context — a
multi-step migration, a large refactor, a full audit across many
files, anything spanning many commits — write a markdown progress
file as you go, not just plan silently in the conversation.

- **Location:** a custom directory at the project root, e.g.
  `.codexpiator/` — pick one consistent name per project. **Add it to
  `.gitignore` immediately**, in the same step you create it, per
  `codexpiator-dx-git/repo-hygiene-and-onboarding.md`'s
  gitignore-every-tool-artifact-directory rule. This is working
  memory, never a project deliverable.
- **One file per task**, named descriptively (e.g.
  `.codexpiator/2026-09-11-auth-migration.md`), containing: the goal,
  what's been done so far, what's left, and any decision/context
  someone (or a future you, in a new session) would need to pick the
  task back up without re-deriving it.
- **Update it as you go** — after each meaningful step, not only at
  the very start and the very end. A progress file that's stale by
  the time it's needed defeats the purpose.
- **Check for one before assuming a fresh start.** If a project has a
  `.codexpiator/` directory with an in-progress file matching the
  current task, read it first — a cancelled command or a new session
  picking up old work should resume from recorded state, not restart
  blind.
- **Clean up on completion.** Once a task finishes successfully,
  delete its progress file — it's a scratchpad for getting through the
  work, not a permanent record (permanent decisions belong in real
  docs/ADRs per `codexpiator-dx-git/documentation-practices.md`).

## Always use superpowers when available

For anything beyond a trivial, obvious change, check whether the
`superpowers:*` skill family is available in the environment and use
it rather than improvising the same process ad hoc — it exists
specifically to make this kind of work efficient and reliable:

- **`superpowers:brainstorming`** before creative/design work or
  anything with more than one reasonable approach.
- **`superpowers:writing-plans`** to turn a spec/requirement into a
  concrete, bite-sized implementation plan before touching code on
  anything multi-step.
- **`superpowers:executing-plans`** or
  **`superpowers:subagent-driven-development`** to carry out a written
  plan task-by-task, with review checkpoints.
- **`superpowers:systematic-debugging`** before proposing a fix for
  any bug or unexpected behavior, instead of guessing.
- **`superpowers:test-driven-development`** while implementing —
  pairs directly with `codexpiator-testing-qa/tdd-workflow.md`'s
  red-green-refactor loop.
- **`superpowers:using-git-worktrees`** when work needs isolation from
  the current workspace.
- **`superpowers:verification-before-completion`** before claiming
  anything is done, fixed, or passing.

If `superpowers` isn't installed in the environment, say so plainly
and fall back to Codexpiator's own equivalent practice (the relevant
`codexpiator-*` file covers the same ground in condensed form) rather
than blocking — the same soft-check-and-fallback pattern as
`shared/external-skills-registry.md`, applied to this specific skill
family because of how directly it improves process efficiency when
present.
