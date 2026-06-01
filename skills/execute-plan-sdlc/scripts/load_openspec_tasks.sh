#!/usr/bin/env bash

LIB="$SDLC_ROOT/scripts/lib/openspec.js"
[ ! -f "$LIB" ] && { echo "ERROR: Could not locate scripts/lib/openspec.js. Is the sdlc plugin installed?" >&2; exit 2; }
     [ -z "$LIB" ] && [ -f "plugins/sdlc-utilities/scripts/lib/openspec.js" ] && LIB="plugins/sdlc-utilities/scripts/lib/openspec.js"
     [ -z "$LIB" ] && { echo "ERROR: Could not locate openspec.js. Is the sdlc plugin installed?" >&2; exit 2; }
     OPENSPEC_LIB="$LIB" \
     OPENSPEC_TASKS_PATH="openspec/changes/<name>/tasks.md" \
     node -e "
     const fs = require('fs');
     const { parseTasks } = require(process.env.OPENSPEC_LIB);
     const content = fs.readFileSync(process.env.OPENSPEC_TASKS_PATH, 'utf8');
     console.log(JSON.stringify(parseTasks(content)));
     "
