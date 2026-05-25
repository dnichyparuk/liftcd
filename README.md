# Antigravity SDLC Plugin

This plugin provides a comprehensive suite of skills and commands for Software Development Lifecycle (SDLC) workflows (pull requests, code reviews, releases) within Google Antigravity. It is a cross-platform port (POSIX and Windows) of the Claude Code SDLC plugin.

## Installation

You can install this plugin either globally for all workspaces, or locally for a specific workspace.

### Global Installation (Recommended)

To make the plugin available in all your Antigravity workspaces, clone this repository into your global Antigravity plugins directory:

```bash
git clone https://github.com/dnichyparuk/antigravity-sdlc.git ~/.gemini/config/plugins/sdlc
```

### Workspace Installation

To install the plugin only for a specific workspace, navigate to the root of your project and clone it into the local `.agents` directory:

```bash
mkdir -p .agents/plugins
git clone https://github.com/dnichyparuk/antigravity-sdlc.git .agents/plugins/sdlc
```

## Usage

Once installed, the SDLC skills will be automatically registered with your Antigravity agent. You can invoke them via the chat interface, for example:

- `/commit-sdlc` - Commit staged changes
- `/pr-sdlc` - Create a pull request
- `/review-sdlc` - Review changes
- `/ship-sdlc` - Ship a release

## SDLC Pipeline Structure

This plugin implements a complete, end-to-end Software Development Lifecycle process natively within the chat interface. The workflow is structured into the following distinct phases:

1. **Planning & Execution** (`/plan-sdlc`, `/execute-plan-sdlc`)
   - Scopes requirements, proposes architectural decisions, and breaks down the work into manageable tasks.
   - Executes the implementation plan systematically while adhering to guardrails.
2. **Committing** (`/commit-sdlc`)
   - Automatically generates smart, conventional commit messages by analyzing your staged diff and recent project history.
3. **Code Review** (`/review-sdlc`)
   - Performs a comprehensive, automated code review of your changes against predefined dimensions (e.g., security, architecture, performance) before you open a Pull Request.
4. **Pull Requests** (`/pr-sdlc`)
   - Generates detailed, well-structured PR descriptions based on the diff and commit history.
5. **Continuous Integration** (`/verify-pipeline-sdlc`)
   - Interfaces with GitHub Actions to monitor, verify, and diagnose CI/CD pipeline runs for your PRs.
6. **Hardening & Recovery** (`/error-report-sdlc`, `/harden-sdlc`)
   - If a pipeline fails or an error occurs, these skills analyze the failure to suggest stronger guardrails, preventing the same class of failure in the future.
7. **Shipping & Release** (`/version-sdlc`, `/ship-sdlc`)
   - Automates semantic versioning, changelog generation, and finalizing the release of the project.
