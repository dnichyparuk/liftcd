#!/usr/bin/env bash

SCRIPT="$SDLC_ROOT/scripts/skill/plan.js"
[ ! -f "$SCRIPT" ] && { echo "ERROR: Could not locate scripts/skill/plan.js. Is the sdlc plugin installed?" >&2; exit 2; }
[ -z "$SCRIPT" ] && [ -f "plugins/sdlc-utilities/scripts/skill/plan.js" ] && SCRIPT="plugins/sdlc-utilities/scripts/skill/plan.js"
# writes planIntegrity marker consumed by stop-plan-integrity Stop hook (issue #285)
[ -n "$SCRIPT" ] && node "$SCRIPT" --mark critiqueRan 2>/dev/null || true
