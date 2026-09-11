# CI/CD Pipelines

This file covers pipeline *structure*. For *what* should actually gate
a merge (required checks vs. warnings) see
`codexpiator-testing-qa/ci-quality-gates.md` — read both when setting
up or changing CI/CD.

## Stage ordering: fail fast

Order pipeline stages from cheapest/fastest to most expensive: lint/
type-check first, then unit tests, then integration tests, then build,
then deploy. A change that fails lint shouldn't have to wait for a
full integration test run to find that out — put the cheap, fast
checks first so failures surface as quickly as possible.

## Build once, deploy many

Build one artifact (container image, compiled bundle) that passes CI,
and promote that exact artifact through staging and into production —
never rebuild at each stage. Rebuilding risks a different result at
each stage (a dependency resolving differently, a subtly different
environment) — the entire point of CI verifying an artifact is
undermined if production runs something that was never actually the
thing tested.

## Trunk-based development for CI/CD velocity

Short-lived feature branches merged frequently into a shared trunk
(vs. long-lived branches that diverge for weeks) keep integration
conflicts small and frequent rather than large and rare, and is what
most CI/CD tooling and practices are optimized around. Long-lived
branches tend to produce large, risky merges and stale CI feedback
against an outdated base.

## Automate what's manual and error-prone first

When deciding what to automate next in a pipeline, prioritize the
steps that are both currently manual and have caused a real mistake
when done by hand (a forgotten migration step, an inconsistent version
tag) — that's where automation pays back fastest, more than
automating something already reliable just because it's automatable.
