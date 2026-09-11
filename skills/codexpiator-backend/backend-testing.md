# Backend Testing

## Non-negotiable baseline

Every function, endpoint, or module created or changed gets its own
tests — written, actually run, and passing — before the work is
considered done. This isn't limited to the happy path: cover edge
cases explicitly (empty/missing input, boundary values, invalid or
malformed input, concurrent/duplicate requests, permission-boundary
cases like one user trying to access another's resource). Run the
*full* test suite before concluding, not just the new test file in
isolation — a change can pass its own new tests while silently
breaking something else. See `codexpiator-testing-qa/tdd-workflow.md`
for the write-test-first discipline this should follow.

## Unit tests for business logic in isolation

Test pure business logic (calculations, validation rules, state
transitions) with the database and network mocked out or entirely
absent — these tests should be fast (milliseconds, not seconds) and
numerous, since they're cheap to write and run and pinpoint failures
precisely.

## Integration tests against something real

For anything whose correctness depends on actual database behavior
(a query's real result set, a constraint firing, a transaction's
isolation behavior), test against a real or realistic database — a
containerized instance of the actual database engine, not a mock.
Mocking the database for this class of test risks the mock quietly
drifting from real behavior, so the tests keep passing while the real
query is actually broken.

## Contract tests for service boundaries

Where one service calls another (internal microservice, third-party
API), a contract test verifies the caller and callee agree on the
request/response shape — catching a breaking change on either side
before it reaches production, independent of full end-to-end testing.

## Test data setup and teardown

Each test should set up its own data and clean up after itself,
independent of other tests' data — no shared mutable fixtures that one
test's changes can leak into another's run. Prefer deterministic,
explicit test data (fixed values, fixed dates/seeds) over relying on
whatever happens to already be in a shared test database.

## Security behavior needs the same testing rigor

Security-relevant behavior (authorization checks, input sanitization,
rate limiting) is not "probably fine because it looks right" — write
explicit tests that attempt the bad case directly: try to access
another user's resource by ID and assert it's rejected (IDOR), submit
an injection-shaped payload and assert it's rejected/escaped, hit a
rate-limited endpoint past its limit and assert the limit engages. See
`codexpiator-security/security-testing.md` for the fuller checklist of
what to actively test, not just implement.
