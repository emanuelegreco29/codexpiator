# Stack Recommendations Policy

Codexpiator's content is stack-agnostic by default. Every topic file
states the universal principle first — the thing that's true
regardless of language or framework — and only then adds a stack
call-out where one of the common stacks below has a specific idiom
worth naming. Never the reverse: a stack-specific recommendation never
stands alone without the principle it serves.

Use this file as the shared cheat-sheet topic files link back to,
instead of repeating stack idioms in every file that touches them.

## React / Next.js (frontend)

- Server Components / server-rendered data fetching by default;
  reach for client-side fetching only for genuinely interactive,
  post-load data.
- Colocate a component's styles, tests, and types with the component
  itself rather than splitting by technical layer.
- Prefer built-in framework routing/data-loading conventions over a
  hand-rolled router once the framework provides one.
- Memoization (`useMemo`/`useCallback`/`memo`) is a targeted fix for a
  measured re-render problem, not a default habit on every component.
- Server state (data from an API) belongs in a request-cache layer
  (framework-provided or a dedicated library), not in the same store
  as local UI state.

## Vue / Nuxt (frontend)

- Composition API for anything with non-trivial logic reuse; Options
  API is fine for small, self-contained components.
- Composables are the equivalent of React hooks for shared stateful
  logic — extract to one when two components need the same behavior.
- Nuxt's file-based routing and auto-imports remove the need for most
  manual wiring; don't hand-roll what the framework already provides.
- Reactivity is automatic for reactive/ref-wrapped state — avoid
  destructuring a reactive object in a way that breaks that tracking.

## Node.js / Express (backend)

- Keep route handlers thin; push business logic into plain functions/
  modules that don't know about `req`/`res`, so they're testable
  without an HTTP layer.
- Centralize error handling in one error-handling middleware rather
  than try/catching identically in every route.
- Use a connection pool for the database driver; never open a new
  connection per request.
- Async/await over callback chains; an unhandled promise rejection
  should crash loudly in development, never fail silently.

## Python / FastAPI (backend)

- Pydantic models for request/response schemas double as validation
  and documentation — define the schema once, don't hand-validate
  fields separately.
- Dependency injection (`Depends`) for anything a route needs but
  shouldn't construct itself (DB sessions, current user, config).
- Async route handlers only when the work inside is actually
  async-compatible (async DB driver, async HTTP calls); mixing
  blocking calls into an async handler stalls the event loop.
- Background tasks (`BackgroundTasks`) for fire-and-forget work that's
  too small to justify a full job queue.

## Go (backend)

- Explicit error returns over exceptions — check every error at the
  call site; never discard one with `_` unless it's genuinely
  impossible to fail.
- Small interfaces defined by the consumer, not the producer ("accept
  interfaces, return structs").
- `context.Context` threaded through any call chain that might need
  cancellation or a deadline (most I/O-bound chains do).
- Goroutines need an explicit lifecycle owner — never start one
  without knowing what stops it and what happens to its errors.
