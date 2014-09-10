{ config, lib, pkgs, ... }:

{
  networking.extraHosts = ''
    # 192.168.56.101  eris.zalora.sg
    # 192.168.56.101  bob.eris.zalora.sg
  ''; 

  networking.enableIPv6 = false;

  networking.useTorAsTransparentProxy = !config.environment.isServer;
}
