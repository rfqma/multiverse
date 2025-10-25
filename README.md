# 🌌 Multiverse - Universal Nix Development Environment

A comprehensive, cross-platform development environment and dotfiles configuration powered by Nix flakes and Home Manager.

## ✨ Features

- **🖥️ Cross-Platform**: macOS (Intel/ARM) and Linux (x86_64/ARM64)
- **🛠️ Development Tools**: Rust, Go, Python, JavaScript, C++, Node.js
- **⚙️ Consistent Configuration**: Git, Zsh, Starship, Tmux, Ghostty, Zed, VSCode
- **📦 System Tools**: Podman, Archive tools (7zip, unrar, etc), htop, curl, jq
- **🏠 Home Manager**: Declarative dotfiles management
- **📋 Template System**: Quick-start templates for new projects

## 🚀 Quick Start

### Prerequisites

#### [Nix](https://nixos.org/download.html) (with flakes enabled)

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

#### [home-manager](https://github.com/nix-community/home-manager)

```bash
nix profile install nixpkgs#home-manager
```

### Development Environment
```bash
# Enter the default development shell
nix develop github:rfqma/multiverse
```

```bash
# Use specific development environment
nix develop github:rfqma/multiverse#minimal
nix develop github:rfqma/multiverse#cpp
```

### Home Manager (dotfiles)
```bash
# For macOS ARM (M1/M2/M3)
home-manager switch --flake github:rfqma/multiverse#mac-arm

# For Linux x86_64
home-manager switch --flake github:rfqma/multiverse#linux-x86
```

### Project Templates
```bash
# Rust project
nix flake init -t github:rfqma/multiverse#rust-dev

# Go project
nix flake init -t github:rfqma/multiverse#go-dev

# JavaScript project
nix flake init -t github:rfqma/multiverse#js-dev

# Python project
nix flake init -t github:rfqma/multiverse#python-dev

# C++ project
nix flake init -t github:rfqma/multiverse#cpp-dev
```

### 📦 Included Tools & Configurations

#### Development Languages
- **🦀 Rust** (rustc, cargo, rustfmt)
- **🐹 Go** (go toolchain)
- **🐍 Python** (3.12 + JupyterLab)
- **🌐 JavaScript/Node.js** (nodejs, npm)
- **🚀 C++** (gcc, cmake)

#### Editors & IDEs
- **📝 Zed** - Modern editor with AI integration
- **📝 VSCode** - Full configuration with extensions and settings
- **📝 Vim** (vim, nvim)

#### Terminal & Shell
- **Zsh** - Enhanced shell with custom aliases
- **Starship** - Beautiful, informative prompt
- **Tmux** - Terminal multiplexer with vi-mode
- **Ghostty** - Fast, feature-rich terminal emulator

#### System & Container Tools
- **Git** - Configured with sensible defaults
- **Podman** + **Podman Compose** - Container runtime
- **Archive Tools** - 7zip, unzip, unrar, tar, gzip, etc.
- **System Utilities** - htop, tree, curl, wget, jq

### 🏗️ Configuration Structure

```
multiverse/
├── home/
│   ├── shared/           # Shared configurations
│   │   ├── git.nix      # Git settings
│   │   ├── shell.nix    # Zsh + Starship
│   │   ├── terminal.nix # Tmux + Ghostty
│   │   ├── editors.nix  # VSCode + Zed
│   │   └── system-tools.nix # Podman, archives, etc.
│   ├── mac-arm.nix      # macOS ARM configuration
│   └── linux-x86.nix   # Linux x86_64 configuration
├── nix/
│   ├── shell.nix        # Development shells
│   └── templates/       # Project templates
└── flake.nix           # Main flake configuration
```

### 🔧 Customization

Fork this repository and modify the configurations in `home/shared/` to match your preferences:
- **Git**: Update username/email in `git.nix
- **Shell**: Add your aliases in `shell.nix
- **VSCode**: Modify settings in `editors.nix
- **Tools**: Add/remove packages in `tools.nix

### 📝 Usage Examples
```bash
# Quick development environment for any project
nix develop github:rfqma/multiverse

# Apply dotfiles to new machine
home-manager switch --flake github:rfqma/multiverse#mac-arm

# Create new Rust project
mkdir my-rust-app && cd my-rust-app
nix flake init -t github:rfqma/multiverse#rust-dev
nix develop
```
