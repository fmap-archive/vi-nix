{ config, ... }:
{ imports = [
    ./roles/common.nix
    ./roles/development.nix
    ./roles/graphical.nix
    ./roles/messenger.nix
    ./roles/tor-transparent.nix
  ];

  networking.hostName = "maclane";
  networking.wireless.enable = true;
}
