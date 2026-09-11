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
| `security-review` | Deep security review of code/diffs | Any pre-merge or periodic security audit pass | Ships via the `security-guidance` (aka `claude-security`) plugin in the official `claude-plugins-official` marketplace | Use `codexpiator-security/secure-coding-checklist.md` and the rest of that skill |
| `frontend-design` | Distinctive, non-generic UI implementation | Building new UI from scratch that needs a strong visual point of view | `claude-plugins-official` marketplace, plugin name `frontend-design` | Use `codexpiator-frontend` guidance plus the general taste heuristics in `component-architecture.md` and `styling-and-css.md` |
| `design-motion-principles` | Motion/interaction design audit and authoring | Adding or reviewing animations, transitions, micro-interactions | Not resolvable to one guaranteed marketplace source as of this writing — check the session's available-skills list first | State the gap by name, continue with `codexpiator-frontend/frontend-performance.md`'s motion-cost notes and basic easing/duration heuristics |
| `impeccable` | Broad frontend polish/critique/redesign | A general UI quality pass across many surfaces at once | Not resolvable to one guaranteed marketplace source | State the gap, fall back to `codexpiator-frontend`'s own resource files |
| `design-taste-frontend` | Anti-template landing pages/portfolios | New marketing/landing-page builds | Not resolvable to one guaranteed marketplace source | Fall back to `codexpiator-frontend/component-architecture.md` + `styling-and-css.md` |
| `web-design-guidelines` | Compliance check against interface guidelines | A pre-ship accessibility/UX guideline audit | Not resolvable to one guaranteed marketplace source | Fall back to `codexpiator-frontend/accessibility.md` |
| `redesign-existing-projects` | Structured audit-then-upgrade of an existing UI | Modernizing an existing app without breaking it | Not resolvable to one guaranteed marketplace source | Fall back to `codexpiator-architecture/project-structure-conventions.md` plus `codexpiator-frontend` guidance, applied incrementally |

## Why some rows don't have a confirmed install path

At the time this registry was written, only `security-review` and
`frontend-design` could be traced to one specific, currently-installed
marketplace plugin in the environment used to build Codexpiator. The
other design skills listed above are real and useful, but they may be
bundled into a user's environment through a different mechanism
(a different marketplace, a bundled creative-tools pack, a private
plugin) that isn't guaranteed to be the same for every user. Promising
a specific `/plugin marketplace add ...` command that might not
resolve would be worse than being honest about the uncertainty — so
those rows tell Claude to check first and be upfront about the gap
rather than guess.

If you maintain this registry and confirm a real, stable install path
for one of the "not resolvable" rows, update its Install column with
the specific marketplace/plugin name rather than leaving it generic.
