#!/usr/bin/env bash

SCRIPT="$SDLC_ROOT/scripts/util/openspec-enrich.js"
[ ! -f "$SCRIPT" ] && { echo "ERROR: Could not locate scripts/util/openspec-enrich.js. Is the sdlc plugin installed?" >&2; exit 2; }

PREPARE_OUTPUT_FILE=$(node "$SCRIPT" --output-file {REMOVE_FLAG} --project-root .)
EXIT_CODE=$?
echo "PREPARE_OUTPUT_FILE=$PREPARE_OUTPUT_FILE"
echo "EXIT_CODE=$EXIT_CODE"
