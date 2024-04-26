{
  config,
  pkgs,
  lib,
  ...
}: {
  options.libreoffice.enable = lib.mkEnableOption "enables LibreOffice home-manager module";

  config = lib.mkIf config.libreoffice.enable {
    home.packages = with pkgs; [
      libreoffice-fresh
      hunspell
      hunspellDicts.de_DE
      hunspellDicts.en_US
    ];
  };
}
