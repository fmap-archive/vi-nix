{ config, pkgs, lib, ... }:
{
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
    htop
    inetutils
    lsof
    mercurial
    nix-prefetch-scripts
    nix-repl
    rsync
    tcpdump
    tmux
    tree
    unzip
    vim
    wget
    zip
  ] ++ (if ! config.environment.isServer then [
    acpid
    calibre
    dzen2
    exif
    fbreader
    feh
    ffmpeg
    gitAndTools.hub
    gnome.zenity
    imagemagick
    irssi
    mnemosyne
    mplayer
    msmtp
    mysql
    nixops
    nmap
    offlineimap
    pdftk
    perlPackages.CryptBlowfish
    perlPackages.CryptDH
    perlPackages.CryptOpenSSLBignum
    perlPackages.MathBigInt
    pinentry
    pkgconfig
    postgresql
    proxychains
    psmisc
    python27Packages.mutagen
    redshift
    rxvt_unicode
    s3cmd_15_pre_81e3842f7a
    scrot
    slock
    texLiveFull
    unclutter
    vi-nix
    vi-mutt
    vi-surf
    vi-zathura
    w3m
    wireshark
    wpa_supplicant
    xclip
    xlibs.xev
    xlibs.xinit
    xlibs.xkbcomp
    xorg.xkill
    xorg.xwininfo
    youtubeDL
    zlib
  ] else []);

  nixpkgs.config.packageOverrides = pkgs : {
    vi-surf    = pkgs.callPackage ./packages/vi-surf {};
    vi-mutt    = pkgs.callPackage ./packages/vi-mutt {};
    vi-zathura = pkgs.callPackage ./packages/vi-zathura {};
    vi-nix     = pkgs.callPackage ./packages/vi-nix {};
  };
}
