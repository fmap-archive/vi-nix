{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.autocutsel;
in 
{ options = {
    services.autocutsel = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "Whether to start autocutsel when you log in ('CLIPBOARD' and 'PRIMARY'.)";
      };
    };
  };
  config = mkIf cfg.enable {
    systemd.user.services."autocutsel" = {
      enable = true;
      description = "Synchronise clipboards.";
      wantedBy = ["default.target"];
      reloadIfChanged = true;
      script = ''
        ${pkgs.autocutsel}/bin/autocutsel -fork
        ${pkgs.autocutsel}/bin/autocutsel -selection PRIMARY -fork
      '';
      environment = {
        DISPLAY = ":0";
      };
      serviceConfig = {
        Type = "forking";
      };
    };
  };
}
