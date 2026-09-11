# Project Structure Conventions

## Feature-based over layer-based, past a small size

Layer-based structure (`controllers/`, `services/`, `models/` at the
top level, every feature's pieces scattered across all three) works
for a very small app but stops scaling once there's more than a
handful of features: changing one feature means touching files spread
across every top-level folder, and there's no single place that shows
you everything about that feature. Feature-based structure (each
feature owns its own controller/service/model together) keeps a
feature's blast radius visible and makes it possible to delete a
feature by deleting one folder. Default to feature-based past a small
app; don't over-structure a genuinely small project before there's a
second feature to separate it from.

## Colocate tests with source

Keep a module's tests next to the module itself (same folder, or an
immediately adjacent `__tests__`/`.test.` file) rather than in a
fully separate parallel test tree that mirrors the source tree — it's
easier to notice a module has no tests, and to keep tests updated when
the module changes, when they're not several directories away.

## Consistent naming as a force multiplier

Pick one naming convention per concept (how list-item components are
named, how service files are named, how test files are named) and
apply it everywhere — a codebase where the same kind of thing is named
three different ways across features costs every new contributor real
time just figuring out the pattern before they can follow it.

## Monorepo vs polyrepo

A monorepo (all related projects/packages in one repository) eases
cross-package refactors (one commit can update a shared library and
all its consumers atomically) and shared tooling/CI configuration, at
the cost of needing tooling that scales with repo size (selective
builds/tests, code ownership boundaries). A polyrepo (each
project/service in its own repository) eases independent deploy
cadence and access control per project, at the cost of coordinating
changes that span multiple repos. Neither is universally correct —
choose based on how tightly the projects are coupled and how
independently they need to release.
