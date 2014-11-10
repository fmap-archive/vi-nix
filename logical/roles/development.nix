{ config, pkgs, ... }:
{ imports = [ <nixos/modules/programs/virtualbox.nix> ];

  services.mysql.enable = true;
  services.mysql.package = pkgs.mysql;
}
