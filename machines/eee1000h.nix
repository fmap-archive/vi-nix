{ config, pkgs, ... }:

{
  require =
    [ ./machines.nix
      ../hardware/eee1000h.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "nodev";  

  networking.hostName = "birkhoff";
  networking.wireless.enable = false;
}
