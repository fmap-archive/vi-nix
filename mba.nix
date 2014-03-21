{ config, pkgs, ... }:

{
  require =
    [ ./hardware/mba.nix
      ./common/services.nix
      ./common/users.nix
      ./common/packages.nix
      ./common/locale.nix
      ./common/security.nix
      ./common/network.nix
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
