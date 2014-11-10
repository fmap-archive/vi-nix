{ config, pkgs, ... }:

{ imports = [ <nixos/modules/installer/scan/not-detected.nix> ];
  
  deployment.targetEnv = "none";
  deployment.targetHost = "tc4ozxdi7wxpmsey.onion";

  boot.initrd.availableKernelModules = [ "uhci_hcd" "ehci_hcd" "ata_piix" ];
  boot.kernelModules = ["dm_crypt" "fuse"];
  boot.extraModulePackages = [ ];

  boot.initrd.luks.devices = [{ device = "/dev/sda1"; name="tomb"; }];

  fileSystems = [
    { mountPoint = "/";
      device = "/dev/mapper/tomb";
      fsType = "ext4";
      options = "rw,data=ordered,relatime";
    }
    { mountPoint = "/boot";
      device = "/dev/sda2";
    }
  ];

  swapDevices = [];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "nodev";

  networking.wireless.enable = true;

  nix.maxJobs = 2;
}
