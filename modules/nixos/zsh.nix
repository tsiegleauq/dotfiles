{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    zshos.enable =
      lib.mkEnableOption "enables zsh for nixos";
  };

  config = lib.mkIf config.zshos.enable {
    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;
    environment.shells = with pkgs; [zsh];
  };
}
