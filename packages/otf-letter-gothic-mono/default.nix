{stdenv, fetchurl}:

stdenv.mkDerivation {
  name = "otf-letter-gothic-mono";
  src = <vi-nix/packages/otf-letter-gothic-mono/otf>;
  buildPhase = "true";
  installPhase = ''
    mkdir -p $out/share/fonts/
    cp *.otf $out/share/fonts/
  '';
}
