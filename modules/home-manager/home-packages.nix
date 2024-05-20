{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    xclip
    bitwarden
    eza
    ffmpeg
    libnotify
    rsync
  ];
}
