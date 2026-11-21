{
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  gnome.enable = true;
  zshos.enable = true;
  nh.enable = true;
  bluetooth.enable = true;

  nixpkgs.config.allowUnfree = true;

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "nixos-notebook";
    networkmanager.enable = true;
  };

  # Enable X11 & Keymap
  services.xserver = {
    enable = true;
    xkb = {
      layout = "de";
      variant = "nodeadkeys";
    };
  };

  # Prevent Skylake i7-6500U thermal throttling during updates/video playback
  services.thermald.enable = true;

  # Hardware video acceleration for Intel HD Graphics 520 (keeps Chromium/GNOME snappy)
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
    ];
  };

  users.users.sean = {
    isNormalUser = true;
    description = "sean";
    extraGroups = ["networkmanager" "wheel"];
  };

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      trusted-users = ["root" "sean"];
    };
  };

  system.stateVersion = "23.11";
}
