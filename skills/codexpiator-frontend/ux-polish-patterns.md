# UX Polish Patterns

Small interaction and typography details that separate a polished UI
from a merely working one. Each pattern below is tagged:

- **DEFAULT** — apply without being asked whenever the surface exists.
  Cheap, low-risk, almost never wrong.
- **PROPOSE** — suggest (one line, via `AskUserQuestion` when several
  apply) when the situation fits; implement when the user agrees or
  asks. Don't add silently: these change behavior or add dependencies.
- **ONLY IF** — a narrow context (games, playful UI). Never in
  productivity or form-heavy UI.

When building or reviewing UI, scan this list against the screen and
say which patterns you applied and which you deliberately skipped.
Always respect `prefers-reduced-motion` for anything animated (see
`accessibility.md`). Always verify visually (see `SKILL.md`).

## Loading and perceived speed

### Skeleton loaders — DEFAULT
Any content that loads asynchronously and takes more than ~300ms gets a
skeleton that matches the final layout's dimensions (no layout shift),
not a centered spinner. Spinners only for short, unpredictable actions
(button submit). Skip the skeleton for loads that finish in under
~150ms: flashing it is worse than showing nothing. Announce loading
state to assistive tech (`aria-busy`).

### Stale-while-revalidate — DEFAULT for fetched data
Show cached data immediately, refetch in the background, swap quietly.
Use the data layer's built-in (TanStack Query, SWR, RTK Query) instead of
hand-rolled `useEffect` fetching, and tune `staleTime` per data type.
Also use the HTTP form (`Cache-Control: ..., stale-while-revalidate=N`)
for cacheable GET responses and static assets (see
`codexpiator-backend/caching-strategies.md`). Never for data where stale
is harmful (balances, stock at checkout, permissions).

### Pre-rendering — PROPOSE
Pre-render what can be known ahead: static generation / ISR for public
and marketing pages, and Speculation Rules (`<script
type="speculationrules">` with `prerender`/`prefetch`) or framework link
prefetch for likely next navigations. Not for pages with side effects on
load, per-user private data, or analytics that would count a page the
user never visited. Speculation Rules are Chromium-only: treat as
progressive enhancement.

### Blurhash placeholders — PROPOSE for image-heavy UI
For galleries, feeds, avatars and hero images from user or CMS content,
store a tiny blurhash/thumbhash (computed at upload time) and render it
until the real image loads, with explicit `width`/`height` or
`aspect-ratio`. Not worth it for a few static local images; use a solid
dominant color or `next/image` blur there.

## Responsiveness of actions

### Optimistic updates — PROPOSE
For low-failure, easily reversible mutations (like, toggle, reorder,
rename, check off), update the UI immediately, send the request, and
roll back plus tell the user on failure. Use the data layer's mechanism
(`onMutate`/rollback in TanStack Query, `useOptimistic` in React 19).
Never for payments, irreversible actions, or anything where the server
decides the result (validation, pricing, permissions). Pair with
idempotency keys on the backend
(`codexpiator-backend/api-design.md`).

### Undo toasts — DEFAULT for reversible destructive actions
For delete/archive/remove where undo is feasible (soft delete, deferred
commit), act immediately and show a toast with an Undo button for
~5-10s instead of a "Are you sure?" confirm dialog. The toast must be
keyboard reachable, announced (`role="status"`), pause its timer on
hover/focus, and not vanish while the user is on it. Keep confirm
dialogs only for truly irreversible actions.

### Command menu — PROPOSE
For apps with many actions, pages or entities (dashboards, editors,
admin tools), propose a `Cmd/Ctrl+K` command menu (cmdk or the design
system's own) with fuzzy search, grouped actions and recent items. Not
for a simple marketing site or an app with under ~10 actions.

### Shortcut hints — DEFAULT wherever shortcuts exist
If an action has a keyboard shortcut, show it: in menu items, command
menu rows and tooltips, rendered as `<kbd>` and platform-aware
(⌘ on macOS, Ctrl elsewhere). Don't show on touch-only devices. Shortcuts
must not collide with browser/OS/screen-reader keys, must be
discoverable (a `?` cheat sheet for larger apps) and, if single-key,
disabled while typing in inputs.

## Motion and navigation

### Interruptible animations — DEFAULT
Every UI animation must be safe to interrupt and reverse mid-flight
(open then close quickly, hover in/out, drag released early). Prefer CSS
transitions or springs, which retarget from the current value, over
fixed keyframe sequences, which restart or jump. Use the animation
library's interruptible primitives (Motion springs, Web Animations API
`reverse()`) for gestures and sheets. Keep UI durations short
(~150-250ms), animate `transform`/`opacity`, never block input during
an animation.

### View transitions — PROPOSE
For navigation between views, list-to-detail, shared-element moves and
reorders, propose the View Transitions API (`document.startViewTransition`
for same-document; `@view-transition { navigation: auto }` for
multi-page) or the framework's integration. Feature-detect, fall back
to an instant change, disable under `prefers-reduced-motion`, and keep
`view-transition-name`s unique per page.

### Swipe-to-dismiss sheets — PROPOSE on mobile
Bottom sheets, drawers and modals on touch layouts should dismiss by
dragging down (with velocity and distance thresholds, rubber-banding
past limits, snap points when useful), in addition to a visible close
button and Escape key. Use a proven primitive (vaul, the design system's
drawer) instead of hand-rolling gestures. Keep scroll inside the sheet
from fighting the drag. Not for desktop-only UI.

### Predictive back — DEFAULT for navigable mobile UI
Back must behave as users expect, including Android's predictive back
gesture, which previews the destination before commit. On the web: open
overlays/sheets/steps as real history entries (push on open, close on
`popstate`), never trap back, never hijack `beforeunload` for routine
flows, and keep route transitions reversible so a partially-completed
back swipe looks right. In native/Capacitor Android shells, opt in with
`android:enableOnBackInvokedCallback="true"` and handle back through the
platform callback API.

### Amazon safe triangles — DEFAULT for hover flyouts
Any hover-opened submenu, mega menu or nested dropdown must tolerate the
cursor travelling diagonally from the trigger to the flyout without
closing it when it crosses neighbouring items. Implement a safe triangle
(or a short hover-intent delay, ~100-200ms, as a minimum) via the
primitive library when it provides one (Radix, Base UI) or a small
pointer-tracking guard. Touch and keyboard still open the menu by
tap/Enter (see `responsive-and-mobile.md`).

### Hit stop — ONLY IF game-like
A 50-120ms freeze/slow of an impact moment (a hit landing, a combo, a
big reward) that makes feedback feel heavy. Use in games, gamified or
deliberately playful UI. Never in productivity, finance, forms or
anything a user performs repeatedly. Respect `prefers-reduced-motion`.

## Typography and surface details

### Tabular numbers — DEFAULT
Numbers that change, align or are compared (prices, tables, counters,
timers, stats, dashboards, tick-by-tick values) use
`font-variant-numeric: tabular-nums` (Tailwind `tabular-nums`) so digits
don't jitter and columns line up. Confirm the chosen font actually has
tabular figures. Leave proportional numerals for running prose.

### Balanced headlines — DEFAULT
Headings, short titles, card titles and pull quotes use
`text-wrap: balance` to avoid orphans and lopsided last lines; long
body paragraphs may use `text-wrap: pretty`. It's progressive
enhancement (ignored where unsupported) and only applies to short blocks
(browsers cap the line count), so don't use it as a body default.

### Continuous corners — PROPOSE
Where the design uses large radii (cards, sheets, app-icon-like tiles,
buttons on premium or mobile-style UI), prefer continuous (squircle)
corners over circular arcs: `corner-shape: squircle` (or `superellipse()`)
where supported, with plain `border-radius` as the fallback, since
support is still partial. Nested elements: inner radius = outer radius
minus padding. Not worth it for small radii (<8px) or sharp/brutalist
styles.

## Mobile and input

### Safe area insets — DEFAULT
Fixed and edge-pinned UI (bottom tab bars, sticky CTAs, sheets, toasts,
full-bleed layouts) pads with `env(safe-area-inset-*)`, and the page
sets `viewport-fit=cover` so the insets are non-zero. Verify on a
notched-device emulation. See `responsive-and-mobile.md`.

### One-time-code autofill — DEFAULT for OTP/2FA/SMS fields
Verification-code inputs use `autocomplete="one-time-code"`,
`inputmode="numeric"` and `pattern="[0-9]*"`, a single field (or a
multi-box UI that still accepts a full paste/autofill into the first
box), no `maxlength` that blocks pasted formatting, auto-submit on
completion, and a resend control with a visible cooldown. For WebOTP, add
the origin-bound SMS format on the server side. See
`forms-and-validation.md`.

## Cross-cutting rules

- Patterns are tools, not decoration: skip a PROPOSE pattern when it
  doesn't fit and say why in one line.
- Every animated or gestural pattern needs a non-animated, keyboard and
  screen-reader path, and reduced-motion handling.
- Each applied pattern needs a test or a Playwright check of its edge
  case (undo after timeout, rollback on failed optimistic update,
  interrupted transition, safe-area padding present).
