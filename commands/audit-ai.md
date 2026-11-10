---
description: AI-integration audit (LLM calls, prompts, agent and tool safety, prompt injection, MCP)
argument-hint: "[path (optional)]"
allowed-tools: Agent, Task, AskUserQuestion, Read, Edit, Grep, Glob, Bash(git:*)
---

Audit the LLM and agent features by launching the
`codexpiator-ai-auditor` agent through the Agent/Task tool, following
`${CLAUDE_PLUGIN_ROOT}/shared/audit-dispatch.md` (scope, model choice per
`${CLAUDE_PLUGIN_ROOT}/shared/model-routing.md`, launch, result translation). `$1`, if given,
is the path to scope to.

If a quick search shows no model calls, tool definitions or MCP config
in scope, say so in one line instead of launching. Never print a
secret's value in the translated findings.
