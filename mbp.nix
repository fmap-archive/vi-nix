{ config, pkgs, ... }:

{
  imports =
    [ ./hardware/mbp.nix
      ./common/services.nix
      ./common/users.nix
      ./common/packages.nix
      ./common/locale.nix
      ./common/security.nix
      ./common/network.nix
      ./common/nix.nix
      <nixos/modules/programs/virtualbox.nix>
    ];

  boot.loader.grub.enable = false;
  boot.loader.gummiboot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "euclid"; 
  networking.wireless.enable = true;

  services.xserver = {
    multitouch = {
      enable       = true;
      invertScroll = true;
      ignorePalm   = true;
    };
    videoDrivers = [ "intel" ];
  };
}
