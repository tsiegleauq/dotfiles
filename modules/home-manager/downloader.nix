{
  config,
  lib,
  pkgs,
  ...
}: {
  options.downloader.enable = lib.mkEnableOption "enables downloader home-manager module";

  config = lib.mkIf config.downloader.enable {
    home.packages = with pkgs; [
      # uget
      # uget-integrator
      motrix
    ];

    programs.yt-dlp = {
      enable = true;
      settings = {
        embed-thumbnail = true;
        embed-subs = true;
        sub-langs = "all";
        paths = "~./Videos";
        # downloader = "aria2c";
        # downloader-args = "aria2c:'-c -x8 -s8 -k1M'";
      };
    };
  };
}
