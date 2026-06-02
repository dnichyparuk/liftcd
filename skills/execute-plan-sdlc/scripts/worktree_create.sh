#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SDLC_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"

SCRIPT="$SDLC_ROOT/scripts/util/worktree-create.js"
[ ! -f "$SCRIPT" ] && { echo "ERROR: Could not locate scripts/util/worktree-create.js. Is the sdlc plugin installed?" >&2; exit 2; }
     [ -z "$SCRIPT" ] && [ -f "plugins/sdlc-utilities/scripts/util/worktree-create.js" ] && SCRIPT="plugins/sdlc-utilities/scripts/util/worktree-create.js"
     result=$(node "$SCRIPT" --name "$EXECUTE_NEW_BRANCH")
     WORKTREE_PATH=$(echo "$result" | node -e "process.stdout.write(JSON.parse(require('fs').readFileSync('/dev/stdin','utf8')).path)")
     # worktree-create.js may collision-suffix; refresh EXECUTE_NEW_BRANCH with resolved name.
     EXECUTE_NEW_BRANCH=$(echo "$result" | node -e "process.stdout.write(JSON.parse(require('fs').readFileSync('/dev/stdin','utf8')).branch)")
     cd "$WORKTREE_PATH"
