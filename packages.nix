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
    mutt
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
    surf
    wpa_supplicant
    xclip
    xlibs.xev
    xlibs.xinit
    xlibs.xkbcomp
    xorg.xkill
    xorg.xwininfo
    zathura
  ] else []);

  nixpkgs.config.packageOverrides = pkgs : {
    surf = lib.overrideDerivation pkgs.surf (default : {
      src = pkgs.fetchgit {
        url = https://github.com/fmap/surf-vi;
        rev = "724a391dee3bf3df5172ef7d3cb2bc0c205670f5";
        sha256 = "3fd42772d2d886b5ccc7f6b5a18c6d6e9bc4c856400d768e98a026460f80dcf7";
      };
      buildInputs = with pkgs; [
        wget 
        gnome3.zenity
      ];
    });
    mutt = lib.overrideDerivation pkgs.mutt (default: {
      name = "mutt-1.5.22";
      src = pkgs.fetchhg {
        url = "https://bitbucket.org/mutt/mutt";
        rev = "8f62001";
      };
      buildInputs = with pkgs; [
        autoconf
        automake
      ];
      preConfigure = ''
        autoreconf --install
      '';
      patches = [
        ./packages/mutt-1.5.22-hidestatus.patch
      ];
    });
    zathura = lib.overrideDerivation pkgs.zathura (default: {
      src = pkgs.fetchurl {
        url = "https://github.com/fmap/zathura-vi/releases/download/vi-0.2.8/zathura-0.2.7.tar.gz";
        sha256 = "8cb6553f67c4e53e23f11a2d83c19bc41fcf0c15933d70e801c598c17480dbd2";
      };
    });
 };
}
