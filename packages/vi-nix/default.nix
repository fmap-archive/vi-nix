{ lib, pkgs, ... }:
let
  inherit (lib) overrideDerivation;
in overrideDerivation pkgs.nix (_ : {
  patches = [
    ./no-set-PS1.patch 
  ];
})
