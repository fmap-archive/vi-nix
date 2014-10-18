{ config, pkgs, lib, ... }:

{
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
  };

  services.printing.enable = true;

  services.acpid = {
    enable = !config.environment.isServer;
    lidEventCommands = ''
      lidClosed()     { grep -q closed /proc/acpi/button/lid/LID*/state; };
      isDischarging() { grep -qi 'discharging' /sys/class/power_supply/BAT*/status; }
      sleep 2; if `lidClosed`; then isDischarging && poweroff; fi
    '';
  };

  services.xserver = {
    enable = !config.environment.isServer;
    exportConfiguration = true;
    xkbOptions = "ctrl:nocaps,compose:rwin";
    windowManager.default = "none";
    desktopManager.xterm.enable = false;
    desktopManager.default = "none";
    displayManager.slim.defaultUser = "vi";
  };

  system.activationScripts.ssl =
    ''
      ln -sf /etc/ssl/certs/ca-bundle.crt /etc/ssl/certs/ca-certificates.crt
    '';

  systemd.services."display-manager".preStart =
    ''
      chmod a+w $(realpath /sys/class/backlight/intel_backlight/brightness)
      chmod a+w $(realpath '/sys/class/leds/smc::kbd_backlight/brightness')
    '';

  services.cron.systemCronJobs = lib.mkIf (!config.environment.isServer)
    [ "*/5 * * * * vi ${pkgs.vi-bin}/bin/cron/courier"
      "*/5 * * * * vi ${pkgs.vi-bin}/bin/cron/dwarf"
    ];

  services.git-mirror.remotes = [
    { repo = "git@github.com:fmap/vi-etc.git"; name = "vi-etc"; key = "/root/.ssh/github.vi-etc.id_rsa"; }
    { repo = "git@github.com:fmap/vi-bin.git"; name = "vi-bin"; key = "/root/.ssh/github.vi-bin.id_rsa"; }
  ];

  # XXX: implement more general secret relocation
  system.activationScripts.installMirrorKeys = ''
    mkdir -p /root/.ssh
    cp ${<secrets>}/github*id* /root/.ssh
    chown root:root /root/.ssh/github*id* # XXX: Too brittle.
    chmod 0 /root/.ssh/github*id*
  '';
}
