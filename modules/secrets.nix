{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services;
in
{ options = {
    services.secrets = mkOption {
      default = [];
      description = "Secret keys, who owns them, etc..";
    };
  };
  config = mkIf (cfg.secrets != []) {
    assertions = map (secret: {
      assertion = all (attr: hasAttr attr secret) ["key" "user" "group" "chmod"];
      message   = "All secrets should specify keys, user, group and chmod.";
    }) cfg.secrets;

    system.activationScripts.secrets = ''
      mkdir -p /etc/keys

      writeKey() {
        cp ${<vi-nix/secrets>}/$1 /etc/keys
        chown $2:$3 /etc/keys/$1
        chmod $4 /etc/keys/$1
      };
    '' +
    concatStringsSep "\n" (map (secret: ''
      writeKey ${secret.key} ${secret.user} ${secret.group} ${secret.chmod}
    '') cfg.secrets);
  };
}
