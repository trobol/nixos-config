{ config, lib, pkgs, callPackage, ... }:

{
  # i3blocks needs this
  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw

  services.xserver.windowManager.default = "i3";
  services.xserver.windowManager.i3.enable = true;
  services.xserver.windowManager.i3.configFile = "/etc/i3.conf";
  environment.etc."i3.conf".text = pkgs.callPackage ./i3-config.nix {};


  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # so that gtk works properly
    extraPackages = with pkgs; [
      swaylock
      swayidle
      wl-clipboard
      mako # notification daemon
      alacritty # Alacritty is the default terminal in the config
      wofi # program launcher
    ];

  };


  wayland.homeManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  home.packages = with pkgs; [
   swaylock
   swayidle
   wl-clipboard
   mako # notification daemon
   alacritty # Alacritty is the default terminal in the config
   wofi # launcher
  ]

}
