{ pkgs, lib, ... }:

{
  programs.clash-verge = {
    enable = true;
    package = pkgs.unstable.clash-verge-rev;
    serviceMode = true;
  };

  fonts.packages = with pkgs.unstable; [
    font-awesome
    inter
    maple-mono.NF
    nerd-fonts.im-writing
    nerd-fonts.symbols-only
    sarasa-gothic
  ];

  environment.systemPackages =
    (with pkgs; [
      age
      bat
      cabal-install
      btop
      curl
      dfu-util
      duf
      eza
      gcc
      gitFull
      git-lfs
      gitui
      go
      google-chrome
      jq
      llvm
      luarocks
      navi
      nodejs
      openssl
      pinentry-curses
      pkg-config
      podman-compose
      poppler
      rbw
      rustup
      sheldon
      sing-box
      sshpass
      vim
      vivid
      wget
      yaegi
      zsh
    ])
    ++ (with pkgs.unstable; [
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
      ghostty
      gui-for-singbox
      hyperfine
      just
      kitty
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
