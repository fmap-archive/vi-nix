{ config, pkgs, ... }:
{
  imports =
    [ ../services.nix
      ../users.nix
      ../packages.nix
      ../locale.nix
      ../security.nix
      ../network.nix
      ../nix.nix
      <nixos/modules/programs/virtualbox.nix>
    ];
}
