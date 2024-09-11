{
  lib,
  pkgs,
  config,
  ...
}: {
  options = {
    gnome.enable =
      lib.mkEnableOption "enables gnome desktop module";
  };

  config = lib.mkIf config.gnome.enable {
    # Enable the GNOME Desktop Environment.
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
    programs.dconf.enable = true;

    environment.systemPackages = with pkgs; [
      gnome-tweaks
      gnome-shell-extensions
    ];

    # Remove some default gnome packages that I dont like
    environment.gnome.excludePackages = with pkgs; [
      gnome-tour
      gnome-maps
    ];
  };
}
