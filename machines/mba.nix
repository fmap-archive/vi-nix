{ config, pkgs, ... }:

{
  require =
    [ ../hardware/mba.nix
      ../services.nix
      ../users.nix
      ../packages.nix
      ../locale.nix
      ../security.nix
      ../network.nix
      ../nix.nix
      <nixos/modules/programs/virtualbox.nix>
    ];

  boot.loader.grub.enable = false;
  boot.loader.gummiboot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.gummiboot.timeout = 4;

  networking.hostName = "maclane"; 
  networking.wireless.enable = true;  

  services.xserver.multitouch = {
    enable       = true;
    invertScroll = true;
    ignorePalm   = true;
  };
}
