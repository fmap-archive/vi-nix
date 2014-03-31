{ config, pkgs, ... }:

{
  users.mutableUsers = false;

  users.extraUsers.root = {
    hashedPassword = "$6$4CptotwIgzT58jB$CIhWW6FzHO1irNchO.KYaLBwKZLrknoMPzWVNjfJH9FQf0opTrJmzguV6lblT7z4dDPNrZoN07GpoZThzwY960";
    # mkpasswd -m sha-512 
  };

  users.extraUsers.vi = {
    createHome = true;
    createUser = true;
    description = "vi";
    extraGroups = ["wheel" "vboxusers" ];
    group = "users";
    home = "/home/vi";
    hashedPassword = "$6$jsl6DJ3J$p/45DOLzK5frmUNKonpcsWx5f.cQuz6Su6wjBftoQnM7DHzdTo/6Lh0OaV1E7Jn4dp4OrzaepjACz/zZqbCIP0";
    useDefaultShell = true;
    uid = 1337;
  };
}
