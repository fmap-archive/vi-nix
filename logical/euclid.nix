{ config, lib, ... }:
{ imports = [
    <vi-nix/logical/roles/common.nix>
    <vi-nix/logical/roles/development.nix>
    <vi-nix/logical/roles/graphical.nix>
    <vi-nix/logical/roles/receive-mail.nix>
    <vi-nix/logical/roles/tor-transparent.nix>
  ];
  networking.hostName = "euclid";
  deployment.targetHost = lib.removeSuffix "\n" (builtins.readFile <vi-nix/secrets/hidden-services.ssh.euclid.hostname>);
  networking.wireless.enable = true;
}
