{
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        nur.url = "github:nix-community/NUR";
        home-manager = {
            url = "github:hyprwm/Hyprland";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        hyprland = {
            url = "github:hyprwm/Hyprland";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        swww-fork.url = "github:SomeGuyNamedMy/swww";
    };
    outputs = {self, nixpkgs, nur, home-manager, swww-fork, hyprland, ...}:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
        nixosConfigurations.flex = nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
                ./system/configuration.nix
                ./system/flex-hardware.nix
                ./system/boot.nix
                ./system/virtualisation.nix
                nur.nixosModules.nur
            ];
        };
        pkgs.homeConfigurations.mason = home-manager.lib.homeManagerConfiguration {
            modules = [
                ./mason/shell.nix
                ./mason/kakoune.nix
                ./mason/mpd.nix
                ./mason/desktop.nix
                ./mason/qutebrowser.nix
                ./mason/packages.nix
                swww-fork.homeManagerModules.x86_64-linux.default
                hyprland.homeManagerModules.default
                {
                    home.stateVersion = "22.11";
                    home.username = "mason";
                    home.homeDirectory = "/home/mason";
                }
            ];
        };
    };
}
