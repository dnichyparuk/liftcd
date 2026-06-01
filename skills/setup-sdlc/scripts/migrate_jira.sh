#!/usr/bin/env bash

SHIM="$SDLC_ROOT/scripts/skill/migrate-jira-templates.js"
[ ! -f "$SHIM" ] && { echo "ERROR: Could not locate scripts/skill/migrate-jira-templates.js. Is the sdlc plugin installed?" >&2; exit 2; }
[ -z "$SHIM" ] && [ -f "plugins/sdlc-utilities/scripts/skill/migrate-jira-templates.js" ] && SHIM="plugins/sdlc-utilities/scripts/skill/migrate-jira-templates.js"
[ -n "$SHIM" ] && node "$SHIM" && echo "Jira templates migration complete" || echo "Jira templates migration: skipped or not found"
