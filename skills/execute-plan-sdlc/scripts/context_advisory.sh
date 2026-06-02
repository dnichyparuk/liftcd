#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SDLC_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"

SCRIPT_DIR="$SDLC_ROOT/scripts/skill/config.js"
[ ! -f "$SCRIPT_DIR" ] && { echo "ERROR: Could not locate scripts/skill/config.js. Is the sdlc plugin installed?" >&2; exit 2; }
node -e "
const { readSection } = require('$SCRIPT_DIR/config.js');
try {
  const advisory = require('$SCRIPT_DIR/context-advisory.js').getAdvisory({ skill: 'execute-plan-sdlc' });
  if (advisory) process.stderr.write(advisory + '\n');
} catch (_) { /* helper missing or sidecar unreadable — silent */ }
const execute = readSection(process.cwd(), 'execute');
console.log(JSON.stringify(execute?.guardrails || []));
"
