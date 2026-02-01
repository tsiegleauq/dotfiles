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
    services = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    programs.dconf.enable = true;

    environment.systemPackages = with pkgs; [
      gnome-tweaks
      gnome-shell-extensions
    ];

    # Remove some default gnome packages that I dont like
    environment.gnome.excludePackages = with pkgs; [
      atomix # puzzle game
      cheese # webcam tool
      epiphany # web browser
      evince # document viewer
      geary # email reader
      gedit # text editor
      gnome-characters
      gnome-music
      gnome-photos
      gnome-terminal
      gnome-tour
      gnome-maps
      hitori # sudoku game
      iagno # go game
      tali # poker game
      totem # video player
    ];
  };
}
