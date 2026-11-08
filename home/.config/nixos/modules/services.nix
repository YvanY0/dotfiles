{ pkgs, ... }:

{
  services.kmscon.enable = true;
  services.openssh.enable = true;

  services.k3s = {
    enable = true;
    package = pkgs.unstable.k3s;
  };

  virtualisation.podman.enable = true;
}
