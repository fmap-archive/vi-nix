{ config, pkgs, lib, ... }:

{
  services.openssh = {
    passwordAuthentication = false;
    challengeResponseAuthentication = false;
    permitRootLogin = "no";
    extraConfig = ''
      Ciphers aes256-ctr
      MACs hmac-sha2-512
    '';
  };

  services.autocutsel.enable = !config.environment.isServer;

  services.printing.enable = false;

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
    [ "*/5 * * * * vi /home/vi/bin/cron/courier"
      "*/5 * * * * vi /home/vi/bin/cron/dwarf"
    ];

  services.git-mirror.remotes = if config.environment.isServer then [] else [
    { repo = "git@github.com:fmap/vi-etc.git"; name = "vi-etc"; key = "/etc/keys/github.vi-etc.id_rsa"; }
    { repo = "git@github.com:fmap/vi-bin.git"; name = "vi-bin"; key = "/etc/keys/github.vi-bin.id_rsa"; }
  ];

  services.secrets = if (config.services.git-mirror.remotes == []) then [] else [
    { key = "github.vi-bin.id_rsa"; user = "root"; group = "root"; chmod = "0"; }
    { key = "github.vi-etc.id_rsa"; user = "root"; group = "root"; chmod = "0"; }
  ];

  services.mysql.enable = !config.environment.isServer;
  services.mysql.package = pkgs.mysql;
}
