# Routing & Navigation

## File-based vs config-based routing

File-based routing (a file's location in a folder tree determines its
route) removes a whole category of manual wiring and keeps route
structure visible in the filesystem, which most modern frameworks
default to for good reason. Config-based routing (an explicit route
table) gives more control for unusual cases (dynamic route generation
from data, highly conditional route sets) at the cost of that manual
wiring. Default to whichever your framework provides natively; don't
hand-roll a config-based router on top of a framework that already
gives you file-based routing.

## Route-level code-splitting by default

Load each route's code on demand rather than bundling the entire
app's routes into one initial payload. Beyond a trivial app, this is
the single highest-leverage frontend performance change available for
free — a user visiting one route shouldn't download the code for
every other route first. Most modern frameworks and bundlers do this
automatically for file-based routes; verify it's actually happening
(check the network tab / build output for per-route chunks) rather
than assuming it.

## Auth-gated routes

Guard access at the route level with a single, consistent mechanism
(a layout/wrapper that checks auth state and redirects) rather than
scattering ad-hoc auth checks inside individual page components — a
missed check in one page is a security gap, and a shared guard makes
that gap structurally hard to introduce. Remember this is a UX
convenience, not the actual authorization boundary: the API/backend
must independently enforce access control regardless of what the
frontend route guard does (see `codexpiator-backend/auth-and-authorization.md`).

## Preserving scroll and focus on navigation

By default, decide deliberately whether a navigation should reset
scroll position (typical for moving to a genuinely new page) or
preserve it (typical for pagination within the same logical view,
back/forward navigation). Also move focus to a sensible target after
a route change (usually the new page's main heading) for keyboard and
screen-reader users — a navigation that silently leaves focus on a
now-gone link is a common, easily-missed accessibility gap.

## Breadcrumbs and back-button correctness

If you show a breadcrumb trail, keep it in sync with the actual
navigation hierarchy — a breadcrumb that doesn't match where the
browser back button actually goes confuses users more than having no
breadcrumb at all. Test back/forward browser navigation explicitly,
not just forward clicks through your own links; it's the most
commonly-skipped manual test on any routed app.
