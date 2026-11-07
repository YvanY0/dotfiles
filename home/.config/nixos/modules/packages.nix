{ pkgs, lib, ... }:

let
  unstable = import (builtins.fetchTarball {
    url = "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/nixpkgs-unstable/nixexprs.tar.xz";
  }) { config.allowUnfree = true; };
in
{
  environment.systemPackages =
    (with pkgs; [
      age
      bat
      btop
      curl
      dfu-util
      duf
      eza
      gcc
      git
      git-lfs
      gitui
      go
      jq
      llvm
      luarocks
      navi
      nodejs
      openssl
      pinentry-curses
      pkg-config
      poppler
      rbw
      rustup
      sheldon
      sshpass
      vim
      vivid
      wget
      yaegi
      zsh
    ])
    ++ (with unstable; [
      atuin
      bottom
      carapace
      delta
      direnv
      fastfetch
      fd
      fzf
      gh
      glab
      glow
      gum
      hyperfine
      just
      lazygit
      mise
      neovim
      nushell
      pi-coding-agent
      prek
      prettier
      protobuf
      ripgrep
      starship
      tealdeer
      tree-sitter
      typst
      uv
      yazi
      yq-go
      zoxide
    ]);

  environment.extraOutputsToInstall = [ "dev" ];

  environment.variables.PKG_CONFIG_PATH = lib.makeSearchPath "lib/pkgconfig" [
    pkgs.openssl.dev
  ];
}
