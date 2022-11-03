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
    let shared-modules = [
                ./system/configuration.nix
                ./system/boot.nix
                ./system/virtualisation.nix
                nur.nixosModules.nur
    ];
    in {
        nixosConfigurations.flex = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = shared-modules ++ [
                ./system/flex-hardware.nix
            ];
        };
        nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = shared-modules ++ [
                ./system/desktop-hardware.nix
            ];
        };
    };
}
