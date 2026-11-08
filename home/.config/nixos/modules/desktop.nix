{ config, lib, pkgs, ... }:

let
  cfg = config.services.displayManager.noctalia-greeter;
  tomlFormat = pkgs.formats.toml { };
  greeterUser = config.services.greetd.settings.default_session.user or "greeter";
  greeterGroup = config.users.users.${greeterUser}.group or "greeter";
in
{
  options.services.displayManager.noctalia-greeter = {
    enable = lib.mkEnableOption "Noctalia Greeter for greetd";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.unstable.noctalia-greeter;
      defaultText = lib.literalExpression "pkgs.unstable.noctalia-greeter";
      description = "The Noctalia Greeter package.";
    };

    settings = lib.mkOption {
      type = tomlFormat.type;
      default = { };
      description = "Declarative settings written to greeter.toml.";
    };

    cursorTheme = {
      package = lib.mkOption {
        type = lib.types.nullOr lib.types.package;
        default = null;
        description = "Cursor theme package for Noctalia Greeter.";
      };

      name = lib.mkOption {
        type = lib.types.str;
        default = "Adwaita";
        description = "Cursor theme name for Noctalia Greeter.";
      };
    };
  };

  config = lib.mkMerge [
    {
      programs.niri = {
        enable = true;
        package = pkgs.unstable.niri;
      };

      services.displayManager.noctalia-greeter = {
        enable = lib.mkDefault true;
        settings = {
          cursor.size = lib.mkDefault 24;
          keyboard.layout = lib.mkDefault "us";
        };
        cursorTheme = {
          package = lib.mkDefault pkgs.bibata-cursors;
          name = lib.mkDefault "Bibata-Modern-Ice";
        };
      };

      environment.systemPackages = [ pkgs.unstable.noctalia ];

      networking.networkmanager.enable = lib.mkDefault true;
      hardware.bluetooth.enable = lib.mkDefault true;
      services.upower.enable = lib.mkDefault true;
      services.power-profiles-daemon.enable = lib.mkIf (!config.services.tuned.enable) (
        lib.mkDefault true
      );

      systemd.user.services.noctalia = {
        description = "Noctalia Wayland desktop shell";
        documentation = [ "https://docs.noctalia.dev/noctalia/" ];
        partOf = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        wantedBy = [ "graphical-session.target" ];
        environment.PATH = lib.mkForce null;
        serviceConfig = {
          ExecStart = lib.getExe pkgs.unstable.noctalia;
          Restart = "on-failure";
        };
      };
    }

    (lib.mkIf cfg.enable {
      environment.systemPackages = [ cfg.package ];

      services.greetd = {
        enable = lib.mkDefault true;
        settings.default_session = {
          command = lib.mkDefault (
            "${lib.getExe' pkgs.coreutils "env"} "
            + "XDG_DATA_DIRS=${config.services.displayManager.sessionData.desktops}/share "
            + "${cfg.package}/bin/noctalia-greeter-session"
          );
          user = lib.mkDefault "greeter";
        };
      };

      services.accounts-daemon.enable = lib.mkDefault true;
      security.polkit.enable = lib.mkDefault true;

      systemd.tmpfiles.settings."10-noctalia-greeter" = {
        "/var/lib/noctalia-greeter".d = {
          user = greeterUser;
          group = greeterGroup;
          mode = "0750";
        };
      } // lib.optionalAttrs (cfg.settings != { }) {
        "/var/lib/noctalia-greeter/greeter.toml"."L+" = {
          argument = "${tomlFormat.generate "greeter.toml" cfg.settings}";
          user = greeterUser;
          group = greeterGroup;
        };
      };

      services.displayManager.noctalia-greeter.settings.cursor = lib.mkIf (cfg.cursorTheme.package != null) {
        theme = lib.mkDefault cfg.cursorTheme.name;
        path = lib.mkDefault "${cfg.cursorTheme.package}/share/icons";
      };
    })
  ];
}
