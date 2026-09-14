<div align="center">

<img src="assets/logo.png" alt="Codexpiator" width="220" />

# 🧙‍♂️ Codexpiator

**The extremely complete Claude Code toolkit for vibe coders & real-world engineers.**

Frontend · Backend · Security · Testing · Architecture · DevOps · Git/DX · AI Integration. One plugin, nine skills, zero fluff.

[![License: MIT](https://img.shields.io/github/license/emanuelegreco29/codexpiator?color=blue)](LICENSE)
[![Version](https://img.shields.io/badge/version-1.1.1-brightgreen)](.claude-plugin/plugin.json)
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

Codexpiator checks for a newer release on every session start and
tells you exactly how to update if one's available: no polling, no
noise when you're already current.

It also **hard-blocks any commit or PR that includes AI/assistant
attribution** (a `Co-Authored-By: Claude` line, a "Generated with
Claude Code" footer, etc.), deterministically, via a `PreToolUse`
hook, not just a skill saying not to. Opt out per project with an
empty `.codexpiator/allow-ai-attribution` file if you genuinely want
attribution there.

## 📖 Table of contents

- [Installing](#-installing)
- [What's inside](#-whats-inside)
- [Topic skills](#-topic-skills)
- [Commands](#-commands)
- [Agent](#-agent)
- [External skills it plugs into](#-external-skills-it-plugs-into)
- [Stack policy](#-stack-policy)

## 🧩 What's inside

| Component | Count | Purpose |
|---|---|---|
| 🧭 Router skill | 1 | Classifies a request and dispatches to the right skill/file |
| 📚 Topic skills | 8 | Deep, single-purpose guidance per engineering domain |
| ⚡ Slash commands | 3 | Audit, setup, and review workflows |
| 🤖 Subagent | 1 | Isolated, read-only multi-file reviewer |

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
| `/codexpiator-audit` | Full frontend + backend + security + testing audit, run through the `codexpiator-reviewer` agent so it never floods your main conversation |
| `/codexpiator-setup` | Bootstraps baseline structure and conventions for a project |
| `/codexpiator-review` | Targeted review of a diff/PR against Codexpiator's own checklists; complements, never replaces, `/code-review` and `security-review` |

## 🤖 Agent

- **`codexpiator-reviewer`**: read-only subagent behind the two audit
  commands above. No write access, ever; it reports findings, it
  doesn't touch your code.

### Compact agent-to-agent findings format

`codexpiator-reviewer` doesn't talk to you directly. Its output goes
to `/codexpiator-audit`, which then writes the human-readable summary
you see. Since that hop is agent-to-agent, not agent-to-user, the
reviewer returns findings as compact JSON (`{"v":1,"n":...,"sev_max":
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

---

<div align="center">

Made for people who ship real software, one skill at a time.

</div>
