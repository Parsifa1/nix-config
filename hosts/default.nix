{ inputs, ... }:
with inputs;
{
  flake.darwinConfigurations.AldricdeMacBook-Air = darwin.lib.darwinSystem rec {
    system = "aarch64-darwin";
    specialArgs = { inherit inputs system; };
    modules = [ self.nixosModules.darwin ];
  };
  flake.nixosConfigurations.nixos = nixpkgs.lib.nixosSystem rec {
    system = "x86_64-linux";
    specialArgs = { inherit inputs system; };
    modules = [ self.nixosModules.nixos ];
  };
  flake.homeConfigurations.parsifa1 =
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit inputs system; };
      modules = [ self.homeModules.debian ];
    };
}
