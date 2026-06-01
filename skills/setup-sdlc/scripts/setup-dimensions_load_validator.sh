#!/usr/bin/env bash

SCRIPT="$SDLC_ROOT/scripts/ci/validate-dimensions.js"
[ ! -f "$SCRIPT" ] && { echo "ERROR: Could not locate scripts/ci/validate-dimensions.js. Is the sdlc plugin installed?" >&2; exit 2; }
  [ -z "$SCRIPT" ] && [ -f "plugins/sdlc-utilities/scripts/ci/validate-dimensions.js" ] && SCRIPT="plugins/sdlc-utilities/scripts/ci/validate-dimensions.js"
