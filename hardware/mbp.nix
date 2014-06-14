{ config, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.kernelPackages = pkgs.linuxPackages_3_14;
  boot.initrd.kernelModules = [ "dm_crypt" "fbcon" "aesni_intel" "hid_apple" "wl" "kvm-intel" "fuse" ];
  boot.initrd.availableKernelModules = [ "xhci_hcd" "ehci_pci" "ahci" ];
  boot.blacklistedKernelModules = [ ];
  boot.extraModulePackages = [
    pkgs.linuxPackages_3_14.broadcom_sta
  ];

  boot.initrd.luks.devices = [
    { name = "graveyard"; device = "/dev/sda4"; preLVM = true; }
  ];

  fileSystems."/" =
    { device = "/dev/mapper/tomb-root";
      fsType = "ext4";
    };

  fileSystems."/home" =
    { device = "/dev/mapper/tomb-home";
      fsType = "ext4";
    };

  fileSystems."/tmp" =
    { device = "/dev/mapper/tomb-tmp";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/sda1";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/dm-2"; }
    ];

  nix.maxJobs = 4;
}
