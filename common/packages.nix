{ config, pkgs, lib, ... }:

let 
  recurseIntoAttrs = attrs: attrs // { recurseIntoDerivations = true; };  
  newScope = extra: lib.callPackageWith (pkgs // extra);
  bundler = lib.overrideDerivation pkgs.rubyLibs.bundler (_: {
    dontPatchShebangs = 1;
  });
in {
  environment.systemPackages = with pkgs; [
    acpi
    acpid
    bc
    bind
    binutils
    bundler
    cacert
    calibre
    coreutils
    dzen2
    exif
    feh
    ffmpeg
    file
    git
    gitAndTools.hub
    gnome.zenity
    gnumake
    gnupg
    gnused
    htop
    imagemagick
    inetutils
    irssi
    mercurial
    mnemosyne
    mplayer
    msmtp
    mysql
    mutt
    nixops
    nix-prefetch-scripts
    offlineimap
    pdftk
    pinentry
    pkgconfig
    postgresql
    proxychains
    psmisc
    python27Packages.mutagen
    redshift
    rsync
    ruby
    rxvt_unicode
    scrot
    slock
    sshfsFuse
    surf
    tcpdump
    texLiveFull
    tmux
    tree
    unclutter
    unzip
    vim
    wget
    wireshark
    wpa_supplicant
    xclip
    xlibs.xev
    xlibs.xinit
    xlibs.xkbcomp
    xorg.xkill
    xorg.xwininfo
    youtubeDL
    zathura
    zip
    zlib
    perlPackages.CryptBlowfish
    perlPackages.CryptDH
    perlPackages.CryptOpenSSLBignum
    perlPackages.MathBigInt
    s3cmd_15_pre_81e3842f7a
  ];
  nixpkgs.config.packageOverrides = pkgs : {
    surf      = pkgs.callPackage ./packages/surf {
      webkit = pkgs.webkitgtk2;
    };
    mutt = lib.overrideDerivation pkgs.mutt (default: {
      name = "mutt-1.5.22";
      src  = pkgs.fetchhg {
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
    zathura = recurseIntoAttrs
      (let 
        callPackage = newScope pkgs.zathuraCollection;
        fetchurl = pkgs.fetchurl;
       in import packages/zathura { inherit callPackage pkgs fetchurl; }
      ).zathuraWrapper;
 };
}
