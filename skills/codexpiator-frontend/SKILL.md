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
| `external-skills-map.md` | Whether a specialized design skill should lead instead |

## Before any visually-led answer

If the task is primarily about visual design quality, motion, a broad
polish pass, or auditing an existing UI, check `external-skills-map.md`
first — a specialized external skill may be a better fit than this
skill's own guidance, and that file (plus
`shared/external-skills-registry.md`) has the procedure for checking.
