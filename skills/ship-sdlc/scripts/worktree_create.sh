#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SDLC_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"

# Step 1: Derive branch name from plan title via lib/branch-name.js (config-driven).
#   Reads workspace.branch config (template, slugMaxLength, typeMap) via readSection.
#   Same helper used by execute-plan-sdlc standalone path — no duplication.
EXECUTE_BRANCH=$(node -e "
  const {resolveBranchName}=require('$SDLC_LIB/branch-name');
  const {readSection,resolveSdlcRoot}=require('$SDLC_LIB/config');
  const cfg=(readSection(resolveSdlcRoot(),'workspace')||{}).branch||{};
  // Logical type and slug derived from plan title (feature/bugfix/chore/docs/refactor).
  // typeMap in config maps logical → branch prefix (defaults: feat/fix/chore/docs/refactor).
  process.stdout.write(resolveBranchName({type:'<logical-type>',slug:'<derived-slug>',config:cfg}));
")

# Step 2: Pre-execute ship state migration (R37).
#   Runs in main worktree cwd — state/ship.js read still resolves OLD slug filename here.
#   BEFORE any branch creation (fixing #379: old post-execute block ran after cwd changed).
STATE_BRANCH=$(node "$SCRIPT" read 2>/dev/null | node -e "process.stdin.on('data',d=>{try{process.stdout.write(JSON.parse(d).branch||'')}catch(_){}})")
if [ -n "$STATE_BRANCH" ] && [ "$EXECUTE_BRANCH" != "$STATE_BRANCH" ]; then
  FROM_SLUG=$(echo "$STATE_BRANCH" | sed 's|[^a-zA-Z0-9-]|-|g')
  result=$(node "$SCRIPT" migrate --from "$FROM_SLUG" --to "$EXECUTE_BRANCH" 2>&1)
  echo "State migrated: $FROM_SLUG → $EXECUTE_BRANCH"
fi

# Step 3a: --workspace branch — simple git checkout, no cd needed (HEAD shared with main worktree).
if [ "$WORKSPACE_MODE" = "branch" ]; then
  git checkout "$EXECUTE_BRANCH" 2>/dev/null || git checkout -b "$EXECUTE_BRANCH"
fi

# Step 3b: --workspace worktree — create worktree+branch, cd in main shell.
if [ "$WORKSPACE_MODE" = "worktree" ]; then
WORKTREE_CREATE_SCRIPT="$SDLC_ROOT/scripts/util/worktree-create.js"
[ ! -f "$WORKTREE_CREATE_SCRIPT" ] && { echo "ERROR: Could not locate scripts/util/worktree-create.js. Is the sdlc plugin installed?" >&2; exit 2; }
  [ -z "$WORKTREE_CREATE_SCRIPT" ] && [ -f "plugins/sdlc-utilities/scripts/util/worktree-create.js" ] && WORKTREE_CREATE_SCRIPT="plugins/sdlc-utilities/scripts/util/worktree-create.js"
  [ -z "$WORKTREE_CREATE_SCRIPT" ] && { echo "ERROR: Could not locate scripts/util/worktree-create.js. Is the sdlc plugin installed?" >&2; exit 2; }
  result=$(node "$WORKTREE_CREATE_SCRIPT" --name "$EXECUTE_BRANCH")
  WORKTREE_PATH=$(echo "$result" | node -e "process.stdout.write(JSON.parse(require('fs').readFileSync('/dev/stdin','utf8')).path)")
  # worktree-create.js may collision-suffix; use the resolved branch name.
  EXECUTE_BRANCH=$(echo "$result" | node -e "process.stdout.write(JSON.parse(require('fs').readFileSync('/dev/stdin','utf8')).branch)")
  # Step 4: cd in main shell — Bash cwd persists; all subsequent dispatches inherit this path.
  cd "$WORKTREE_PATH"
fi
