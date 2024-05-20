{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./autologin.nix
    ./bluetooth.nix
    ./fonts.nix
    ./gnome.nix
    ./locales.nix
    ./nh.nix
    ./samsung-printer.nix
    ./sound.nix
    ./spice.nix
    ./steam.nix
    ./system-environment.nix
    ./zsh.nix
  ];
}
