{
  config,
  lib,
  ...
}: let
  aliases = import ./aliases.nix;
  sharedFunctions = builtins.readFile ./shared_functions.sh;
in {
  options.zsh.enable = lib.mkEnableOption "enables zsh home-manager module";

  config = lib.mkIf config.zsh.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;

      oh-my-zsh = {
        enable = true;
        plugins = ["git"];
        theme = "robbyrussell";
      };

      shellAliases = aliases;

      initExtra = sharedFunctions;

      history.size = 10000;
      history.path = "${config.xdg.dataHome}/zsh/history";
    };

    home.file.".zshrc".text = ''
      unsetopt nomatch
    '';
  };
}
