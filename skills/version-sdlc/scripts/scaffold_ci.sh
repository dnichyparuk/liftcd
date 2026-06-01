#!/usr/bin/env bash

SCRIPT="$SDLC_ROOT/scripts/skill/scaffold-ci.js"
[ ! -f "$SCRIPT" ] && { echo "ERROR: Could not locate scripts/skill/scaffold-ci.js. Is the sdlc plugin installed?" >&2; exit 2; }
