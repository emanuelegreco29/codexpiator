# Data Modeling & Databases

## Normalize by default, denormalize for a measured hot path

Start with a normalized schema (each fact stored once, related via
foreign keys) — it keeps data consistent by construction and avoids
update anomalies. Denormalize (duplicate data to avoid a join) only
once you've measured a specific read path that's actually slow because
of the join, and accept the trade-off explicitly: denormalized data
needs an explicit strategy for staying in sync with its source of
truth (or it silently drifts).

## Indexing basics

Index the columns you actually filter, sort, or join on — not every
column "just in case." Every index speeds up reads on that column but
slows down writes (the index must be updated on every insert/update)
and takes storage, so an unused index is pure cost. When a query is
slow, check its execution plan to confirm whether it's actually using
an index before adding one blind.

## The N+1 query anti-pattern

Fetching a list, then fetching each item's related data in a separate
query inside a loop (N+1 queries for N items) is the most common
backend performance bug: it looks correct and works fine in
development with 5 rows, then falls over under real data volume.
Spot it by counting queries per request in a slow endpoint; fix it by
fetching the related data in one batched query (a join, or a single
`WHERE id IN (...)` query) instead of one query per item.

## Atomic, logical write methods

Any operation that must update more than one row/table to stay
consistent (transferring a value between two accounts, creating an
order plus its line items) belongs inside a single database
transaction — never as separate, independent writes that could
succeed partially and leave the data in a state that never should have
existed. Watch for the "illogical write" version of this bug: writing
a parent record, then a child record, in two unrelated calls with no
transaction and no compensating cleanup if the second fails. If your
data access layer makes it easy to forget the transaction, wrap the
common multi-write patterns in a helper that takes the transaction
boundary for granted.

## Migration discipline

Every schema change is a versioned, reversible migration file checked
into source control — never a manual `ALTER TABLE` run directly
against production. This gives you: a reproducible way to build any
environment from scratch, a record of how the schema evolved, and a
rollback path if a migration causes a problem. Treat "I'll just fix it
directly in prod this once" as never acceptable, even for a tiny
change — it's exactly the kind of untracked change that causes
environments to drift out of sync with each other.

## Choosing SQL vs NoSQL

Relational (SQL) is the right default for data with real relationships
between entities and where consistency guarantees matter (most
business applications: users, orders, inventory) — the relational
model and transactional guarantees are built for exactly that shape.
Document/NoSQL stores earn their place for schema-flexible data that
doesn't fit a fixed relational shape well, very high write throughput
with denormalized-by-design access patterns, or when the access
pattern is genuinely simple key-value lookups at large scale. Don't
choose NoSQL by default for "it might scale better" without a concrete
access-pattern reason — a well-indexed relational database handles far
more scale than most projects ever reach.
