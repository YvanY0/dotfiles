{ ... }:

let
  nixosVersions = import ./versions.nix;
  unstableNixpkgs = builtins.fetchTarball {
    url = "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/nixpkgs-unstable/nixexprs.tar.xz";
  };
in
{
  nixpkgs.overlays = [
    (final: prev: {
      unstable = import unstableNixpkgs {
        system = prev.stdenv.hostPlatform.system;
        config.allowUnfree = true;
      };
    })
  ];

  imports = [
    /etc/nixos/hardware-configuration.nix
    ./modules/boot.nix
    ./modules/networking.nix
    ./modules/locale.nix
    ./modules/users.nix
    ./modules/packages.nix
    ./modules/desktop.nix
    ./modules/shell.nix
    ./modules/nix.nix
    ./modules/services.nix
  ];

  system.stateVersion = nixosVersions.stateVersion;
}
