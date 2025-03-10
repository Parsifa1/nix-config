{ inputs, ... }:
with inputs;
{
  flake.nixosConfigurations.nixos = nixpkgs.lib.nixosSystem rec {
    system = "x86_64-linux";
    specialArgs = { inherit inputs system; };
    modules = [ self.nixosModules.nixos ];
  };
  flake.darwinConfigurations.AldricdeMacBook-Air = darwin.lib.darwinSystem rec {
    system = "aarch64-darwin";
    specialArgs = { inherit inputs system; };
    modules = [ self.nixosModules.darwin ];
  };
  flake.homeConfigurations.parsifa1 = home-manager.lib.homeManagerConfiguration {
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    modules = [ self.homeModules.debian ];
    extraSpecialArgs = {
      system = "x86_64-linux";
      inherit inputs;
    };
  };
}
