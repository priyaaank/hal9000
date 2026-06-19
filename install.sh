#!/usr/bin/env bash
# Installs the hal9000 Obsidian skills into ~/.claude/skills by symlinking.
# Re-run any time after editing a SKILL.md — symlinks mean changes apply immediately.
#
# NOTE: This script is provided for convenience. The skills are NOT installed until you
# run it. To use hal9000 as a Claude Code plugin instead, add this directory as a plugin.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_SRC="$REPO_DIR/skills"
SKILLS_DST="$HOME/.claude/skills"

mkdir -p "$SKILLS_DST"

for skill in "$SKILLS_SRC"/*/; do
  name="$(basename "$skill")"
  dst="$SKILLS_DST/$name"
  if [ -L "$dst" ] || [ -e "$dst" ]; then
    echo "↻ replacing $dst"
    rm -rf "$dst"
  fi
  ln -s "${skill%/}" "$dst"
  echo "✓ linked $name -> $dst"
done

echo
echo "Done. Skills installed:"
ls -1 "$SKILLS_DST" | sed 's/^/  - /'
echo
echo "Verify inside Claude Code with: /organize  /plan  /review  /followups  /add-todo"
