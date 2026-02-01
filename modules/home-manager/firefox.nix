{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  options.firefox.enable = lib.mkEnableOption "enables firefox home-manager module";

  config = lib.mkIf config.firefox.enable {
    programs.firefox = {
      enable = true;
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

        settings = {
          "dom.security.https_only_mode" = true;
          "browser.download.panel.shown" = true;
          "identity.fxaccounts.enabled" = false;
          "signon.rememberSignons" = false;
        };

        extensions.packages = with inputs.firefox-addons.packages."x86_64-linux"; [
          bitwarden
          ublock-origin
          floccus
        ];
      };
    };
  };
}
