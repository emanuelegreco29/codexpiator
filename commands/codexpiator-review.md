---
description: Review a diff or PR against Codexpiator's checklists
argument-hint: [pr-number-or-branch (optional)]
allowed-tools: Skill, Read, Grep, Glob, Bash(git:*), Bash(gh:*)
---

Review a change against Codexpiator's own checklists — complementary
to, not a replacement for, `/code-review` and `security-review` when
those are available.

1. Determine the target: if `$1` is given, treat it as a PR number or
   branch to review (`gh pr diff $1` or `git diff main...$1` as
   appropriate); otherwise review the current uncommitted diff
   (`git diff` / `git diff --staged`).
2. Invoke the `codexpiator-dx-git` skill and apply its code review
   checklist.
3. For any changed file touching auth, user input, secrets, payments,
   or infrastructure config, also invoke `codexpiator-security` and
   apply its relevant checklist(s).
4. For any changed frontend/backend code, invoke
   `codexpiator-frontend`/`codexpiator-backend` and spot-check against
   the specific concern touched (don't pull in everything either skill
   covers — only what's relevant to what changed).
5. Confirm no unwanted AI/assistant attribution was left in any commit
   message or PR description in scope (per
   `codexpiator-dx-git/commit-and-pr-conventions.md`).
6. Output one line per finding: `file:line — severity — problem — fix`.
   No praise, no scope creep, no restating what's already correct.
