# Error Handling & Logging

## Fail loudly in development, safely in production

In development, let errors surface with full detail (stack traces,
internal messages) — you want the fastest possible path to diagnosing
a problem while you're the only one looking at it. In production,
never expose internal detail to the client (stack traces, raw
exception messages, internal file paths) — that's both a security
leak and unhelpful to the end user. Log the full detail server-side in
both environments; only the client-facing response differs.

## Structured logging

Log as structured data (JSON, or your logging framework's structured
format) with consistent fields — timestamp, log level, request/
correlation ID, service/module name — rather than free-text strings.
Structured logs are queryable and filterable at scale ("show me every
error for this request ID across every service it touched"); free-text
logs require fragile string-matching to extract the same information.

## Correlation / request IDs

Generate a unique ID for each incoming request (or accept one from an
upstream caller) and thread it through every log line, error report,
and downstream call that request triggers. When something goes wrong,
this is what lets you reconstruct the full story of one request across
multiple log lines, services, or async jobs — without it, "the login
endpoint threw an error" gives you a haystack, with it you get the
exact needle.

## Error taxonomy

Distinguish expected/validation errors (a user submitted bad input,
a resource wasn't found — these are normal operation, log at a low
severity or not at all, return a clear client-facing message) from
unexpected/system errors (a database connection failed, an
unhandled exception — these indicate something is actually broken,
log at high severity, alert on them, return a generic message to the
client). Treating every error the same (all logged as "error" severity,
all alerting on-call) buries the signal that actually needs attention
under routine, expected noise.

## Never swallow exceptions silently

An empty `catch` block (or an exception caught and only logged at a
level nobody watches) hides failures instead of handling them — the
system keeps running in a state nobody knows is broken until a much
later, harder-to-diagnose symptom appears. At minimum, log every
caught exception with enough context to act on it; only suppress an
exception you've deliberately decided is truly safe to ignore, and say
so explicitly in a comment at that point.
