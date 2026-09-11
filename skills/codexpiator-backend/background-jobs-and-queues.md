# Background Jobs & Queues

## When to move work off the request path

Move work to a background job when it's slow (sending an email,
processing an image, generating a report), unreliable (calling a
third-party API that might be down), or non-critical to the immediate
response (analytics events, non-transactional notifications). Keep on
the request path only what the caller genuinely needs to wait for to
get a correct, immediate response.

## Delivery guarantees: design for at-least-once

Most real-world queues guarantee at-least-once delivery (a message
might be processed more than once, e.g. after a worker crash mid-job
and redelivery) rather than exactly-once (which is expensive or
impossible to guarantee in the general case). Design job handlers to
be idempotent — processing the same message twice produces the same
end state as processing it once (e.g. keyed on an idempotency ID
before performing the side effect) — rather than assuming delivery is
exactly-once and getting duplicated side effects when it isn't.

## Dead-letter queues

Route a message to a dead-letter queue after it's failed processing a
bounded number of times, instead of retrying forever or silently
dropping it. A poison message (one that will never process
successfully, e.g. due to malformed data) left in the main queue can
block or slow processing of everything behind it; a dead-letter queue
isolates it for investigation without losing it.

## Retries with backoff

Retry a failed job with exponential backoff (increasing delay between
attempts) rather than immediately and repeatedly — an immediate tight
retry loop can amplify load on an already-struggling downstream
dependency instead of giving it room to recover. Cap the number of
retries and route to a dead-letter queue after the cap.

## Scheduled vs event-triggered jobs

Use a scheduled/cron job for work that's inherently time-based
(nightly cleanup, periodic reports); use an event-triggered job for
work that's inherently reactive to something happening (a user
signed up, an order was placed). Don't simulate event-driven behavior
with a tight polling loop when the system could instead push an event
directly — polling adds latency and unnecessary load for something an
event could deliver immediately.
