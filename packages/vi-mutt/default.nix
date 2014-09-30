{ lib, pkgs, ... }:

let
  inherit (lib) overrideDerivation;
  inherit (pkgs) fetchhg;
  revision = "8f62001";
in overrideDerivation pkgs.mutt (_: {
  name = "mutt-${revision}-hidestatus";
  src = fetchhg {
    url = "https://bitbucket.org/mutt/mutt";
    rev = revision;
  };
  buildInputs = with pkgs; [
    autoconf
    automake
  ];
  preConfigure = ''
    autoreconf --install
  '';
  patches = [
    ./hidestatus.patch
  ];
})
