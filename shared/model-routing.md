# Subagent Model Routing

Every Codexpiator subagent is defined with `model: inherit` (the
session's own model). Which model it actually runs on is decided at
launch time, through the `model` parameter of the Agent/Task tool,
following the user's recorded choice. Not every task needs the same
horsepower: judgment-heavy, high-stakes audits are worth a stronger
model, mechanical checklist sweeps are not.

## Recommended models

| Agent | Recommended | Why |
|---|---|---|
| `codexpiator-security-auditor` | `opus` | Missed vulnerabilities are the costliest false negatives; needs multi-step reasoning over data flow and trust boundaries |
| `codexpiator-architecture-auditor` | `opus` | Judging structure, coupling and trade-offs is open-ended reasoning, not pattern matching |
| `codexpiator-frontend-auditor` | `sonnet` | Broad checklist plus code reading; mid-tier is enough |
| `codexpiator-backend-auditor` | `sonnet` | Same; N+1, error handling and API shape are well-defined checks |
| `codexpiator-testing-auditor` | `sonnet` | Needs to understand what tests actually assert, not only that they exist |
| `codexpiator-devops-auditor` | `sonnet` | Config and pipeline review |
| `codexpiator-ai-auditor` | `sonnet` | Prompt-injection and permission review needs some judgment |
| `codexpiator-hygiene-auditor` | `haiku` | Mostly mechanical: gitignore, README, dead code, stale files |
| `codexpiator-design-ref-picker` | `haiku` | Browses an index and copies matching docs |

## Asking the user (once per project)

Before the first subagent launch in a project, check the project's
`CLAUDE.md` for a `Subagent models:` line under
`## Codexpiator preferences`. If it exists, follow it silently. If
not, call `AskUserQuestion` once with these options:

1. **Recommended models (Recommended)**: use the table above.
2. **Session default**: every subagent runs on whatever model this
   session uses; no override is passed.
3. **Choose my own**: ask a follow-up `AskUserQuestion` (up to four
   agents per call, grouped) offering `opus`, `sonnet`, `haiku` or
   session default for each agent that will run.

Persist the answer per
`${CLAUDE_PLUGIN_ROOT}/shared/collaboration-and-audit-practice.md`'s preference-persistence
rule: one line in the project's `CLAUDE.md`, e.g.
`- Subagent models: recommended`, `- Subagent models: default`, or
`- Subagent models: custom (security=opus, hygiene=haiku, others=default)`.
If the user later says they want to change it, update that line.

## Applying the choice

- **Recommended**: pass the table's model as the Agent/Task tool's
  `model` parameter for each launch.
- **Session default**: omit `model` (agents inherit).
- **Custom**: pass each agent's chosen model; omit it where the user
  chose default.

If a requested model isn't available in the environment, say so in one
line, omit the override for that agent, and continue.
