---
description: Security-only audit (authn/authz, injection, secrets, dependencies, infra, webhooks, AI safety)
argument-hint: "[path (optional)]"
allowed-tools: Agent, Task, AskUserQuestion, Read, Edit, Grep, Glob, Bash(git:*)
---

Audit only security by launching the `codexpiator-security-auditor`
agent through the Agent/Task tool, following
`shared/audit-dispatch.md` (scope, model choice per
`shared/model-routing.md`, launch, result translation). `$1`, if given,
is the path to scope to.

The auditor leads with the `security-review` skill when it is
available and falls back to Codexpiator's security checklists. This
audit is the one where the recommended model matters most (Opus).
Never print a secret's value in the translated findings; show its
location only.
