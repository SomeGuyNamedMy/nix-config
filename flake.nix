{
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        nur.url = "github:nix-community/NUR";
    };
    outputs = {self, nixpkgs, nur, ...}: {
        nixosConfigurations.flex = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                ./cachix.nix
                ./configuration.nix
                ./hardware-configuration.nix
                ./boot.nix
                ./virtualisation.nix
                nur.nixosModules.nur
            ];
        };
    };
}
