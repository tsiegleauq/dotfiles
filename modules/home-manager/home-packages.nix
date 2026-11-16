{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    xclip
    ffmpeg
    libnotify
    rsync
  ];

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    icons = "auto";
  };
}
