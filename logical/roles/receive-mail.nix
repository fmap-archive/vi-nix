{ config, pkgs, lib, ... }:

{ services.cron.systemCronJobs = [
    "*/5 * * * * vi /home/vi/bin/cron/courier"
    "*/5 * * * * vi /home/vi/bin/cron/dwarf"
  ];
}
