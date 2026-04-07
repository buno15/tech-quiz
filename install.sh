#!/usr/bin/env bash
set -euo pipefail

DEST="$HOME/.claude"
TECHQUIZ_DIR="$DEST/techquiz"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

GREEN='\033[0;32m'
DIM='\033[2m'
NC='\033[0m'

ok()   { echo -e "  ${GREEN}✓${NC} $1"; }
skip() { echo -e "  ${DIM}-${NC} $1"; }

echo ""
echo "Installing TechQuiz..."
echo ""

# ── Command ──────────────────────────────────────────────
mkdir -p "$DEST/commands"
cp "$SCRIPT_DIR/.claude/commands/techquiz.md" "$DEST/commands/techquiz.md"
ok "Command registered  →  ~/.claude/commands/techquiz.md"

# ── Prompts ───────────────────────────────────────────────
mkdir -p "$TECHQUIZ_DIR/prompts"
cp "$SCRIPT_DIR/prompts/"*.md "$TECHQUIZ_DIR/prompts/"
ok "Prompts installed   →  ~/.claude/techquiz/prompts/"

# ── Config (skip if already configured) ───────────────────
mkdir -p "$TECHQUIZ_DIR/config"
if [ ! -f "$TECHQUIZ_DIR/config/profile.yml" ]; then
  cp "$SCRIPT_DIR/config/profile.yml.example" "$TECHQUIZ_DIR/config/profile.yml"
  ok "Config created      →  ~/.claude/techquiz/config/profile.yml"
else
  skip "Config already exists — skipping (edit ~/.claude/techquiz/config/profile.yml to change settings)"
fi

# ── History (initialize if fresh install) ─────────────────
mkdir -p "$TECHQUIZ_DIR/history/sessions"
if [ ! -f "$TECHQUIZ_DIR/history/index.md" ]; then
  printf "# TechQuiz Question History\n" > "$TECHQUIZ_DIR/history/index.md"
  ok "History initialized →  ~/.claude/techquiz/history/"
else
  skip "History already exists — keeping your progress"
fi

echo ""
echo "Done! Open any project in Claude Code and run:"
echo ""
echo "  /techquiz <category> <level 1-10>"
echo "  /techquiz review"
echo "  /techquiz project <level>"
echo ""
