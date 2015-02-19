{ pkgs, base, ... }:

pkgs.lib.overrideDerivation base.mutt (_: {
  src = pkgs.fetchhg {
    url = "https://bitbucket.org/mutt/mutt";
    rev = "8f62001";
  };
  buildInputs = with pkgs; [ autoconf automake ];
  preConfigure = "autoreconf --install";
  patches = [ <vi-nix/packages/mutt/hidestatus.patch> ];
})
