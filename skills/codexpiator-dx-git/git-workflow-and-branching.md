# Git Workflow & Branching

## Short-lived feature branches

Branch from the trunk (`main`), keep the branch alive for as short a
time as practical, and merge back via PR — this scales down cleanly
to a solo project (branch, PR, merge, delete) and up to a small team
without extra ceremony. Long-lived branches accumulate drift from the
trunk, making eventual merges larger and riskier the longer they live.

## Rebase vs merge for staying current

Rebasing a feature branch onto the latest trunk produces a clean,
linear history — good when the team has agreed on this convention and
nobody else is building on top of your branch (rebase rewrites commit
history, which is unsafe to do on commits others have already based
work on). Merging the trunk into your branch is safer when history-
rewriting could disrupt collaborators, at the cost of extra merge
commits in the history. Pick one convention per project and apply it
consistently; the specific choice matters less than everyone following
the same one.

## Never force-push a shared branch

Force-pushing rewrites history that others may have already pulled —
doing this on a branch anyone else is working from can silently
destroy their work or desynchronize their local copy in a confusing
way. Force-push is fine on your own not-yet-shared feature branch;
never on `main`/`master` or any branch others are actively using.

## Meaningful release tags

Tag releases with a clear, consistent scheme (semantic versioning —
`MAJOR.MINOR.PATCH`, incrementing MAJOR for breaking changes, MINOR
for backward-compatible features, PATCH for backward-compatible fixes)
so anyone can tell from the version number alone roughly what kind of
change it represents.
