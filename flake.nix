{
  description = "NixOS Configuration with Caelestia Shell + Hyprland Rice";

  inputs = {
    # Core
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland - latest from git
    hyprland.url = "github:hyprwm/Hyprland";

    # Caelestia Shell - the star of the show
    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Quickshell (for manual integration if needed)
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Astal widgets library
    astal = {
      url = "github:aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    hyprland,
    caelestia-shell,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    # NixOS configuration
    nixosConfigurations = {
      # Replace "caelestia-pc" with your hostname
      caelestia-pc = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/default/configuration.nix
          ./modules/hyprland.nix

          # Home Manager as NixOS module
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              # Replace "user" with your username
              users.user = import ./modules/home/default.nix;
            };
          }
        ];
      };
    };

    # Standalone Home Manager configuration (if not using NixOS module)
    homeConfigurations = {
      "user@caelestia-pc" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };
        modules = [
          caelestia-shell.homeManagerModules.default
          ./modules/home/default.nix
        ];
      };
    };
  };
}
