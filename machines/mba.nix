{ config, pkgs, ... }:

{
  require =
    [ ./machines.nix
      ../hardware/mba.nix
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

  environment.isServer = false;
}
