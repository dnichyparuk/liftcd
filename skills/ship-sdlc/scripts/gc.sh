#!/usr/bin/env bash

SCRIPT="$SDLC_ROOT/scripts/skill/ship.js"
[ ! -f "$SCRIPT" ] && { echo "ERROR: Could not locate scripts/skill/ship.js. Is the sdlc plugin installed?" >&2; exit 2; }
[ -z "$SCRIPT" ] && [ -f "plugins/sdlc-utilities/scripts/skill/ship.js" ] && SCRIPT="plugins/sdlc-utilities/scripts/skill/ship.js"
PREPARE_OUTPUT_FILE=$(node "$SCRIPT" --output-file --gc)  # add --ttl-days <N> when provided
trap 'rm -f "$PREPARE_OUTPUT_FILE"' EXIT INT TERM
