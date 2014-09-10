{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

 nix.buildMachines =
   [ { hostName = "bitlbee.ops.zalora.com";
       sshUser  = "vi";
       sshKey   = "/home/vi/.ssh/id_bitlbee";
       system   = "x86_64-linux";
       maxJobs  = 4;
     }
   ];
  
  nix.distributedBuilds = true;
}
