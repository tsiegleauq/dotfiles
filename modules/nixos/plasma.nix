{
  lib,
  pkgs,
  config,
  ...
}: {
  options = {
    plasma.enable =
      lib.mkEnableOption "enables plasma desktop module";
  };

  config = lib.mkIf config.plasma.enable {
    services = {
      displayManager.sddm = {
        enable = true;
        settings.General.DisplayServer = "wayland";
        wayland.enable = true;
      };
      desktopManager.plasma6.enable = true;
    };
  };
}
