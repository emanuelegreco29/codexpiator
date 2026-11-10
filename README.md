<div align="center">

<img src="assets/logo.png" alt="Codexpiator" width="220" />

# 🧙‍♂️ Codexpiator

**The extremely complete Claude Code toolkit for vibe coders & real-world engineers.**

Frontend · Backend · Security · Testing · Architecture · DevOps · Git/DX · AI Integration. One plugin, nine skills, zero fluff.

[![License: MIT](https://img.shields.io/github/license/emanuelegreco29/codexpiator?color=blue)](LICENSE)
[![Version](https://img.shields.io/badge/version-1.3.0-brightgreen)](.claude-plugin/plugin.json)
[![Claude Code Plugin](https://img.shields.io/badge/Claude%20Code-Plugin-6c47ff)](https://github.com/emanuelegreco29/codexpiator)
[![Skills](https://img.shields.io/badge/skills-9-orange)](#-topic-skills)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-ff69b4)](https://github.com/emanuelegreco29/codexpiator/pulls)

</div>

---

Codexpiator is a router skill plus eight topic skills covering the
full span of shipping real software, organized as dozens of small,
single-purpose files instead of one giant wall of advice. It knows its
own limits too: when a more specialized external skill (visual design,
motion, a deep security audit, ...) would serve you better, it checks
whether that skill is available, tells you plainly if it isn't (and
what it would have given you), and falls back to its own condensed
guidance instead of blocking you.

## 🚀 Installing

```
/plugin marketplace add emanuelegreco29/codexpiator
/plugin install codexpiator
```

Working on it directly? Install straight from your local clone:

```
/plugin marketplace add /absolute/path/to/codexpiator
/plugin install codexpiator
```

Codexpiator ships no hooks and no scripts: it never runs code on its
own and never restricts which Bash commands Claude can run. Everything
is done by Claude, as visible actions, after asking you.

Codexpiator answers in your language. It detects it from your messages,
saves it as `Language:` in the project's `CLAUDE.md`, and keeps using it
until you ask for another one.

`/codexpiator:setup` asks you, **once per project**:

- **Commit attribution**: keep Claude's attribution (`Co-Authored-By`
  line, "Generated with Claude Code" footer) or not. If not, it detects
  your Claude Code version and disables `attribution` in
  `.claude/settings.json` the right way for it (`false` on v2.1.281+,
  the empty-fields object on older versions).
- **Subagent models**: run the audit agents on the recommended models
  (Opus for security and architecture, Sonnet for most, Haiku for
  mechanical sweeps), on your session's default model, or pick per agent.

## 📖 Table of contents

- [Installing](#-installing)
- [What's inside](#-whats-inside)
- [Topic skills](#-topic-skills)
- [Commands](#-commands)
- [Agents](#-agents)
- [External skills it plugs into](#-external-skills-it-plugs-into)
- [Stack policy](#-stack-policy)

## 🧩 What's inside

| Component | Count | Purpose |
|---|---|---|
| 🧭 Router skill | 1 | Classifies a request and dispatches to the right skill/file |
| 📚 Topic skills | 8 | Deep, single-purpose guidance per engineering domain |
| ⚡ Slash commands | 11 | Full audit, 8 single-domain audits, setup, review |
| 🤖 Subagents | 9 | 8 read-only specialist auditors plus a design-reference picker |

## 📚 Topic skills

| Skill | Covers |
|---|---|
| 🎨 `codexpiator-frontend` | Component architecture, state management, styling/CSS, forms & validation, routing, responsive/mobile, performance, accessibility, SEO & AI-search visibility (GEO) |
| ⚙️ `codexpiator-backend` | API design, data modeling & DB, auth & authorization, error handling & logging, caching, background jobs & queues, resilience & rate limiting, performance, testing |
| 🔒 `codexpiator-security` | Secure coding checklist, authn/authz hardening, injection defense (SQLi/XSS/CSRF/SSRF/...), secrets & config, dependency/supply-chain risk, infra & access control, business-logic/webhook security, security testing |
| ✅ `codexpiator-testing-qa` | Testing pyramid & strategy, TDD workflow, mocking & test data, CI quality gates |
| 🏗️ `codexpiator-architecture` | Project structure conventions, design patterns catalog, API contracts & versioning, scalability trade-offs, monolith vs microservices |
| 🚀 `codexpiator-devops` | CI/CD pipelines, environments & config, containerization, observability & monitoring, incident response & rollback, deployment platforms |
| 🌿 `codexpiator-dx-git` | Git workflow & branching, commit/PR conventions, code review checklist, documentation practices, repo hygiene & onboarding |
| 🧠 `codexpiator-ai-integration` | LLM integration patterns, prompt engineering, agentic/tool-use safety (prompt injection, permissions), MCP usage & recommendations |

## ⚡ Commands

| Command | What it does |
|---|---|
| `/codexpiator:audit` | Full audit: launches every relevant specialist auditor in parallel and merges the findings |
| `/codexpiator:audit-frontend` | Components, state, CSS, forms, a11y, performance, SEO |
| `/codexpiator:audit-backend` | API, data, auth implementation, errors, caching, jobs, resilience |
| `/codexpiator:audit-security` | Authn/authz, injection, secrets, dependencies, infra, webhooks, AI safety |
| `/codexpiator:audit-testing` | Coverage of real behavior, edge cases, flaky or over-mocked tests, CI gates |
| `/codexpiator:audit-architecture` | Structure, coupling, patterns, API contracts, scalability, service boundaries |
| `/codexpiator:audit-devops` | CI/CD, environments, Dockerfiles, observability, rollback, deployment |
| `/codexpiator:audit-ai` | LLM calls, prompts, agent and tool safety, prompt injection, MCP |
| `/codexpiator:audit-hygiene` | gitignore, README, `.env.example`, dead code, unused dependencies, commits |
| `/codexpiator:setup` | Bootstraps baseline structure and conventions, and asks your attribution and subagent-model preferences once |
| `/codexpiator:review` | Reviews a diff/PR by launching only the auditors the changed files call for; complements, never replaces, `/code-review` and `security-review` |

## 🤖 Agents

All auditors are read-only: no write access, ever. They report
findings and never touch your code. The audit commands that launch them
are granted `Edit` only so the command itself can save your model
preference to `CLAUDE.md` after asking you; it never edits your code
unless you ask for fixes after seeing the findings.

| Agent | Recommended model |
|---|---|
| `codexpiator-security-auditor` | Opus |
| `codexpiator-architecture-auditor` | Opus |
| `codexpiator-frontend-auditor` | Sonnet |
| `codexpiator-backend-auditor` | Sonnet |
| `codexpiator-testing-auditor` | Sonnet |
| `codexpiator-devops-auditor` | Sonnet |
| `codexpiator-ai-auditor` | Sonnet |
| `codexpiator-hygiene-auditor` | Haiku |
| `codexpiator-design-ref-picker` | Haiku |

The first time agents are needed in a project, Codexpiator asks whether
to use these recommended models, your session's default model, or a
model you pick per agent, and remembers the answer in the project's
`CLAUDE.md` (see [`shared/model-routing.md`](shared/model-routing.md)).

### Compact agent-to-agent findings format

The auditors don't talk to you directly. Their output goes to the
dispatching command, which writes the human-readable summary you see.
Since that hop is agent-to-agent, not agent-to-user, each auditor
returns findings as compact JSON (`{"v":1,"n":...,"sev_max":
...,"f":[{"sev":"H","cat":"SQLI","loc":"api.py:42","desc":"...",
"fix":"..."}]}`) instead of a formatted prose list. The dispatching
command translates that JSON into the readable list before showing it
to you; you never see the raw JSON.

Measured on a 2-finding sample report: the prose form (severity
headers, spelled-out words like "critical"/"medium") ran 347 bytes,
the equivalent JSON ran 273 bytes: a 21% cut, and larger reports save
proportionally more since JSON's fixed key overhead is paid once
while prose repeats headers and severity words per group. Every
findings-list channel that's agent-to-agent only (never rendered
straight to you) follows this pattern; anything shown to you directly
stays plain text.

## 🔌 External skills it plugs into

Codexpiator checks for these when relevant and tells you exactly how
to get them if they're missing. See
[`shared/external-skills-registry.md`](shared/external-skills-registry.md)
for the full behavior and honest notes on which install paths are
actually confirmed:

| Skill | For |
|---|---|
| `security-review` | Deep, specialized security audits |
| `frontend-design` | Distinctive, non-generic UI implementation |
| `design-motion-principles` | Motion & interaction design |
| `impeccable` | Broad frontend polish/critique pass |
| `design-taste-frontend` | Anti-template landing pages & portfolios |
| `web-design-guidelines` | Interface-guideline compliance audits |
| `redesign-existing-projects` | Upgrading an existing UI without breaking it |
| `ui-ux-pro-max` | General high-end UI/UX assistance |

Availability varies by environment. Codexpiator always falls back to
its own guidance when one isn't installed, never leaving you blocked.

## 🧱 Stack policy

Universal principles first, always, with explicit "if you use X"
call-outs for the most common modern stacks (React/Next.js, Vue/Nuxt,
Node/Express, Python/FastAPI, Go). See
[`shared/stack-recommendations.md`](shared/stack-recommendations.md).

## 🤝 Contributing

1. Fork, then branch from `main` (`feat/...`, `fix/...`, `docs/...`).
2. Keep the structure: one topic per file under `skills/<skill>/`,
   shared behavior in `shared/`, one file per command in `commands/`
   and per subagent in `agents/`. No hooks and no scripts.
3. Check your change: every file's frontmatter must parse as YAML, every
   path or agent name mentioned must exist, and
   `claude plugin validate .` (or the `plugin-dev:plugin-validator`
   agent) must come back clean.
4. Use conventional commit prefixes (`feat`, `fix`, `docs`, `refactor`,
   `chore`), one logical change per commit, and keep version bumps in
   their own commit.
5. Open a PR describing what changed, why, and how you checked it.

---

<div align="center">

Made for people who ship real software, one skill at a time.

</div>
