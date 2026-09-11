# API Design

## Resource-oriented naming

Use plural nouns for collections (`/users`, not `/user` or `/getUsers`)
and nest only as deep as the relationship actually requires
(`/users/{id}/orders`, not `/users/{id}/orders/{orderId}/items/{itemId}/details/{x}`
— beyond two or three levels, prefer a flatter resource with a filter
query, e.g. `/order-items?orderId=...`). The URL should describe *what
resource* you're operating on; the HTTP method should describe *what
operation* — don't encode verbs into the path (`/createUser`) when a
`POST /users` says the same thing more consistently.

## Status-code discipline

Use status codes to mean what they mean: `200`/`201`/`204` for
success (create returns `201`, a body-less success returns `204`),
`400`-range for client errors (`400` malformed request, `401`
unauthenticated, `403` unauthorized, `404` not found, `409` conflict,
`422` semantically invalid), `500`-range only for genuine server
failures. Returning `200` with an error payload inside the body
defeats every generic HTTP-aware tool (caching, monitoring, client
error handling) that relies on the status code to know what happened.

## Versioning strategy

URL-path versioning (`/v1/users`) is simpler for API consumers to
understand and debug (the version is visible in every request/log
line/browser address bar) than header-based versioning, at the cost of
needing to duplicate routes across versions. Recommend URL-path
versioning as the default for anything with external or semi-external
consumers; for a purely internal API deployed and consumed as one
unit, versioning may not be needed at all until you actually have two
consumers that need different contract shapes simultaneously.

## Pagination: cursor over offset for anything that can grow

Offset-based pagination (`?page=3&pageSize=20`) is simple but breaks
under concurrent writes (items shift between pages, causing skipped or
duplicated results) and gets slower as the offset grows on most
databases. Cursor-based pagination (`?after=<opaque-cursor>`) stays
correct under concurrent writes and stays fast regardless of how deep
you paginate. Use offset pagination only for small, rarely-changing
datasets where its simplicity outweighs these downsides.

## Idempotency for unsafe methods

For any `POST` that creates something and might reasonably be retried
by a client (network failure ambiguity, a double-click, an
at-least-once queue redelivering a webhook), accept an
idempotency key from the client and store which keys have already been
processed, so a retried request with the same key returns the original
result instead of creating a duplicate. This matters most for
anything with a real-world side effect (payments, order creation).

## Compress responses, don't ship raw JSON

Enable response compression (gzip/brotli, typically one line of
middleware) for any non-trivial JSON payload. Uncompressed JSON over
the wire wastes bandwidth and latency for free — there's essentially
no downside to compressing text responses, and most frameworks and
reverse proxies support it as a toggle rather than custom work.

## Modular, configurable API surface

Structure endpoints as small, focused modules (one resource or
capability per module/router) wired together at a top level, rather
than one large file handling every route — this is the API-design
equivalent of `codexpiator-frontend/component-architecture.md`'s
single-responsibility rule. Keep environment-specific and
deployment-specific behavior (base paths, feature toggles, rate
limits, third-party endpoints) driven by configuration/environment
variables rather than hardcoded, so the same codebase runs correctly
across dev/staging/prod without code changes (see
`codexpiator-devops/environments-and-config.md`).

## GraphQL/RPC vs REST

GraphQL or RPC-style APIs earn their complexity when clients need to
aggregate data from many resources in one round trip (avoiding
REST's over-fetching/under-fetching for complex UIs) or for
strongly-typed internal service-to-service calls where a shared schema
is a real asset. For simple CRUD, public APIs, or anything where broad
client/tooling familiarity matters more than fetch efficiency, REST's
simplicity and ubiquity usually wins — don't reach for GraphQL as a
default without a concrete aggregation or typing problem it solves.
