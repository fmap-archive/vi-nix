{ config, ... }:
{ imports = [ ./roles/common.nix ];

  networking.hostName = "birkhoff";

  networking.wireless.enable = false;
    
  networking.firewall.enable = true;
  networking.firewall.rejectPackets = true;
  networking.firewall.allowPing = false;
  networking.firewall.allowedTCPPorts = [];
  networking.firewall.allowedUDPPortRanges = [];

  services.logind.extraConfig = ''
    HandleLidSwitch=ignore
  '';
}
