---
description: Frontend-only audit (components, state, CSS, forms, a11y, performance, SEO)
argument-hint: [path (optional)]
allowed-tools: Agent, Task, AskUserQuestion, Read, Edit, Grep, Glob, Bash(git:*)
---

Audit only the frontend by launching the `codexpiator-frontend-auditor`
agent through the Agent/Task tool, following
`shared/audit-dispatch.md` (scope, model choice per
`shared/model-routing.md`, launch, result translation). `$1`, if given,
is the path to scope to.

Use this for a focused pass on the UI layer. For everything at once,
use `/codexpiator-audit`.
