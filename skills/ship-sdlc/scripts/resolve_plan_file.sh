#!/usr/bin/env bash
[ -z "$1" ] && { echo "ERROR: No PREPARE_OUTPUT_FILE provided." >&2; exit 2; }
F="$1" node -e "const d=require('fs').readFileSync(process.env.F,'utf8'); process.stdout.write(JSON.parse(d).context.planFile||'')"
