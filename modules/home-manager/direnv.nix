{
  config,
  pkgs,
  lib,
  ...
}: {
  options.direnv.enable = lib.mkEnableOption "enables direnv home-manager module";

  config = lib.mkIf config.direnv.enable {
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
