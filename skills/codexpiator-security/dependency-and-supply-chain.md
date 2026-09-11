# Dependency & Supply-Chain Security

## Lockfiles, always

Commit a lockfile (`package-lock.json`/`pnpm-lock.yaml`/`uv.lock`/
`poetry.lock`/equivalent) and install from it in every environment —
never a floating-version install in anything beyond local
experimentation. A lockfile is what guarantees the exact same
dependency tree (including transitive dependencies) runs in
development, CI, and production.

## Vulnerable dependencies

Run automated dependency vulnerability scanning as a CI gate (most
ecosystems have a built-in or widely-used tool for this), not as an
occasional manual check. Treat a newly-disclosed critical
vulnerability in a direct dependency as something to patch promptly,
not something to batch into the next unrelated release.

## Malicious packages

Before adding a new dependency, a quick sanity check is worth the
minute it costs: does it have a plausible download history and
maintainer activity, does its source match what it claims to do, does
it require unusually broad install-time permissions (a lint plugin
that needs network access at install time is a red flag). This
matters most for typosquatting risk (a malicious package with a name
one character off from a popular one) — double-check the exact package
name when adding a new dependency, especially one recommended in a
snippet rather than official documentation.

## Minimize dependency footprint

Every dependency is both attack surface (its own vulnerabilities and
its transitive dependencies' vulnerabilities become yours) and an
ongoing maintenance liability (it can be abandoned, or a maintainer
account can be compromised and used to push a malicious update). A
small utility you could write in twenty lines doesn't always need a
package for it — weigh the convenience against the long-term exposure.

## Insecure CI/CD as a supply-chain risk

Your build pipeline is itself part of the supply chain: if it can be
tampered with, the artifact it produces can be too, regardless of how
clean the source code is. Concretely:
- **Untrusted build actions/steps** — pin third-party CI actions/steps
  to an exact commit SHA (not a mutable tag like `v1` or `latest`)
  when your CI system allows it, so a compromised upstream action
  can't silently change what runs in your pipeline.
- **Unpinned build dependencies** — the same lockfile discipline
  applies to whatever the build itself pulls in (build-time tools,
  base container images), not just application dependencies.
- **Checks that fail open** — a CI check that's misconfigured to pass
  when it errors (rather than fail) silently stops protecting you the
  moment it breaks. Verify failure modes explicitly: a broken linter
  invocation should fail the build, not report success by accident.
- **Missing timeouts on CI jobs** — a hung job with no timeout can
  block a pipeline indefinitely or, in some configurations, keep
  consuming compute/credentials longer than intended.
- Grant CI/CD credentials the minimum scope they need (a deploy step
  shouldn't hold the same broad access as a full admin credential).

## Unreviewed code as a supply-chain gap

Code that lands without review (a direct push to a protected branch,
an auto-merged dependency update with no human look at the diff) skips
the one check most likely to catch an introduced vulnerability or a
compromised upstream change before it ships. See
`codexpiator-dx-git/code-review-checklist.md` and
`codexpiator-testing-qa/ci-quality-gates.md` for what should be
required, not optional, before merge.
