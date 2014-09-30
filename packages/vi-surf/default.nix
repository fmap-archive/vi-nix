{ lib, pkgs, ... }:

let
  inherit (lib) overrideDerivation;
  inherit (pkgs) fetchgit;
in overrideDerivation pkgs.surf (_: {
  src = fetchgit {
    url = https://github.com/fmap/surf-vi;
    rev = "724a391dee3bf3df5172ef7d3cb2bc0c205670f5";
    sha256 = "3fd42772d2d886b5ccc7f6b5a18c6d6e9bc4c856400d768e98a026460f80dcf7";
  };
  buildInputs = with pkgs; [
    wget
    gnome3.zenity
  ];
})

