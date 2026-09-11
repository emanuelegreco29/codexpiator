# Observability & Monitoring

## The three pillars

**Logs** — discrete events with context, best for "what exactly
happened at this specific point." **Metrics** — numeric measurements
over time (request rate, error rate, latency percentiles), best for
"what's the overall trend/health right now." **Traces** — the path a
single request took across multiple services/functions, best for
"where did the time/failure in this one request actually happen."
Each answers a different question during an investigation; a system
missing one of the three has a real blind spot for the kind of
question only that pillar answers well.

## Alert on symptoms, not just causes

Alert on what users actually feel — elevated error rate, degraded
latency, failed critical transactions — as the primary signal, with
cause-level metrics (CPU, memory, queue depth) available for
diagnosis once an alert fires rather than as the alert trigger itself.
A symptom-based alert reliably indicates a real user-facing problem; a
pure cause-based alert (e.g. "CPU is high") can fire without any
actual impact, or miss real impact that didn't happen to spike that
particular resource.

## Avoid alert fatigue

An alert that fires often without indicating a real actionable problem
trains whoever's on call to start ignoring alerts generally — at which
point the one alert that matters gets missed along with the noise.
Tune thresholds to fire only when action is actually warranted, and
retire or fix any alert that's routinely ignored rather than letting
it keep firing.

## Dashboards built around real incident questions

Design dashboards around the questions someone actually asks during an
incident ("is this specific service degraded right now," "did this
deploy correlate with the error spike") rather than a generic grab-bag
of every available metric. A dashboard nobody can quickly get an
answer from during a live incident isn't serving its purpose.

## Distributed tracing once more than one service is involved

Once a single user-facing request can touch more than one service,
logs and metrics alone make it hard to reconstruct where time was
actually spent or where a failure originated — a trace ID threaded
through the whole call chain (see
`codexpiator-backend/error-handling-and-logging.md`'s correlation-ID
section) is what makes that reconstruction possible.

## Security-relevant monitoring

Beyond general health, monitor for signals of active abuse — spikes in
failed logins, repeated authorization failures, unusual data-access
volume — per `codexpiator-security/infrastructure-and-access-control.md`.
This is a distinct concern from uptime/performance monitoring and
needs its own alerting, not an assumption that general monitoring
would catch it.
