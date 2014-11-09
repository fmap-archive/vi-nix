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
      ../modules/client-or-server.nix
      ../modules/tor-transparent.nix
      ../modules/bitlbee-signing.nix
      ../modules/git-mirror.nix
      ../modules/autocutsel.nix
      ../modules/afraid-dyndns.nix
      ../modules/tor-hidden-service.nix
      ../modules/secrets.nix
    ];
}
