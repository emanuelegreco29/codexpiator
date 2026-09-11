---
description: Bootstrap baseline project structure using Codexpiator's conventions
argument-hint: [stack (optional)]
allowed-tools: Read, Write, Edit, Bash, Glob, Grep, AskUserQuestion
---

Bootstrap baseline project structure and conventions using
Codexpiator's guidance.

1. Determine the stack: if `$1` names one, use it; otherwise check for
   existing stack signals in the project (`package.json`,
   `pyproject.toml`, `go.mod`, etc.). If none are found and none was
   given, ask the user (via `AskUserQuestion` when available) rather
   than guessing.
2. Apply `codexpiator-architecture/project-structure-conventions.md`
   for folder layout (feature-based by default) and
   `codexpiator-dx-git/repo-hygiene-and-onboarding.md` for repo
   hygiene basics.
3. Scaffold, only where missing (never overwrite an existing file
   without explicit confirmation first): `.gitignore` (including every
   Claude/skill-tool artifact directory per
   `repo-hygiene-and-onboarding.md` — `.claude/`, `.superpowers/`,
   `.playwright/`, `.docs/`, and any others observed in this
   environment), `.env.example`, a README skeleton (what it is, how to
   run it, how to contribute), and a CI config skeleton appropriate to
   the stack (lint, type-check, test stages per
   `codexpiator-testing-qa/ci-quality-gates.md`).
4. For a Python backend, confirm `uv`/`pdm`/`poetry` is set up (per
   `shared/stack-recommendations.md`) rather than a bare
   `requirements.txt`, and that Ruff is configured.
5. For a frontend, confirm Prettier and a type checker are configured,
   and that the folder-per-component convention from
   `codexpiator-frontend/component-architecture.md` is reflected in
   the scaffolded structure.
6. Report exactly what was created/left alone, and suggest
   `/codexpiator-audit` once real code exists to check against these
   conventions.
