{ config, lib, pkgs, ... }:

with lib; let
  cfg = config.services.afraidDNS;
in
{ options = {
    services.afraidDNS = with types; {
      enable    = mkOption { type = bool; description = "run dyndns?";  default = false; };
      accessKey = mkOption { type = string; description = "access key"; };
    };
  };
  config = mkIf cfg.enable {
    users.extraUsers.afraidDNS.uid = 1001;
    systemd.services.afraidDNS = {
      description   = "update afraid dns records";
      requires      = ["network.target"];
      script        = "curl --cacert ${pkgs.cacert}/etc/ca-bundle.crt https://freedns.afraid.org/dynamic/update.php?${cfg.accessKey}";
      serviceConfig = { User = "afraidDNS"; };
      path          = [pkgs.curl];
    };
    systemd.timers.afraidDNS = {
      description = "update afraid dns records often";
      wantedBy    = ["multi-user.target"];
      timerConfig = { Unit = "afraidDNS.service"; };
    };
  };
}
