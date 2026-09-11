# Input Validation & Injection

## The default posture: allowlist, and validate every input

Any value that crosses a trust boundary (user input, a third-party
API response, a file upload, a query parameter) is untrusted until
validated. Prefer allowlisting (define exactly what's acceptable —
shape, type, range, allowed characters) over denylisting (trying to
block known-bad patterns), since a denylist only ever covers the
attack patterns someone thought of. This applies uniformly across
"APIs + user input" — every endpoint that accepts a body, query
string, header, or path parameter is a validation surface, not just
form submissions.

## SQL injection

Never build a query by concatenating or interpolating user input into
a SQL string. Use parameterized queries / prepared statements
exclusively — the query structure and the data are sent separately to
the database, so user input can never change the query's meaning, no
matter what characters it contains. An ORM used correctly gives you
this for free; raw string-built SQL is the failure mode to watch for
in code review.

## NoSQL injection

Document/NoSQL databases have their own injection risk: a query
"operator" object (e.g. `{ "$ne": null }`-style structures) passed
directly from user input can change query logic just as SQL
concatenation can. Validate that input intended to be a plain value
(a string/number for a filter) is actually a plain value, not an
object/operator structure, before it reaches the query layer.

## XSS (Cross-Site Scripting)

Escape output based on the context it's rendered into — HTML body,
HTML attribute, JavaScript string, and URL contexts each need
different escaping rules, and using the wrong one (or none) is how
XSS happens even when *some* escaping is present. Most modern frontend
frameworks escape HTML-context output by default — the real risk is
anywhere that default is deliberately bypassed (`dangerouslySetInnerHTML`,
`v-html`, `innerHTML`, raw template interpolation marked "safe") for
content that isn't fully trusted and sanitized first.

**Stored XSS specifically** — a payload saved to the database (a
comment, a profile field, any user-generated content) and rendered
later to *other* users — is more severe than reflected XSS precisely
because it persists and hits every viewer, not just whoever clicked a
crafted link. Escaping at render time is still required regardless of
source, but also sanitize at the point of storage (see "Sanitize
before storing" below) so every future consumer of that data — an
admin panel, an export, a different page entirely — starts from
already-safe content instead of each one needing to remember to escape
correctly.

## Misused dynamic conditions

Be wary of any conditional/authorization/query-building logic whose
*shape* (not just its values) is constructed from user input — a
filter field name chosen by the client, a dynamically-built database
query condition, a permission check assembled from a client-supplied
key, `eval`-style dynamic code execution, or dynamic property access
using a user-controlled key (which can lead to prototype pollution in
languages/runtimes where that's possible). The risk isn't just wrong
data — it's the logic itself being redirected into a code path or
condition nobody intended to expose. Keep the *set of possible
conditions/fields/keys* fixed and allowlisted in code; let user input
only choose among that fixed set of already-safe options, never define
new ones.

## CSRF (Cross-Site Request Forgery)

For any state-changing request authenticated via cookies, add CSRF
protection: a CSRF token tied to the user's session, included in the
request and verified server-side, or `SameSite=Lax`/`Strict` cookies
as a strong baseline defense (see
`secrets-and-config-management.md` for cookie flag settings).
API-key or bearer-token authentication (not cookie-based) is
inherently not vulnerable to classic CSRF, since the browser doesn't
attach those automatically — but confirm which auth mechanism is
actually in play before assuming you're covered.

## Insecure file uploads

- **Whitelist allowed file types** by actual content (verify the file's
  real content/magic bytes, not just the extension or the
  client-supplied MIME type, both of which are trivially spoofed).
- Store uploads outside the web root, or serve them from a separate
  domain/subdomain with no execute permission, so an uploaded file can
  never be directly executed as server code.
- Enforce a maximum file size to prevent trivial denial-of-service via
  huge uploads.
- Re-encode/re-process images rather than serving the raw uploaded
  bytes where feasible, to strip embedded exploits some image formats
  can carry.

## Path traversal

When user input contributes to a filesystem path (a filename
parameter, a requested file path), canonicalize the resolved path and
verify it's still inside the intended allowed root directory before
using it — reject anything that resolves outside that root (e.g. via
`../` sequences or absolute paths). Never trust a "sanitize `../`
out of the string" approach alone; canonicalize-then-check is the
reliable version.

## SSRF (Server-Side Request Forgery)

When the server fetches a URL that's derived from user input (a
"fetch this webhook/image/link" feature), validate the destination
against an allowlist of expected hosts/schemes before fetching, and
explicitly block requests to internal/private IP ranges and cloud
metadata endpoints (e.g. `169.254.169.254`) — otherwise a user can use
your server as a proxy to reach internal infrastructure it wouldn't
otherwise be able to reach directly.

## Open redirects

If a feature redirects based on a user-supplied URL/path (a
`?redirect=` parameter after login, for example), validate it's a
relative path or matches an allowlisted domain before redirecting —
an unchecked redirect target lets an attacker craft a link that looks
like it points at your trusted domain but forwards the victim
elsewhere (commonly used in phishing).

## Command injection

Never pass user input into a shell command string. If shell execution
is unavoidable, use an API that passes arguments as a list/array
(avoiding shell interpretation entirely) rather than a single
interpolated command string, and validate the input against a strict
allowlist regardless.

## Mass assignment

Don't bind a request body directly onto a database model/entity
without an explicit allowlist of which fields that endpoint is allowed
to set — otherwise a client can include an unexpected field in the
request body (e.g. `role: "admin"`, `isVerified: true`) and have it
silently accepted if the model happens to have that field. Explicitly
list the fields each endpoint accepts from the client.

## Insecure deserialization

Deserializing untrusted data with a format/library that can
instantiate arbitrary types or execute code as a side effect of
deserialization (common in some language-native serialization formats)
is a direct code-execution risk. Prefer data-only formats (JSON with a
schema validator) for anything crossing a trust boundary, and if a
richer serialization format is required, use it only for
fully-trusted, internally-generated data.

## Sanitize before storing, not only before rendering

Validate and sanitize input at the point of storage, not only at the
point of display — data can be read by more than one consumer (an
admin panel, an export, a different rendering context) over its
lifetime, and each one re-implementing sanitization independently is
fragile. Storing already-clean data means every future consumer starts
from a safe baseline.
