#!/usr/bin/env bash
# subagent installer — installs the CLI and the agent skill.
#   curl -fsSL https://raw.githubusercontent.com/kacperkwapisz/subagent/main/install.sh | bash
#
# Env overrides:
#   SUBAGENT_INSTALL_DIR  CLI install dir        (default: ~/.local/bin)
#   SUBAGENT_SKILL_DIR    skill install dir      (default: ~/.agents/skills)
#   SUBAGENT_NO_SKILL=1   skip installing the skill
#   SUBAGENT_REF          git ref to install from (default: main)

set -euo pipefail

REPO="kacperkwapisz/subagent"
REF="${SUBAGENT_REF:-main}"
BASE="https://raw.githubusercontent.com/$REPO/$REF"
INSTALL_DIR="${SUBAGENT_INSTALL_DIR:-$HOME/.local/bin}"
SKILL_DIR="${SUBAGENT_SKILL_DIR:-$HOME/.agents/skills}"

command -v curl >/dev/null || { echo "error: curl is required" >&2; exit 1; }

tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT

# CLI
echo "Downloading subagent ($REF)..."
curl -fsSL "$BASE/bin/subagent" -o "$tmp"
bash -n "$tmp" # sanity-check it's a valid script
mkdir -p "$INSTALL_DIR"
install -m 0755 "$tmp" "$INSTALL_DIR/subagent"
echo "Installed CLI    -> $INSTALL_DIR/subagent"

# Skill (model selection + delegation guidance for your agent)
if [[ "${SUBAGENT_NO_SKILL:-0}" != "1" ]]; then
  mkdir -p "$SKILL_DIR/subagent"
  curl -fsSL "$BASE/skills/subagent/SKILL.md" -o "$SKILL_DIR/subagent/SKILL.md"
  echo "Installed skill  -> $SKILL_DIR/subagent/SKILL.md"
fi

if ! command -v pi >/dev/null; then
  echo "note: 'pi' not found on PATH — subagent wraps the pi coding agent:"
  echo "      npm install -g @earendil-works/pi-coding-agent"
fi

case ":$PATH:" in
  *":$INSTALL_DIR:"*) ;;
  *) echo "note: $INSTALL_DIR is not on your PATH. Add:"
     echo "      export PATH=\"$INSTALL_DIR:\$PATH\"" ;;
esac

"$INSTALL_DIR/subagent" --version
echo
echo "Last step: add the snippet from $BASE/docs/AGENTS.md"
echo "to your global agent instructions (~/.pi/agent/AGENTS.md, ~/.claude/CLAUDE.md, ...)"
echo "so your agent knows to delegate."
