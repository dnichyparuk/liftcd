---
name: review-sdlc
description: "Use this skill when reviewing code changes across project-defined dimensions (security, performance, docs, concurrency, etc.). Runs skill/review.js to pre-compute all git data, then delegates to the review-orchestrator agent. Arguments: [--base <branch>] [--committed] [--staged] [--working] [--worktree] [--set-default] [--dimensions <name,...>] [--dry-run]. Triggers on: review changes, code review, review PR, multi-dimension review, run review."
user-invocable: true
argument-hint: "[--base <branch>] [--committed] [--staged] [--working] [--worktree] [--set-default] [--dimensions <name,...>] [--dry-run]"
model: gemini-3.5-flash-low
---

# Review (Thin Dispatcher)

This is a thin dispatcher to prevent context bloat. The actual execution logic lives in `lift_sdlc_review_workflow`.

## Workflow

1. Extract any arguments provided by the user (e.g. `--base`, `--committed`).
2. Extract any active hooks from the current `<system-reminder>`.
3. Call the `invoke_subagent` tool to spawn the `sdlc:review-workflow` subagent.
4. Pass the parsed arguments, extracted hooks, and the current working directory in the `Prompt` field.
5. Wait for the subagent to complete, then surface its final summary to the user verbatim, without any conversational prefix or wrapper. Do not execute any SDLC logic in this main context.
