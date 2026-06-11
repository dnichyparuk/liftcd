#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SDLC_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"

SDLC_LIB="$SDLC_ROOT/scripts/lib"
[ ! -f "$SDLC_LIB/config.js" ] && { echo "ERROR: Could not locate scripts/lib/config.js. Is the sdlc plugin installed?" >&2; exit 2; }

node -e "
const { migrateConfig } = require('$SDLC_LIB/config.js');
const result = migrateConfig(process.cwd());
console.log(JSON.stringify(result, null, 2));
"
