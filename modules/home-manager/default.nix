{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./alacritty.nix
    ./chromium.nix
    ./direnv.nix
    ./downloader.nix
    ./firefox.nix
    ./git.nix
    ./gnome-config.nix
    ./home-packages.nix
    ./lf.nix
    ./libreoffice.nix
    ./mangohud.nix
    ./mpv.nix
    ./nixvim.nix
    ./nvim.nix
    ./rclone.nix
    ./ssh-client.nix
    ./vscode.nix
    ./shells/zsh.nix
    ./zed.nix
  ];
}
