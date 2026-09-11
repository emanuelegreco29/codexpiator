# Repo Hygiene & Onboarding

## A new contributor should succeed from the README alone

If getting a working local environment requires undocumented tribal
knowledge (a step someone has to be told in chat), that's a gap in the
README, not an acceptable onboarding cost. Test the setup
instructions from a genuinely clean checkout periodically to catch
drift between what's documented and what's actually required.

## Keep `.env.example` in sync

Every environment variable the project actually reads should have a
corresponding placeholder entry in `.env.example`, kept up to date as
config needs change — a stale example file sends a new contributor
chasing a missing-variable error that a five-second file update would
have prevented.

## Gitignore every Claude/skill-tool artifact directory, always

Any directory a Claude Code skill, plugin, or AI coding tool creates
as its own working/cache state — `.claude/`, `.superpowers/`,
`.playwright/`, `.docs/` (a tool-generated dot-directory, distinct from
a project's own plain `docs/` folder holding real authored content),
and any similar tool-artifact directory a skill introduces — must be
added to `.gitignore` in every project this toolkit sets up or
touches. Check for this explicitly whenever `/codexpiator-setup` runs
or whenever a skill is observed creating a new such directory; add the
missing entry immediately rather than letting tool-generated state get
committed by accident. This is separate from, and doesn't affect,
committing a project's own deliberately-authored documentation.

## Remove dead code instead of commenting it out

A block of commented-out code accumulates as unreadable clutter and
nobody's ever confident it's safe to delete later — if it's not
running, delete it and rely on git history to recover it if it's ever
actually needed again.

## Dependency updates on a cadence

Handle dependency updates as routine, scheduled maintenance (weekly/
monthly automated PRs, reviewed and merged like any other change)
rather than letting them accumulate until a security scanner forces an
urgent, larger, riskier update all at once.

## CODEOWNERS once there's more than a couple of contributors

Route review responsibility explicitly (a CODEOWNERS file or
equivalent) once a repo has enough contributors that "who should
review this" isn't obvious by default — this prevents both PRs
languishing with no clear reviewer and the opposite problem of nobody
feeling specifically responsible for a review.
