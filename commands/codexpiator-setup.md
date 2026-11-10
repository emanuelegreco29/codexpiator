---
description: Bootstrap project structure using Codexpiator conventions
argument-hint: [stack (optional)]
allowed-tools: Skill, Read, Write, Edit, Bash, Glob, Grep, AskUserQuestion
---

Bootstrap baseline project structure and conventions using
Codexpiator's guidance.

1. Determine the stack: if `$1` names one, use it; otherwise check for
   existing stack signals in the project (`package.json`,
   `pyproject.toml`, `go.mod`, etc.). If none are found and none was
   given, call `AskUserQuestion` rather than guessing.
2. Invoke `codexpiator-architecture` for folder layout (feature-based
   by default) and `codexpiator-dx-git` for repo hygiene basics.
3. Scaffold, only where missing (never overwrite an existing file
   without explicit confirmation first): `.gitignore` (including every
   Claude/skill-tool artifact directory per
   `codexpiator-dx-git`'s repo-hygiene guidance — `.claude/`,
   `.superpowers/`, `.playwright/`, `.docs/`, `.codexpiator/`, and any
   others observed in this environment), `.env.example`, a README
   skeleton (what it is, how to run it, how to contribute), and a CI
   config skeleton appropriate to the stack (lint, type-check, test
   stages — invoke `codexpiator-testing-qa` for what should gate).
4. For a Python backend, confirm `uv`/`pdm`/`poetry` is set up (per
   `shared/stack-recommendations.md`) rather than a bare
   `requirements.txt`, and that Ruff is configured.
5. For a frontend, invoke `codexpiator-frontend` and confirm Prettier,
   a type checker, and the folder-per-component convention are
   reflected in the scaffolded structure.
6. Attribution question, asked **once per project**. Skip it if
   `.claude/settings.json` already has an `attribution` key, or
   `.codexpiator/allow-ai-attribution` exists. Otherwise call `AskUserQuestion`: should commits and PRs
   keep Claude's attribution (the `Co-Authored-By` trailer and
   "Generated with Claude Code" footer)?
   - **Keep it**: create an empty `.codexpiator/allow-ai-attribution`
     file (this disables the plugin's attribution-blocking hook for
     this project) and change nothing else.
   - **Remove it**: detect the Claude Code version by running
     `claude --version`, then merge into `.claude/settings.json`
     (create it if missing, preserve every existing key):
     - v2.1.281 or newer: `"attribution": false`
     - older, or version undetectable:
       `"attribution": {"commit": "", "pr": "", "sessionUrl": false}`
     Compare versions numerically per segment (2.1.281 > 2.1.99),
     not as strings.
   Never re-ask on later runs.
7. Report exactly what was created/left alone, and suggest
   `/codexpiator-audit` once real code exists to check against these
   conventions.
