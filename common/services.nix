{ config, pkgs, ... }:

{
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
  };

  services.printing.enable = true;

  services.acpid = {
    enable = true;
    lidEventCommands = ''
      lidClosed()     { grep -q closed /proc/acpi/button/lid/LID*/state; };
      isDischarging() { grep -qi 'discharging' /sys/class/power_supply/BAT*/status; }
      sleep 2; if `lidClosed`; then isDischarging && poweroff; fi
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

  system.activationScripts.ssl =
    ''
      ln -s /etc/ssl/certs/ca-bundle.crt /etc/ssl/certs/ca-certificates.crt 
    '';
  
  systemd.services."display-manager".preStart = ''
    chmod a+w $(realpath /sys/class/backlight/intel_backlight/brightness)
    chmod a+w $(realpath '/sys/class/leds/smc::kbd_backlight/brightness')
  '';

  services.cron.systemCronJobs = 
    [ "*/5 * * * * vi /home/vi/bin/cron/courier" 
      "*/5 * * * * vi /home/vi/bin/cron/dwarf"
    ];

  services.tor.client.enable = true;

  # Tor configuration. With the property unset, the file reads:
  #
  #    DataDirectory /var/lib/tor
  #    User tor
  #    SOCKSPort 127.0.0.1:9050 IsolateDestAddr
  #    SOCKSPort 127.0.0.1:9063

  services.tor.config = ''
    AutomapHostsOnResolve 1
    TransPort 9040
    DNSPort 53
    AutomapHostsOnResolve 1
    AutomapHostsSuffixes .onion
  '';
}
