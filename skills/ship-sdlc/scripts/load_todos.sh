#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SDLC_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"

SHIP_TODOS="$SDLC_ROOT/scripts/lib/ship-todos.js"
[ ! -f "$SHIP_TODOS" ] && { echo "ERROR: Could not locate scripts/lib/ship-todos.js. Is the sdlc plugin installed?" >&2; exit 2; }
