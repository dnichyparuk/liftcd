#!/usr/bin/env bash

HELPER="$SDLC_ROOT/scripts/skill/mcp-failure.js"
[ ! -f "$HELPER" ] && { echo "ERROR: Could not locate scripts/skill/mcp-failure.js. Is the sdlc plugin installed?" >&2; exit 2; }
FAILURE_CLASS=schema  # or "workflow" for transition errors
[ -n "$HELPER" ] && node "$HELPER" --telemetry --class "$FAILURE_CLASS" --tool "$MCP_TOOL_NAME" --site "$JIRA_SITE" --project "$PROJECT_KEY" --error "$ERROR_MSG" --recovered no
[ -n "$HELPER" ] && ANALYZE_JSON=$(node "$HELPER" --analyze --class "$FAILURE_CLASS" --tool "$MCP_TOOL_NAME" --site "$JIRA_SITE" --project "$PROJECT_KEY" --error "$ERROR_MSG" --recovered no --r-path R9)
