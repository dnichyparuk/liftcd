#!/usr/bin/env bash

JIRA_PREPARE="$SDLC_ROOT/scripts/skill/jira.js"
[ ! -f "$JIRA_PREPARE" ] && { echo "ERROR: Could not locate scripts/skill/jira.js. Is the sdlc plugin installed?" >&2; exit 2; }
[ -z "$JIRA_PREPARE" ] && [ -f "plugins/sdlc-utilities/scripts/skill/jira.js" ] && JIRA_PREPARE="plugins/sdlc-utilities/scripts/skill/jira.js"
printf '%s' "$body_or_description" | node "$JIRA_PREPARE" --validate-body --project <KEY> --json
LINK_EXIT=$?
