{ config, pkgs, ... }:

{
  imports =
    [ ../hardware/mbp.nix
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
}
