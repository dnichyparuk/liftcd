#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SDLC_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"

SCRIPT_DIR="$SDLC_ROOT/lib"
[ ! -f "$SCRIPT_DIR" ] && { echo "ERROR: Could not locate lib. Is the sdlc plugin installed?" >&2; exit 2; }

node -e "
const { writeSection } = require('$SCRIPT_DIR/config.js');
const guardrails = JSON.parse(process.argv[1]);
writeSection(process.cwd(), 'plan', { guardrails });
console.log('Wrote ' + guardrails.length + ' guardrails to .sdlc/config.json');
" '<GUARDRAILS_JSON>'
