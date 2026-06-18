#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SDLC_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"

SCRIPT="$SDLC_ROOT/scripts/ci/validate-dimensions.js"
[ ! -f "$SCRIPT" ] && { echo "ERROR: Could not locate scripts/ci/validate-dimensions.js. Is the LiftCD plugin installed?" >&2; exit 2; }
  [ -z "$SCRIPT" ] && [ -f "plugins/liftcd/scripts/ci/validate-dimensions.js" ] && SCRIPT="plugins/liftcd/scripts/ci/validate-dimensions.js"
