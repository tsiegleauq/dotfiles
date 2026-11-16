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

  programs.home-manager.enable = true;

  # Enabled Home-Manager Modules
  direnv.enable = true;
  downloader.enable = true;
  firefox.enable = true;
  git.enable = true;
  gnomeconfig.enable = true;
  mangohud.enable = true;
  mpv.enable = true;
  vscode.enable = true;
  zsh.enable = true;

  # Machine-specific packages
  home.packages = with pkgs; [
    p7zip
    pnpm
    ruffle
    sweethome3d.application
    unrar
    unzip
    xarchiver
  ];

  catppuccin = {
    enable = true;
    autoEnable = true;

    flavor = "mocha";
    accent = "mauve";

    # Enable themes for specific apps you use:
    # gtk.enable = true;
    vscode.profiles.default.enable = true;
    eza.enable = true;
    firefox = {
      enable = true;
      force = true;
    };

    # Use pre-compiled whiskers from nixpkgs to avoid building from source
    sources = inputs.catppuccin.packages.${pkgs.stdenv.hostPlatform.system}.overrideScope (_: _: {
      whiskers = pkgs.catppuccin-whiskers;
    });

    cache.enable = true;
  };
}
