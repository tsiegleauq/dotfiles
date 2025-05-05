{
  lib,
  pkgs,
  config,
  ...
}: {
  options.nh.enable = lib.mkEnableOption "enables nh module";

  config = lib.mkIf config.nh.enable {
    programs.nh = {
      enable = true;
      clean.enable = true;
      flake = "/home/sean/.dotfiles";
    };
  };
}
