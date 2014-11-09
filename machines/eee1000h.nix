{ config, pkgs, ... }:

{
  imports =
    [ <nixos/modules/installer/scan/not-detected.nix>
      ./machines.nix
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

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "nodev";

  nix.maxJobs = 2;

  networking.hostName = "birkhoff";
  networking.wireless.enable = false;

  environment.isServer = true;

  networking.firewall.enable = true;
  networking.firewall.rejectPackets = true;
  networking.firewall.allowPing = false;
  networking.firewall.allowedTCPPorts = [22];
  networking.firewall.allowedUDPPortRanges = [];

  services.openssh.enable = true;
}
