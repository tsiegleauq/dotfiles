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
  # alacritty.enable = true;
  chromium.enable = true;
  direnv.enable = true;
  downloader.enable = true;
  firefox.enable = true;
  git.enable = true;
  gnomeconfig.enable = true;
  # lf.enable = true;
  # libreoffice.enable = true;
  mangohud.enable = true;
  mpv.enable = true;
  # nvim.enable = true;
  nixvim.enable = true;
  # rclone.enable = true;
  # ssh-client.enable = true;
  vscode.enable = true;
  zsh.enable = true;
  # zed.enable = true;

  # individual packages per machine
  home.packages = with pkgs; [
    audacity
    # butler #broken package
    f3
    bottles
    # calibre
    desktop-file-utils
    # discord
    # easyeffects
    gimp
    godot_4
    # ghex
    # mnamer # broken
    # iperf
    # jellyfin-media-player
    libnotify
    # lutris
    # wineWowPackages.stable
    ocrmypdf
    pavucontrol
    r2modman
    ruffle
    sweethome3d.application
    # rpi-imager
    krita
    # moonlight-qt
    # telegram-desktop
    unrar
    veracrypt
    vesktop
    vlc
    tor-browser
    # wipe
    unzip
    p7zip
    # vrrtest
    xarchiver
  ];

  # programs.kodi = {
  #   enable = true;
  #   package = pkgs.kodi-wayland.passthru.withPackages (kodiPkgs:
  #     with kodiPkgs; [
  #       # trakt
  #       youtube # or invidious?
  #       netflix
  #       # libretro
  #       # inputstream-ffmpegdirect
  #       # inputstream-adaptive
  #       # pvr-iptvsimple
  #       # jellycon
  #     ]);
  # };
}
