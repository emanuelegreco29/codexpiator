# External Skills Registry

Codexpiator is deliberately not a replacement for specialized skills
that already do one thing extremely well. This file is the single
source of truth every `codexpiator-*` skill points to before it
answers a request that a specialized external skill would handle
better.

## How to check availability (procedure)

1. Look at the list of skills currently available in this session
   (the system surfaces this at session start / via its skill
   listing). Match by exact name, or `<plugin>:<name>` if the skill is
   namespaced by its plugin.
2. **If found:** invoke it. Let it do the specialized work; don't
   duplicate its content from memory.
3. **If not found:** say so plainly to the user — name the skill,
   name what it would have provided — then continue using
   Codexpiator's own fallback guidance from the row below. Never
   block the user waiting on an install.
4. **Never fabricate an install command.** Only state an install path
   for a skill whose marketplace source is confirmed (see the table).
   For everything else, say installation availability varies by
   environment and point at `/plugin marketplace` as the place to
   look, without promising a specific result.

## Registry

| Skill | Purpose | Prefer it when | Install | Fallback if absent |
|---|---|---|---|---|
| `security-review` | Deep security review of code/diffs | Any pre-merge or periodic security audit pass — MANDATORY: attempt this before finalizing any security-sensitive change, not just as a fallback-if-missing check | Ships via the `security-guidance` (aka `claude-security`) plugin in the official `claude-plugins-official` marketplace | Use `codexpiator-security`'s own checklist files |
| `frontend-design` | Distinctive, non-generic UI implementation | Building new UI from scratch that needs a strong visual point of view | `claude-plugins-official` marketplace, plugin name `frontend-design` | Use `codexpiator-frontend` guidance plus the general taste heuristics in `component-architecture.md` and `styling-and-css.md` |
| `design-motion-principles` | Motion/interaction design audit and authoring | Adding or reviewing animations, transitions, micro-interactions | `npx skills add kylezantos/design-motion-principles` | State the gap by name, continue with `codexpiator-frontend/frontend-performance.md`'s motion-cost notes and basic easing/duration heuristics |
| `impeccable` | Broad frontend polish/critique/redesign | A general UI quality pass across many surfaces at once | `npx impeccable install` | State the gap, fall back to `codexpiator-frontend`'s own resource files |
| `design-taste-frontend` | Anti-template landing pages/portfolios | New marketing/landing-page builds | `npx skills add Leonxlnx/taste-skill` (same repo as `redesign-existing-projects` below) | Fall back to `codexpiator-frontend/component-architecture.md` + `styling-and-css.md` |
| `web-design-guidelines` | Compliance check against interface guidelines | A pre-ship accessibility/UX guideline audit — treat as most important skill to pull from this bundle | `npx skills add vercel-labs/agent-skills` (installs the full bundle; `web-design-guidelines` is the priority skill in it) | Fall back to `codexpiator-frontend/accessibility.md` |
| `redesign-existing-projects` | Structured audit-then-upgrade of an existing UI | Modernizing an existing app without breaking it | `npx skills add https://github.com/leonxlnx/taste-skill --skill redesign-existing-projects` | Fall back to `codexpiator-architecture/project-structure-conventions.md` plus `codexpiator-frontend` guidance, applied incrementally |
| `ui-ux-pro-max` | Broad UI/UX pro-level design assistance | General high-end UI/UX pass not covered by the more specific skills above | `/plugin marketplace add nextlevelbuilder/ui-ux-pro-max-skill` then `/plugin install ui-ux-pro-max@ui-ux-pro-max-skill` — or globally via `uipro init --ai claude --global` (installs to `~/.claude/skills/`) | Fall back to `codexpiator-frontend`'s own resource files |

## Install commands are user-confirmed, still verify before running

The commands above were supplied directly by this plugin's maintainer
as known-working install paths — treat them as trustworthy, but still
confirm the skill actually registered as available after running one
(check the session's available-skills listing) before relying on it,
since a network failure or a renamed upstream repo can make even a
correct command fail silently from Claude's point of view. If a
command in this table stops working, note it and fall back rather than
retrying it blindly.
