#!/usr/bin/env bash

SCRIPT="$SDLC_ROOT/scripts/skill/review.js"
[ ! -f "$SCRIPT" ] && { echo "ERROR: Could not locate scripts/skill/review.js. Is the sdlc plugin installed?" >&2; exit 2; }

MANIFEST_FILE=$(node "$SCRIPT" --output-file $ARGUMENTS --json)
EXIT_CODE=$?
echo "MANIFEST_FILE=$MANIFEST_FILE"
echo "EXIT_CODE=$EXIT_CODE"
# Single canonical cleanup: trap fires unconditionally on EXIT/INT/TERM, so
# the manifest is removed even if dispatch errors or the agent crashes.
trap 'rm -f "$MANIFEST_FILE"' EXIT INT TERM
