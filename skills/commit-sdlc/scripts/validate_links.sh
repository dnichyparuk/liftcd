#!/usr/bin/env bash

LINKS_LIB="$SDLC_ROOT/scripts/lib/links.js"
[ ! -f "$LINKS_LIB" ] && { echo "ERROR: Could not locate scripts/lib/links.js. Is the sdlc plugin installed?" >&2; exit 2; }
   [ -z "$LINKS_LIB" ] && [ -f "plugins/sdlc-utilities/scripts/lib/links.js" ] && LINKS_LIB="plugins/sdlc-utilities/scripts/lib/links.js"
   [ -z "$LINKS_LIB" ] && { echo "ERROR: Could not locate scripts/lib/links.js. Is the sdlc plugin installed?" >&2; exit 2; }
   printf '%s' "$message" | node "$LINKS_LIB" --json
   LINK_EXIT=$?
