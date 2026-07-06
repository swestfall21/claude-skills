#!/usr/bin/env bash
# SessionStart hook: inject fable-mode into every session automatically,
# so nobody has to remember to type /fable-mode.
#
# Stdout from a SessionStart hook is added to Claude's context.
# Set FABLE_SKILL_PATH if your skills live somewhere other than ~/.claude/skills.

SKILL="${FABLE_SKILL_PATH:-$HOME/.claude/skills/fable-mode/SKILL.md}"

if [ -f "$SKILL" ]; then
  echo "The following working-style profile is active for this session:"
  echo
  # strip the YAML frontmatter, emit the skill body
  awk 'f; /^---$/ && ++c == 2 {f=1}' "$SKILL"
fi
