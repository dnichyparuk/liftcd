#!/usr/bin/env bash

SCRIPT="$SDLC_ROOT/scripts/skill/jira.js"
[ ! -f "$SCRIPT" ] && { echo "ERROR: Could not locate scripts/skill/jira.js. Is the sdlc plugin installed?" >&2; exit 2; }

JIRA_CONTEXT_FILE=$(node "$SCRIPT" --output-file $ARGUMENTS --check)
EXIT_CODE=$?
# Single canonical cleanup: trap fires unconditionally on EXIT/INT/TERM.
trap 'rm -f "$JIRA_CONTEXT_FILE"' EXIT INT TERM
