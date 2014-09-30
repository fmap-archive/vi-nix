{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    acpi
    acpid
    bc
    bind
    binutils
    cacert
    coreutils
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
    mercurial
    mplayer
    msmtp
    mysql
    vi-mutt
    nixops
    nix-prefetch-scripts
    pdftk
    pkgconfig
    postgresql
    proxychains
    psmisc
    python27Packages.mutagen
    rsync
    tcpdump
    texLiveFull
    tmux
    tree
    unclutter
    unzip
    vim
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
  };
}
