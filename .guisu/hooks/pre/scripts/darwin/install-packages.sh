#!/bin/bash
# install-packages — darwin
# Triggered by .guisu/hooks/pre/install-packages.toml on macOS hosts.
# Loaded by Guisu's hook loader via the scripts/darwin/ override (see
# docs/user-guide/hooks.md → "Platform-specific script overrides").
set -eufo pipefail

gum spin --spinner points --title "Installing/updating Homebrew packages" -- \
  brew bundle --quiet --file="${GUISU_SOURCE}/.config/homebrew/Brewfile"
