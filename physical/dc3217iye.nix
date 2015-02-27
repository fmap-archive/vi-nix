{ config, pkgs, ... }:

{ imports = [ <nixos/modules/installer/scan/not-detected.nix> ];

  deployment.targetEnv = "none";

  boot.initrd.availableKernelModules = [ "ehci_pci" "ahci" "usbhid" "usb_storage" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/5e5d27d9-16e7-4add-a5cc-adfa2835af33";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/81777766-aa8a-49d3-a5b9-4c907a2174d0";
      fsType = "ext2";
    };

  swapDevices = [ ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";
  networking.hostId = "11f1026f";

  nixpkgs.system = "i686-linux";

  nix.maxJobs = 4;
}
