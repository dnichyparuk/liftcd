#!/usr/bin/env bash
[ -z "$1" ] && { echo "ERROR: No PREPARE_OUTPUT_FILE provided." >&2; exit 2; }
F="$1"
WORKSPACE_MODE="$2"

REQUIRE_MAIN_CWD=$(F="$F" node -e "const d=JSON.parse(require('fs').readFileSync(process.env.F,'utf8'));process.stdout.write(String((d.assertions&&d.assertions.requireMainWorktreeCwd)===true))")
EXPECTED_ROOT=$(F="$F" node -e "const d=JSON.parse(require('fs').readFileSync(process.env.F,'utf8'));process.stdout.write((d.assertions&&d.assertions.expectedMainWorktreeRoot)||'')")

if [ "$REQUIRE_MAIN_CWD" = "true" ] && [ -n "$EXPECTED_ROOT" ]; then
  ACTUAL_CWD=$(git rev-parse --show-toplevel 2>/dev/null)
  if [ "$ACTUAL_CWD" != "$EXPECTED_ROOT" ]; then
    echo "ERROR: ship-sdlc cwd assertion failed (R65, #405)." >&2
    echo "  actual cwd:    $ACTUAL_CWD" >&2
    echo "  expected root: $EXPECTED_ROOT" >&2
    echo "  ship.workspace: $WORKSPACE_MODE" >&2
    echo "  git worktree list --porcelain:" >&2
    git worktree list --porcelain | sed 's/^/    /' >&2
    echo "" >&2
    echo "ship-sdlc was launched from inside a linked worktree but workspace mode is 'branch'." >&2
    echo "Re-run from the main worktree root, or pass --workspace worktree." >&2
    exit 1
  fi
fi
