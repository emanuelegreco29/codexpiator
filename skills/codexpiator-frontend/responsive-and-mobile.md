# Responsive & Mobile

## Mobile-first breakpoints

Design and implement for the smallest supported viewport first, then
add breakpoints upward for more space (see `styling-and-css.md` for
why this produces simpler CSS). Pick breakpoints from real content
needs (where your specific layout actually breaks) rather than
copying a generic device-width list — a breakpoint chosen because
"that's where this content wraps badly" is more durable than one
chosen because it matches a specific phone's width.

## Touch target sizing

Interactive elements (buttons, links, form controls) need a minimum
touch target of roughly 44x44px (iOS Human Interface Guidelines) or
48x48px (Material Design) — smaller targets cause mis-taps,
disproportionately affecting users with larger fingers or motor
impairments. Visual size and touch target size can differ (padding
can extend the tappable area beyond a visually smaller icon), but the
tappable area itself must meet the minimum.

## Safe-area and notch handling

On mobile web, account for device safe areas (notches, home
indicators, rounded corners) using the platform's safe-area insets
(e.g. `env(safe-area-inset-*)` in CSS) for any fixed-position UI
(bottom navigation, floating action buttons) so it isn't obscured or
placed unreachably close to a device edge.

## Avoiding hover-only interactions

Hover has no equivalent on touch devices — any interaction that's
*only* reachable via hover (a tooltip that only appears on hover, a
menu that only opens on hover) is unusable on mobile. Provide a
tap/click-triggered equivalent for anything hover reveals, and treat
hover effects as a progressive enhancement on top of that, not the
only way in.

## Testing at real breakpoints

Resizing a desktop browser window approximates layout but misses real
mobile behavior: actual touch event handling, real viewport units
behaving differently with mobile browser chrome, and real network
conditions. Test on an actual device or a device emulator with correct
viewport/user-agent emulation before considering mobile support done,
not just a resized desktop window.

## Viewport meta tag

Confirm the page has `<meta name="viewport" content="width=device-width, initial-scale=1">` (or the framework's equivalent). Its absence is a common, easy-to-miss cause of a mobile page rendering zoomed-out and effectively non-responsive regardless of how correct the CSS is.
