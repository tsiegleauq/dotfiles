{
  lib,
  pkgs,
  config,
  ...
}: {
  options = {
    cinnamon.enable =
      lib.mkEnableOption "enables cinnamon desktop module";
  };

  config = lib.mkIf config.cinnamon.enable {
    services.xserver = {
      displayManager.lightdm = {
        enable = true;
      };
      desktopManager.cinnamon.enable = true;
    };
  };
}
