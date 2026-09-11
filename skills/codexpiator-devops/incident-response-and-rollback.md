# Incident Response & Rollback

## Rollback-first instinct

When production breaks shortly after a deploy, the fastest path back
to a working state is usually reverting to the last known-good
version — not diagnosing the root cause under pressure with users
actively affected. Roll back first, then investigate the actual cause
calmly afterward with the pressure off. Resist the urge to try a
quick forward-fix during an active incident unless you're genuinely
confident it's both correct and faster than a rollback.

## Have a tested rollback path before you need it

A rollback mechanism that's never been exercised is a rollback
mechanism you don't actually know works. Test the rollback path (or
at minimum, confirm it conceptually against how the deploy pipeline
actually works) before the first real incident, not during it —
discovering the rollback script is broken while production is down is
the worst possible time to learn that.

## Blameless postmortems, systemic fixes

After an incident, focus the retrospective on what allowed the failure
to happen and reach production (missing test coverage, no alert on
that failure mode, a gap in the deploy process) rather than on who
made the change — blame discourages the honest reporting needed to
actually find and fix the systemic gap, and the same class of incident
tends to recur if only the immediate symptom is patched.

## Communicate status during an incident

Post a status update as soon as an incident is confirmed, even before
there's a fix — "we're aware, investigating" is far better than
silence, both for users and for internal stakeholders. Keep updating
at a predictable cadence until resolved, rather than going quiet until
there's a complete answer.

## Feature-flag kill switches

Where a feature is behind a flag (see
`environments-and-config.md`), flipping it off is often faster than a
full rollback/redeploy and can be scoped more precisely (disable just
the broken feature, not the entire release). Design flags for
higher-risk features with this kill-switch use case in mind, not only
for gradual rollout.
