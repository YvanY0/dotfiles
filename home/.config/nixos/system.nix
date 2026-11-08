let
  nixosVersions = import ./versions.nix;
  nixpkgs = builtins.fetchTarball "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/nixos-${nixosVersions.channel}/nixexprs.tar.xz";
in
import "${nixpkgs}/nixos" {
  configuration.imports = [ ./configuration.nix ];
}
