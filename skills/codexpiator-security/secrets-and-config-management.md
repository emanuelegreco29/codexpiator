# Secrets & Config Management

## Secrets never in source control

No database credentials, API keys, JWT signing secrets, or any other
credential ever committed to git — including in a `.env` file. Commit
an `.env.example` with placeholder values and the real `.env`
gitignored. If a secret is ever accidentally committed, **rotate it**
— removing it from a future commit doesn't remove it from git history,
which may already be cloned elsewhere; the only real fix is treating
that credential as compromised and replacing it.

## Public `.env` files

Confirm `.env` (and any environment-specific config file with real
values) is actually gitignored — a `.env` file present in the repo, or
worse, served as a static file the web server accidentally exposes at
a request URL, is a direct credential leak. Verify a deployed site
doesn't serve `.env`, `.git/`, or other config/metadata files at a
guessable URL.

## Hardcoded secrets

A credential typed directly into source code (even "temporarily," even
in a comment) tends to outlive the intention to remove it later and
still leaks the same way a committed `.env` does. Load all secrets
from environment variables or a secret manager, never as a literal in
code.

## Secrets in client-side JavaScript

Anything shipped to the browser is fully readable by anyone who opens
devtools — never put a real secret (a private API key, a signing
secret, a service credential) in frontend code, even "obfuscated" or
minified. If a frontend needs to call a service that requires a
secret, proxy that call through your own backend, which holds the
secret server-side.

## "Client-only security" is not security

Any check that exists only in frontend code (hidden UI, disabled
buttons, client-side validation of who's allowed to do what) is a UX
nicety, not a security boundary — see
`authn-authz-patterns.md`'s client-side admin-check section. Treat the
server as the only place a security decision can actually be enforced.

## JWT secrets

The signing secret (HMAC) or private key (RSA/EC) used to sign JWTs
must be treated with the same care as a database credential — anyone
who has it can forge valid tokens for any user. Store it via the same
secret-management mechanism as other credentials, rotate it if it's
ever suspected of leaking (which invalidates all currently-issued
tokens — plan for that operational impact), and never accept a token
whose algorithm/issuer isn't exactly what you expect (reject `"alg":
"none"` and algorithm-confusion attempts explicitly if your library
doesn't already).

## Default credentials

Any default username/password shipped with a database, admin panel,
or third-party service integration must be changed before the system
is reachable from anywhere untrusted — default credentials for common
software are actively scanned for by automated attackers within
minutes of a service becoming internet-reachable.

## Exposed non-production environments

A staging/dev/internal environment reachable from the public internet
without authentication is a real exposure — it often has weaker
security settings (verbose errors, test data, disabled rate limits)
than production while still touching real or realistic data. Put
non-production environments behind authentication or network
restriction (VPN, IP allowlist, basic auth at minimum) if they can't
be fully private.

## Unencrypted sensitive data

Sensitive data (PII, credentials, tokens) should be encrypted at rest
where the data store supports it, and every connection carrying it
(client-to-server, server-to-database, server-to-third-party) should
use TLS — never plain HTTP or an unencrypted database connection for
anything sensitive.

## Logs must not leak secrets

Never log full request/response bodies, headers, or objects that might
contain credentials, tokens, or PII without explicit redaction —
logging middleware that dumps "everything" by default is a common,
easy-to-miss leak of exactly the secrets this file is otherwise
protecting. Redact known-sensitive fields (password, token, secret,
authorization header) before anything is written to a log.

## Sensitive data in browser storage

Avoid storing sensitive tokens in `localStorage`/`sessionStorage` —
both are readable by any JavaScript running on the page, making them a
direct target for XSS-based token theft. Prefer an `HttpOnly` cookie
(inaccessible to JavaScript entirely) for session/auth tokens where
the architecture allows it.

## Cookie flags

For any cookie carrying a session or auth token, set: `HttpOnly`
(blocks JavaScript access, mitigating XSS-based theft), `Secure`
(only sent over HTTPS), and `SameSite=Lax` or `Strict` (mitigates
CSRF — see `input-validation-and-injection.md`). Treat a
session/auth cookie missing any of these three flags as
misconfigured.
