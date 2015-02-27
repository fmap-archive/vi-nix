{ lib, config, ... }:
{ imports = [
    <vi-nix/logical/roles/common.nix>
    <vi-nix/logical/roles/development.nix>
    <vi-nix/logical/roles/graphical.nix>
  ];

  networking.hostName = "lang";
  deployment.targetHost = lib.removeSuffix "\n" (builtins.readFile <vi-nix/secrets/hidden-services.ssh.lang.hostname>);
}
