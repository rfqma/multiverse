# 🌌 Multiverse - Nix Development Environment

A comprehensive, cross-platform development environment and dotfiles configuration powered by Nix flakes and Home Manager.

> \[!NOTE]
> Currently GUI apps are **not** automatically linked to macOS Spotlight search and may not appear in system application menus or launchers. Some of it are dotfiles-based and may require manual download.

## ✨ What's Inside

- **🖥️ Cross-Platform**: macOS (Intel/ARM) and Linux (x86_64/ARM64)
- **🛠️ Development Tools**: Rust, Go, Python, C++, Node.js, Laravel
- **⚙️ Consistent Configuration**: Git, Zsh, Starship, Ghostty, Zed, Vim, Neovim
- **📦 System Tools**: Podman, Podman Compose, Archive tools (7zip), htop, curl, jq
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
nix profile add nixpkgs#home-manager
```

### Development Environment

```bash
# default development shell
nix develop github:rfqma/multiverse
```

```bash
# nodejs, rust, go, python
nix develop github:rfqma/multiverse#minimal
```

```bash
# cpp
nix develop github:rfqma/multiverse#cpp
```

```bash
# nodejs
nix develop github:rfqma/multiverse#js
```

```bash
# laravel
nix develop github:rfqma/multiverse#laravel
```

### Home Manager (dotfiles)

```bash
# For macOS ARM
home-manager switch --flake github:rfqma/multiverse#mac-arm --refresh
```

```bash
# For Linux x86_64
home-manager switch --flake github:rfqma/multiverse#linux-x86 --refresh
```

### Project Templates

```bash
# create directory
mkdir my-project && cd my-project
```

```bash
# Rust project
nix flake init -t github:rfqma/multiverse#rust-dev
```

```bash
# Go project
nix flake init -t github:rfqma/multiverse#go-dev
```

```bash
# JavaScript project
nix flake init -t github:rfqma/multiverse#js-dev
```

```bash
# Python project
nix flake init -t github:rfqma/multiverse#python-dev
```

```bash
# C++ project
nix flake init -t github:rfqma/multiverse#cpp-dev
```

```bash
# trigger flake.nix
nix develop
```

### 🔁 Continuous

```bash
# Clear Nix cache
nix registry pin github:rfqma/multiverse
```

```bash
# Update flake inputs
nix flake update
```

### 📦 Included Tools & Configurations

#### Development Languages

- **🦀 Rust** (rustc, cargo, rustfmt)
- **🐹 Go** (go toolchain)
- **🐍 Python** (3.12 + JupyterLab)
- **🌐 Node.js** (nodejs, npm)
- **🚀 C++** (gcc, cmake)
- **🌐 Laravel** (php, composer)

#### Editors & IDEs

- [**📝 Zed**](https://zed.dev/) - Modern editor with AI integration
- [**📝 Neovim**](https://neovim.io/) - (vim, nvim)

#### Terminal & Shell

- **Zsh** - Enhanced shell with custom aliases
- [**Starship**](https://starship.rs/) - Beautiful, informative prompt
- [**Ghostty**](https://ghostty.org/) - Fast, feature-rich terminal emulator

#### System & Container Tools

- **Git** - Configured with sensible defaults
- [**Podman**](https://podman.io/) + [**Podman Compose**](https://github.com/containers/podman-compose) - Container runtime
- **Archive Tools** - 7zip
- **System Utilities** - htop, tree, curl, wget, jq

### 🏗️ Configuration Structure

```
multiverse/
├── home/
│   ├── shared/          # Shared configurations
│   │   ├── git.nix      # Git settings
│   │   ├── shell.nix    # Zsh + Starship
│   │   ├── terminal.nix # Ghostty
│   │   ├── editors.nix  # Neovim + Zed
│   │   └── tools.nix    # Podman, archives, etc.
│   ├── mac-arm.nix      # macOS ARM configuration
│   └── linux-x86.nix    # Linux x86_64 configuration
├── nix/
│   ├── shell.nix        # Development shells
│   └── templates/       # Project templates
└── flake.nix            # Main flake configuration
```
