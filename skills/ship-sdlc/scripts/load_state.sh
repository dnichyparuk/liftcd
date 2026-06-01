#!/usr/bin/env bash

SCRIPT="$SDLC_ROOT/scripts/state/ship.js"
[ ! -f "$SCRIPT" ] && { echo "ERROR: Could not locate scripts/state/ship.js. Is the sdlc plugin installed?" >&2; exit 2; }
[ -z "$SCRIPT" ] && [ -f "plugins/sdlc-utilities/scripts/state/ship.js" ] && SCRIPT="plugins/sdlc-utilities/scripts/state/ship.js"
