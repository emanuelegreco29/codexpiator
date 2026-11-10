---
description: DevOps audit (CI/CD, environments, Dockerfiles, observability, rollback, deployment)
argument-hint: "[path (optional)]"
allowed-tools: Agent, Task, AskUserQuestion, Read, Edit, Grep, Glob, Bash(git:*)
---

Audit the build, deploy and operations setup by launching the
`codexpiator-devops-auditor` agent through the Agent/Task tool,
following `${CLAUDE_PLUGIN_ROOT}/shared/audit-dispatch.md` (scope, model choice per
`${CLAUDE_PLUGIN_ROOT}/shared/model-routing.md`, launch, result translation). `$1`, if given,
is the path to scope to.

If the scope has no CI config, Dockerfile or deploy config, say so in
one line instead of launching.
