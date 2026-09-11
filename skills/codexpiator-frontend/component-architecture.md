# Component Architecture

## Single responsibility

A component should do one thing: render a piece of UI, or coordinate
a small group of children — not both a data-fetching concern, a
complex business calculation, and a large render tree at once. If you
can't describe a component's job in one sentence without "and", split
it.

## Container / presentational split

Separate the component that knows *how to get data* (a container:
fetches, computes, decides what to render) from the component that
knows *how to render given data* (presentational: pure props in, UI
out). The presentational half is trivially testable and reusable
without a backend; the container half is where data-fetching and
side-effect concerns live. This isn't a rigid rule to apply
everywhere — a small, self-contained component with a little local
state doesn't need to be split — but reach for it once a component's
render logic and data logic start growing independently of each
other.

## Composition over prop-drilling

If a prop is passed through three or more intermediate components
that don't use it themselves, that's prop-drilling — a sign the data
should either be composed differently (pass the child as `children`/
a slot instead of threading props down to it) or lifted into a
shared state mechanism (see `state-management.md`). Composition
(wrapping children rather than threading props) usually resolves this
without introducing a new state layer.

## When to extract a component

Extract when at least one of these is true:
- The same markup/logic is used in two or more places (reuse).
- A section of a render function has grown large enough that reading
  the parent component requires scrolling past it to understand the
  parent's own logic (size).
- The section has a genuinely distinct responsibility from its parent
  (e.g. a form field vs the form that contains it).

Don't extract just because "components should be small" as an
abstract rule — a 40-line component that does one clear thing doesn't
need to become three 15-line ones. Splitting for its own sake adds
indirection (extra files, extra prop plumbing) without reducing real
complexity. YAGNI applies to component boundaries as much as to
features.

## Naming conventions

- Name a component for what it renders or represents, not for its
  internal implementation detail (`UserCard`, not `FlexRowWithAvatar`).
- Keep naming consistent across the codebase: if list-item components
  elsewhere are named `ThingListItem`, don't introduce
  `ThingRow` for the same pattern in a new feature.
- A component's file name should match its exported name exactly —
  don't make someone guess which export `Card.tsx` provides.

## Folder-per-component/page colocation

Every component and every page gets its own dedicated directory
holding everything specific to it — markup/logic (`.tsx`), styles
(`.css`/module), and its own tests — rather than scattering a
component's `.tsx` in one shared folder and its `.css` in another.
This is the file-system expression of single responsibility: deleting
or moving the feature means deleting or moving one folder, and nothing
about it is implicit or split across parallel directory trees. Default
layout for a component:

```
components/
  UserCard/
    UserCard.tsx
    UserCard.css
    UserCard.test.tsx
```

The same applies to pages/routes: a page's `.tsx` and its `.css` live
together in that page's own directory, not in a global `styles/`
folder disconnected from the component that uses them. Apply this
consistently — the more modular and predictable the layout, the less
someone has to search to find everything relevant to one piece of UI.

## Folder-per-feature vs folder-per-type

Folder-per-type (`components/`, `hooks/`, `utils/` at the top level,
everything for every feature mixed inside each) works for very small
apps but stops scaling once you have more than a handful of features:
changing one feature means touching files scattered across every
top-level folder, and it's hard to tell what's safe to delete.

Folder-per-feature (each feature owns its own components, hooks, and
utils in one place; only genuinely cross-feature code lives in a
shared top-level folder) scales better past that point: a feature's
blast radius is visible at a glance, and deleting a feature is
deleting one folder. Default to feature-based structure for anything
beyond a small app; a flat structure is fine to start with and doesn't
need to be preemptively over-organized before there's a second
feature to separate it from.
