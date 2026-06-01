#!/usr/bin/env bash

SCRIPT="$SDLC_ROOT/scripts/skill/received-review.js"
[ ! -f "$SCRIPT" ] && { echo "ERROR: Could not locate scripts/skill/received-review.js. Is the sdlc plugin installed?" >&2; exit 2; }

if [ -n "$SCRIPT" ]; then
  MANIFEST_FILE=$(node "$SCRIPT" --output-file $ARGUMENTS --pr <PR_NUMBER>)
  EXIT_CODE=$?
  echo "MANIFEST_FILE=$MANIFEST_FILE"
  echo "EXIT_CODE=$EXIT_CODE"
  # Single canonical cleanup: trap fires unconditionally on EXIT/INT/TERM.
  trap 'rm -f "$MANIFEST_FILE"' EXIT INT TERM
fi
