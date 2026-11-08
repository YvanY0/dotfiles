{ pkgs, ... }:

let
  nixosVersions = import ../versions.nix;
in
{
  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    substituters = [
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
    ];
  };

  nix.channel.enable = false;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  nix.nixPath = [
    "nixos-config=${toString ../configuration.nix}"
    "nixos-system=${toString ../system.nix}"
  ];

  nix.registry.nixpkgs.to = {
    type = "tarball";
    url = "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/nixos-${nixosVersions.channel}/nixexprs.tar.xz";
  };

  nix.registry.unstable.to = {
    type = "tarball";
    url = "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/nixpkgs-unstable/nixexprs.tar.xz";
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib
      zlib
    ];
  };

  programs.bash.shellAliases.nixos-rebuild =
    "nixos-rebuild -f ${toString ../system.nix}";
}
