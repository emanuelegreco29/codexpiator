---
name: codexpiator-backend
description: Backend engineering guidance - API design, data modeling and databases, authentication and authorization, error handling and logging, caching, background jobs and queues, resilience and rate limiting, backend performance, and backend testing. Use for any server-side/API/data-layer question.
---

# Codexpiator Backend

Single-purpose reference files for backend engineering decisions.
Read the specific file below for the concern at hand.

| File | Read this when... |
|---|---|
| `api-design.md` | Designing endpoints, naming, versioning, pagination |
| `data-modeling-and-db.md` | Schema design, indexing, migrations, SQL vs NoSQL |
| `auth-and-authorization.md` | Authentication mechanism, session/token trade-offs, password storage |
| `error-handling-and-logging.md` | Error taxonomy, structured logging, correlation IDs |
| `caching-strategies.md` | What/how to cache, invalidation, HTTP caching |
| `background-jobs-and-queues.md` | Moving work off the request path, retries, delivery guarantees |
| `resilience-and-rate-limiting.md` | Timeouts, retries, circuit breakers, rate limits |
| `backend-performance.md` | Profiling, DB bottlenecks, scaling direction |
| `backend-testing.md` | Unit vs integration tests, test data for the backend |

For deeper security hardening beyond the how-to in
`auth-and-authorization.md`, see `codexpiator-security` — that skill
covers the threat model, this one covers the implementation approach.

## Mandatory pre-completion gate for any backend change

Before considering backend work done:
1. For a Python project, confirm dependencies are managed via `uv`,
   `pdm`, or `poetry` and the code passes Ruff (see
   `shared/stack-recommendations.md`).
2. **Write and run real tests covering every function/endpoint
   touched, including edge cases** (empty input, boundary values,
   invalid/malformed input, concurrent-write scenarios where
   relevant) — not just the happy path. Run the full test suite, not
   just the new tests in isolation. See `backend-testing.md` and
   `codexpiator-testing-qa/tdd-workflow.md`.
3. For anything security-sensitive (auth, input handling, data
   access), also run the relevant checks from `codexpiator-security` —
   security behavior needs to be tested as thoroughly as functional
   behavior, not assumed correct because it looks right.
