{ pkgs, base, ... }: pkgs.lib.overrideDerivation base.irssi (_: { 
  patches = [ ./privmsg.patch ]; 
})
