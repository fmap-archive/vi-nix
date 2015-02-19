{ pkgs, base, ... }: pkgs.lib.overrideDerivation base.zathuraCollection.zathuraWrapper (_: {
  zathura_core = pkgs.lib.overrideDerivation base.zathuraCollection.zathuraWrapper.zathura_core (_ : {
    src = <zathura-vi>;
    buildInputs = [pkgs.python27Packages.sphinx];
  });
})
