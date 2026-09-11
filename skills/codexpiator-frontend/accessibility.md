# Accessibility

## Semantic HTML before ARIA

"No ARIA is better than bad ARIA." A native `<button>` already has
correct keyboard behavior, focus handling, and screen-reader semantics
built in for free; a `<div onClick>` styled to look like a button has
none of that until you manually reimplement it, and it's easy to get
wrong. Reach for the correct native element first (`button`, `a`,
`nav`, `main`, `label`, `table` for tabular data) and only add ARIA
attributes for the gap that's left once semantic HTML has done what it
can.

## Keyboard navigability is a baseline requirement

Every interactive element must be reachable and operable via keyboard
alone (Tab to move focus, Enter/Space to activate) — not an
accessibility "nice to have" added at the end. Verify this directly:
unplug the mouse (or just don't use it) and try to complete the core
flow using only Tab, Shift+Tab, Enter, Space, and arrow keys where
applicable.

## Color contrast minimums

Follow WCAG AA at minimum: 4.5:1 contrast ratio for normal text, 3:1
for large text (roughly 18pt+/14pt+bold) and for meaningful UI
component boundaries/icons. Check actual rendered colors against these
ratios (many design tools and browser devtools do this automatically)
rather than eyeballing it — insufficient contrast is one of the most
common and most consequential accessibility failures because it
affects any low-vision user regardless of assistive technology.

## Focus management on route change and modal open

When a route changes, move focus to a sensible landing point (usually
the new view's main heading) so keyboard/screen-reader users aren't
left focused on a now-invisible element. When a modal opens, trap
focus within it (Tab cycles only through the modal's own focusable
elements) and return focus to the triggering element when it closes.
Both are easy to miss because they're invisible to a mouse-only manual
test.

## Alt-text discipline

Every meaningful image needs alt text describing its content or
purpose in context — not its filename, and not a generic "image".
Purely decorative images should have an empty `alt=""` (not a missing
attribute) so screen readers skip them instead of announcing an
unhelpful filename.

## When to reach for a full compliance audit

This file is a fast baseline pass, not an exhaustive guideline
compliance check. For a pre-ship audit against the full interface
guidelines, check `external-skills-map.md` — `web-design-guidelines`
(when available) is the specialized skill for that depth.
