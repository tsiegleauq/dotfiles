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
    ./sunshine.nix
    ./spice.nix
    ./steam.nix
    ./system-environment.nix
    ./zsh.nix
  ];
}
