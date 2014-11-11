{ lib, pkgs, ... }: with lib; overrideDerivation pkgs.irssi (_: { patches = [ ./privmsg.patch ]; })
