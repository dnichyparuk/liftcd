#!/usr/bin/env bash

SCRIPT="$SDLC_ROOT/scripts/skill/plan-handoff-advisory.js"
[ ! -f "$SCRIPT" ] && { echo "ERROR: Could not locate scripts/skill/plan-handoff-advisory.js. Is the sdlc plugin installed?" >&2; exit 2; }
[ -z "$SCRIPT" ] && [ -f "plugins/sdlc-utilities/scripts/skill/plan-handoff-advisory.js" ] && SCRIPT="plugins/sdlc-utilities/scripts/skill/plan-handoff-advisory.js"
[ -n "$SCRIPT" ] && node "$SCRIPT"
