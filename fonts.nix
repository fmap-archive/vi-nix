{ config, pkgs, ... }:

{
  fonts.enableFontDir = !config.environment.isServer;
}
