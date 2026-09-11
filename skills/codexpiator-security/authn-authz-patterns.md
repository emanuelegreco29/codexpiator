# Authentication & Authorization Patterns

## Weak authentication basics

Never roll your own password hashing or crypto (see
`codexpiator-backend/auth-and-authorization.md` for the correct
approach: bcrypt/scrypt/argon2). Enforce a real password strength
check on signup/change (length is the strongest single signal — 12+
characters — over arbitrary complexity rules that push users toward
predictable substitutions). Rate-limit the `/login` endpoint
specifically and separately from general API rate limits, since it's
the most directly brute-forceable endpoint in the system. Lock an
account (or escalate to a CAPTCHA/delay) after a bounded number of
consecutive failed login attempts, so credential-stuffing and
brute-force attempts hit a wall instead of unlimited guesses.

## MFA / 2FA / OTP

Offer multi-factor authentication (TOTP app, or at minimum OTP via
email/SMS) for anything with sensitive data or actions, and default it
on for admin/privileged accounts specifically even if optional for
regular users. Treat "no MFA available at all" as a real gap for any
system beyond a low-stakes prototype.

## Broken password reset

A password reset flow is a common weak point:
- Reset links/tokens must **expire** (short window, e.g. 15-60
  minutes) and be **single-use** — a reset link that works indefinitely
  or repeatedly is a standing credential leak risk.
- Never reveal whether an email/username exists based on the reset
  flow's response (see account enumeration below).
- **Invalidate all active sessions when a password is changed** —
  otherwise a session an attacker already established survives the
  legitimate user's own password change, defeating the point of
  changing it.

## Weak session management

- Rotate the session identifier on login and on privilege change
  (prevents session fixation, where an attacker sets a known session
  ID before the victim authenticates into it).
- Set a reasonable session expiry and support explicit logout that
  actually invalidates the session server-side, not just a client-side
  redirect.
- See `secrets-and-config-management.md` for cookie flag settings that
  protect the session token itself.

## Misconfigured OAuth

Validate the `redirect_uri`/callback URL against an exact allowlist
(not a prefix match, which can be bypassed) to prevent authorization
code/token theft via an attacker-controlled redirect. Validate the
`state` parameter to prevent CSRF against the OAuth flow itself. Don't
trust claims from an OAuth provider you haven't explicitly configured
to trust (verify the token's issuer and audience).

## IDOR / BOLA (cross-user access) — the most common real-world bug

Insecure Direct Object Reference / Broken Object-Level Authorization:
an endpoint takes a resource ID and returns/modifies it without
checking the caller actually owns or is permitted to act on *that
specific* resource — checking only that they're authenticated, not
that they're authorized for this object. This is the single most
common authorization bug in real APIs precisely because it's invisible
in normal testing (you always test with your own resources) and only
appears when someone deliberately tries another user's ID.

**Test for it explicitly and directly**: as user A, attempt to
read/modify/delete a resource that belongs to user B by guessing or
incrementing an ID. Every endpoint that takes a resource identifier
needs this check, applied on the server — not inferred from what the
UI happens to show the user.

## Client-side admin/authorization checks

Hiding an admin button in the UI for non-admin users is a UX
convenience, not a security control — it does nothing to stop a
direct API call. Every privileged action must be independently
authorized on the server regardless of what the client displayed or
attempted to prevent. Treat any authorization logic that exists
*only* in frontend code as equivalent to having no authorization check
at all.

## Account enumeration

Login, signup, and password-reset error messages should not reveal
whether a specific email/username exists in the system ("invalid
email or password" instead of "no account with that email") —
otherwise an attacker can enumerate valid accounts to target for
credential stuffing or phishing, one response at a time.

## Least-privilege role/permission modeling

Model roles/permissions explicitly and grant the minimum a role
actually needs (see `codexpiator-backend/auth-and-authorization.md`
for the implementation approach) — this file's concern is verifying
that model is actually enforced at every access point, not just
defined.
