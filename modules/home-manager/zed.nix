{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  options.zed.enable = lib.mkEnableOption "enables zed home-manager module";

  config = lib.mkIf config.zed.enable {
    home.packages = with pkgs; [
      zed-editor
    ];
  };
}
