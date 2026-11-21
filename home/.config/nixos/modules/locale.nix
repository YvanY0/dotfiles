{ pkgs, ... }:

let
  wowtype = import ../wowtype.nix { inherit pkgs; };
in
{
  time.timeZone = "Asia/Shanghai";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = [ wowtype ];
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
