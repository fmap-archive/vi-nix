{ config, pkgs, ... }:

{
  require = [
    ./hardware/eee1000h.nix
    ./common/services.nix
    ./common/users.nix
    ./common/packages.nix
    ./common/locale.nix
    ./common/security.nix
    ./common/network.nix
    ./common/nix.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "nodev";  

  networking.hostName = "birkhoff";
  networking.wireless.enable = false;
}
