# Claude Security plugin (mandatory for security work)

Anthropic's `claude-security` plugin (skill `claude-security:claude-security`,
marketplace `claude-plugins-official`) is the lead tool for security work in
Codexpiator. Install it when missing and use it almost every time security is
in play. Codexpiator's own `codexpiator:security` checklists are the baseline
that runs next to it, never a replacement.

## When it applies

Any security-sensitive task: auth, sessions, user input, uploads, payments,
webhooks, secrets, dependencies, infra or access config, AI/agent features,
`/codexpiator:audit-security`, the security part of `/codexpiator:audit` and
`/codexpiator:review`, and any "is this secure" question. Skip only for
changes with no security surface (typo, copy, pure styling) — say so in one
line instead of silently skipping.

## Procedure (main thread only)

1. **Check.** Look for `claude-security:claude-security` in the session's
   skill listing.
2. **If missing, install it.** Do not ask first: the user has made this a
   standing requirement. Run through Bash:
   `claude plugin install claude-security@claude-plugins-official`.
   If the marketplace is unknown, first run
   `claude plugin marketplace add anthropics/claude-plugins-official`.
   `/plugin ...` slash commands cannot be run by Claude, so use the CLI form.
3. **Tell the user.** A newly installed plugin only loads after
   `/reload-plugins` or a restart. Say that in one line and ask them to run
   it. Do not claim the skill ran when it did not.
4. **If install fails** (no CLI, no network, blocked): say so plainly with the
   shortest decisive error line, then continue with `security-review` if
   present, else the `codexpiator:security` checklists. Never retry blindly.
5. **If present, invoke it** with the Skill tool, scoped to the same
   files/diff as the task, before finalizing. Then also apply the
   `codexpiator:security` checklists for what it did not cover.

## Why main thread only

The plugin's scan orchestrator cannot scan from inside a subagent, and the
read-only `codexpiator-security-auditor` has no install rights. So commands
and skills do steps 1-5 themselves, then launch the auditor. The auditor
stays the checklist pass and receives the plugin's findings as extra context
to verify and merge, not to duplicate.

## Reporting

Name the source of each finding (`claude-security` vs Codexpiator checklist).
When both flag the same issue, report it once. Never print a secret's value;
cite location only.
