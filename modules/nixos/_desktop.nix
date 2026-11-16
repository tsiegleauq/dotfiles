{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./bluetooth.nix
    ./cinnamon.nix
    ./cosmic.nix
    ./fonts.nix
    ./gnome.nix
    ./plasma.nix
    ./samsung-printer.nix
    ./sound.nix
    ./steam.nix
    ./system-environment.nix
  ];
}
