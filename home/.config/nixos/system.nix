let
  nixpkgs = builtins.fetchTarball "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/nixos-26.05/nixexprs.tar.xz";
in
import "${nixpkgs}/nixos" {
  configuration.imports = [ ./configuration.nix ];
}
