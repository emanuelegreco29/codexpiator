---
description: Full frontend/backend/security/testing audit
allowed-tools: Task, Read, Grep, Glob, Bash(git:*)
---

Run a full audit of the current project's frontend, backend, security,
and testing surfaces by actually launching the `codexpiator-reviewer`
agent through the Task/Agent tool — never substitute reading files
yourself and narrating what an audit would find instead of running one.

Before launching the agent:
1. Determine the audit scope: if the user gave a path/directory
   argument, scope to it; otherwise scope to the whole project.
2. Tell the agent which `codexpiator-*` skills to invoke for what it
   will find (at minimum `codexpiator-frontend`, `codexpiator-backend`,
   `codexpiator-security`, and `codexpiator-testing-qa` — skip a
   category only if the scope clearly has nothing of that kind, e.g. a
   pure backend service has no frontend to audit).
3. Instruct the agent to also check for: unused dependencies,
   excessive boilerplate, duplicated code, and logical inconsistencies
   — not only checklist violations.

Launch the `codexpiator-reviewer` agent (via the Task/Agent tool) with
that scope and instruction set. It returns a compact JSON object
(`{"v":1,"n":...,"sev_max":...,"f":[...]}`), not prose — that's the
agent-to-agent channel, so don't expect or ask for human-readable text
there. Translate it yourself into what the user sees: a prioritized
list (most severe first), one line per finding —
`path:line — severity — problem — fix` — do not re-narrate every file
it found clean, and do not apply any fixes yourself unless the user
asks you to after seeing the findings.
