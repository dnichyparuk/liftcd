#!/usr/bin/env bash

SCRIPT="$SDLC_ROOT/scripts/skill/plan.js"
[ ! -f "$SCRIPT" ] && { echo "ERROR: Could not locate scripts/skill/plan.js. Is the sdlc plugin installed?" >&2; exit 2; }

PLAN_OUTPUT_FILE=$(node "$SCRIPT" --output-file)
EXIT_CODE=$?
echo "PLAN_OUTPUT_FILE=$PLAN_OUTPUT_FILE"
echo "EXIT_CODE=$EXIT_CODE"
# Single canonical cleanup: trap fires unconditionally on EXIT/INT/TERM,
# so the manifest is removed even if plan generation is cancelled or errors out.
trap 'rm -f "$PLAN_OUTPUT_FILE"' EXIT INT TERM
