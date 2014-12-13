{ config, pkgs, ... }:
{ services.virtualboxGuest.enable = false;
  services.virtualboxHost.enable = true;

  services.mysql.enable = true;
  services.mysql.package = pkgs.mysql;
}
