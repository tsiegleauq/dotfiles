{
  pkgs,
  lib,
  config,
  ...
}: {
  options.rclone.enable = lib.mkEnableOption "enables rclone home-manager module";

  config = lib.mkIf config.rclone.enable {
    home.packages = with pkgs; [
      rclone
      rclone-browser
    ];
  };
}
