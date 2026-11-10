---
description: Review a diff or PR against Codexpiator's checklists using specialist auditors
argument-hint: [pr-number-or-branch (optional)]
allowed-tools: Agent, Task, AskUserQuestion, Read, Edit, Grep, Glob, Bash(git:*), Bash(gh:*)
---

Review a change against Codexpiator's checklists, complementary to, not
a replacement for, `/code-review` and `security-review` when those are
available.

1. Determine the target: if `$1` is given, treat it as a PR number or
   branch (`gh pr diff $1` or `git diff main...$1` as appropriate);
   otherwise review the current uncommitted diff (`git diff` and
   `git diff --staged`). List the changed files.
2. Choose auditors from what changed, not from the whole project:
   - UI files: `codexpiator-frontend-auditor`
   - server, API or data files: `codexpiator-backend-auditor`
   - anything touching auth, user input, secrets, payments, uploads,
     webhooks, dependencies or infra config:
     `codexpiator-security-auditor`
   - test files, or source changes with no test changes:
     `codexpiator-testing-auditor`
   - CI, Docker or deploy files: `codexpiator-devops-auditor`
   - model calls, agent tools, MCP config: `codexpiator-ai-auditor`
   - structural changes across many files:
     `codexpiator-architecture-auditor`
   - repo hygiene is only checked if the diff touches ignore files,
     README, env examples or dependency manifests:
     `codexpiator-hygiene-auditor`
3. Launch them following `shared/audit-dispatch.md`, passing the diff
   command as their scope so each reads only the changed code.
4. Output one line per finding: `file:line — severity — problem — fix`.
   No praise, no scope creep, no restating what's already correct.
