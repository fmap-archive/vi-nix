{ config, lib, ... }:

with lib;

let
  hiddenServices = config.services.tor.hiddenServices;
in {
  options.services.tor = { 
    hiddenServices = mkOption { default = []; };
  };
  config = mkIf (hiddenServices != []) {
    assertions = map (hiddenService: {
      assertion = hasAttr "name" hiddenService && hasAttr "port" hiddenService;
      message   = "all hidden services should define a name and a port..";
    }) hiddenServices;

    services.tor.enable = true;

    services.tor.extraConfig = concatStringsSep "\n" (map (hiddenService: ''
      HiddenServiceDir /var/lib/tor/${hiddenService.name}/
      HiddenServicePort ${toString hiddenService.port} 127.0.0.1:${toString hiddenService.port}
    '') hiddenServices);
  };
}
