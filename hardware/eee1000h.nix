{ config, pkgs, ... }:

{
  imports =
    [ <nixos/modules/installer/scan/not-detected.nix>
    ];

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

  swapDevices =[ ];

  nix.maxJobs = 2;
}
