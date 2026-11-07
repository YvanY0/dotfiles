{ pkgs, lib, ... }:

{
  programs.zsh.enable = true;
  programs.zsh.enableGlobalCompInit = false;
  programs.zsh.promptInit = "";
  users.users.yvanyo.shell = pkgs.zsh;
  environment.variables = {
    ATUIN_CONFIG_DIR = lib.mkForce "$HOME/.config/atuin";
    SSL_CERT_FILE = "/etc/ssl/certs/ca-bundle.crt";
  };
  programs.atuin = {
    enable = true;
    enableZshIntegration = false;
    enableBashIntegration = false;
    daemon.enable = true;
  };
  systemd.user.services.atuin-daemon.environment = {
    ATUIN_CONFIG_DIR = "%h/.config/atuin";
  };
}
