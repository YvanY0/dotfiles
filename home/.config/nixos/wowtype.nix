{ pkgs }:

let
  src = builtins.fetchGit {
    url = "https://github.com/Gloridust/WowType.git";
    ref = "release";
  };
in
pkgs.callPackage "${src}/nix/package.nix" { }
