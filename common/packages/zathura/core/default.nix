{ stdenv, fetchurl, pkgconfig, gtk, girara, glib, gettext, docutils, file, makeWrapper, zathura_icon }:

let
  giraraGTK3 = girara.override {
    gtk = gtk;
  };
in stdenv.mkDerivation rec {
  version = "0.2.7";
  name = "zathura-core-${version}";

  src = fetchurl {
    url = "https://github.com/fmap/zathura-vi/releases/download/vi-0.2.8/zathura-${version}.tar.gz";
    sha256 = "8cb6553f67c4e53e23f11a2d83c19bc41fcf0c15933d70e801c598c17480dbd2";
  };

  buildInputs = [ pkgconfig file gtk glib giraraGTK3 gettext makeWrapper ];

  preBuild = '''';

  makeFlags = [ "PREFIX=$(out)" "RSTTOMAN=${docutils}/bin/rst2man.py" "VERBOSE=1" ];

  postInstall = ''
    wrapProgram "$out/bin/zathura" \
      --prefix PATH ":" "${file}/bin" \
      --prefix XDG_CONFIG_DIRS ":" "$out/etc"

    mkdir -pv $out/etc
    echo "set window-icon ${zathura_icon}" > $out/etc/zathurarc
  '';

  meta = {
    homepage = http://pwmt.org/projects/zathura/;
    description = "A core component for zathura PDF viewer";
    license = stdenv.lib.licenses.zlib;
    platforms = stdenv.lib.platforms.linux;
    maintainers = [ stdenv.lib.maintainers.garbas ];

    # Set lower priority in order to provide user with a wrapper script called
    # 'zathura' instead of real zathura executable. The wrapper will build
    # plugin path argument before executing the original.
    priority = 1;
  };
}
