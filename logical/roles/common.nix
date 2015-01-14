{ config, pkgs, lib, ... }:
{ imports = [
    ../../modules/git-mirror.nix
    ../../modules/secrets.nix
    ../../modules/tor-hidden-service.nix
  ];
  
  users.mutableUsers = false;

  users.extraUsers.root = {
    openssh.authorizedKeys.keys = config.users.extraUsers.vi.openssh.authorizedKeys.keys;
  };

  users.extraUsers.vi = {
    isNormalUser = true;
    description = "vi";
    extraGroups = ["wheel" "vboxusers" ];
    group = "users";
    home = "/home/vi";
    hashedPassword = "$6$jsl6DJ3J$p/45DOLzK5frmUNKonpcsWx5f.cQuz6Su6wjBftoQnM7DHzdTo/6Lh0OaV1E7Jn4dp4OrzaepjACz/zZqbCIP0";
    useDefaultShell = true;
    uid = 1337;
    openssh.authorizedKeys.keys = ["ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBAAnko8n4kcVcreZO62HdQ/s9ysRHrCwUKc17f7aITwSOmwJUDmmCBrODYvkIr822kgrG0dykfrIjSa1hi0xtCjFEACreAX0N2oiocqrAgeBfbQnGjeziDoqDpOUdI1rdiMK3XN3ZTvZsRFe1HO0vDv/JkfaV4+gnzBxwXW2jgkebKI/6w==" "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC6EXMZwI6ng1irYcl8CBkj4X7gSj23BTbA0N7gHPHz7pNOeF0MkTa7Yx0iqS2nOjMb6jvaW6T0GBZSLL0f6rpaiABA0cZEArZ/O408QROZxK5wiR7HtO3NZsCKrTR37neWkDaNhUuL08Q6PrVDQOj14aFRa290WRXmCesTuEsK0PMxWjOtZZsqaFq5czl6grcnK1L5tDEeLU7V6xlsy/49WCKySSGu9+Le0Ao/K0Qr3vvssUdF/xWGk6ipo3DFxkiAR42NSB4SpuKuieYBN+bPFtpbgIfoZqUNMS3RFV/RU3EsZu2QmVjc5STbNHscKBsKQbe/+wUMzgd2NbYcHfst"];
  };

  security.initialRootPassword = "!";

  # Locale
  i18n = {
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
    supportedLocales = ["en_US.UTF-8"];
  };
  time = {
    timeZone = "UTC";
  };
  # Nix
  nixpkgs.config.allowUnfree = true;

  nix.binaryCaches = [
    https://hydra.nixos.org
  ];

  nix.trustedBinaryCaches = config.nix.binaryCaches;

  nix.extraOptions = ''
    allow-unsafe-native-code-during-evaluation = true
    allow-unfree = true
  '';

  # Core Packages
  environment.systemPackages = with pkgs; [
    acpi
    bc
    bind
    binutils
    cacert
    coreutils
    dos2unix
    file
    git
    gnumake
    gnupg
    gnused
    graphviz
    htop
    inetutils
    lsof
    mercurial
    nix-prefetch-scripts
    nix-repl
    nix-exec
    openssl
    rsync
    tcpdump
    tmux
    tree
    unzip
    vim
    wget
    zip
  ];
  nixpkgs.config.packageOverrides = base: {
    vi-surf                = pkgs.callPackage ../../packages/vi-surf {};
    vi-mutt                = pkgs.callPackage ../../packages/vi-mutt {};
    vi-zathura             = pkgs.callPackage ../../packages/vi-zathura {};
    vi-nix                 = pkgs.callPackage ../../packages/vi-nix {};
    vi-znc                 = pkgs.callPackage ../../packages/vi-znc {};
    vi-irssi               = pkgs.callPackage ../../packages/vi-irssi {};
    otf-letter-gothic-mono = pkgs.callPackage ../../packages/otf-letter-gothic-mono {};
    tor                    = pkgs.callPackage ../../packages/tor/faster-ecdh.nix { inherit base; };
  };

  # Networking
  networking.enableIPv6 = false;

  # Services
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    challengeResponseAuthentication = false;
    listenAddresses = [{ addr = "127.0.0.1"; port = 22; }];
    hostKeys = [
     { path = "/etc/ssh/ssh_host_ed25519_key";
       type = "ed25519";
       bits = 9001; # ACHTUNG! Fixed length key, but nixpkgs balks if this is unspecified. OpenSSH balks if this is specified but small.
     }
     { path = "/etc/ssh/ssh_host_rsa_key";
       type = "rsa";
       bits = 4096;
     }
    ];
    extraConfig = ''
      KexAlgorithms curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256
      Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr
      MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-ripemd160-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256,hmac-ripemd160,umac-128@openssh.com
    '';
  };

  programs.ssh.extraConfig = ''
    Host github.com
      KexAlgorithms curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256,diffie-hellman-group-exchange-sha1,diffie-hellman-group14-sha1
    Host *
      KexAlgorithms curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256
      Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr
      MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-ripemd160-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256,hmac-ripemd160,umac-128@openssh.com
      PasswordAuthentication no
  '';

  services.tor.hiddenServices = [
    { name = "ssh"; port = 22; }
  ];

  system.activationScripts.ssl = ''
    ln -sf /etc/ssl/certs/ca-bundle.crt /etc/ssl/certs/ca-certificates.crt
  '';
  
  services.git-mirror.remotes = [
    { repo = "git@github.com:fmap/vi-etc.git"; name = "vi-etc"; key = "/etc/keys/github.vi-etc.id_rsa"; }
    { repo = "git@github.com:fmap/vi-bin.git"; name = "vi-bin"; key = "/etc/keys/github.vi-bin.id_rsa"; }
  ];

  services.secrets = [
    { key = "github.vi-bin.id_rsa"; user = "root"; group = "root"; chmod = "0"; }
    { key = "github.vi-etc.id_rsa"; user = "root"; group = "root"; chmod = "0"; }
  ];
}
