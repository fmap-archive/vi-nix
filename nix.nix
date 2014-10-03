{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  nix.binaryCaches = [
    https://hydra.nixos.org
  ];

  nix.trustedBinaryCaches = config.nix.binaryCaches;

  nix.distributeBuildsToBitlbee = false;
}
