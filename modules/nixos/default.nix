{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./autologin.nix
    ./bluetooth.nix
    ./cinnamon.nix
    ./cosmic.nix
    ./fonts.nix
    ./gnome.nix
    ./locales.nix
    ./nh.nix
    ./plasma.nix
    ./samsung-printer.nix
    ./sound.nix
    ./sunshine.nix
    ./spice.nix
    ./steam.nix
    ./system-environment.nix
    ./zsh.nix
  ];
}
