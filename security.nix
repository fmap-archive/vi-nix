{ config, pkgs, lib, ... }:

{
  security.setuidPrograms = lib.mkIf (!config.environment.isServer) [
    "slock"
    "pinentry"
  ];
}
