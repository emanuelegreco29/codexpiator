# Codexpiator

An extremely complete Claude Code plugin for vibe coders, software
engineers, and frontend/backend developers. Codexpiator is a router
skill plus eight topic skills covering frontend, backend, security,
testing, architecture, devops, git/DX, and AI-integration practice —
organized as many small, single-purpose files instead of one giant
document.

It also knows when a more specialized external skill (visual design,
motion, security review, ...) would serve you better than its own
guidance: it checks whether that skill is available in your
environment, tells you plainly if it isn't (and what it would have
given you), and falls back to its own condensed guidance rather than
blocking you.

## What's inside

### Router

- **codexpiator** — entry point. Classifies your request and points
  you at the right skill below, or dispatches straight to it.

### Topic skills

| Skill | Covers |
|---|---|
| `codexpiator-frontend` | Component architecture, state management, styling/CSS, forms & validation, routing, responsive/mobile, frontend performance, frontend testing, accessibility |
| `codexpiator-backend` | API design, data modeling & DB, auth & authorization, error handling & logging, caching, background jobs & queues, resilience & rate limiting, backend performance, backend testing |
| `codexpiator-security` | Secure coding checklist, authn/authz patterns, input validation & injection, secrets & config management, dependency & supply-chain risk |
| `codexpiator-testing-qa` | Testing pyramid & strategy, TDD workflow, mocking & test data, CI quality gates |
| `codexpiator-architecture` | Project structure conventions, design patterns catalog, API contracts & versioning, scalability trade-offs, monolith vs microservices |
| `codexpiator-devops` | CI/CD pipelines, environments & config, containerization, observability & monitoring, incident response & rollback, deployment platforms |
| `codexpiator-dx-git` | Git workflow & branching, commit/PR conventions, code review checklist, documentation practices, repo hygiene & onboarding |
| `codexpiator-ai-integration` | LLM integration patterns, prompt engineering basics, agentic/tool-use safety, MCP usage & recommendations |

### Commands

- `/codexpiator-audit` — full frontend + backend + security + testing
  audit of the current project, run through the `codexpiator-reviewer`
  agent so it doesn't fill up your main conversation.
- `/codexpiator-setup` — bootstraps baseline structure/conventions for
  a new project.
- `/codexpiator-review` — targeted review of a diff/PR against
  Codexpiator's own checklists (complements, doesn't replace,
  `/code-review` and `security-review`).

### Agent

- `codexpiator-reviewer` — read-only subagent used by the two audit
  commands above for isolated, multi-file review work.

## External skills it plugs into

Codexpiator checks for these when relevant and tells you how to get
them if they're missing — see `shared/external-skills-registry.md`
for the full behavior and honest caveats about which install paths are
actually confirmed:

- `security-review` — deep security audits
- `frontend-design` — distinctive, non-generic UI implementation
- `design-motion-principles`, `impeccable`, `design-taste-frontend`,
  `web-design-guidelines`, `redesign-existing-projects` — design/UX
  specialists (availability varies by environment; Codexpiator falls
  back to its own guidance when one isn't installed)

## Stack policy

Content is stack-agnostic by default: universal principles first,
with explicit "if you use X" call-outs for the most common modern
stacks (React/Next.js, Vue/Nuxt, Node/Express, Python/FastAPI, Go).
See `shared/stack-recommendations.md`.

## Installing

This plugin isn't published yet — install it straight from your local
clone:

```
/plugin marketplace add /absolute/path/to/Codexpiator
/plugin install codexpiator
```

Once it's pushed to GitHub, the same flow works with the repo URL
instead of a local path:

```
/plugin marketplace add <github-user>/Codexpiator
/plugin install codexpiator
```
