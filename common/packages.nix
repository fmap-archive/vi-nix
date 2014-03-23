{ config, pkgs, lib, ... }:

let 
  recurseIntoAttrs = attrs: attrs // { recurseIntoDerivations = true; };  
  newScope = extra: lib.callPackageWith (pkgs // extra);
  bundler = lib.overrideDerivation pkgs.rubyLibs.bundler (_: {
    dontPatchShebangs = 1;
  });
in {
  environment.systemPackages = with pkgs; [
    #amphetype
    #mnemosyne
    acpi
    acpid
    spotify
    psmisc
    xlibs.xkbcomp
    unclutter
    bind
    dzen2
    python27Packages.mutagen
    xorg.xwininfo
    xlibs.xev
    cacert
    chromium
    feh
    file
    gcc
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
    skype
    slock
    sshfsFuse
    surf
    tmux
    unzip
    vim
    wget
    wireshark
    wpa_supplicant
    xclip
    xlaunch
    xlibs.xinit
    zathura
    gnome.zenity
    zip
    zlib
    ruby
    calibre
    bundler
    (haskellPackages.ghcWithPackages (self : [
      self.cabalInstall
      self.xmonad
      self.xmonadContrib
      self.xmonadExtras
      self.pandoc
      # ...
      self.lens
      self.hmatrix
    ]))
  ];
 nixpkgs.config = {
   packageOverrides = pkgs: {
      surf    = pkgs.callPackage ./packages/surf {};
      zathura = recurseIntoAttrs
        (let 
          callPackage = newScope pkgs.zathuraCollection;
          fetchurl = pkgs.fetchurl;
         in import packages/zathura { inherit callPackage pkgs fetchurl; }
        ).zathuraWrapper;
   };
 };
}
