#!/usr/bin/env bash

SCRIPT="$SDLC_ROOT/scripts/skill/harden-prepare.js"
[ ! -f "$SCRIPT" ] && { echo "ERROR: Could not locate scripts/skill/harden-prepare.js. Is the sdlc plugin installed?" >&2; exit 2; }

MANIFEST_FILE=$(node "$SCRIPT" \
  ${FAILURE_TEXT:+--failure-text "$FAILURE_TEXT"} \
  ${FROM_ISSUE:+--from-issue "$FROM_ISSUE"} \
  --skill "$SKILL_NAME" \
  --step "$STEP_NAME" \
  --operation "$OPERATION" \
  --exit-code "$EXIT_CODE_ARG" \
  --error-type "$ERROR_TYPE" \
  --user-intent "$USER_INTENT" \
  --args-string "$ARGS_STRING" \
  --output-file)
EXIT_CODE_PREPARE=$?
echo "MANIFEST_FILE=$MANIFEST_FILE"
echo "EXIT_CODE=$EXIT_CODE_PREPARE"
# Single canonical cleanup: trap fires only when MANIFEST_FILE was written so
# we do not attempt `rm -f ""` on a failed script invocation.
trap '[ -n "$MANIFEST_FILE" ] && rm -f "$MANIFEST_FILE"' EXIT INT TERM
