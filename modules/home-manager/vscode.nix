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
      extensions = with pkgs.vscode-extensions; [
        dracula-theme.theme-dracula
        yzhang.markdown-all-in-one
        bbenoist.nix
        kamadorueda.alejandra
      ];

      userSettings = {
        # Editor Font
        "editor.fontFamily" = "'FiraCode Nerd Font', monospace";
        "editor.fontSize" = 14;
        "editor.fontLigatures" = true;

        # Terminal Font
        "terminal.integrated.fontFamily" = "'FiraCode Nerd Font Mono', monospace";
        "terminal.integrated.fontSize" = 14;

        # Styling
        "workbench.colorTheme" = "Dracula";
        "window.menuBarVisibility" = "toggle";
      };
    };
  };
}
