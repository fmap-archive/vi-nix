{ config, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
      ./machines.nix
    ];

  boot.initrd.kernelModules = [ "dm_crypt" "fbcon" "aesni_intel" "hid_apple" ];
  boot.initrd.availableKernelModules = [ "xhci_hcd" "ehci_pci" "ahci" ];
  boot.kernelModules = [ "kvm_intel" "fuse" ];
  boot.extraModulePackages = [ ];

  boot.initrd.luks.devices = [
    { name = "tomb"; device = "/dev/sda2"; preLVM = true; }
  ];

  fileSystems."/" =
    { device = "/dev/mapper/tomb";
      fsType = "ext4";
      options = "rw,data=ordered,relatime";
    };

  fileSystems."/boot" =
    { device = "/dev/sda1";
      fsType = "vfat";
      options = "rw,fmask=0022,dmask=0022,codepage=437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro,relatime";
    };

  swapDevices = [ ];

  boot.loader.grub.enable = false;
  boot.loader.gummiboot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.gummiboot.timeout = 4;

  networking.hostName = "maclane";
  networking.wireless.enable = true;

  services.xserver.multitouch = {
    enable       = true;
    invertScroll = true;
    ignorePalm   = true;
  };

  environment.isServer = false;

  nix.maxJobs = 4;
}
