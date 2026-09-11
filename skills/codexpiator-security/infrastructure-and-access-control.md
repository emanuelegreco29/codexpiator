# Infrastructure & Access Control

## Database and cloud permissions

- **No open/public DB permissions** — a database reachable from the
  public internet with no network restriction (no VPC/firewall rule
  limiting access to known application servers) is scanned and
  attacked automatically within hours of being exposed, regardless of
  how strong its password is.
- **Excessive DB permissions** — an application's database user should
  have only the privileges it actually needs (read/write on its own
  tables), not a superuser/admin credential used for routine queries —
  limits the damage of a credential leak or an injection bug that does
  get through.
- **Cloud service misconfiguration** — the most common real-world
  breach pattern for cloud infrastructure is a storage
  bucket/database/service left with a default or overly permissive
  access policy (e.g. a storage bucket set to public read when it
  should be private). Explicitly review the access policy of every
  cloud resource that holds real or sensitive data.
- **Poor tenant isolation** — in a multi-tenant system, every query
  must be scoped to the requesting tenant at the data-access layer
  (not just filtered in application code after a broader fetch) so a
  bug in one code path can't leak one tenant's data into another's
  response.

## Admin surfaces and debug tooling

- **Unprotected admin routes** — an admin panel or route must require
  authentication and an explicit admin-role check, independent of
  whether it's "hard to guess" — obscurity is not access control.
- **Remove default admin routes/accounts** that ship with a framework
  or CMS before deploying (e.g. a default admin login page or seeded
  admin account with a known password).
- **Exposed production debug tools** — a framework's debug mode,
  interactive error page, or admin/introspection endpoint (GraphQL
  introspection, an ORM's admin UI, a debugger endpoint) must be
  disabled in production; these routinely expose internals or allow
  direct data manipulation when left on.
- **Exposed internal dashboards** (metrics, logs, admin panels for
  internal tools) must sit behind authentication/network restriction,
  not just an unlisted URL.
- **Disable directory listing** on any web server/static file host —
  an open directory listing hands out the full file structure of
  whatever it's serving.

## Network and transport config

- **Permissive CORS** — `Access-Control-Allow-Origin: *` combined with
  credentialed requests is a common misconfiguration; scope CORS to an
  explicit allowlist of trusted origins, and never combine a wildcard
  origin with `Access-Control-Allow-Credentials: true`.
- **Missing security headers** — set, at minimum: `Content-Security-
  Policy` (mitigates XSS impact), `X-Content-Type-Options: nosniff`,
  `X-Frame-Options`/`frame-ancestors` (mitigates clickjacking), and
  **`Strict-Transport-Security` (HSTS)** so browsers refuse to
  downgrade the connection to plain HTTP after the first HTTPS visit.
- **Unsecured/exposed endpoints** — periodically enumerate what's
  actually reachable from the internet (not just what you remember
  building) — an old debug endpoint, a forgotten internal API, or a
  test route left in production are all real-world breach entry
  points precisely because nobody was watching them.

## Rate limits and request size

- Apply rate limiting broadly (per-IP and/or per-account) across
  public endpoints, not only login (see
  `codexpiator-security/authn-authz-patterns.md` for the login-specific
  case and `codexpiator-backend/resilience-and-rate-limiting.md` for
  the reliability angle on the same mechanism).
- **Limit request body size** at the server/proxy level — an
  unbounded request body accepted before your application logic even
  runs is a cheap denial-of-service vector.

## Logging, monitoring, and recovery

- **Exposed logs** — log files or a logging dashboard reachable
  without authentication can leak everything discussed in
  `secrets-and-config-management.md`'s logging section, plus general
  operational detail useful for an attack. Restrict access the same as
  any other sensitive internal system.
- **Missing audit logs** — record who did what for security-relevant
  actions specifically (login, permission changes, admin actions, data
  export/deletion) in an append-only, tamper-resistant way — this is
  what makes "did this actually happen, and who did it" answerable
  after the fact.
- **No security monitoring** — alert on the signals that indicate
  active abuse (spikes in failed logins, repeated authorization
  failures, unusual data access volume), not only on raw uptime/error
  rate. See `codexpiator-devops/observability-and-monitoring.md` for
  the general observability practice this specializes.
- **No backups / no tested restore** — a backup that's never been
  restored from is unverified; schedule regular backups **and**
  periodically test actually restoring from one. A backup you can't
  restore isn't a backup, it's an unverified assumption.
