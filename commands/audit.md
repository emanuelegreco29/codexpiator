---
description: Full audit, all specialist auditors in parallel (frontend, backend, security, testing, architecture, devops, AI, hygiene)
argument-hint: "[path (optional)]"
allowed-tools: Agent, Task, AskUserQuestion, Read, Edit, Grep, Glob, Bash(git:*)
---

Run a full audit by launching the specialist auditor agents through the
Agent/Task tool, following `${CLAUDE_PLUGIN_ROOT}/shared/audit-dispatch.md` (scope, model
choice per `${CLAUDE_PLUGIN_ROOT}/shared/model-routing.md`, parallel launch, merged
translation). `$1`, if given, is the path to scope to.

Pick the auditors by what the scope actually contains, then launch them
all in one message:

| Auditor agent | Launch when scope has |
|---|---|
| `codexpiator-frontend-auditor` | UI code (components, pages, styles) |
| `codexpiator-backend-auditor` | server, API or data-layer code |
| `codexpiator-security-auditor` | always (any code can carry security issues) |
| `codexpiator-testing-auditor` | any source code |
| `codexpiator-architecture-auditor` | more than a handful of source files |
| `codexpiator-devops-auditor` | CI config, Dockerfiles or deploy config |
| `codexpiator-ai-auditor` | model calls, agent tools or MCP config |
| `codexpiator-hygiene-auditor` | always |

Tell the user in one line which auditors you launched and which you
skipped and why. Single-domain runs are available as
`/codexpiator:audit-frontend`, `-backend`, `-security`, `-testing`,
`-architecture`, `-devops`, `-ai` and `-hygiene`.
