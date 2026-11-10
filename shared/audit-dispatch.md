# Audit Dispatch Procedure

Shared procedure for every `/codexpiator:audit*` command and for
`/codexpiator:review`. Each command says which auditor agent(s) it
launches; this file says how.

Launching an agent means a real call to the Agent/Task tool, never
reading files yourself and narrating what an audit would find.

## 1. Scope

- If the user gave a path argument, scope to it.
- For `/codexpiator:review`, scope is the diff (see that command).
- Otherwise scope is the whole project. Skip build output,
  `node_modules`, vendored code, lockfiles' contents and
  `.codexpiator/`.
- If the scope clearly has nothing of an auditor's kind (a backend-only
  service has no frontend), don't launch that auditor and say so in one
  line.

## 2. Models

Resolve the model per auditor following `${CLAUDE_PLUGIN_ROOT}/shared/model-routing.md`:
read the project's recorded preference, ask once with
`AskUserQuestion` if there is none, then pass the `model` parameter
accordingly (omit it for the session default).

## 3. Launch

Launch every selected auditor **in parallel**, all Agent/Task calls in
a single message. Set `subagent_type` to the plugin-namespaced agent
type, e.g. `codexpiator:codexpiator-security-auditor`; if the
environment lists the agent under its bare name instead, use that. Give each one: the scope (paths or the diff command to
run), the instruction to also report unused dependencies, excessive
boilerplate, duplicated logic and logical inconsistencies within its
domain, and nothing else. The auditors are read-only and cannot fix
anything.

## 4. Translate the result

Auditors return compact JSON per `${CLAUDE_PLUGIN_ROOT}/shared/findings-contract.md`,
an agent-to-agent channel. Never show the raw JSON. Merge all `f`
arrays, drop duplicates (same `loc` and same problem reported by two
auditors keeps the higher severity), sort by severity (C, H, M, L), and
print one line per finding:

`path:line — severity — problem — fix`

Write the problem and fix text in the user's saved language per
`${CLAUDE_PLUGIN_ROOT}/shared/user-language.md` (paths, code and
identifiers stay as they are).

Mark findings that carry `conf` below 1 as "unverified". Do not
re-narrate what came back clean, do not apply fixes unless the user asks
after seeing the list. If every auditor returned an empty list, say so
in one line.

## 5. Afterwards

Offer to fix the findings (highest severity first) only after showing
the list. Long audits follow
`${CLAUDE_PLUGIN_ROOT}/shared/long-task-memory-and-superpowers.md` for progress memory.
