# Findings Contract

Every Codexpiator auditor agent returns its result in this format. The
output is read by the dispatching command (see
`${CLAUDE_PLUGIN_ROOT}/shared/audit-dispatch.md`), not by the user.
Return one JSON object and nothing else:

```json
{"v":1,"n":2,"sev_max":"H","f":[
  {"sev":"H","cat":"n+1","loc":"orders.py:42","desc":"query per item in loop","fix":"prefetch / join","conf":0.9},
  {"sev":"M","cat":"swallowed-error","loc":"jobs.py:10","desc":"bare except","fix":"catch and log specific errors"}
]}
```

- `sev`: `C`/`H`/`M`/`L`.
- `cat`: short tag for the finding type. Each agent lists its preferred
  tags.
- `loc`: `path:line`, or `path` alone for whole-file findings.
- `conf` (0 to 1) only when not fully certain; omit when certain.
- `f` sorted most severe first, `n` its length, `sev_max` the highest
  severity or `null` when empty.
- No entries for clean areas, no praise, no prose outside the JSON.
