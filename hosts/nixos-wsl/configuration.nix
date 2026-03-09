# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL
{
  config,
  lib,
  pkgs,
  ...
}: {
  networking.hostName = "nixos-wsl";

  wsl = {
    enable = true;
    defaultUser = "sean";
  };

  zshos.enable = true;
  nh.enable = true;

  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld;
  };

  environment.systemPackages = with pkgs; [
    git
    wget
    alejandra
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "24.05";

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  security.pki.certificateFiles = [
    /etc/nixos/private-certs/customer-repo.crt
  ];
}
