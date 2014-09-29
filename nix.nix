{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  nix.binaryCaches = [
    https://hydra.nixos.org
  ];

  nix.distributeBuildsToBitlbee = true;
}
