{ config, lib, pkgs, ... }:

{ networking.enableIPv6 = false;

  networking.useTorAsTransparentProxy = !config.environment.isServer;
}
