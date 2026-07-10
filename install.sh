#!/usr/bin/env bash
# subagent installer
#   curl -fsSL https://raw.githubusercontent.com/kacperkwapisz/subagent/main/install.sh | bash
#
# Env overrides:
#   SUBAGENT_INSTALL_DIR  install directory (default: ~/.local/bin)
#   SUBAGENT_REF          git ref to install from (default: main)

set -euo pipefail

REPO="kacperkwapisz/subagent"
REF="${SUBAGENT_REF:-main}"
INSTALL_DIR="${SUBAGENT_INSTALL_DIR:-$HOME/.local/bin}"
URL="https://raw.githubusercontent.com/$REPO/$REF/bin/subagent"

command -v curl >/dev/null || { echo "error: curl is required" >&2; exit 1; }

mkdir -p "$INSTALL_DIR"
tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT

echo "Downloading subagent ($REF)..."
curl -fsSL "$URL" -o "$tmp"
bash -n "$tmp" # sanity-check it's a valid script
install -m 0755 "$tmp" "$INSTALL_DIR/subagent"

echo "Installed to $INSTALL_DIR/subagent"

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
