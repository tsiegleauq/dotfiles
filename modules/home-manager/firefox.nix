{
  config,
  lib,
  pkgs,
  ...
}: {
  options.firefox.enable = lib.mkEnableOption "enables firefox home-manager module";

  config = lib.mkIf config.firefox.enable {
    programs.firefox = {
      enable = true;
      configPath = "${config.xdg.configHome}/mozilla/firefox";

      # Enforce extensions via Enterprise Policies (Instant nixos-rebuild, zero local compilation)
      policies = {
        ExtensionSettings = {
          # Bitwarden
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          };
          # uBlock Origin
          "uBlock0@raymondhill.net" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          };
          # Floccus
          "floccus@floccus.org" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/floccus/latest.xpi";
          };
        };
      };

      profiles.sean = {
        search.engines = {
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@np"];
          };
        };
        search.force = true;
        extensions.force = true;

        settings = {
          "dom.security.https_only_mode" = true;
          "browser.download.panel.shown" = true;
          "identity.fxaccounts.enabled" = false;
          "signon.rememberSignons" = false;
        };
      };
    };
  };
}
