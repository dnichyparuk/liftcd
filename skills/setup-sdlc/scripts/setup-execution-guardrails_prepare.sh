#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SDLC_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"

SCRIPT="$SDLC_ROOT/scripts/skill/guardrails.js"
[ ! -f "$SCRIPT" ] && { echo "ERROR: Could not locate scripts/skill/guardrails.js. Is the sdlc plugin installed?" >&2; exit 2; }

PREPARE_OUTPUT_FILE=$(node "$SCRIPT" --output-file --project-root . --target execute --mode {init|add} --json)
EXIT_CODE=$?
cat "$PREPARE_OUTPUT_FILE"
rm -f "$PREPARE_OUTPUT_FILE"

echo "EXIT_CODE: $EXIT_CODE"