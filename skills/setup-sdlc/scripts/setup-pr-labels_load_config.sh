#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SDLC_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"

SCRIPT="$SDLC_ROOT/lib/config.js"
[ ! -f "$SCRIPT" ] && { echo "ERROR: Could not locate lib/config.js. Is the sdlc plugin installed?" >&2; exit 2; }
