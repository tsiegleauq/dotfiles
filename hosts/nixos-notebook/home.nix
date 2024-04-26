{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ../../modules/home-manager/default.nix
  ];

  home = {
    username = "sean";
    homeDirectory = "/home/sean";
    stateVersion = "23.11";
    file = {};
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;

  #enable software
  alacritty.enable = true;
  chromium.enable = true;
  #downloader.enable = true;
  #firefox.enable = true;
  git.enable = true;
  gnomeconfig.enable = true;
  lf.enable = true;
  #libreoffice.enable = true;
  mpv.enable = true;
  nvim.enable = true;
  #rclone.enable = true;
  ssh-client.enable = true;
  vscode.enable = true;
  zsh.enable = true;

  # individual packages per machine
  home.packages = with pkgs; [
    #audacity
    #desktop-file-utils
    discord
    #easyeffects
    #gimp
    godot_4
    libnotify
    #ruffle
    #krita
    #veracrypt
    #vesktop
  ];
}
