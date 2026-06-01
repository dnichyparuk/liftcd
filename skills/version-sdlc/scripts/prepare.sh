#!/usr/bin/env bash

SCRIPT="$SDLC_ROOT/scripts/skill/version.js"
[ ! -f "$SCRIPT" ] && { echo "ERROR: Could not locate scripts/skill/version.js. Is the sdlc plugin installed?" >&2; exit 2; }

VERSION_CONTEXT_FILE=$(node "$SCRIPT" --output-file $ARGUMENTS)
EXIT_CODE=$?
# Single canonical cleanup: trap fires unconditionally on EXIT/INT/TERM, so
# the manifest is removed even if the release is cancelled or errors out.
trap 'rm -f "$VERSION_CONTEXT_FILE"' EXIT INT TERM
