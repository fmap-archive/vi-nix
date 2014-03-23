{ config, pkgs, ... }:

{
  services.openssh.enable = false;
  services.printing.enable = false;

  services.acpid = {
    enable = true;
    lidEventCommands = ''
      lidClosed()  { grep -q closed /proc/acpi/button/lid/LID*/state; };
      isCharging() { grep -qiP '(?<!dis)charging' /sys/class/power_supply/BAT*/status; }
      sleep 2; if `lidClosed`; then isCharging || poweroff; fi
    '';
    acEventCommands = ''
      isCharging()    { grep -qiP '(?<!dis)charging' /sys/class/power_supply/BAT*/status; }
      setBrightness() { echo -n $1 > /sys/class/backlight/intel_backlight/brightness; }
      sleep 2; isCharging && setBrightness 200 || setBrightness 120
    '';
  };

  services.xserver = { 
    enable = true;
    exportConfiguration = true;
    xkbOptions = "ctrl:nocaps,compose:rwin";
    windowManager.default = "none";
    desktopManager.xterm.enable = false;
    desktopManager.default = "none";
    displayManager.slim.defaultUser = "vi";
  };
  
  systemd.services."display-manager".preStart = ''
    chmod a+w $(realpath /sys/class/backlight/intel_backlight/brightness)
    chmod a+w $(realpath '/sys/class/leds/smc::kbd_backlight/brightness')
  '';

  services.cron.systemCronJobs = 
    [ "*/5 * * * * vi /home/vi/bin/cron/courier" 
      "*/5 * * * * vi /home/vi/bin/cron/dwarf"
    ];
}
