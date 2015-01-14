{ pkgs, ... }: with pkgs; { modules = recurseIntoAttrs (callPackage ./modules.nix {}); } 
