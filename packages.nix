{ config, pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    acpi
    acpid
    bc
    vi-bin
    bind
    binutils
    cacert
    coreutils
    dos2unix
    exif
    ffmpeg
    file
    git
    gitAndTools.hub
    gnumake
    gnupg
    gnused
    htop
    imagemagick
    inetutils
    irssi
    lsof
    mercurial
    mplayer
    msmtp
    mysql
    vi-mutt
    nixops
    nix-prefetch-scripts
    nmap
    pdftk
    pkgconfig
    postgresql
    proxychains
    psmisc
    python27Packages.mutagen
    rsync
    s3cmd_15_pre_81e3842f7a
    tcpdump
    texLiveFull
    tmux
    tree
    unclutter
    unzip
    vim
    w3m
    wget
    wireshark
    youtubeDL
    zip
    zlib
    perlPackages.CryptBlowfish
    perlPackages.CryptDH
    perlPackages.CryptOpenSSLBignum
    perlPackages.MathBigInt
  ] ++ (if ! config.environment.isServer then [
    calibre
    dzen2
    feh
    gnome.zenity
    mnemosyne
    offlineimap
    pinentry
    redshift
    rxvt_unicode
    scrot
    slock
    vi-surf
    wpa_supplicant
    xclip
    xlibs.xev
    xlibs.xinit
    xlibs.xkbcomp
    xorg.xkill
    xorg.xwininfo
    vi-zathura
  ] else []);

  nixpkgs.config.packageOverrides = pkgs : {
    vi-surf    = pkgs.callPackage ./packages/vi-surf {};
    vi-mutt    = pkgs.callPackage ./packages/vi-mutt {};
    vi-zathura = pkgs.callPackage ./packages/vi-zathura {};
    vi-bin     = pkgs.callPackage ./packages/vi-bin {};
  };
}
