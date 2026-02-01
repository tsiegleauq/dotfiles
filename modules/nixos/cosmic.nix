{
  lib,
  pkgs,
  config,
  ...
}: {
  options = {
    cosmic.enable =
      lib.mkEnableOption "enables cosmic desktop module";
  };

  config = lib.mkIf config.cosmic.enable {
    services = {
      displayManager.cosmic-greeter = {
        enable = true;
      };
      desktopManager.cosmic.enable = true;
    };
  };
}
