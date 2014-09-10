{ config, pkgs, ... }:

{
  imports = [
    ./machines.nix
    ../hardware/mbp.nix
  ];

  boot.loader.grub.enable = false;
  boot.loader.gummiboot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "euclid"; 
  networking.wireless.enable = true;

  i18n.consoleFont = "sun12x22";

  services.xserver = {
    multitouch = {
      enable       = true;
      invertScroll = true;
      ignorePalm   = true;
    };
    videoDrivers = [ "intel" ];
  };

  environment.isServer = false;
}
