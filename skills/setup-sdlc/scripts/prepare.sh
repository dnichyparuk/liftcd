#!/usr/bin/env bash

SCRIPT="$SDLC_ROOT/scripts/skill/setup.js"
[ ! -f "$SCRIPT" ] && { echo "ERROR: Could not locate scripts/skill/setup.js. Is the sdlc plugin installed?" >&2; exit 2; }

PREPARE_OUTPUT_FILE=$(node "$SCRIPT" --output-file $ARGUMENTS)
EXIT_CODE=$?
echo "PREPARE_OUTPUT_FILE=$PREPARE_OUTPUT_FILE"
echo "EXIT_CODE=$EXIT_CODE"
