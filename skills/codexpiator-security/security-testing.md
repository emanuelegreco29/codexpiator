# Security Testing

Knowing a security principle isn't the same as verifying it holds in
the actual code. Security-relevant behavior must be tested with the
same rigor as functional behavior — see the mandatory pre-completion
gates in `codexpiator-frontend/SKILL.md` and
`codexpiator-backend/SKILL.md`. This file is what to actually test,
per vulnerability class covered elsewhere in this skill.

## Write the test as an attack attempt, not a happy-path check

For each item below, the test should actively attempt the bad case and
assert it's rejected — not just assert the good case succeeds. A
passing "happy path" test suite gives no evidence these controls
actually work.

- **IDOR/BOLA**: as user A, attempt to read/update/delete a resource
  belonging to user B. Assert it's rejected (403/404), for every
  endpoint that takes a resource identifier.
- **Missing/broken authorization**: call a privileged endpoint as an
  unauthenticated or under-privileged user. Assert rejection.
- **SQL/NoSQL injection**: submit an injection-shaped payload
  (`' OR '1'='1`, an operator object like `{"$ne": null}` where a plain
  value is expected) as input. Assert it's rejected or safely
  neutralized, not interpreted as query logic.
- **XSS**: submit a payload containing markup/script
  (`<script>alert(1)</script>`) into any field that gets rendered back
  to a user. Assert it's escaped in the rendered output, not executed.
- **CSRF**: attempt the state-changing request without the expected
  CSRF token / from a disallowed origin. Assert rejection.
- **File upload**: attempt to upload a disallowed file type (including
  one with a spoofed extension/MIME type) and an oversized file. Assert
  both are rejected.
- **Path traversal**: request a file path containing `../` sequences
  aimed outside the intended directory. Assert it's rejected, not
  served.
- **SSRF**: attempt to make the server fetch an internal/private
  address or a cloud metadata endpoint via any feature that fetches a
  user-supplied URL. Assert it's rejected.
- **Mass assignment**: submit an unexpected privileged field (e.g.
  `role: "admin"`) in a request body to an endpoint that shouldn't
  accept it. Assert it's ignored, not applied.
- **Rate limiting**: send requests past the documented limit (login
  attempts, password reset requests, general API calls). Assert the
  limit actually engages.
- **Account enumeration**: compare the response for a valid vs.
  invalid email/username on login, signup, and password reset. Assert
  the responses are indistinguishable.
- **Session invalidation**: change a password, then assert a
  previously-issued session/token no longer works.
- **Webhook verification**: send a webhook payload with an invalid or
  missing signature. Assert it's rejected. Send a valid, previously-
  processed payload again. Assert it's not reprocessed (replay).
- **Race conditions**: fire concurrent requests against a
  check-then-act flow (redeeming a coupon, spending a balance) and
  assert only one succeeds where only one should be able to.
- **Open redirect**: attempt a redirect to an external, non-allowlisted
  domain via any redirect-accepting parameter. Assert rejection.

## Where this fits in the overall testing effort

These test cases are additive to normal functional test coverage, not
a replacement for it — a feature isn't done when it works correctly
for a legitimate user; it's done when it also fails correctly for an
illegitimate one. Run these alongside the full test suite (per the
mandatory pre-completion gates), and treat a missing security test for
any of the applicable classes above as a gap in the same way a missing
functional test would be.

## When to escalate to `security-review`

This file's tests are the baseline any Codexpiator user should be able
to write and run directly. For anything genuinely high-stakes (payment
flows, auth systems, data export features, anything handling
regulated data), also attempt the specialized `security-review` skill
per `external-skills-map.md` — a dedicated security review can probe
further than a fixed checklist of test cases can anticipate.
