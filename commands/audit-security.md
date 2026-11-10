---
description: Security-only audit (authn/authz, injection, secrets, dependencies, infra, webhooks, AI safety)
argument-hint: "[path (optional)]"
allowed-tools: Agent, Task, Skill, AskUserQuestion, Read, Edit, Grep, Glob, Bash(git:*), Bash(claude plugin:*)
---

First, in this main thread, follow
`${CLAUDE_PLUGIN_ROOT}/shared/claude-security-plugin.md`: check for
`claude-security:claude-security`, install it if missing, invoke it on
the scope, and keep its findings.

Then audit security by launching the `codexpiator-security-auditor`
agent through the Agent/Task tool, following
`${CLAUDE_PLUGIN_ROOT}/shared/audit-dispatch.md` (scope, model choice per
`${CLAUDE_PLUGIN_ROOT}/shared/model-routing.md`, launch, result translation).
Pass the `claude-security` findings (or the fact it was missing/failed)
in the auditor's prompt. `$1`, if given, is the path to scope to.

The auditor verifies and merges those findings, runs `security-review`
when available, and applies Codexpiator's security checklists. This
audit is the one where the recommended model matters most (Opus).
Never print a secret's value in the translated findings; show its
location only.
