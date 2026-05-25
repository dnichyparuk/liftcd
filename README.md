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
