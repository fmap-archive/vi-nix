{ config, ... }:
{ imports = [
    ./roles/common.nix
    ./roles/development.nix
    ./roles/graphical.nix
    ./roles/receive-mail.nix
    ./roles/tor-transparent.nix
  ];
  networking.hostName = "euclid";
  networking.wireless.enable = true;
}
