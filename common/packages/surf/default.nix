{stdenv, fetchurl, makeWrapper, gtk, webkit, wget, gnome3, pkgconfig, glib, glib_networking, libsoup, gsettings_desktop_schemas, fetchgit, patches ? null}:

stdenv.mkDerivation rec {
  name = "surf-${version}";
  version="0.6";

  src = fetchgit {
    url = https://github.com/fmap/surf-vi;
    rev = "724a391dee3bf3df5172ef7d3cb2bc0c205670f5";
    sha256 = "3fd42772d2d886b5ccc7f6b5a18c6d6e9bc4c856400d768e98a026460f80dcf7";
  };

  buildInputs = [ gtk makeWrapper webkit gsettings_desktop_schemas pkgconfig glib libsoup wget gnome3.zenity ];

  buildPhase = " make ";

# `-lX11' to make sure libX11's store path is in the RPATH
  NIX_LDFLAGS = "-lX11";
  preConfigure = [''
    sed -i "s@PREFIX = /usr/local@PREFIX = $out@g" config.mk
  ''];
  installPhase = ''
    make PREFIX=/ DESTDIR=$out install
  '';
  preFixup = ''
    wrapProgram "$out/bin/surf" \
      --prefix GIO_EXTRA_MODULES : ${glib_networking}/lib/gio/modules \
      --prefix XDG_DATA_DIRS : "$GSETTINGS_SCHEMAS_PATH"
  '';
  meta = {
    description = "Simple web browser";
    longDescription = ''
      Surf is a simple web browser based on WebKit/GTK+. It is able to display
      websites and follow links. It supports the XEmbed protocol which makes it
      possible to embed it in another application. Furthermore, one can point
      surf to another URI by setting its XProperties.
      '';
    homepage = http://surf.suckless.org;
    license = "MIT";
    platforms = stdenv.lib.platforms.linux;
  };
}
