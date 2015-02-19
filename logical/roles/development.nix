{ config, pkgs, ... }:
{ networking.extraHosts = builtins.readFile <vi-nix/secrets/zalora.extra-hosts>;

  services.virtualboxGuest.enable = false;
  services.virtualboxHost.enable = true;

  services.mysql.enable = true;
  services.mysql.package = pkgs.mysql;
  systemd.services.mysql.wantedBy = pkgs.lib.mkForce [];

  services.postgresql.enable = true;
  services.postgresql.package = pkgs.postgresql;
  systemd.services.postgresql.wantedBy = pkgs.lib.mkForce [];
}
