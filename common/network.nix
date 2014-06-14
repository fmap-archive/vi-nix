{ config, pkgs, ... }:

{
  networking.extraHosts = ''
    192.168.56.101  eris.zalora.sg
    192.168.56.101  bob.eris.zalora.sg
  ''; 
}
