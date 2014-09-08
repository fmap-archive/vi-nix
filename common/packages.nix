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
    coreutils
    dzen2
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
    inetutils
    imagemagick
    calibre
    irssi
    nix-prefetch-scripts
    mercurial
    mnemosyne
    mplayer
    msmtp
    mutt
    offlineimap
    pdftk
    pinentry
    pkgconfig
    postgresql
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
    tmux
    tree
    unclutter
    unzip
    vim
    wget
    wpa_supplicant
    xclip
    xlibs.xev
    xlibs.xinit
    xlibs.xkbcomp
    xorg.xkill
    xorg.xwininfo
    youtubeDL
    texLiveFull
    zathura
    zip
    zlib
    perlPackages.CryptBlowfish
    perlPackages.CryptDH
    perlPackages.CryptOpenSSLBignum
    perlPackages.MathBigInt
    s3cmd_15_pre_81e3842f7a
  ];
 nixpkgs.config = {
   packageOverrides = pkgs: {
      surf      = pkgs.callPackage ./packages/surf {
        webkit = pkgs.webkitgtk2;
      };
      mutt      = pkgs.callPackage ./packages/mutt {};
      zathura = recurseIntoAttrs
        (let 
          callPackage = newScope pkgs.zathuraCollection;
          fetchurl = pkgs.fetchurl;
         in import packages/zathura { inherit callPackage pkgs fetchurl; }
        ).zathuraWrapper;
   };
 };
}
