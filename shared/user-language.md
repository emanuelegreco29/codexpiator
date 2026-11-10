# User Language

Codexpiator answers in the user's language and remembers it, so it
never switches by mistake.

## Detect and record

1. Check the project's `CLAUDE.md` for a `Language:` line under
   `## Codexpiator preferences` (for example `- Language: it`). If it
   exists, use it silently.
2. If not, detect the language from the user's own messages (not from
   code, file contents or tool output). Record it as
   `- Language: <ISO 639-1 code>` (`it`, `en`, `pt`...) in that
   section, creating the section if missing, and tell the user in one
   line what was saved and how to change it.
3. If the language is unclear (very short or mixed messages), ask once
   with `AskUserQuestion` instead of guessing.

## Apply

- Write all prose in the saved language: answers, questions
  (`AskUserQuestion` text and options), reports, and the translated
  audit findings (`desc` and `fix` of each finding, per
  `${CLAUDE_PLUGIN_ROOT}/shared/audit-dispatch.md`).
- Keep unchanged: code, identifiers, file paths, command and skill
  names, flags, exact error strings, JSON keys, commit-type prefixes.
- Subagents return structured JSON for the dispatching command, which
  does the translating. Pass the language only to a subagent that
  writes prose for the user.

## Changing it

- If the user explicitly asks for another language, switch and update
  the `Language:` line.
- If they merely write one message in another language, keep the
  saved one. If they keep writing in the new language over several
  messages, ask once whether to switch.
- Per `${CLAUDE_PLUGIN_ROOT}/shared/collaboration-and-audit-practice.md`,
  the preference is per project unless the user says it is global.
