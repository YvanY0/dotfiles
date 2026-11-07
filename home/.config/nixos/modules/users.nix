{ ... }:

{
  users.users."yvanyo" = {
    isNormalUser = true;
    description = "Yvan Yo";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  security.sudo.extraRules = [{
    users = [ "yvanyo" ];
    commands = [{ command = "ALL"; options = [ "NOPASSWD" ]; }];
  }];
}
