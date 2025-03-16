{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  gnome.enable = true;
  samsungprinter.enable = true;
  steam.enable = true;
  zshos.enable = true;
  nh.enable = true;
  # sunshine.enable = true;
  # bluetooth.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # make AppImages runnable
  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
    magicOrExtension = ''\x7fELF....AI\x02'';
  };

  networking = {
    hostName = "nixos-main";
    networkmanager.enable = true;
    extraHosts = ''
      192.168.0.26 omv
      192.168.0.128 moode
    '';
  };

  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "altgr-intl";
      };
      videoDrivers = ["amdgpu"];
    };
    # enable trim ssd support - important
    fstrim.enable = true;
    nfs.server.enable = true;
    teamviewer.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account.
  users.users.sean = {
    isNormalUser = true;
    description = "sean";
    extraGroups = ["users" "networkmanager" "wheel" "scanner" "lp"];
  };

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    auto-optimise-store = true;
  };

  system.stateVersion = "23.11";

  # for standalone linux applications
  programs.nix-ld.enable = true;
  # programs.nix-ld.libraries = with pkgs; [
  #   # Add any missing dynamic libraries for unpackaged programs
  #   # here, NOT in environment.systemPackages
  # ];

  programs.ausweisapp = {
    enable = true;
    openFirewall = true;
  };

  ## Testig nix-flathub
  services.flatpak = {
    enable = true;
    # packages = [
    #   "com.usebottles.bottles" # install bottles from flathub
    # ];
  };
}
