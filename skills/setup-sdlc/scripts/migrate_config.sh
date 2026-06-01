#!/usr/bin/env bash

SCRIPT_DIR="$SDLC_ROOT/scripts/skill/config.js"
[ ! -f "$SCRIPT_DIR" ] && { echo "ERROR: Could not locate scripts/skill/config.js. Is the sdlc plugin installed?" >&2; exit 2; }

node -e "
const { migrateConfig } = require('$SCRIPT_DIR/config.js');
const result = migrateConfig(process.cwd());
console.log(JSON.stringify(result, null, 2));
"
