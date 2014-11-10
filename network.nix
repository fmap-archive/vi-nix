{ network.description = "vi's network";

  maclane = { 
    imports = [./physical/mba.nix ./logical/maclane.nix];
  };

  birkhoff = { 
    imports = [./physical/eee1000h.nix ./logical/birkhoff.nix]; 
  };
  
  euclid = { 
    imports = [./physical/mbp.nix ./logical/euclid.nix]; 
  };
}
