---
description: Architecture audit (structure, coupling, patterns, API contracts, scalability, service boundaries)
argument-hint: "[path (optional)]"
allowed-tools: Agent, Task, AskUserQuestion, Read, Edit, Grep, Glob, Bash(git:*)
---

Audit the architecture by launching the
`codexpiator-architecture-auditor` agent through the Agent/Task tool,
following `${CLAUDE_PLUGIN_ROOT}/shared/audit-dispatch.md` (scope, model choice per
`${CLAUDE_PLUGIN_ROOT}/shared/model-routing.md`, launch, result translation). `$1`, if given,
is the path to scope to.

Architecture findings are trade-offs: present each with the cost it
causes, and when a fix would restructure code, ask the user before
acting rather than assuming.
