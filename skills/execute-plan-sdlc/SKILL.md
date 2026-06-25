---
name: execute-plan-sdlc
description: "Use when the user wants to execute an implementation plan with adaptive intelligence — classifies tasks by complexity and risk, builds optimized dependency waves, critiques wave structure before dispatch, verifies results after each wave, and recovers from failures without stopping. Self-contained: no external sub-skills required. Triggers on: execute plan, run plan, implement plan, autonomous execution, execute this plan. Also auto-triggered when the user accepts a plan from plan-sdlc (plan content is already in conversation context)."
user-invocable: true
argument-hint: "[plan-file-path] [--quality full|balanced|minimal] [--resume] [--workspace branch|worktree|prompt] [--rebase auto|skip|prompt] [--auto] [--branch <name>] [--commit-waves] [--plan-file <path>]"
model: gemini-3.5-flash-low
---

# Execute Plan (Thin Dispatcher)

This is a thin dispatcher to prevent context bloat. The actual execution logic lives in `sdlc:execute-plan-workflow`.

## Workflow

1. Extract any arguments provided by the user (e.g. `--resume`, `--quality balanced`).
2. Extract any active hooks from the current `<system-reminder>` (e.g., `Active execution (post-compact):`).
3. Call the `invoke_subagent` tool to spawn the `sdlc:execute-plan-workflow` subagent.
4. Pass the parsed arguments, extracted hooks, and the current working directory in the `Prompt` field.
5. Wait for the subagent to complete, then surface its final summary to the user verbatim, without any conversational prefix or wrapper. Do not execute any SDLC logic in this main context.
