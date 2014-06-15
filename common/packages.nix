{ config, pkgs, lib, ... }:

let 
  recurseIntoAttrs = attrs: attrs // { recurseIntoDerivations = true; };  
  newScope = extra: lib.callPackageWith (pkgs // extra);
  bundler = lib.overrideDerivation pkgs.rubyLibs.bundler (_: {
    dontPatchShebangs = 1;
  });
in {
  environment.systemPackages = with pkgs; [
    bc
    coreutils
    gnused
    xorg.xkill
    inetutils
    mnemosyne
    acpi
    acpid
    psmisc
    xlibs.xkbcomp
    unclutter
    bind
    dzen2
    python27Packages.mutagen
    xorg.xwininfo
    xlibs.xev
    cacert
    feh
    ffmpeg
    file
    git
    gnumake
    gnupg
    htop
    irssi
    mplayer
    msmtp
    mutt
    offlineimap
    pinentry
    pkgconfig
    redshift
    mercurial
    rsync
    rxvt_unicode
    scrot
    slock
    sshfsFuse
    surf
    tree
    tmux
    unzip
    vim
    wget
    wpa_supplicant
    xclip
    postgresql
    xlibs.xinit
    zathura
    gnome.zenity
    zip
    zlib
    ruby
    bundler
    (haskellPackages.ghcWithPackages (self : [
      self.cabalInstall_1_18_0_3
      self.xmonad
      self.xmonadContrib
      self.xmonadExtras
      self.pandoc
      self.cabal2nix
      self.interpolate
      self.lens
      self.hmatrix
    ]))
    perlPackages.CryptBlowfish
    perlPackages.CryptDH
    perlPackages.CryptOpenSSLBignum
    perlPackages.MathBigInt
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
