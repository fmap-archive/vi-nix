{ lib, pkgs, ... }:

let
  inherit (lib) overrideDerivation;
  inherit (pkgs) fetchurl;
in overrideDerivation pkgs.zathuraCollection.zathuraWrapper (_: {
  zathura_core = overrideDerivation pkgs.zathuraCollection.zathuraWrapper.zathura_core (_ : {
    src = fetchurl {
      url = "https://github.com/fmap/zathura-vi/releases/download/vi-0.2.8/zathura-0.2.7.tar.gz";
      sha256 = "8cb6553f67c4e53e23f11a2d83c19bc41fcf0c15933d70e801c598c17480dbd2";
    }; 
  });
})
