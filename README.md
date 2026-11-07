# Dotfiles

[![License: MIT](https://img.shields.io/github/license/YvanY0/dotfiles?style=for-the-badge&color=EBCB8B)](LICENSE)
[![Last Commit](https://img.shields.io/github/last-commit/YvanY0/dotfiles/guisu?style=for-the-badge&color=8FBCBB)](https://github.com/YvanY0/dotfiles/commits/guisu)
![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux-B48EAD?style=for-the-badge)
[![Managed with guisu](https://img.shields.io/badge/managed%20with-guisu-88C0D0?style=for-the-badge)](https://github.com/YvanY0/guisu)

Personal configurations managed with [guisu](https://github.com/YvanY0/guisu), for macOS, Fedora Linux, and NixOS. The repository includes shell, terminal, editor, and command-line tool configurations, adapted to each platform with templates and system detection.

> This repository contains personal preferences and encrypted files. It is not intended for direct use on other users' devices. Review the configuration and hooks before applying it.

## What's Included

- Shells: zsh and Nushell
- Terminals: Ghostty and Kitty
- Editors: Neovim, Helix, VS Code, and Zed
- CLI tools: Git, Starship, Atuin, eza, bat, and more
- System setup: Homebrew on macOS, packages on Fedora, and system configuration on NixOS
- Secrets: age-encrypted files, with keys retrieved through rbw

## Usage

Install and configure [guisu](https://github.com/YvanY0/guisu), clone this repository, then run from the repository directory:

```sh
git clone git@github.com:YvanY0/dotfiles.git
cd dotfiles
guisu apply
```

Review `.guisu.toml.j2`, `.guisu/hooks/`, and `home/` before applying. Personal systems require rbw access and the age identity needed to decrypt protected files. Hooks may install packages, change Git settings, or rebuild the NixOS system.

## Platform Behavior

- macOS: runs the Homebrew package installation hook.
- Fedora: runs the dnf package installation hook.
- NixOS: deploys the system configuration from `home/.config/nixos/` and runs `nixos-rebuild switch` after apply.
- Other Linux distributions: treated as ephemeral environments; dnf and NixOS system operations are skipped, and some personal or encrypted configurations are excluded.

Personal configuration is selected using the detected system and username. The current personal username is `yvanyo`; see `.guisu.toml.j2` for the detection logic.

## Repository Layout

- `.guisu.toml.j2`: guisu configuration, platform detection, and variables
- `.guisu/variables/`: user, visual, and platform-specific variables
- `.guisu/hooks/`: pre- and post-apply scripts for packages, keys, and system setup
- `.guisu/ignores.toml`: environment-specific exclusions
- `home/`: configuration files deployed to the user's home directory

## Development

Run the repository's pre-commit checks with:

```sh
pre-commit run --all-files
```

[简体中文](README.zh-CN.md)
