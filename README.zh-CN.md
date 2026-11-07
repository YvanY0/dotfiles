# Dotfiles

[![许可证：MIT](https://img.shields.io/github/license/YvanY0/dotfiles?style=for-the-badge&color=EBCB8B)](LICENSE)
[![最近提交](https://img.shields.io/github/last-commit/YvanY0/dotfiles/guisu?style=for-the-badge&color=8FBCBB)](https://github.com/YvanY0/dotfiles/commits/guisu)
![支持平台](https://img.shields.io/badge/platform-macOS%20%7C%20Linux-B48EAD?style=for-the-badge)
[![由 guisu 管理](https://img.shields.io/badge/managed%20with-guisu-88C0D0?style=for-the-badge)](https://github.com/YvanY0/guisu)

使用 [guisu](https://github.com/YvanY0/guisu) 管理的个人配置，适用于 macOS、Fedora Linux 和 NixOS。配置涵盖 shell、终端、编辑器及常用命令行工具，并通过模板和平台判断适配不同系统。

> 这是个人配置仓库，包含个人偏好和加密文件，不建议直接应用到其他用户的设备。应用前请先检查配置及其执行的 hooks。

## 配置内容

- Shell：zsh、Nushell
- 终端：Ghostty、Kitty
- 编辑器：Neovim、Helix、VS Code、Zed
- 命令行工具：Git、Starship、Atuin、eza、bat 等
- 系统：macOS Homebrew、Fedora 软件包，以及 NixOS 系统配置
- 秘密管理：使用 age 加密，并通过 rbw 获取相关密钥

## 使用

安装并配置好 [guisu](https://github.com/YvanY0/guisu) 后，将仓库克隆到本地并在仓库目录中运行：

```sh
git clone git@github.com:YvanY0/dotfiles.git
cd dotfiles
guisu apply
```

应用前请先查看 `.guisu.toml.j2`、`.guisu/hooks/` 和 `home/` 中的配置。个人系统需要配置 rbw，并确保有权限获取 age 密钥；缺少这些条件时，加密文件可能无法解密。hooks 可能会安装软件包、修改 Git 配置，或在 NixOS 上执行系统重建。

## 平台行为

- macOS：运行 Homebrew 软件包安装 hook。
- Fedora：运行 dnf 软件包安装 hook。
- NixOS：部署 `home/.config/nixos/` 中的系统配置，并在应用后运行 `nixos-rebuild switch`。
- 其他 Linux 发行版：作为临时环境处理，跳过 dnf 和 NixOS 系统操作；部分个人或加密配置会被忽略。

仓库会根据系统和用户名选择个人配置。当前个人用户名判断为 `yvanyo`，相关逻辑见 `.guisu.toml.j2`。

## 仓库结构

- `.guisu.toml.j2`：guisu 配置、平台判断和变量设置
- `.guisu/variables/`：用户、视觉及平台专属变量
- `.guisu/hooks/`：应用前后执行的软件包安装、密钥准备和系统配置脚本
- `.guisu/ignores.toml`：按环境排除的配置
- `home/`：将部署到用户目录的配置文件

## 开发检查

仓库使用 pre-commit 管理格式与静态检查：

```sh
pre-commit run --all-files
```

[English](README.md)
