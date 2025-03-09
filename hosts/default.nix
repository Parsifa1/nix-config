{ withSystem, inputs, ... }:
with inputs;
{
  flake.darwinConfigurations.AldricdeMacBook-Air = withSystem "aarch64-darwin" (
    { inputs', ... }:
    darwin.lib.darwinSystem rec {
      system = "aarch64-darwin";
      specialArgs = { inherit inputs inputs' system; };
      modules = [ self.nixosModules.darwin ];
    }
  );
  flake.nixosConfigurations.nixos = withSystem "x86_64-linux" (
    { inputs', ... }:
    nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      specialArgs = { inherit inputs inputs' system; };
      modules = [ self.nixosModules.nixos ];
    }
  );
  flake.homeConfigurations.parsifa1 = withSystem "x86_64-linux" (
    { inputs', ... }:
    let
      system = "x86_64-linux";
      conf = import ../modules/imports/nixpkgs.nix { inherit inputs inputs' system; };
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = conf.nixpkgs.overlays;
      };
    in
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ self.homeModules.debian ];
    }
  );
}
