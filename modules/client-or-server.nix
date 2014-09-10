{ config, lib, ...}:
with lib;

{ options = {
    environment.isServer = mkOption {
      type        = types.bool;
      default     = false;
      description = "Is this machine a client or a server?";
    };
  };
}
