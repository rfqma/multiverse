## Overview

This repository contains a development environment setup using Nix flakes and Home Manager. It provides a reproducible and consistent environment across different operating systems, with a special focus on creating a fully isolated development shell that coexists with a managed home environment. It includes development tools, shell configuration, and editor setups.

## Features

- **Cross-platform compatibility**: Supports macOS (aarch64-darwin) and Linux (x86_64-linux).
- **Isolated Development Shell**: The `nix develop` shell is fully isolated, with its own `HOME` directory to keep toolchains and build artifacts separate from main environment.
- **Shared Shell Configuration**: Zsh and Starship configuration is shared between the isolated shell and main environment for a consistent experience.
- **Declarative Dotfiles**: Home Manager is used to declaratively manage dotfiles and application configurations.
- **Reproducible Environments**: Nix flakes ensure to get the exact same environment every time.

## What's Included

### Development Tools

The development shell comes pre-configured with:

- node.js
- python3 with jupyterlab
- go
- rust (rustc, rustfmt, cargo)
- git
- ngrok
- gemini-cli

### GUI Applications Config

Home Manager is configured to manage:

- **Zed**: high-performance, multiplayer code editor.
- **Zsh** with a shared configuration and custom aliases.
- **Starship** prompt with a clean, informative display.
- **Ghostty** fast, GPU-accelerated terminal emulator.

## Quick Start

### Prerequisites

- [nix](https://nixos.org/download.html) with flakes enabled:

  ```bash
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
  ```

- [vscode](https://code.visualstudio.com/)
- [zed](https://zed.dev/)
- [ghostty](https://ghostty.org)
- [podman](https://podman.io)
- [podman-compose](https://github.com/containers/podman-compose)

### Home Manager Setup

To set up main environment (outside the dev shell), run the activation command for specific OS.

**For macOS:**

```bash
nix run github:rfqma/multiverse#homeConfigurations.mac.activationPackage --refresh
```

**For Linux:**

```bash
nix run github:rfqma/multiverse#homeConfigurations.linux.activationPackage --refresh
```

### Development Environment

Enter the isolated development shell:

```bash
nix develop github:rfqma/multiverse --command zsh
```

or after home manager setup:

```bash
ndzsh
```

This provides the declared development tools in an isolated environment, with some configuration loaded.

## Project Structure

```
multiverse/
├── flake.nix             # Main flake configuration
├── flake.lock            # Lock file for reproducible builds
├── modules/
│   ├── base.nix          # Cross-platform development tools
│   ├── mac.nix         # macOS-specific packages
│   └── linux.nix         # Linux-specific packages
└── home/
    ├── mac.nix           # macOS-specific home manager configuration
    └── linux.nix         # Linux-specific home manager configuration
```

## Useful Aliases

- `nr` → `npm run`
- `ndzsh` → `nix develop github:rfqma/multiverse --command zsh`

## Supported Systems

- **macOS**: Apple Silicon (aarch64-darwin)
- **Linux**: x86_64 (x86_64-linux)
