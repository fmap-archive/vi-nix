{ config, pkgs, ... }:

{
  security.setuidPrograms = [
    "xlaunch"
    "slock"
    "pinentry"
    "fusermount"
    "sshfs"
  ];
}
