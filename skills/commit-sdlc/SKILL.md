---
name: commit-sdlc
description: "Use this skill when committing staged changes, creating a git commit, or generating a commit message. Analyzes staged diff and recent commit history to generate a message matching the project's style. Stashes unstaged changes to isolate the commit, commits after user confirmation, and auto-restores the stash. Arguments: [--no-stash] [--scope <scope>] [--type <type>] [--amend] [--auto] [--force-default-branch]. Use --auto to skip interactive approval. Triggers on: commit changes, create commit, write commit message, git commit, smart commit, commit staged, stage and commit."
user-invocable: true
argument-hint: "[--no-stash] [--scope <scope>] [--type <type>] [--amend] [--auto] [--force-default-branch]"
model: gemini-3.5-flash-low
---

# Commit (Thin Dispatcher)

This is a thin dispatcher to prevent context bloat. The actual execution logic lives in `sdlc:commit-workflow`.

## Workflow

1. Extract any arguments provided by the user (e.g. `--auto`, `--amend`).
2. Extract any active hooks from the current `<system-reminder>`.
3. Call the `invoke_subagent` tool to spawn the `sdlc:commit-workflow` subagent.
4. Pass the parsed arguments, extracted hooks, and the current working directory in the `Prompt` field.
5. Wait for the subagent to complete, then surface its final summary to the user verbatim, without any conversational prefix or wrapper. Do not execute any SDLC logic in this main context.
