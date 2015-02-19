# This is @proger's design, but says he doesn't mind me stealing it. <3

let
  inherit (import ./lib) mapcats;
in rec {
  defscope = {
    vi-nix = ./.;
    nixos = ./vendor/nixpkgs/nixos;
  };

  dependencies = {
    nixpkgs = {
      url = "git://github.com/NixOS/nixpkgs.git";
      rev = "4c125ceddc834be9567c6ea4404021fa13d844c3";
    };
    surf-vi = {
      url = "git://github.com/fmap/surf-vi";
      rev = "724a391dee3bf3df5172ef7d3cb2bc0c205670f5";
    };
    zathura-vi = {
      url = "git://github.com/fmap/zathura-vi";
      rev = "e86077de8a9950fb72a9935772aa3b6eba70e97e";
    };
  };

  # $CHECKOUT_DEST must be exported and point to an absolute path.
  prefetch-script =
    { name, url, rev ? null, branch ? null, force-fetch ? false }:
    let
      git = ''''$CHECKOUT_DEST/_cache/${name}.git'';
      ref = if rev != null then rev else "$(env GIT_DIR=${git} git rev-parse ${name}/${branch})";
    in ''
      ${if !force-fetch then ''
      if [ -d ${git} ] &&
         [ "$(cd $CHECKOUT_DEST/${name} && git rev-parse HEAD)" == "${ref}" ];
      then
        echo ${name} is already at rev ${ref} >&2
      else
      '' else ''
      echo bypassing version check >&2
      if [ 1 -eq 1 ]; then
      ''}

        [ ! -d ${git} ] && git init --bare ${git}
        env GIT_DIR=${git} git remote add ${name} ${url} 2>&1 || true
        [ -z "$ERIS_NOFETCH" ] && env GIT_DIR=${git} git fetch ${name}
        if [ ! -d $CHECKOUT_DEST/${name} ]; then
          (cd $CHECKOUT_DEST; git clone -n --shared ${git} ${name})
        fi
        ( cd $CHECKOUT_DEST/${name}
          git checkout "${ref}" -- .
          git checkout "${ref}"
          git submodule init
          git submodule update
        )
      fi
    '';

  get-dependencies = ''
    export CHECKOUT_DEST=$PWD/vendor
    mkdir -p $CHECKOUT_DEST
  '' + mapcats (name: path: ''
      [ ! -L $CHECKOUT_DEST/${name} ] && ln -svf ${toString path} $CHECKOUT_DEST/${name}
  '') defscope
     + mapcats (name: as: ''
      ${prefetch-script { inherit name; inherit (as) url rev; }}
  '') dependencies;
}
