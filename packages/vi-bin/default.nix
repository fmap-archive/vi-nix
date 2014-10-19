{ stdenv, fetchgitPrivate, pkgs }:

stdenv.mkDerivation rec {
  name = "vi-bin";
  src = fetchgitPrivate {
    url    = "git@github.com:fmap/vi-bin.git";
    rev    = "e9f9d82f5eb9270f147a2a9d22bb7f046f30e2d5";
    sha256 = "4ef404f4d164411914065b48d0a9d0e18ec0a5d04e28a163674b2ac67527b4c4";
  };
  installPhase = ''
    mkdir -p $out/bin
    cp -r * $out/bin
  '';
  propagatedUserEnvPkgs = with pkgs; [
    bash
    bzip2
    curl
    djvulibre
    dzen2
    gawk
    ghc.ghc783
    gnutar
    gzip
    haskellPackages.pandoc
    imagemagick
    inetutils
    lsof
    mplayer
    nodejs
    openssh
    p7zip
    python27Packages.mutagen
    ruby
    unrar
    vi-surf
    vi-zathura
    xclip
    xlibs.xrdb
    youtubeDL
    ruby

    # ruby-nokogiri
    # node-krake
  ];
}
