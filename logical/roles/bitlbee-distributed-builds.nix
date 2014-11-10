{ config, lib, pkgs, ...}:
{ services.secrets = [
    { key = "signing-key.sec"; user = "root"; group = "root"; chmod = "0"; }
    { key = "bitlbee.id_rsa";  user = "root"; group = "root"; chmod = "0"; }
  ];

  system.activationScripts.installBitlbeeSigningKey = stringAfter ["secrets"] ''
    if [[ ! -f /etc/nix/signing-key.sec || ! -f /etc/nix/signing-key.pub ]]; then
      ln -sf /etc/keys/signing-key.sec /etc/nix/signing-key.sec
      ${pkgs.openssl}/bin/openssl rsa -in /etc/nix/signing-key.sec -pubout > /etc/nix/signing-key.pub
      chown root:root /etc/nix/signing-key.pub
      chmod 0 /etc/nix/signing-key.pub
    fi
  '';

  system.activationScripts.installBitlbeeSSHKey = ''
    ln -sf /etc/keys/bitlbee.id_rsa /etc/nix/ssh-key
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
}
