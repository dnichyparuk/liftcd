#!/usr/bin/env bash

SCRIPT="$SDLC_ROOT/lib/config.js"
[ ! -f "$SCRIPT" ] && { echo "ERROR: Could not locate lib/config.js. Is the sdlc plugin installed?" >&2; exit 2; }
