{ pkgs, base, ... }: pkgs.lib.overrideDerivation base.nixUnstable (_: {
  patches = [ <vi-nix/packages/nix/no-set-ps1.patch> ];
})
