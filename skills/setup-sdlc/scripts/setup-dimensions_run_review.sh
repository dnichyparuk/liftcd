#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SDLC_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"

PREP="$SDLC_ROOT/scripts/skill/review.js"
[ ! -f "$PREP" ] && { echo "ERROR: Could not locate scripts/skill/review.js. Is the LiftCD plugin installed?" >&2; exit 2; }
[ -z "$PREP" ] && [ -f "plugins/liftcd/scripts/skill/review.js" ] && PREP="plugins/liftcd/scripts/skill/review.js"
[ -n "$PREP" ] && node "$PREP" --project-root . --json 2>/dev/null
