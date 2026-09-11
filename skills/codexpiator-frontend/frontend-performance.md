# Frontend Performance

## Bundle-size budget mindset

Treat JavaScript bundle size as a budget, not an afterthought checked
once at the end: know roughly what your initial-load bundle costs
today, and treat a large new dependency as a decision with a real
cost, not a free `npm install`. Every kilobyte of JS has to be
downloaded, parsed, and executed before the page is interactive — on
a slow connection or a low-end device this is felt directly as
sluggishness.

## Code-splitting and lazy-loading

Split code by route by default (see
`routing-and-navigation.md`) and additionally lazy-load anything
heavy that isn't needed for the initial view: a rich text editor
behind a "edit" button, a chart library used only after data loads, a
modal's contents. The goal is that the code shipped for the first
paint is only what the first paint actually needs.

## Image optimization

Serve images in a modern format (WebP/AVIF where supported, with a
fallback), sized appropriately for their actual display size (don't
ship a 4000px-wide image into a 400px container), and lazy-load
images below the fold (`loading="lazy"` or framework equivalent) so
they don't compete with above-the-fold content for bandwidth on
initial load.

## Avoiding layout shift

Reserve space for content that loads asynchronously (images, ads,
embeds, late-arriving data) by setting explicit dimensions or aspect
ratios up front, so the layout doesn't jump once the content arrives.
Unexpected layout shift is both a measurable performance metric
(Cumulative Layout Shift) and a directly-felt UX problem (a user about
to tap something has it move away from under their finger).

## Memoization as a targeted fix

Memoization (caching a computed value or preventing a re-render) is a
tool for a *measured* performance problem, not a default habit applied
to every component or calculation. Reaching for it everywhere adds
complexity (memoization has its own cost and its own correctness
pitfalls — stale closures, incorrect dependency lists) without a
guaranteed benefit. Profile first, then memoize the specific hot spot
the profile actually identifies.

## Motion and perceived performance

Gratuitous or slow animation makes an interface feel slower even when
the underlying work is fast — every animation adds a minimum time the
user has to wait before an action feels "done." Keep transition
durations short (roughly 100-300ms for most UI feedback) and prefer
animating cheap properties (`transform`, `opacity`) over properties
that trigger layout recalculation. If the concern is motion *quality*
and *design* rather than raw performance cost, check
`external-skills-map.md` — `design-motion-principles` (when available)
is the specialized skill for that.
