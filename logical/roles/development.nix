{ config, pkgs, ... }:
{ networking.extraHosts = builtins.readFile <secrets/zalora.extra-hosts>;

  services.virtualboxGuest.enable = false;
  services.virtualboxHost.enable = true;

  services.mysql.enable = true;
  services.mysql.package = pkgs.mysql;
}
