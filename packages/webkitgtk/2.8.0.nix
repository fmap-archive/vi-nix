{ lib, fetchurl, webkitgtk }: lib.overrideDerivation webkitgtk (_: rec {
  name = "webkitgtk-2.8.0";
  src = fetchurl {
    url = "http://webkitgtk.org/releases/${name}.tar.xz";
    sha256 = "05b8mkr1mv1w5vi5vyczzirgf5nr6qavrdwbcaiv0dghylwx5yh5";
  };
})
