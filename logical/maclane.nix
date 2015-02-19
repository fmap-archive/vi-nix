{ config, ... }:
{ imports = [
    <vi-nix/logical/roles/common.nix>
    <vi-nix/logical/roles/development.nix>
    <vi-nix/logical/roles/graphical.nix>
    <vi-nix/logical/roles/messenger.nix>
    <vi-nix/logical/roles/tor-transparent.nix>
  ];

  networking.hostName = "maclane";
  networking.wireless.enable = true;
}
