#!/usr/bin/env bash

HELPER="$SDLC_ROOT/scripts/skill/mcp-failure.js"
[ ! -f "$HELPER" ] && { echo "ERROR: Could not locate scripts/skill/mcp-failure.js. Is the sdlc plugin installed?" >&2; exit 2; }
[ -n "$HELPER" ] && node "$HELPER" --telemetry --class auth --tool "$MCP_TOOL_NAME" --site "$JIRA_SITE" --project "$PROJECT_KEY" --error "$AUTH_ERROR" --recovered no
