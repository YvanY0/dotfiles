{ pkgs, ... }:

let
  src = builtins.path {
    path = builtins.fetchGit {
      url = "https://github.com/AprilNEA/OpenLogi.git";
      ref = "master";
    };
    name = "openlogi-source";
  };

  openlogiLib = pkgs.unstable.lib // {
    fileset = pkgs.unstable.lib.fileset // {
      toSource = { root, ... }: root;
    };
  };

  openlogi =
    (pkgs.unstable.callPackage "${src}/packaging/linux/package.nix" {
      inherit src;
      lib = openlogiLib;
      rustPlatform = pkgs.unstable.rustPlatform;
    }).overrideAttrs
      (old: {
        nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [
          pkgs.unstable.pkg-config
        ];
        buildInputs = (old.buildInputs or [ ]) ++ [
          pkgs.unstable.zstd
        ];
      });
in
{
  imports = [ "${src}/packaging/linux/nixos-module.nix" ];

  programs.openlogi = {
    enable = true;
    package = openlogi;
    launchAtLogin = true;
  };
}
