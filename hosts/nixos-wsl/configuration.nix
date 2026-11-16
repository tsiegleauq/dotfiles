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

  systemd.services."wsl-mnt-guard" = {
    overrideStrategy = "asDropin";
    unitConfig.ConditionPathIsMountPoint = "/mnt/wsl";
    serviceConfig = {
      ExecStart = ["" "${pkgs.coreutils}/bin/true"];
      ExecStop = ["" "-${pkgs.util-linux}/bin/mount --make-rslave /mnt/wsl"];
    };
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
    /etc/nixos/private-certs/customer-prd.crt
  ];
}
