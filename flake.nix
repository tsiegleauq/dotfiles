{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix-flatpak = {
    #   url = "github:gmodena/nix-flatpak/?ref=v0.5.1";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    nixos-wsl,
    nixvim,
    # nix-flatpak,
    ...
  }: {
    nixosConfigurations = {
      ##############
      # Main machine
      ##############
      nixos-main = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        system = "x86_64-linux";
        modules = [
          ./hosts/nixos-main/configuration.nix
          ./modules/nixos
          # nix-flatpak.nixosModules.nix-flatpak
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = {inherit inputs;};
              users = {
                sean = import ./hosts/nixos-main/home.nix;
              };
              sharedModules = [
                nixvim.homeModules.nixvim
              ];
            };
          }
        ];
      };
      # Notebook
      nixos-notebook = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        system = "x86_64-linux";
        modules = [
          ./hosts/nixos-notebook/configuration.nix
          ./modules/nixos
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = {inherit inputs;};
              users = {
                sean = import ./hosts/nixos-notebook/home.nix;
              };
              sharedModules = [
                nixvim.homeModules.nixvim
              ];
            };
          }
        ];
      };
      #wsl
      nixos-wsl = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        system = "x86_64-linux";
        modules = [
          ./hosts/nixos-wsl/configuration.nix
          nixos-wsl.nixosModules.default
          ./modules/nixos
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = {inherit inputs;};
              users = {
                sean = import ./hosts/nixos-wsl/home.nix;
              };
              sharedModules = [
                nixvim.homeModules.nixvim
              ];
            };
          }
        ];
      };
    };
  };
}
