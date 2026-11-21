{ ... }:

{
  networking.firewall = {
    trustedInterfaces = [ "Mihomo" ];
    extraReversePathFilterRules = ''
      iifname { "Mihomo" } accept comment "allow Clash TUN traffic"
    '';
  };

  networking.hostName = "NixOS-HP-Z2-Mini-G5";
  networking.networkmanager.enable = true;
}
