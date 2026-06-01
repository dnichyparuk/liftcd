#!/usr/bin/env bash

LINKS_LIB="$SDLC_ROOT/scripts/lib/links.js"
[ ! -f "$LINKS_LIB" ] && { echo "ERROR: Could not locate scripts/lib/links.js. Is the sdlc plugin installed?" >&2; exit 2; }
node "$LINKS_LIB" --file "$plan_path" --json
LINK_EXIT=$?
