{ config, pkgs, ... }:

{
  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };
  time = {
    timeZone = "Asia/Singapore";
  };
}
