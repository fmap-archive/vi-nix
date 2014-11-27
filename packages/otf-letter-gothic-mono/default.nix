{stdenv, fetchurl}:

stdenv.mkDerivation {
  name = "otf-letter-gothic-mono";
  src = ./otf;
  buildPhase = "true";
  installPhase = ''
    mkdir -p $out/share/fonts/
    cp *.otf $out/share/fonts/
  '';
}
