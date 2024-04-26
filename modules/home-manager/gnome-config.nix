{
  pkgs,
  lib,
  config,
  ...
}: let
  theme_name = "Orchis";
in {
  options.gnomeconfig.enable = lib.mkEnableOption "enables gnome config home-manager module";

  config = lib.mkIf config.gnomeconfig.enable {
    home.packages =
      (with pkgs; [
        orchis-theme
        tela-icon-theme
      ])
      ++ (with pkgs.gnomeExtensions; [
        user-themes
        dash-to-panel
        quick-settings-tweaker
        gsconnect
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
          "dash-to-panel@jderose9.github.com"
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

      "org/gnome/shell/extensions/dash-to-panel" = {
        panel-sizes = "{\"0\":32}";
        dot-style-focused = "DASHES";
        dot-style-unfocused = "DOTS";
        animate-appicon-hover = true;
        intellihide = true;
        intellihide-hide-from-windows = true;
        intellihide-use-pressure = true;
        trans-use-custom-bg = true;
        trans-bg-color = "#241f31";
        trans-use-dynamic-opacity = true;
        trans-dynamic-anim-target = 1.0;
        panel-element-positions = "{\"0\":[{\"element\":\"showAppsButton\",\"visible\":false,\"position\":\"stackedTL\"},{\"element\":\"activitiesButton\",\"visible\":true,\"position\":\"stackedTL\"},{\"element\":\"leftBox\",\"visible\":true,\"position\":\"stackedTL\"},{\"element\":\"taskbar\",\"visible\":true,\"position\":\"centered\"},{\"element\":\"centerBox\",\"visible\":true,\"position\":\"centered\"},{\"element\":\"rightBox\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"dateMenu\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"systemMenu\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"desktopButton\",\"visible\":false,\"position\":\"stackedBR\"}]}";
      };
    };
  };
}
