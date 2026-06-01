#!/usr/bin/env bash

ERR_FILE=$(mktemp)
gh pr create --title "<title>" --body "<body>" [--draft] [--label ...] 2> "$ERR_FILE"
GH_EXIT=$?
if [ "$GH_EXIT" -ne 0 ]; then
RECOVER_SCRIPT="$SDLC_ROOT/scripts/skill/pr-recover-gh-account.js"
[ ! -f "$RECOVER_SCRIPT" ] && { echo "ERROR: Could not locate scripts/skill/pr-recover-gh-account.js. Is the sdlc plugin installed?" >&2; exit 2; }
  [ -z "$RECOVER_SCRIPT" ] && [ -f "plugins/sdlc-utilities/scripts/skill/pr-recover-gh-account.js" ] && RECOVER_SCRIPT="plugins/sdlc-utilities/scripts/skill/pr-recover-gh-account.js"
  if [ -n "$RECOVER_SCRIPT" ]; then
    RECOVER_JSON=$(node "$RECOVER_SCRIPT" --error-file "$ERR_FILE")
  else
    echo "Warning: pr-recover-gh-account.js not found — skipping account-switch recovery"
  fi
fi
rm -f "$ERR_FILE"
