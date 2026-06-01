#!/usr/bin/env bash

LIB="$SDLC_ROOT/scripts/lib/openspec.js"
[ ! -f "$LIB" ] && { echo "ERROR: Could not locate scripts/lib/openspec.js. Is the sdlc plugin installed?" >&2; exit 2; }
     [ -z "$LIB" ] && [ -f "plugins/sdlc-utilities/scripts/lib/openspec.js" ] && LIB="plugins/sdlc-utilities/scripts/lib/openspec.js"
     [ -z "$LIB" ] && { echo "ERROR: Could not locate openspec.js. Is the sdlc plugin installed?" >&2; exit 2; }
     # Pass arguments as env vars to avoid shell injection from LLM-generated task titles
     # (titles may contain ", `, $(...), or newlines that would break inline interpolation).
     OPENSPEC_LIB="$LIB" \
     OPENSPEC_CHANGE='<change>' \
     OPENSPEC_REF='<ref>' \
     OPENSPEC_LINE='<line>' \
     OPENSPEC_TITLE='<title>' \
     node -e "
     const { markTaskDone } = require(process.env.OPENSPEC_LIB);
     const line = process.env.OPENSPEC_LINE ? Number(process.env.OPENSPEC_LINE) : undefined;
     const r = markTaskDone(process.env.OPENSPEC_CHANGE, process.env.OPENSPEC_REF, { line, title: process.env.OPENSPEC_TITLE });
     console.log(JSON.stringify(r));
     "
