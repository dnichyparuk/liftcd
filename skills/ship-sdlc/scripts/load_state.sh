#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SDLC_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"

SCRIPT="$SDLC_ROOT/scripts/state/ship.js"
[ ! -f "$SCRIPT" ] && { echo "ERROR: Could not locate scripts/state/ship.js. Is the sdlc plugin installed?" >&2; exit 2; }
[ -z "$SCRIPT" ] && [ -f "plugins/sdlc-utilities/scripts/state/ship.js" ] && SCRIPT="plugins/sdlc-utilities/scripts/state/ship.js"
