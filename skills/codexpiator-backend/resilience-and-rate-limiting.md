# Resilience & Rate Limiting

## Timeouts on every external call

Every network call to another service, database, or external API
needs an explicit timeout — never an unbounded wait. Without one, a
single slow or hanging downstream dependency can exhaust your own
service's threads/connections/resources while every request queues up
waiting for it, turning one dependency's slowness into your own
service's total outage.

## Retries with backoff and jitter

Retry transient failures (timeouts, connection resets) with
exponential backoff plus a small random jitter — jitter prevents many
clients from retrying in synchronized bursts that re-overwhelm the
struggling dependency right as it starts recovering. Don't retry
errors that indicate the request itself is wrong (4xx client errors)
— retrying those just repeats the same failure.

## Circuit breakers

Once a downstream dependency has failed enough times in a row, stop
calling it for a cool-down period (open the circuit) and fail fast
instead — this protects your own service's resources and gives the
struggling dependency room to recover instead of being hammered by
continued retries from every caller. Reset (close the circuit) after
the cool-down, typically via a small number of trial requests.

## Rate limiting: protect yourself and respect others

Apply rate limits to your own public-facing endpoints to protect
against abusive or accidentally-runaway traffic (see
`codexpiator-security`'s treatment of rate limiting for the
brute-force/abuse angle specifically — this file is about general
service reliability, that one is about attack surface). Separately,
respect the rate limits of any third-party API you call — track your
own usage against their documented limits and back off before you're
throttled, rather than discovering the limit by hitting it in
production.

## No single dependency as an unmitigated bottleneck

Identify anything every request path routes through unconditionally
(one database, one third-party API, one internal service) — that's a
single point of failure by definition. You don't have to eliminate
every one of these (some are unavoidable, like "the" database), but
each one deserves a deliberate decision: a timeout and circuit breaker
at minimum, a fallback/degraded mode where feasible (serve cached or
partial data instead of failing outright), and monitoring that alerts
before it becomes a full outage. The failure mode to avoid is an
undocumented, unexamined bottleneck that nobody realized was a single
point of failure until it took the whole system down.

## Graceful degradation

Prefer serving partial or slightly-stale functionality over a total
failure when a non-critical dependency is down (e.g. show the page
without the "recommended items" section if the recommendation service
is unreachable, rather than failing the whole page load). Reserve hard
failures for cases where partial service would actually be incorrect
or unsafe (e.g. never partially process a payment).
