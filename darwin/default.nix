{ withSystem, inputs, ... }:
with inputs;
{
  flake.darwinConfigurations.AldricdeMacBook-Air = withSystem "aarch64-darwin" (
    { pkgs, inputs', ... }:
    darwin.lib.darwinSystem {
      inherit (pkgs) system;
      specialArgs = { inherit inputs' inputs pkgs; };
      modules = [
        ./system.nix
        ./secret.nix
        #some modules
        agenix.darwinModules.default
        home-manager.darwinModules.home-manager
      ];

    }
  );

}
