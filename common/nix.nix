{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  
  nix.binaryCaches = 
    [ "http://cache.nixos.org"
      "http://hydra.nixos.org"
    ];

  nix.trustedBinaryCaches = 
    [ "http://cache.nixos.org"
      "http://hydra.nixos.org"
    ];
}
