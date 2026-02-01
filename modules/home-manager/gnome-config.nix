{
  pkgs,
  lib,
  config,
  ...
}: let
  theme_name = "Orchis";
  # theme_name = "Orchis-Dark";
  # theme_name = "Adwaita";
in {
  options.gnomeconfig.enable = lib.mkEnableOption "enables gnome config home-manager module";

  config = lib.mkIf config.gnomeconfig.enable {
    home.packages =
      (with pkgs; [
        orchis-theme
        # (orchis-theme.override {tweaks = ["compact"];})
        tela-icon-theme
      ])
      ++ (with pkgs.gnomeExtensions; [
        user-themes
        dash-to-panel
        # hide-top-bar
        # dash-to-dock
        # quick-settings-tweaker
        # gsconnect
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
        monospace-font-name = "Fira Code 10 @wght=400";
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
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          "appindicatorsupport@rgcjonas.gmail.com"
          "dash-to-panel@jderose9.github.com"
          # "dash-to-dock@micxgx.gmail.com"
          # "hidetopbar@mathieu.bidon.ca"
          # "quick-settings-tweaks@qwreey"
          # "gsconnect@andyholmes.github.io"
        ];
      };

      # get from: `dconf dump /org/gnome/shell/extensions/`
      # or: dconf watch /
      "org/gnome/shell/extensions/user-theme" = {
        name = "${theme_name}";
      };

      "org/gnome/mutter" = {
        experimental-features = ["variable-refresh-rate"];
      };

      # Window buttons
      "org/gnome/desktop/wm/preferences" = {
        button-layout = ":close";
      };

      # disable donation reminder
      "org/gnome/settings-daemon/plugins/housekeeping" = {
        donation-reminder-enabled = false;
      };

      # configure "quick-settings-tweaks"
      "org/gnome/shell/extensions/quick-settings-tweaks" = {
        add-dnd-quick-toggle-enabled = false;
        output-show-selected = true;
      };

      # configure hidetopbar
      "org/gnome/shell/extensions/hidetopbar" = {
        mouse-sensitive = true;
        hot-corner = true;
      };

      # configure "dash to panel"
      "org/gnome/shell/extensions/dash-to-panel" = {
        panel-sizes = "{\"0\":32}";
        panel-element-positions-monitors-sync = true;
        dot-style-focused = "DASHES";
        dot-style-unfocused = "DOTS";
        animate-appicon-hover = true;
        animate-appicon-hover-animation-type = "RIPPLE";
        intellihide = true;
        intellihide-hide-from-windows = true;
        intellihide-use-pressure = true;
        trans-use-custom-bg = true;
        trans-bg-color = "#241f31";
        trans-use-dynamic-opacity = true;
        trans-dynamic-anim-target = 1.0;
        panel-element-positions = "{\"0\":[{\"element\":\"showAppsButton\",\"visible\":false,\"position\":\"stackedTL\"},{\"element\":\"activitiesButton\",\"visible\":true,\"position\":\"stackedTL\"},{\"element\":\"leftBox\",\"visible\":true,\"position\":\"stackedTL\"},{\"element\":\"taskbar\",\"visible\":true,\"position\":\"centered\"},{\"element\":\"centerBox\",\"visible\":true,\"position\":\"centered\"},{\"element\":\"rightBox\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"dateMenu\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"systemMenu\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"desktopButton\",\"visible\":false,\"position\":\"stackedBR\"}]}";
        pressure-threshold = 0;
        pressure-timeout = 0;
      };

      # configure "dash to dock"
      "org/gnome/shell/extensions/dash-to-dock" = {
        dash-max-icon-size = 32;
        height-fraction = 0.9;
        dock-fixed = false;
        dock-position = "BOTTOM";
        show-show-apps-button = true;
        show-apps-at-top = true;
        custom-theme-shrink = true;
        disable-overview-on-startup = false;
      };
    };
  };
}
