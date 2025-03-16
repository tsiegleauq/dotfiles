{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  options.vscode.enable = lib.mkEnableOption "enables vscode home-manager module";

  config = lib.mkIf config.vscode.enable {
    programs.vscode = {
      enable = true;
      mutableExtensionsDir = false;
      profiles = {
        default = {
          enableExtensionUpdateCheck = false;
          enableUpdateCheck = false;
          extensions = with pkgs.vscode-extensions; [
            dracula-theme.theme-dracula
            yzhang.markdown-all-in-one
            bbenoist.nix
            kamadorueda.alejandra
            esbenp.prettier-vscode
            eamodio.gitlens
            #vue.volar
          ];

          userSettings = {
            # Editor Font
            "editor.fontFamily" = "'Fira Code', monospace";
            "editor.fontSize" = 14;
            "editor.fontLigatures" = true;
            "editor.defaultFormatter" = "esbenp.prettier-vscode";

            # Terminal Font
            "terminal.integrated.fontFamily" = "'Fira Code', monospace";
            "terminal.integrated.fontSize" = 14;

            # Styling
            "workbench.colorTheme" = "Dracula";
            "window.menuBarVisibility" = "toggle";
          };
        };
      };
    };
  };
}
