#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SDLC_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"

STATE_SCRIPT="$SDLC_ROOT/scripts/state/execute.js"
[ ! -f "$STATE_SCRIPT" ] && { echo "ERROR: Could not locate scripts/state/execute.js. Is the sdlc plugin installed?" >&2; exit 2; }
[ -z "$STATE_SCRIPT" ] && [ -f "plugins/sdlc-utilities/scripts/state/execute.js" ] && STATE_SCRIPT="plugins/sdlc-utilities/scripts/state/execute.js"
