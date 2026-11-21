{
  description = "NixOS config flake";

  nixConfig = {
    extra-substituters = [
      "https://catppuccin.cachix.org"
    ];
    extra-trusted-public-keys = [
      "catppuccin.cachix.org-1:j9FfH5E5nPEDgM88w83p73N9479bC/Aebq2LTL4KIK8="
    ];
  };

  inputs = {
    # Unstable inputs (for nixos-main, wsl)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Stable inputs (for nixos-notebook)
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-26.05";

    home-manager-stable = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
    };

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-stable,
    home-manager,
    home-manager-stable,
    nixos-wsl,
    nixvim,
    catppuccin,
    ...
  }: let
    # Added pkgsInput and hmInput parameters to isolate release branches per host
    mkSystem = {
      hostname,
      system,
      pkgsInput ? nixpkgs,
      hmInput ? home-manager,
      extraModules ? [],
    }:
      pkgsInput.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};
        modules =
          [
            ./hosts/${hostname}/configuration.nix
            catppuccin.nixosModules.catppuccin
            hmInput.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {inherit inputs;};
                users.sean = {
                  imports = [
                    ./hosts/${hostname}/home.nix
                    catppuccin.homeModules.catppuccin
                  ];
                };
              };
            }
          ]
          ++ extraModules;
      };
  in {
    nixosConfigurations = {
      nixos-main = mkSystem {
        hostname = "nixos-main";
        system = "x86_64-linux";
        extraModules = [
          ./modules/nixos/_core.nix
          ./modules/nixos/_desktop.nix
        ];
      };

      nixos-notebook = mkSystem {
        hostname = "nixos-notebook";
        system = "x86_64-linux";
        pkgsInput = nixpkgs-stable;
        hmInput = home-manager-stable;
        extraModules = [
          ./modules/nixos/_core.nix
          ./modules/nixos/_desktop.nix
        ];
      };

      nixos-wsl = mkSystem {
        hostname = "nixos-wsl";
        system = "x86_64-linux";
        extraModules = [
          nixos-wsl.nixosModules.default
          ./modules/nixos/_core.nix
        ];
      };
    };
  };
}
