{ lib, pkgs, ... }:
let
  inherit (lib) overrideDerivation;
in overrideDerivation pkgs.nixUnstable (_ : {
  patches = [
    ./no-set-PS1.patch 
  ];
})
