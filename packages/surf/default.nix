{ pkgs, base, ... }: pkgs.lib.overrideDerivation base.surf (_: {
  src = <surf-vi>;
  buildInputs = with pkgs; [ wget gnome3.zenity ];
})
