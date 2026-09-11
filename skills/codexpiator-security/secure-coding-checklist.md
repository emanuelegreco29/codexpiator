# Secure Coding Checklist

A fast, OWASP-Top-10-shaped pass to run over any non-trivial change.
Each item names what it looks like in practice and the fix. For depth
on any one item, follow the link to the dedicated file.

- [ ] **Injection** — user input reaches a query, command, or
  interpreter without being parameterized/escaped. *Fix:* parameterized
  queries, never string-built commands. See
  `input-validation-and-injection.md`.
- [ ] **Broken authentication** — weak password rules, no lockout after
  repeated failures, no MFA option, predictable session tokens. *Fix:*
  see `authn-authz-patterns.md`.
- [ ] **Sensitive data exposure** — secrets, PII, or credentials
  logged, hardcoded, or transmitted unencrypted. *Fix:* see
  `secrets-and-config-management.md`.
- [ ] **Broken access control** — an endpoint or UI action doesn't
  independently verify the caller is allowed to act on the specific
  resource requested (not just that they're logged in). *Fix:* see
  `authn-authz-patterns.md`'s IDOR/BOLA section.
- [ ] **Security misconfiguration** — verbose error pages in
  production, default credentials left in place, unnecessary services/
  ports/routes exposed, permissive CORS. *Fix:* see
  `infrastructure-and-access-control.md`.
- [ ] **XSS** — user-controlled content rendered without
  context-appropriate escaping. *Fix:* see
  `input-validation-and-injection.md`.
- [ ] **Insecure deserialization** — untrusted data deserialized into
  objects/code without validation. *Fix:* see
  `input-validation-and-injection.md`.
- [ ] **Vulnerable/outdated dependencies** — no automated scanning, no
  lockfile discipline. *Fix:* see `dependency-and-supply-chain.md`.
- [ ] **Insufficient logging & monitoring** — a security-relevant
  event (failed logins, permission denials, admin actions) isn't
  logged anywhere anyone would notice. *Fix:* see
  `infrastructure-and-access-control.md`'s audit-logging section.
- [ ] **SSRF** — the server fetches a URL derived from user input
  without validating the destination. *Fix:* see
  `input-validation-and-injection.md`.

## Process notes that don't fit a single vulnerability class

- **Verbose production errors are a misconfiguration, not just a UX
  issue** — a stack trace or internal exception message returned to a
  client in production can leak file paths, library versions, or query
  structure that helps an attacker. Return generic error messages to
  clients in production; log full detail server-side (see
  `codexpiator-backend/error-handling-and-logging.md`).
- **Unreviewed code is a security gap, not just a quality one** —
  security-relevant changes (auth, payments, input handling,
  infrastructure config) should go through the same code review
  discipline as everything else, with a reviewer specifically looking
  for the items on this checklist. See
  `codexpiator-dx-git/code-review-checklist.md`.
- **If the project has AI/agentic features**, this checklist doesn't
  cover prompt injection, excessive AI tool permissions, or unvalidated
  AI output — those live in
  `codexpiator-ai-integration/agentic-and-tool-use-safety.md`. Check
  that file too when security-reviewing an AI-integrated feature.
