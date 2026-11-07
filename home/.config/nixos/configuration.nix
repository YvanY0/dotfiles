{ ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./modules/boot.nix
    ./modules/networking.nix
    ./modules/locale.nix
    ./modules/users.nix
    ./modules/packages.nix
    ./modules/shell.nix
    ./modules/nix.nix
    ./modules/services.nix
  ];

  system.stateVersion = "26.05";
}
