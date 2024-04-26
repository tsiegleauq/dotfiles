{inputs, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  gnome.enable = true;
  samsungprinter.enable = true;
  #steam.enable = true;
  zshos.enable = true;
  nh.enable = true;
  bluetooth.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-notebook";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap
  services.xserver.xkb = {
    layout = "de";
    variant = "nodeadkeys";
  };

  services.fstrim.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account.
  users.users.sean = {
    isNormalUser = true;
    description = "sean";
    extraGroups = ["networkmanager" "wheel"];
  };

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  environment.variables.EDITOR = "vim";
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  system.stateVersion = "23.11";
}
