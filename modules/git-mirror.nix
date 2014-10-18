{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.git-mirror;
in 
{ options = {
    services.git-mirror = {
      remotes = mkOption {
        default = [];
        description = "The repositories to mirror.";
      };   
      dataDir = mkOption {
        default = "/usr/src";
        description = "Where repositories should be mirrored to.";
      };
      period = mkOption {
        default = "*-*-* 0:00:00";
        description = "When to mirror; global, defaults to daily at midnight";
      };
    };
  };
  config = mkIf (cfg.remotes != []) {
    assertions = map (remote: {
      assertion = hasAttr "repo" remote && hasAttr "name" remote;
      message   = "All remotes should include at least both 'repo' and 'name'.";
    }) cfg.remotes;
    systemd.services."git-mirror" = {
      description = "git-mirror daemon";
      requires    = ["network.target"];
      path        = [ pkgs.bash pkgs.git pkgs.openssh ];
      script      = concatStringsSep "\n" (map (remote: ''
        Repository="${remote.repo}"; 
        LocalPath="${cfg.dataDir}/${remote.name}"; 
        KeyFile="${optionalString (hasAttr "key" remote) remote.key}";

        [[ -z "$KeyFile" ]] || {
          export GIT_SSH=$(mktemp);
          trap "rm -f $GIT_SSH" 0
          echo 'ssh -i '"$KeyFile"' $@' > $GIT_SSH
          chmod +x $GIT_SSH
        }

        if [[ ! -d "$LocalPath" ]]; then
          git clone --mirror "$Repository" "$LocalPath"
        else
          git --git-dir="$LocalPath" remote update
        fi

        chmod -R a+r "$LocalPath"
      '') cfg.remotes);
    };
    systemd.timers."git-mirror" = {
      description = "Timed invocation of git-mirror.";
      wantedBy    = ["multi-user.target"];
      timerConfig = {
        Unit       = "git-mirror.service";
        OnCalendar = "${cfg.period}";
      };
    }; 
  };
}
