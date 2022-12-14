{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nur.url = "github:nix-community/NUR";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
    base16.url = "github:tinted-theming/base16-schemes";
    base16.flake = false;
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    swww-fork.url = "github:SomeGuyNamedMy/swww";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
  };
  outputs = { self, nixpkgs, nur, home-manager, stylix, base16, swww-fork, hyprland, emacs-overlay, ... }:
    let
      shared-system-modules = [
        ./system/configuration.nix
        ./system/boot.nix
        ./system/packages.nix
        ./system/virtualisation.nix
        ./system/general-hardware.nix
        ./modules/emacs.nix
        nur.nixosModules.nur
        home-manager.nixosModules.home-manager
        stylix.nixosModules.stylix
        {
          stylix.image = "/home/mason/Videos/biker-with-girl.gif";
          stylix.base16Scheme = "${base16}/nord.yaml";
          stylix.polarity = "dark";
          stylix.targets.gtk.enable = false;
        }
        {
          nix.settings.trusted-public-keys = [
            "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          ];
          nix.settings.substituters = [
            "https://cache.iog.io"
            "https://nix-community.cachix.org"
            "https://hyprland.cachix.org"
          ];
        }
      ];
      shared-home-manager-config = {
        home.stateVersion = "22.11";
        home.username = "mason";
        home.homeDirectory = "/home/mason";
        imports = [
          hyprland.homeManagerModules.default
          swww-fork.homeManagerModules.x86_64-linux.default
          ./mason/shell.nix
          ./mason/programming-env.nix
          ./mason/kakoune.nix
          ./mason/mpd.nix
          ./mason/desktop.nix
          ./mason/packages.nix
          { nixpkgs.overlays = [ (import emacs-overlay) ]; }
        ];
      };
      mason-home-config = {
        home-manager.users.mason = shared-home-manager-config;
      };
    in {
      nixosConfigurations.flex = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = shared-system-modules
          ++ [ ./system/flex-hardware.nix mason-home-config ];
      };
      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = shared-system-modules
          ++ [ ./system/desktop-hardware.nix mason-home-config ];
      };
    };
}
