---
name: codexpiator-frontend
description: Frontend engineering guidance - component architecture, state management, CSS/styling architecture, forms and validation, routing, responsive/mobile design, frontend performance, frontend testing, and accessibility. Use for any UI/component/frontend-structure question.
---

# Codexpiator Frontend

Single-purpose reference files for frontend engineering decisions.
Read the specific file below for the concern at hand rather than
trying to hold all of it in one place.

| File | Read this when... |
|---|---|
| `component-architecture.md` | Structuring components, deciding what to extract, naming, folder layout |
| `state-management.md` | Choosing where state lives, local vs global, server vs client state |
| `styling-and-css.md` | Choosing a styling approach, design tokens, theming, responsive strategy |
| `forms-and-validation.md` | Building forms, validation timing, accessible error handling |
| `routing-and-navigation.md` | Route structure, code-splitting by route, auth-gated routes |
| `responsive-and-mobile.md` | Breakpoints, touch targets, mobile web specifics |
| `frontend-performance.md` | Bundle size, lazy loading, images, layout shift |
| `frontend-testing.md` | What to unit/integration/E2E test on the frontend |
| `accessibility.md` | Semantic HTML, ARIA, keyboard nav, contrast, focus management |
| `seo-and-launch-checklist.md` | Pre-launch pass: metadata, SEO tags, legal pages, conversion essentials |
| `seo-strategy-and-ai-visibility.md` | Deep SEO strategy + GEO: ranking in Google/Bing/DuckDuckGo and being cited by AI answer engines |
| `external-skills-map.md` | Whether a specialized design skill should lead instead |

## Before any visually-led answer

If the task is primarily about visual design quality, motion, a broad
polish pass, or auditing an existing UI, check `external-skills-map.md`
first — a specialized external skill may be a better fit than this
skill's own guidance, and that file (plus
`shared/external-skills-registry.md`) has the procedure for checking.
This is not optional for design-heavy work: attempt to consult the
relevant external design skill(s) before finalizing an answer, not
only as a fallback when you happen to remember to check.

## Reference material: awesome-design-md

For design-heavy frontend work, pull relevant reference docs from
https://github.com/voltagent/awesome-design-md — a curated collection
of design-principle documents. Fetch the specific docs relevant to the
task at hand rather than guessing from memory when a authoritative
written reference is one fetch away.

## Mandatory pre-completion gate for any frontend change

Before considering frontend work done:
1. **Consult every relevant file in this skill** (`component-
   architecture.md`, `state-management.md`, `styling-and-css.md`,
   etc. — whichever apply to the change) plus any applicable external
   design skill from `external-skills-map.md`, not just the first one
   that seems relevant.
2. **Run Prettier (or the project's configured formatter) and a type
   check** and resolve everything they flag. Never report frontend
   work complete with unformatted code or type errors outstanding.
3. Confirm new components/pages follow the folder-per-component
   colocation convention in `component-architecture.md`.
4. **Write and run real tests for whatever was created or changed** —
   not just the happy path, cover edge cases too (empty/loading/error
   states, boundary inputs, keyboard-only interaction where relevant)
   — and run the full test suite before calling the work done, not
   just the new test file in isolation. See `frontend-testing.md` and
   `codexpiator-testing-qa/tdd-workflow.md`.
5. Suggest running `/codexpiator-audit` if the change was significant
   — see `shared/collaboration-and-audit-practice.md`.

Also see that same shared file for when to ask a clarifying question
(`AskUserQuestion` when available) instead of guessing.
