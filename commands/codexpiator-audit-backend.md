---
description: Backend-only audit (API, data, auth implementation, errors, caching, jobs, resilience)
argument-hint: "[path (optional)]"
allowed-tools: Agent, Task, AskUserQuestion, Read, Edit, Grep, Glob, Bash(git:*)
---

Audit only the backend by launching the `codexpiator-backend-auditor`
agent through the Agent/Task tool, following
`shared/audit-dispatch.md` (scope, model choice per
`shared/model-routing.md`, launch, result translation). `$1`, if given,
is the path to scope to.

Use this for a focused pass on the server side. For security-specific
findings use `/codexpiator-audit-security`; for everything at once,
`/codexpiator-audit`.
