{ config, lib, pkgs, ...}:

with lib;
let
  distributingBuildsToBitlbee = config.nix.distributeBuildsToBitlbee;
in {
  options.nix.distributeBuildsToBitlbee = mkOption {
    type        = types.bool;
    default     = false;
    description = "Distribute builds to bitlbee?";
  };

  config = mkIf distributingBuildsToBitlbee {
    system.activationScripts.installBitlbeeSigningKey = ''
      if [[ ! -f /etc/nix/signing-key.sec || ! -f /etc/nix/signing-key.pub ]]; then
        cp "${<secrets/signing-key.sec>}" /etc/nix/signing-key.sec
        ${pkgs.openssl}/bin/openssl rsa -in /etc/nix/signing-key.sec -pubout > /etc/nix/signing-key.pub
        chown root:root /etc/nix/ssh-key
        chmod 0 /etc/nix/signing-key.*
      fi
    '';

    system.activationScripts.installBitlbeeSSHKey = ''
      if [[ ! -f /etc/nix/ssh-key ]]; then
        cp "${<secrets/bitlbee.id_rsa>}" /etc/nix/ssh-key
        chown root:root /etc/nix/ssh-key
        chmod 0 /etc/nix/ssh-key
      fi
    '';

    nix.buildMachines =
      [ { hostName = "bitlbee.ops.zalora.com";
          sshUser  = "vi";
          sshKey   = "/etc/nix/ssh-key";
          system   = "x86_64-linux";
          maxJobs  = 4;
        }
      ];

    nix.distributedBuilds = true;
  };
}
