#!/usr/bin/env bash

SHIP_TODOS="$SDLC_ROOT/scripts/skill/ship-todos.js"
[ ! -f "$SHIP_TODOS" ] && { echo "ERROR: Could not locate scripts/skill/ship-todos.js. Is the sdlc plugin installed?" >&2; exit 2; }
