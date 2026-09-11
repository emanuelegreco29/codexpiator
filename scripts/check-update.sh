#!/bin/bash
# SessionStart hook: check whether a newer Codexpiator release exists
# on GitHub and tell the user how to update. Never blocks the session
# and never modifies anything itself — Claude Code doesn't expose a
# supported way for a plugin to silently rewrite its own installed
# files from inside a hook, so this checks and instructs rather than
# fabricating a self-update mechanism.
set -uo pipefail

REPO_RAW_URL="https://raw.githubusercontent.com/emanuelegreco29/codexpiator/main/.claude-plugin/plugin.json"
PLUGIN_JSON="${CLAUDE_PLUGIN_ROOT:-.}/.claude-plugin/plugin.json"

extract_version() {
  grep -o '"version"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed -E 's/.*"([0-9]+\.[0-9]+\.[0-9]+)".*/\1/'
}

version_gt() {
  # returns success (0) if $1 is strictly greater than $2
  [ "$1" = "$2" ] && return 1
  local v1 v2 a1 a2 a3 b1 b2 b3
  IFS='.' read -r a1 a2 a3 <<< "$1"
  IFS='.' read -r b1 b2 b3 <<< "$2"
  for i in 1 2 3; do
    v1=$(eval echo \$a$i); v2=$(eval echo \$b$i)
    v1=${v1:-0}; v2=${v2:-0}
    if [ "$v1" -gt "$v2" ] 2>/dev/null; then return 0; fi
    if [ "$v1" -lt "$v2" ] 2>/dev/null; then return 1; fi
  done
  return 1
}

[ -f "$PLUGIN_JSON" ] || exit 0
local_version=$(extract_version < "$PLUGIN_JSON")
[ -n "${local_version:-}" ] || exit 0

remote_json=$(curl -fsSL --max-time 5 "$REPO_RAW_URL" 2>/dev/null) || exit 0
remote_version=$(printf '%s' "$remote_json" | extract_version)
[ -n "${remote_version:-}" ] || exit 0

if version_gt "$remote_version" "$local_version"; then
  cat <<EOF
{"systemMessage": "Codexpiator update available: $local_version -> $remote_version. Update with: /plugin marketplace update emanuelegreco29/codexpiator (then /plugin install codexpiator if prompted). Release notes: https://github.com/emanuelegreco29/codexpiator"}
EOF
fi

exit 0
