#!/bin/bash
# PreToolUse hook (matcher: Bash): deterministically block any git
# commit/tag/PR command whose text includes AI/assistant attribution
# (Co-Authored-By Claude/Anthropic, a "Generated with Claude Code"
# footer, an anthropic.com noreply address, etc.).
#
# Why this exists as a hook and not just skill prose: a skill's own
# guidance ("never add AI attribution") can be outweighed by a host
# environment's own default attribution instructions, which are
# injected fresh every session and can win over prose guidance from a
# plugin. A PreToolUse hook is deterministic and runs on every
# matching command regardless of what instructions are currently in
# context, so it's the actual enforcement mechanism - this file is
# what makes the "never" in codexpiator-dx-git's commit conventions
# real rather than aspirational.
#
# Escape hatch: a project that genuinely wants AI attribution can
# create an empty file at .codexpiator/allow-ai-attribution to disable
# this check for that project specifically.
set -uo pipefail

input=$(cat)

project_dir="${CLAUDE_PROJECT_DIR:-.}"
if [ -f "$project_dir/.codexpiator/allow-ai-attribution" ]; then
  exit 0
fi

# Only care about commands that look like a git commit, tag, or
# GitHub CLI PR/release creation (the places a commit/PR message body
# gets written).
printf '%s' "$input" | grep -Eiq 'git[[:space:]]+(commit|tag)|gh[[:space:]]+(pr|release)[[:space:]]+create' || exit 0

# Signatures of AI/assistant attribution that must never appear.
if printf '%s' "$input" | grep -Eiq \
  'co-authored-by:[^"\\]*(claude|anthropic)|claude\.com/claude-code|noreply@anthropic\.com|generated with \\?\[claude|generated with claude code|🤖'; then
  # Every concrete PreToolUse example in Claude Code's own hook-
  # development reference material emits this exact
  # hookSpecificOutput.permissionDecision payload to stderr with
  # exit 2, not stdout with exit 0 - match that convention exactly so
  # the deny decision is actually honored rather than silently
  # no-op'd (this hook is the one deterministic enforcement point for
  # the no-attribution policy, so a wrong exit path here would mean
  # the whole thing quietly does nothing).
  cat >&2 <<'EOF'
{
  "hookSpecificOutput": {
    "permissionDecision": "deny"
  },
  "systemMessage": "Blocked by Codexpiator: this command's commit/PR message includes AI/assistant attribution (a Co-Authored-By Claude/Anthropic line, a Claude Code footer, or similar). The standing rule is to never add this unless the project owner explicitly asked for it in this project. Rewrite the message without any Claude/Anthropic reference and retry - do not just delete the hook or bypass it. If this project genuinely wants attribution, tell the user to create an empty .codexpiator/allow-ai-attribution file."
}
EOF
  exit 2
fi

exit 0
