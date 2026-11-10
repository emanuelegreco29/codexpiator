---
description: Repo hygiene audit (gitignore, README, .env.example, dead code, unused deps, commits)
argument-hint: "[path (optional)]"
allowed-tools: Agent, Task, AskUserQuestion, Read, Edit, Grep, Glob, Bash(git:*)
---

Audit repo hygiene and developer experience by launching the
`codexpiator-hygiene-auditor` agent through the Agent/Task tool,
following `shared/audit-dispatch.md` (scope, model choice per
`shared/model-routing.md`, launch, result translation). `$1`, if given,
is the path to scope to.

This is a mostly mechanical sweep, so the recommended model is Haiku.
Never print a secret's value in the translated findings.
