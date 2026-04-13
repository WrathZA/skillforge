#!/usr/bin/env bash
# Runs after every Write tool call in this project.
# Syncs ~/.claude/skills/ symlinks if a SKILL.md was just written.

input=$(cat)
file_path=$(echo "$input" | jq -r '.tool_input.file_path // empty')

case "$file_path" in
  */SKILL.md)
    bash "$(dirname "$0")/../../symlink-global-skills.sh"
    ;;
esac
