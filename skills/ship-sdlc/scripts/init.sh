#!/usr/bin/env bash

SCRIPT="$SDLC_ROOT/scripts/skill/ship-init.js"
[ ! -f "$SCRIPT" ] && { echo "ERROR: Could not locate scripts/skill/ship-init.js. Is the sdlc plugin installed?" >&2; exit 2; }

INIT_OUTPUT_FILE=$(node "$SCRIPT" --output-file --steps execute,commit,review,archive-openspec,pr --bump patch --auto --threshold high --workspace prompt)
EXIT_CODE=$?
echo "INIT_OUTPUT_FILE=$INIT_OUTPUT_FILE"
echo "EXIT_CODE=$EXIT_CODE"
# Single canonical cleanup: trap fires unconditionally on EXIT/INT/TERM.
trap 'rm -f "$INIT_OUTPUT_FILE"' EXIT INT TERM
