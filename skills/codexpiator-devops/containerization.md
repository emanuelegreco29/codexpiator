# Containerization

## Multi-stage builds

Use a multi-stage Dockerfile: one stage with full build tooling
(compilers, dev dependencies) to produce the build artifact, then copy
only the artifact into a minimal final stage. This keeps the shipped
image small and avoids shipping build tools and dev dependencies (both
extra attack surface and extra size) into production.

## Non-root user

Run the container process as a non-root user, not the default root —
if the application is ever compromised, running as root inside the
container gives an attacker more to work with (and, depending on
container runtime configuration, a shorter path to the host).

## Pin base image versions

Reference a specific version tag for the base image (`node:20.11-
slim`, not `node:latest`) — `latest` (or any floating tag) means the
exact same Dockerfile can produce a different image tomorrow, breaking
reproducibility and potentially introducing an untested new base image
version without anyone deciding to upgrade.

## `.dockerignore` mirrors `.gitignore` intent

Exclude anything not needed inside the image (`.git/`, local env
files, `node_modules` if reinstalled inside the build, test files) via
`.dockerignore` — this keeps build context small (faster builds) and
prevents accidentally baking local secrets or dev-only files into the
image.

## Health checks

Define a health check the container orchestrator can use to know when
the container is actually ready to receive traffic (not just that the
process started) and to detect when it's become unhealthy afterward —
without this, an orchestrator may route traffic to a container that
hasn't finished starting up, or keep routing to one that's silently
stopped functioning correctly.

## One process per container

Run one main process per container rather than multiple unrelated
services in one container (e.g. an app server and a cron daemon
together) — this keeps scaling, logging, and restart behavior scoped
correctly to one concern, matching how most orchestration tooling
expects containers to behave.
