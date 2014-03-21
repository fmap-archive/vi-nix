{ config, pkgs, ... }:

{
  services.openssh.enable = false;
  services.printing.enable = false;
  services.acpid.enable = true;

  services.xserver = {
    enable = true;
    exportConfiguration = true;
    xkbOptions = "ctrl:nocaps,compose:rwin";
    windowManager.default = "none";
    desktopManager.xterm.enable = false;
    desktopManager.default = "none";
    displayManager.slim.defaultUser = "vi";
  };
}
