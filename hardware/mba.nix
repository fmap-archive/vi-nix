{ config, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];
  
  boot.initrd.kernelModules = [ "dm_crypt" "fbcon" "aesni_intel" "hid_apple" ];
  boot.initrd.availableKernelModules = [ "xhci_hcd" "ehci_pci" "ahci" ];
  boot.kernelModules = [ "kvm_intel" ];
  boot.extraModulePackages = [ ];

  boot.initrd.luks.devices = [
    { name = "tomb"; device = "/dev/sda4"; preLVM = true; }
  ];

  fileSystems."/" =
    { device = "/dev/mapper/rings-root";
      fsType = "ext4";
      options = "rw,data=ordered,relatime";
    };

  fileSystems."/tmp" =
    { device = "/dev/mapper/rings-tmp";
      fsType = "ext4";
      options = "rw,relatime";
    };

  fileSystems."/home" =
    { device = "/dev/mapper/rings-home";
      fsType = "ext4";
      options = "rw,data=ordered,relatime";
    };

  fileSystems."/boot" =
    { device = "/dev/sda1";
      fsType = "vfat";
      options = "rw,fmask=0022,dmask=0022,codepage=437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro,relatime";
    };

  fileSystems."/media/wadler" = 
    { device = "/dev/sda2";
      fsType = "hfsplus";
    };

  swapDevices =[ ];

  nix.maxJobs = 4;
}
