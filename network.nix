{ network.description = "vi's network";

  maclane = { 
    imports = [ <vi-nix/physical/mba.nix> <vi-nix/logical/maclane.nix>];
  };

  birkhoff = { 
    imports = [ <vi-nix/physical/eee1000h.nix> <vi-nix/logical/birkhoff.nix> ]; 
  };
  
# lang = {
#   imports = [ <vi-nix/physical/dc3217iye.nix> <vi-nix/logical/lang.nix> ];
# };
}
