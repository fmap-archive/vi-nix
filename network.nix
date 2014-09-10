{ config, pkgs, ... }:

{
  networking.extraHosts = ''
    # 192.168.56.101  eris.zalora.sg
    # 192.168.56.101  bob.eris.zalora.sg
  ''; 

  networking.enableIPv6 = false;

  networking.firewall.enable = true;

  # Use Tor as a transparent proxy.
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
}
