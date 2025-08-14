{ inputs, ... }:
with inputs;
{
  flake.nixosConfigurations.nix-wsl = nixpkgs.lib.nixosSystem rec {
    system = "x86_64-linux";
    specialArgs = { inherit inputs system; };
    modules = [
      ./nix-wsl/config.nix
      self.nixosModules.nix-wsl
    ];
  };
  flake.darwinConfigurations.apfel = darwin.lib.darwinSystem rec {
    system = "aarch64-darwin";
    specialArgs = { inherit inputs system; };
    modules = [
      ./apfel/config.nix
      self.nixosModules.apfel
    ];
  };
  flake.homeConfigurations.parsifa1 = home-manager.lib.homeManagerConfiguration {
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    modules = [
      ./debian/config.nix
      self.homeModules.debian
    ];
    extraSpecialArgs = {
      system = "x86_64-linux";
      inherit inputs;
    };
  };
}
