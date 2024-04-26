{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./autologin.nix
    ./fonts.nix
    ./gnome.nix
    ./locales.nix
    ./nh.nix
    ./samsung-printer.nix
    ./sound.nix
    ./spice.nix
    ./steam.nix
    ./system-packages.nix
    ./zsh.nix
  ];
}
