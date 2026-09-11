# Business Logic & Webhook Security

These are the vulnerability classes that don't show up as a broken
input filter or a missing auth check — they're the application doing
exactly what it was coded to do, in a sequence or context nobody
intended.

## Webhook signature verification

Any incoming webhook (payment provider, third-party integration) must
be verified as actually coming from the claimed sender before it's
trusted — check the signature the provider includes (typically an
HMAC over the raw request body using a shared secret) before acting on
the payload. An unsigned or unverified webhook endpoint lets anyone
who finds the URL send fake events (fake "payment succeeded" events
being the highest-value target).

## Webhook replay

Verifying the signature isn't enough on its own if the same valid,
signed payload can be resent later and processed again. Track
processed webhook event IDs and reject (or no-op) a duplicate,
and/or verify a timestamp included in the signed payload is recent —
otherwise a captured, legitimately-signed webhook can be replayed to
repeat its effect (e.g. re-triggering a "grant access" action).

## Payment checks belong on the server

Never trust a price, discount, or "payment succeeded" signal that
originates from the client. Set prices server-side from your own
source of truth (not a value posted from the frontend), and confirm
payment success from the payment provider's server-to-server
confirmation (webhook or verified API call), not from the browser
redirecting back to a "success" URL — a client-side redirect proves
nothing about whether the payment actually happened.

## Business logic abuse

Look for sequences of individually-valid actions that produce an
unintended outcome: applying a one-time discount code multiple times
because nothing marks it used, exploiting a workflow's ordering (e.g.
submitting a refund request before a payment fully settles), or
abusing a feature at a volume or pattern it wasn't designed for (a
"free trial" script-able to be created unlimited times). This class of
bug isn't caught by input validation or auth checks, because the
individual requests are all legitimate — it requires thinking through
the actual business rule and what happens if a step is skipped,
repeated, or reordered.

## Race conditions

A check-then-act sequence that isn't atomic (check a coupon hasn't
been used, then mark it used; check a balance is sufficient, then
deduct it) can be exploited by firing multiple concurrent requests
that all pass the check before any of them completes the act,
producing an outcome that shouldn't be possible (a coupon used twice,
a balance going negative). Fix by making the check-and-act a single
atomic database operation (a conditional update, a transaction with
appropriate isolation, or a unique constraint that makes the double
case fail at the database level) rather than two separate steps in
application code.
