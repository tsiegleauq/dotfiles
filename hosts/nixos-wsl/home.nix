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
    stateVersion = "24.05";
    file = {};
    sessionVariables = {
      EDITOR = "nvim";
    };
    # use global npm packages. Requires:
    # >> npm config set prefix "${HOME}/.cache/npm/global"
    # >> mkdir -p "${HOME}/.cache/npm/global"
    sessionPath = [
      "/home/sean/.cache/npm/global/bin"
    ];
  };

  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;

  #enable software
  git.enable = true;
  git.email = "sean.engelhardt@stackit.cloud";
  nvim.enable = false;
  nixvim.enable = true;
  zsh.enable = true;

  # individual packages per machine
  home.packages = with pkgs; [
    nodejs_22
  ];
}
