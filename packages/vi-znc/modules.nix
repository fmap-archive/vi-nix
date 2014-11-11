{ stdenv, fetchurl, fetchgit, znc }:
let
  zncDerivation = a@{
    name, src, module_name,
    buildPhase ? "${znc}/bin/znc-buildmod ${module_name}.cpp",
    installPhase ? "install -D ${module_name}.so $out/lib/znc/${module_name}.so", ...
  } : stdenv.mkDerivation (a // {
    inherit buildPhase;
    inherit installPhase;

    meta = { platforms = stdenv.lib.platforms.unix; };
    passthru.module_name = module_name;
  });
in rec {
  privmsg = zncDerivation rec {
    name        = "znc-privmsg-c9f98690be";
    module_name = "privmsg";

    src = fetchgit {
      url    = "https://github.com/kylef/znc-contrib";
      rev    = "c9f98690beb4e3a7681468d5421ff11dc8e1ee8b";
      sha256 = "dfeb28878b12b98141ab204191288cb4c3f7df153a01391ebf6ed6a32007247f";
    };
  };
}
