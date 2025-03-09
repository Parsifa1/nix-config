{ withSystem, inputs, ... }:
with inputs;
{
  flake.darwinConfigurations.AldricdeMacBook-Air = withSystem "aarch64-darwin" (
    { inputs', ... }:
    darwin.lib.darwinSystem rec {
      system = "aarch64-darwin";
      specialArgs = { inherit inputs' inputs system; };
      modules = [
        ./darwin
        ../nixpkgs.nix
        ../modules/nixModules
        #some modules
        agenix.darwinModules.default
        home-manager.darwinModules.home-manager
      ];

    }
  );
  flake.nixosConfigurations.nixos = withSystem "x86_64-linux" (
    { inputs', ... }:
    nixpkgs.lib.nixosSystem rec {
      specialArgs = { inherit inputs inputs' system; };
      system = "x86_64-linux";
      modules = [
        ./nixos
        ../nixpkgs.nix
        ../modules/nixModules
        # some modules
        nixos-wsl.nixosModules.wsl
        agenix.nixosModules.default
        home-manager.nixosModules.home-manager
      ];
    }
  );
  flake.homeConfigurations.parsifa1 = withSystem "x86_64-linux" (
    { inputs', ... }:
    let
      system = "x86_64-linux";
      conf = import ../nixpkgs.nix { inherit inputs inputs' system; };
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = conf.nixpkgs.overlays;
      };
    in
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./debain
        ../modules/homeModules
        agenix.homeManagerModules.default
      ];
    }
  );

}
