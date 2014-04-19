{ config, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.kernelModules = [ "dm_crypt" "fbcon" "aesni_intel" "hid_apple" "wl" ];
  boot.initrd.availableKernelModules = [ "xhci_hcd" "ehci_pci" "ahci" ];
  boot.blacklistedKernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" "fuse" ];
  boot.extraModulePackages = [ pkgs.linuxPackages.broadcom_sta ];

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
