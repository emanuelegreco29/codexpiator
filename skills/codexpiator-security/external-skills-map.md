# External Skills Map (Security)

`security-review` is the specialized skill for a deep security pass —
see `shared/external-skills-registry.md` for its confirmed install
path (via the `security-guidance`/`claude-security` plugin in the
official marketplace) and the availability-check procedure.

Unlike the frontend design skills, this isn't a "fall back gracefully
if missing" relationship by default — for security-sensitive work,
**attempt to invoke `security-review` before finalizing the change**,
per `SKILL.md`'s mandatory-consult instruction. Use this skill's own
checklist files (`secure-coding-checklist.md` and the rest) as the
fast baseline that runs regardless, and as the fallback specifically
when `security-review` genuinely isn't available in the environment —
not as a substitute reached for by default instead of checking.
