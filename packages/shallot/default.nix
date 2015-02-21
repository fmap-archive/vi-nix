{stdenv, fetchurl, openssl, lib}:

stdenv.mkDerivation {
  name = "shallot-0.0.3";

  src = fetchurl {
    url = "http://taswebqlseworuhc.onion/hosted/shallot-0.0.3.tgz";
    sha256 = "1gbs031dm00wnbzy3m4q58n823gcans6x7gcv98c2d64ykk4hr1i";
  };

  buildInputs = [openssl];

  patches = [ <vi-nix/packages/shallot/onionlen.patch> ];

  buildPhase = ''
    ./configure
    make
  '';

  installPhase = ''
    mkdir -p $out/bin
    mv shallot $out/bin
  '';
}
