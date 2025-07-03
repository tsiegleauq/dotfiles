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
  chromium.enable = true;
  git.enable = true;
  gnomeconfig.enable = true;
  nixvim.enable = true;
  ssh-client.enable = true;
  zsh.enable = true;

  # individual packages per machine
  home.packages = with pkgs; [
    libnotify
  ];
}
