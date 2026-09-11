# Scalability & Trade-offs

## Premature scaling is a real anti-pattern

Most projects never reach the scale that justifies the complexity of
aggressive early scaling work (sharding, complex caching layers,
microservices split purely for scale). Building for a scale you don't
have yet costs real complexity and velocity today for a benefit that
may never materialize. Optimize for being able to scale later
(reasonably clean structure, statelessness where cheap to achieve) —
not for having already scaled.

## Signals that mean it's actually time

Scale based on measured evidence, not guesses: real load approaching
observed limits (response times degrading under current traffic,
resource utilization consistently high), a specific bottleneck
identified through profiling, or a concrete near-term growth
projection with a real basis. "We might get big" is not a signal;
"this endpoint's p99 latency has doubled over the last month under
growing load" is.

## Statelessness first

Horizontal scaling (more instances) only works cleanly if a service is
stateless — no in-memory data (session state, in-process cache) that
only one instance has. Moving state out of the application process
(into a shared cache, a database, a distributed session store) is
usually a prerequisite step before horizontal scaling can work
correctly, not something that happens automatically by adding more
instances.

## The database is usually the first real bottleneck

Application servers scale horizontally fairly easily once stateless;
the database usually becomes the harder constraint first. The typical
order of increasing complexity: better indexing and query
optimization, then caching (see
`codexpiator-backend/caching-strategies.md`), then read replicas
(scale reads independently of writes), then sharding (partition data
across multiple database instances) only once replicas and caching
are no longer enough. Reach for the next level of complexity only
after the current one is genuinely exhausted, not preemptively.

## CAP theorem, in practice

Under a network partition, a distributed system must choose between
consistency (every read sees the latest write) and availability
(every request gets a response, possibly stale). Neither choice is
universally correct — a banking balance update leans toward
consistency (better to fail than show a wrong balance); a social media
feed leans toward availability (better to show a slightly stale feed
than none at all). Make this trade-off deliberately per use case
rather than assuming one default is always right.
