{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    xclip
    eza
    ffmpeg
    libnotify
    rsync
  ];
}
