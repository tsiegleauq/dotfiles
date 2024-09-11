{
  pkgs,
  lib,
  config,
  ...
}: let
  theme_name = "Orchis";
  # theme_name = "Orchis-Dark";
in {
  options.gnomeconfig.enable = lib.mkEnableOption "enables gnome config home-manager module";

  config = lib.mkIf config.gnomeconfig.enable {
    home.packages =
      (with pkgs; [
        (orchis-theme.override {tweaks = ["compact"];})
        tela-icon-theme
      ])
      ++ (with pkgs.gnomeExtensions; [
        user-themes
        hide-top-bar
        dash-to-dock
        quick-settings-tweaker
        gsconnect
        appindicator
      ]);

    gtk = {
      enable = true;
      theme = {
        name = "${theme_name}";
      };
    };

    # gtk4 theme
    home.file.".config/gtk-4.0/gtk.css".source = "${pkgs.orchis-theme}/share/themes/${theme_name}/gtk-4.0/gtk.css";
    home.file.".config/gtk-4.0/gtk-dark.css".source = "${pkgs.orchis-theme}/share/themes/${theme_name}/gtk-4.0/gtk-dark.css";
    home.file.".config/gtk-4.0/assets" = {
      recursive = true;
      source = "${pkgs.orchis-theme}/share/themes/${theme_name}/gtk-4.0/assets";
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        icon-theme = "Tela";
        monospace-font-name = "FiraCode Nerd Font Propo 10";
      };

      # keyboard shortcuts
      "org/gnome/desktop/wm/keybindings" = {
        close = ["<Shift><Super>q"];
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Control><Alt>t";
        command = "kgx";
        name = "Open terminal";
      };

      "org/gnome/shell" = {
        disable-user-extensions = false;

        # `gnome-extensions list` for a list
        enabled-extensions = [
          "appindicatorsupport@rgcjonas.gmail.com"
          "dash-to-dock@micxgx.gmail.com"
          "hidetopbar@mathieu.bidon.ca"
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          "quick-settings-tweaks@qwreey"
          "gsconnect@andyholmes.github.io"
        ];
      };

      # get from: `dconf dump /org/gnome/shell/extensions/`
      # or: dconf watch /
      "org/gnome/shell/extensions/user-theme" = {
        name = "${theme_name}";
      };

      "org/gnome/shell/extensions/quick-settings-tweaks" = {
        add-dnd-quick-toggle-enabled = false;
        output-show-selected = true;
      };

      "org/gnome/shell/extensions/hidetopbar" = {
        mouse-sensitive = true;
        hot-corner = true;
      };
    };
  };
}
