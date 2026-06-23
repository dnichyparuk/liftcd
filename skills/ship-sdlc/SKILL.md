---
name: ship-sdlc
description: "Use this skill when shipping a feature end-to-end after plan acceptance: executing, committing, reviewing, fixing critical issues, versioning, and opening a PR in one flow. Dispatches every sub-skill (including execute-plan-sdlc) as a native subagent tool for context isolation, with structured return values driving the pipeline state machine. Arguments: [--auto] [--steps <csv>] [--quick] [--quality full|balanced|minimal] [--bump patch|minor|major|<label>] [--draft] [--dry-run] [--resume] [--init-config]. The `<label>` form for --bump (e.g. `--bump rc`) is forwarded to version-sdlc, where it is interpreted as `--bump patch --pre <label>`; labels must match `^[a-z][a-z0-9]*$`. Triggers on: ship it, ship this, full pipeline, execute to PR, ship feature, run the whole thing."
user-invocable: true
argument-hint: "[--auto] [--steps <csv>] [--quick] [--quality full|balanced|minimal] [--bump patch|minor|major|<label>] [--draft] [--dry-run] [--resume] [--workspace branch|worktree|prompt] [--branch | --tree] [--openspec-change <name>] [--init-config] [--gc] [--ttl-days <N>]"
model: gemini-3.5-flash-low
---

# Ship (Thin Dispatcher)

This is a thin dispatcher to prevent context bloat. The actual execution logic lives in `lift_sdlc_ship_workflow`.

## Workflow

1. Extract any arguments provided by the user (e.g. `--auto`, `--steps`, `--quick`, `--dry-run`, `--resume`).
2. Extract any active hooks from the current `<system-reminder>`.
3. Call the `lift_sdlc_ship_workflow` tool to execute the workflow.
4. Pass the parsed arguments, extracted hooks, and the current working directory in the `Prompt` field.
5. Wait for the subagent to complete, then surface its final summary to the user verbatim, without any conversational prefix or wrapper. Do not execute any SDLC logic in this main context.
