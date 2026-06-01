#!/usr/bin/env bash

AR_SCRIPT="$SDLC_ROOT/scripts/skill/await-remote-review.js"
[ ! -f "$AR_SCRIPT" ] && { echo "ERROR: Could not locate scripts/skill/await-remote-review.js. Is the sdlc plugin installed?" >&2; exit 2; }
   [ -z "$AR_SCRIPT" ] && [ -f "plugins/sdlc-utilities/scripts/skill/await-remote-review.js" ] && AR_SCRIPT="plugins/sdlc-utilities/scripts/skill/await-remote-review.js"
   [ -z "$AR_SCRIPT" ] && { echo "ERROR: Could not locate skill/await-remote-review.js. Is the sdlc plugin installed?" >&2; exit 2; }
