#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SDLC_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"

VP_SCRIPT="$SDLC_ROOT/scripts/skill/verify-pipeline.js"
[ ! -f "$VP_SCRIPT" ] && { echo "ERROR: Could not locate scripts/skill/verify-pipeline.js. Is the sdlc plugin installed?" >&2; exit 2; }
   [ -z "$VP_SCRIPT" ] && [ -f "plugins/sdlc-utilities/scripts/skill/verify-pipeline.js" ] && VP_SCRIPT="plugins/sdlc-utilities/scripts/skill/verify-pipeline.js"
   [ -z "$VP_SCRIPT" ] && { echo "ERROR: Could not locate skill/verify-pipeline.js. Is the sdlc plugin installed?" >&2; exit 2; }
