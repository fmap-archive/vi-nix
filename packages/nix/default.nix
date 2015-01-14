{ pkgs, base, ... }: pkgs.lib.overrideDerivation base.nixUnstable (_: {
  patches = [ ./no-set-ps1.patch ];
})
