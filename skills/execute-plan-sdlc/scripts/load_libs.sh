#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SDLC_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"

SDLC_LIB="$SDLC_ROOT/scripts/lib"
[ ! -f "$SDLC_LIB" ] && { echo "ERROR: Could not locate scripts/lib. Is the sdlc plugin installed?" >&2; exit 2; }
     [ -z "$SDLC_LIB" ] && [ -f "plugins/sdlc-utilities/scripts/lib/branch-name.js" ] && SDLC_LIB="plugins/sdlc-utilities/scripts/lib"
SDLC_LIB_CONFIG="$SDLC_ROOT/scripts/lib"
[ ! -f "$SDLC_LIB_CONFIG" ] && { echo "ERROR: Could not locate scripts/lib. Is the sdlc plugin installed?" >&2; exit 2; }
     [ -z "$SDLC_LIB_CONFIG" ] && SDLC_LIB_CONFIG="$SDLC_LIB"
     EXECUTE_NEW_BRANCH=$(node -e "
       const {resolveBranchName}=require('$SDLC_LIB/branch-name');
       const {readSection,resolveSdlcRoot}=require('$SDLC_LIB_CONFIG/config');
       const cfg=(readSection(resolveSdlcRoot(),'workspace')||{}).branch||{};
       // Map plan nature to logical type (feature/bugfix/chore/docs/refactor).
       // typeMap in config translates logical type to branch prefix (defaults: feat/fix/chore/docs/refactor).
       process.stdout.write(resolveBranchName({type:'<logical-type>',slug:'<derived-slug>',config:cfg}));
     ")
