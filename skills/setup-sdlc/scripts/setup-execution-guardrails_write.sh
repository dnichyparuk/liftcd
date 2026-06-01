#!/usr/bin/env bash

SCRIPT_DIR="$SDLC_ROOT/lib"
[ ! -f "$SCRIPT_DIR" ] && { echo "ERROR: Could not locate lib. Is the sdlc plugin installed?" >&2; exit 2; }

node -e "
const { writeSection } = require('$SCRIPT_DIR/config.js');
const guardrails = JSON.parse(process.argv[1]);
writeSection(process.cwd(), 'execute', { guardrails });
console.log('Wrote ' + guardrails.length + ' execution guardrails to .sdlc/config.json');
" '<GUARDRAILS_JSON>'
