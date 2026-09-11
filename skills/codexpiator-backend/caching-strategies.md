# Caching Strategies

## Cache-aside vs write-through vs write-behind

**Cache-aside** (application checks cache, falls back to the source on
a miss, then populates the cache): simplest, most common, cache stays
optional — if it's down, reads just get slower, not wrong. **Write-
through** (every write goes to the cache and the source together):
keeps cache always fresh at the cost of every write paying the cache's
latency. **Write-behind** (write to cache immediately, persist to the
source asynchronously): fastest writes, but risks data loss if the
cache fails before the async persist completes. Default to cache-aside
unless you have a specific reason (write-heavy workload needing low
write latency) to accept write-through/write-behind's trade-offs.

## Invalidation is the hard part

"There are only two hard things in computer science: cache
invalidation and naming things." When it's unclear whether a change
correctly invalidates every cache entry it should, prefer a short TTL
(time-to-live) over trying to manually invalidate every affected key —
a short TTL bounds the staleness window predictably, while manual
invalidation that misses a case can serve stale data indefinitely with
no visible symptom until it causes a real bug.

## What belongs in cache

Good candidates: expensive to compute or fetch, read far more often
than written, and tolerant of being slightly stale for the TTL window
(a product listing, a computed aggregate, a rendered page fragment).
Poor candidates: anything requiring strong read-your-own-write
consistency (a user's own just-submitted data that they expect to see
reflected immediately), or data that changes on every read anyway
(caching it adds cost with no benefit).

## HTTP caching before a cache server

For anything served over HTTP, `Cache-Control` and `ETag`/
`If-None-Match` headers let browsers and CDNs cache responses without
you running any caching infrastructure at all. Reach for these first
for public, cacheable GET responses (static assets, public API
responses that don't vary per user) before introducing a dedicated
cache server (Redis/Memcached) for a problem HTTP caching would
already solve.
