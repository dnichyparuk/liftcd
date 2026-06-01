#!/usr/bin/env bash

SCRIPT="$SDLC_ROOT/scripts/ci/validate-pr-template.js"
[ ! -f "$SCRIPT" ] && { echo "ERROR: Could not locate scripts/ci/validate-pr-template.js. Is the sdlc plugin installed?" >&2; exit 2; }
node "$SCRIPT" --project-root .
EXIT_CODE=$?
