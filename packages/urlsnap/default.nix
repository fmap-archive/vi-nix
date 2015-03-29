{ stdenv, atk, cairo , fontconfig, freetype, gcc, gdk_pixbuf, glib, gtk3
, libsoup, pango, pkgconfig, webkitgtk2 
}: stdenv.mkDerivation ({
  name = "urlsnap";
  src = <jotmuch>;
  buildInputs = [
    atk
    cairo
    fontconfig
    freetype
    gdk_pixbuf
    glib
    gtk3
    libsoup
    pango
    pkgconfig
    webkitgtk2
  ];
  buildPhase = ''
    ${gcc}/bin/gcc urlsnap.c $(${pkgconfig}/bin/pkg-config webkit2gtk-4.0 --cflags --libs) -o urlsnap
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp urlsnap $out/bin
  '';
})
