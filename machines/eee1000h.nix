{ config, pkgs, ... }:

{
  require = [
    ../hardware/eee1000h.nix
    ../services.nix
    ../users.nix
    ../packages.nix
    ../locale.nix
    ../security.nix
    ../network.nix
    ../nix.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "nodev";  

  networking.hostName = "birkhoff";
  networking.wireless.enable = false;
}
