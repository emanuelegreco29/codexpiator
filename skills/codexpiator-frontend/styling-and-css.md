# Styling & CSS Architecture

## Pick one approach, stay consistent

Utility-first (atomic classes composed in markup), component-scoped
CSS (a stylesheet per component, scoped by tooling or convention), and
CSS-in-JS (styles authored in the same file as the component's logic)
each have real trade-offs — utility-first is fast to write and keeps
styles colocated with markup but can make markup noisy; scoped CSS
keeps markup clean but separates style from structure across two
files; CSS-in-JS colocates fully but can add a runtime or build-step
cost depending on implementation. None of the three is universally
correct. What matters more than which one you pick is picking one per
project and applying it consistently — a codebase mixing all three
styling strategies is harder to maintain than a codebase fully
committed to the "wrong" one.

## Design tokens

Define spacing, color, and typography as a small fixed scale (tokens)
rather than letting each component invent its own values. A scale
like `4px, 8px, 12px, 16px, 24px, 32px, 48px` for spacing, and a named
palette (`primary`, `neutral-100`...`neutral-900`, `danger`, `success`)
for color, is the single biggest lever against visual inconsistency —
it's much easier to keep a UI coherent when every measurement and
color traces back to one small shared vocabulary instead of arbitrary
per-component values.

## Avoiding magic numbers

A `margin-top: 13px` with no explanation is a magic number — nobody
maintaining the code can tell if `13` is intentional or an accident of
trial-and-error. If a value doesn't map to a token, that's usually a
sign the token scale is missing something, not that this one spot
needs a one-off exception.

## Responsive strategy: mobile-first by default

Write the base (no media query) styles for the smallest viewport, then
add complexity for larger viewports with `min-width` media queries.
This tends to produce simpler CSS than desktop-first (`max-width`
overrides cascading downward) because you're adding capability as
space increases rather than subtracting it, and it forces you to
design the constrained case first instead of as an afterthought.

## Theming / dark mode at the token level

Implement theming by swapping the *values* behind your design tokens
(e.g. `--color-background` resolves differently per theme) rather than
writing parallel dark-mode overrides for every component
individually. If every component already references tokens instead of
hardcoded colors, theming becomes a token-file change instead of a
codebase-wide one.
