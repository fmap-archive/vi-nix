{ config, lib, ...}:
with lib;

let
  usingTorAsTransparentProxy = config.networking.useTorAsTransparentProxy;
in {
  options.networking.useTorAsTransparentProxy = mkOption {
    type        = types.bool;
    default     = false;
    description = "Use Tor as a transparent proxy?";
  };
  config = mkIf usingTorAsTransparentProxy {
    services.tor.client.enable = true;

    # Tor configuration. With the property unset, the file reads:
    #
    #    DataDirectory /var/lib/tor
    #    User tor
    #    SOCKSPort 127.0.0.1:9050 IsolateDestAddr
    #    SOCKSPort 127.0.0.1:9063

    services.tor.config = ''
      TransPort 9040
      DNSPort 53
      AutomapHostsOnResolve 1
      AutomapHostsSuffixes .onion,.exit
    '';

    networking.firewall.enable = true;

    networking.firewall.extraCommands = ''
      iptables -F
      iptables -t nat -F

      iptables -t nat -A OUTPUT -m owner --uid-owner ${toString config.ids.uids.tor} -j RETURN
      iptables -t nat -A OUTPUT -p udp --dport 53 -j REDIRECT --to-ports 53

      iptables -t nat -A OUTPUT -d 127.0.0.0/9 -j RETURN

      iptables -t nat -A OUTPUT -p tcp --syn -j REDIRECT --to-ports 9040
      iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

      iptables -A OUTPUT -d 127.0.0.0/8 -j ACCEPT

      iptables -A OUTPUT -m owner --uid-owner ${toString config.ids.uids.tor} -j ACCEPT
      iptables -A OUTPUT -j REJECT
    '';

    networking.dhcpcd.extraConfig = ''
      nohook resolv.conf
    '';
  };
}
