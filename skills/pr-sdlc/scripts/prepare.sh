#!/usr/bin/env bash

SCRIPT="$SDLC_ROOT/scripts/skill/pr.js"
[ ! -f "$SCRIPT" ] && { echo "ERROR: Could not locate scripts/skill/pr.js. Is the sdlc plugin installed?" >&2; exit 2; }

PR_CONTEXT_FILE=$(node "$SCRIPT" --output-file $ARGUMENTS)
EXIT_CODE=$?
# Single canonical cleanup: trap fires unconditionally on EXIT/INT/TERM, so
# the manifest is removed even if a PR creation/update path errors out.
trap 'rm -f "$PR_CONTEXT_FILE"' EXIT INT TERM
