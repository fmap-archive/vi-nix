{ pkgs, base, ... }: pkgs.lib.overrideDerivation base.zathuraCollection.zathuraWrapper (_: {
  zathura_core = pkgs.lib.overrideDerivation base.zathuraCollection.zathuraWrapper.zathura_core (_ : {
    src = pkgs.fetchgit {
      url    = https://github.com/fmap/zathura-vi;
      rev    = "e86077de8a9950fb72a9935772aa3b6eba70e97e";
      sha256 = "fa2af0b2364cf172bc906afa01ba0a0d36f7c42957ecdb702d3e03faec0673cc";
    };
    buildInputs = [pkgs.python27Packages.sphinx];
  });
})