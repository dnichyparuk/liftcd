#!/usr/bin/env bash

HELPER="$SDLC_ROOT/scripts/skill/mcp-failure.js"
[ ! -f "$HELPER" ] && { echo "ERROR: Could not locate scripts/skill/mcp-failure.js. Is the sdlc plugin installed?" >&2; exit 2; }
HOOK_HASH=$(echo -n "$permissionDecisionReason" | sha256sum | cut -c1-12)
[ -n "$HELPER" ] && node "$HELPER" --telemetry --class hook-block --tool "$MCP_TOOL_NAME" --site "$JIRA_SITE" --project "$PROJECT_KEY" --error "$permissionDecisionReason" --recovered no
[ -n "$HELPER" ] && HOOK_COUNT=$(node "$HELPER" --record-occurrence --class hook-block --key "$HOOK_HASH")
