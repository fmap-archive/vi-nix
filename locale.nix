{ config, pkgs, ... }:

{
  i18n = {
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
    supportedLocales = ["en_US.UTF-8"];
  };
  time = {
    timeZone = "Asia/Singapore";
  };
}
