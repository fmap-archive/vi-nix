{ config, lib, ... }:
{ imports = [
    <vi-nix/logical/roles/common.nix>
    <vi-nix/logical/roles/development.nix>
    <vi-nix/logical/roles/graphical.nix>
    <vi-nix/logical/roles/messenger.nix>
    <vi-nix/logical/roles/tor-transparent.nix>
  ];

  networking.hostName = "maclane";
  deployment.targetHost = lib.removeSuffix "\n" (builtins.readFile <vi-nix/secrets/hidden-services.ssh.maclane.hostname>);
  networking.wireless.enable = true;
}
