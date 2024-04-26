{
  config,
  lib,
  ...
}: {
  options.mpv.enable = lib.mkEnableOption "enables mpv home-manager module";

  config = lib.mkIf config.mpv.enable {
    programs.mpv = {
      enable = true;

      config = {
        profile = "gpu-hq";
        force-window = true;
        ytdl-format = "bestvideo+bestaudio";
        save-position-on-quit = true;
      };

      bindings = {
        "WHEEL_UP" = "seek 10";
        "WHEEL_DOWN" = "seek -10";
        "Alt+0" = "set window-scale 0.5";
        "Alt+RIGHT" = "no-osd cycle-values video-rotate 90 180 270 0";
        "Alt+R" = "no-osd cycle-values video-rotate 90 180 270 0";
        "Alt+LEFT " = "no-osd cycle-values video-rotate 270 180 90 0";
        "-" = " add video-zoom -.25";
        "+" = " add video-zoom .25";
        "kp8" = "add video-pan-y .05";
        "kp6" = "add video-pan-x -.05";
        "kp2" = "add video-pan-y -.05";
        "kp4" = "add video-pan-x .05";
        "kp7" = "vf toggle hflip";
        "kp5" = "set video-pan-x 0; set video-pan-y 0; set video-zoom 0";
      };
    };
  };
}
