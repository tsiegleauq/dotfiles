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
      # to run "protonup" command that installs protonGE
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    };
  };

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;

  #enable software
  alacritty.enable = true;
  chromium.enable = true;
  direnv.enable = true;
  downloader.enable = true;
  firefox.enable = true;
  git.enable = true;
  gnomeconfig.enable = true;
  lf.enable = true;
  libreoffice.enable = true;
  mpv.enable = true;
  nvim.enable = true;
  rclone.enable = true;
  ssh-client.enable = true;
  vscode.enable = true;
  zsh.enable = true;

  # individual packages per machine
  home.packages = with pkgs; [
    audacity
    # butler #broken package
    desktop-file-utils
    discord
    easyeffects
    gimp
    godot_4
    #mnamer # broken
    jellyfin-media-player
    libnotify
    pavucontrol
    r2modman
    ruffle
    rpi-imager
    krita
    telegram-desktop
    unrar
    veracrypt
    vesktop
    vlc
    tor-browser
    wipe
  ];

  programs.kodi = {
    enable = true;
    package = pkgs.kodi-wayland.passthru.withPackages (kodiPkgs:
      with kodiPkgs; [
        # trakt
        youtube # or invidious?
        netflix
        # libretro
        # inputstream-ffmpegdirect
        # inputstream-adaptive
        # pvr-iptvsimple
        # jellycon
      ]);
  };
}
