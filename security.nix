{ config, pkgs, lib, ... }:

{
  security.setuidPrograms = lib.mkIf (!config.environment.isServer) [
    "xlaunch"
    "slock"
    "pinentry"
    "fusermount"
    "sshfs"
  ];
}
