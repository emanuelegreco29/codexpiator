# Design Patterns Catalog

Practical, not academic — each pattern here earns its place by solving
a specific problem. Reach for one because you have that problem, not
because applying a recognizable pattern feels like good practice on
its own (YAGNI applies to patterns as much as to features).

## Dependency injection

Pass a dependency (a database client, an external service client) into
a component/function rather than having it construct or import that
dependency directly. This makes the component testable in isolation
(inject a fake/mock in tests) and makes swapping an implementation
(a different email provider, a different data store) a
configuration change rather than a code change throughout the
codebase.

## Repository pattern

Wrap data-access logic (queries, persistence) behind an interface that
the rest of the application depends on, rather than having business
logic call the database/ORM directly everywhere it needs data. This
decouples domain logic from the specific persistence mechanism —
useful when the persistence layer might change, or simply to keep
business logic testable without a real database.

## Strategy pattern

When a piece of behavior needs to vary (different pricing rules,
different notification channels, different sorting algorithms) and
the specific variant is chosen at runtime, encapsulate each variant
behind a common interface and select between them, rather than a
sprawling conditional (`if type == 'a' ... elif type == 'b' ...`)
scattered through the codebase every time that behavior is invoked.

## Observer / event-driven pattern

When one action should trigger reactions in other, unrelated parts of
the system (a user signs up → send a welcome email, provision a
default workspace, log an analytics event), publish an event and let
interested parts subscribe, rather than the original action's code
directly calling every downstream concern. This decouples the trigger
from its reactions — new reactions can be added without modifying the
original code path.

## The overriding caution

Every pattern above adds a layer of indirection. That indirection pays
for itself when it solves a real, present problem (testability,
genuine runtime variability, genuine decoupling need) — it costs
readability and adds unnecessary ceremony when applied preemptively to
a problem that doesn't exist yet. A simple, direct function call is
often better than a strategy pattern with exactly one strategy
implemented "for future extensibility."
