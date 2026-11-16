{
  description = "NixOS config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    nixos-wsl,
    nixvim,
    catppuccin,
    ...
  }: let
    mkSystem = hostname: system: extraModules:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};
        modules =
          [
            ./hosts/${hostname}/configuration.nix
            catppuccin.nixosModules.catppuccin
            home-manager.nixosModules.home-manager
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
      nixos-main = mkSystem "nixos-main" "x86_64-linux" [
        ./modules/nixos/_core.nix
        ./modules/nixos/_desktop.nix
      ];

      nixos-notebook = mkSystem "nixos-notebook" "x86_64-linux" [
        ./modules/nixos/_core.nix
        ./modules/nixos/_desktop.nix
      ];

      nixos-wsl = mkSystem "nixos-wsl" "x86_64-linux" [
        nixos-wsl.nixosModules.default
        ./modules/nixos/core.nix
      ];

      nixos-pi = mkSystem "nixos-pi" "aarch64-linux" [
        ./modules/nixos/core.nix
      ];
    };
  };
}
