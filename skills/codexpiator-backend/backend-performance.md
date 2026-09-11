# Backend Performance

## Measure before optimizing

Profile to find the actual bottleneck before changing anything for
performance reasons — intuition about what's slow is frequently wrong,
and optimizing the wrong part wastes effort while leaving the real
problem untouched. Use real profiling tools/query analyzers, and
measure with production-representative data volume where possible
(a query that's fast against 100 rows can be catastrophically slow
against 10 million).

## The database is usually the bottleneck first

Before optimizing application code, check the database: missing
indexes, N+1 queries (see `data-modeling-and-db.md`), unnecessarily
large result sets fetched and filtered in application code instead of
in the query. Application-level CPU optimization matters far less for
most typical backend workloads than the shape of the queries hitting
the database.

## Connection pooling

Reuse a pool of database connections across requests instead of
opening a new connection per request — connection setup (especially
over TLS) has real latency and resource cost, and most databases have
a hard limit on concurrent connections that an unpooled service can
exhaust under load.

## Don't block the event loop / thread unnecessarily

In a single-threaded/event-loop runtime, a synchronous CPU-heavy or
blocking-I/O call on the main path stalls every other concurrent
request being handled by that process, not just the one that issued
it. Move genuinely heavy CPU work to a background job or a worker
process/thread, and use the runtime's async I/O primitives for network
and disk calls rather than synchronous equivalents.

## Horizontal vs vertical scaling

Prefer horizontal scaling (more instances of a stateless service
behind a load balancer) over vertical scaling (a bigger single
machine) as the default: it has a higher ceiling, no single point of
hardware failure, and matches how most modern infrastructure bills and
scales. This requires the service to actually be stateless (no
in-memory session/data that only one instance has) — if it isn't yet,
that's a prerequisite to fix before horizontal scaling works correctly.
