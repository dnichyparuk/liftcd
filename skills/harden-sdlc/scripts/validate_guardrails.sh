#!/usr/bin/env bash

# resolve_script is sourced once at Step 1; re-source here if running in a fresh shell block
VALIDATOR="$SDLC_ROOT/scripts/ci/validate-guardrails.js"
[ ! -f "$VALIDATOR" ] && { echo "ERROR: Could not locate scripts/ci/validate-guardrails.js. Is the sdlc plugin installed?" >&2; exit 2; }
