# Monolith vs Microservices

## Start with a well-structured monolith

A single, well-organized codebase (feature-based structure, clear
internal module boundaries — see `project-structure-conventions.md`)
deployed as one unit is the right default for most projects,
especially early on. Microservices add real operational complexity —
network calls where there used to be function calls, distributed
tracing/debugging, per-service deployment pipelines, data consistency
across service boundaries — that isn't justified until the pain a
monolith actually causes is real, not hypothetical.

## Signals that justify splitting

- **Independent deploy cadence genuinely needed** — one part of the
  system needs to ship many times a day while another barely changes,
  and coupling their deploys is causing real friction.
- **Genuinely different scaling profiles** — one component needs far
  more compute/memory than the rest, and scaling the whole monolith to
  satisfy it wastes significant resources.
- **Team ownership boundaries causing real conflict** — multiple teams
  working in the same codebase are frequently blocked on each other's
  changes or stepping on each other's deploys.

Absent at least one of these concrete pains, a monolith is not
"behind" or "unscalable" — it's the appropriate choice.

## The distributed-monolith failure mode

Splitting services along technical layers (a "frontend service," an
"API service," a "database service") instead of business capabilities
often produces a distributed monolith: multiple services that still
have to deploy together in lockstep because they're too tightly
coupled, but now pay the full network/operational cost of being
separate processes with none of the independence benefit. If you do
split, split along business capability boundaries (each service owns
a coherent domain), not technical layers.

## Data ownership is the hard requirement

If you split into services, each service must own its own data — no
service directly querying another service's database. Cross-service
data access happens through that service's API, not a shared
database. Skipping this (a shared database "for now") reintroduces
tight coupling immediately and defeats most of the point of having
separate services in the first place.
