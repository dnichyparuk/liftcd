#!/usr/bin/env bash

# Resolve SDLC_LIB once — used by all subsequent node -e heredocs in this section.
SDLC_LIB="$SDLC_ROOT/scripts/skill/config.js"
[ ! -f "$SDLC_LIB" ] && { echo "ERROR: Could not locate scripts/skill/config.js. Is the sdlc plugin installed?" >&2; exit 2; }

# R61: Resolve workspace mode — flag → config → fail-fast. No interactive prompt.
if [ -z "$WORKSPACE_MODE_FLAG" ]; then
  WORKSPACE_MODE=$(node -e "
    const {readSection,resolveSdlcRoot}=require('$SDLC_LIB/config');
    const ws=readSection(resolveSdlcRoot(),'workspace')||{};
    process.stdout.write(ws.mode||'');
  ")
else
  WORKSPACE_MODE="$WORKSPACE_MODE_FLAG"
fi
if [ -z "$WORKSPACE_MODE" ]; then
  echo "Error: workspace mode not set. Pass --workspace branch|worktree|continue or set workspace.mode in .sdlc/local.json." >&2
  exit 1
fi

# R62: Default-branch guard — reject --workspace continue on the repo default branch.
DEFAULT_BRANCH=$(git symbolic-ref --short refs/remotes/origin/HEAD 2>/dev/null | sed 's|^origin/||')
[ -z "$DEFAULT_BRANCH" ] && DEFAULT_BRANCH="main"
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" = "$DEFAULT_BRANCH" ] && [ "$WORKSPACE_MODE" = "continue" ]; then
  echo "Error: cannot ship on default branch '$DEFAULT_BRANCH'. Pass --workspace branch or --workspace worktree." >&2
  exit 1
fi
