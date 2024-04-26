{
  lib,
  pkgs,
  config,
  ...
}: {
  options.nh.enable = lib.mkEnableOption "enables nh module";

  config = lib.mkIf config.nh.enable {
    environment.systemPackages = with pkgs; [
      nh
    ];

    environment.sessionVariables = {
      FLAKE = "/home/sean/.dotfiles";
    };

    # unstable
    # programs.nh = {
    #   enable = true;
    #   clean.enable = true;
    #   clean.extraArgs = "--keep-since 4d --keep 3";
    #   flake = "/home/sean/.dotfiles";
    # };
  };
}
