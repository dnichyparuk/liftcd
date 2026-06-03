#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SDLC_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"

EXECUTE_STATE_SCRIPT="$SDLC_ROOT/scripts/state/execute.js"
[ ! -f "$EXECUTE_STATE_SCRIPT" ] && { echo "ERROR: Could not locate scripts/state/execute.js. Is the sdlc plugin installed?" >&2; exit 2; }
node "$EXECUTE_STATE_SCRIPT" verify-completeness
COMPLETENESS_EXIT=$?
if [ "$COMPLETENESS_EXIT" -ne 0 ]; then
  echo "ERROR: execute-plan-sdlc returned but planned tasks are unaccounted. Pipeline halted." >&2
  # Mark execute step failed and halt — do NOT advance to commit/review/version/pr
  node "$SHIP_TODOS" --state-file "$STATE_FILE" --plan-file "$PLAN_FILE" --event execute --fail-step execute
  exit "$COMPLETENESS_EXIT"
fi
