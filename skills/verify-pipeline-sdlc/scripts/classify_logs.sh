#!/usr/bin/env bash

CLASSIFY_SCRIPT="$SDLC_ROOT/scripts/skill/verify-pipeline-sdlc-classify.js"
[ ! -f "$CLASSIFY_SCRIPT" ] && { echo "ERROR: Could not locate scripts/skill/verify-pipeline-sdlc-classify.js. Is the sdlc plugin installed?" >&2; exit 2; }
echo "$LOGS" | node "$CLASSIFY_SCRIPT"
