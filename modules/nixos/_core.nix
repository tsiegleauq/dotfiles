{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./locales.nix
    ./nh.nix
    ./zsh.nix
  ];
}
