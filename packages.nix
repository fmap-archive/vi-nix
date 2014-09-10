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
    ruby
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
    zathura = recurseIntoAttrs
      (let 
        callPackage = newScope pkgs.zathuraCollection;
        fetchurl = pkgs.fetchurl;
       in import packages/zathura { inherit callPackage pkgs fetchurl; }
      ).zathuraWrapper;
 };
}
