---
description: Testing/QA audit (coverage of real behavior, edge cases, flaky or over-mocked tests, CI gates)
argument-hint: "[path (optional)]"
allowed-tools: Agent, Task, AskUserQuestion, Read, Edit, Grep, Glob, Bash(git:*)
---

Audit the tests by launching the `codexpiator-testing-auditor` agent
through the Agent/Task tool, following `shared/audit-dispatch.md`
(scope, model choice per `shared/model-routing.md`, launch, result
translation). `$1`, if given, is the path to scope to.

The auditor judges tests by reading them; it does not run the suite.
If the user wants the suite run too, run it yourself afterwards and
report failures separately.
