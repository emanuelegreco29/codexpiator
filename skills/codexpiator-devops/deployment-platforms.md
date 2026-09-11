# Deployment Platforms

## PaaS vs self-managed infrastructure

A platform-as-a-service (Vercel-style: git-push deploys, managed
scaling, built-in preview environments) trades some control and
per-unit cost for a large reduction in operational burden — no server
management, patching, or scaling configuration to own. Self-managed
infrastructure (VMs, self-run container orchestration) gives maximum
control and can be more cost-efficient at real scale, at the cost of
someone owning that operational work. Default to a PaaS for velocity,
especially for small teams and early-stage projects; move toward
self-managed infrastructure only once a concrete need (cost at scale,
a specific control requirement the PaaS can't meet) justifies taking
on the operational burden.

## Preview deployments per pull request

A deployment automatically generated for each pull request, reachable
at its own URL, lets reviewers (and the author) see and click through
the actual running change before merge — catching visual and
functional issues that a code diff alone won't surface. This is a
strong default for anything with a user-facing surface, regardless of
platform.

## Zero-downtime deploy strategies

**Blue-green**: run two identical production environments, deploy to
the idle one, then switch traffic over atomically — instant rollback
by switching back. **Rolling**: replace instances gradually one at a
time behind a load balancer — no need for double the infrastructure,
but a rollback is also gradual. Either avoids the downtime a naive
"stop old version, start new version" deploy causes; pick based on
whether instant switch-back or lower infrastructure cost matters more
for the project.

## Platform-specific depth

For projects actually deployed on Vercel specifically, the `vercel:*`
skill family (deployment, environment variables, functions, caching,
and more) covers platform-specific depth this file intentionally
doesn't duplicate — use those skills directly for anything
Vercel-specific.
