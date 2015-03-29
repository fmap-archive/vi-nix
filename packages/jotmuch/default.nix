{ lib, stdenv, urlsnap, python, pythonPackages, makeWrapper
, xapianBindings
}: stdenv.mkDerivation {
  name = "jotmuch";
  src = <jotmuch>;
  buildInputs = [
    urlsnap 
    python
    (xapianBindings.override { inherit python; })
  ] ++ (with pythonPackages; [
    arrow
    click
    dateutil
    jinja2
    lxml
    pyyaml
  ]);
  nativeBuildInputs = [ makeWrapper ];
  installPhase = ''
    mkdir -p $out/bin
    cp jot $out/bin 
    wrapProgram $out/bin/jot --prefix PYTHONPATH : $PYTHONPATH \
                             --prefix PATH : ${urlsnap}/bin
  '';
}
