{ withSystem, inputs, ... }:
with inputs;
{
  flake.darwinConfigurations.AldricdeMacBook-Air = withSystem "aarch64-darwin" (
    { pkgs, inputs', ... }:
    darwin.lib.darwinSystem {
      inherit (pkgs) system;
      specialArgs = { inherit inputs' inputs pkgs; };
      modules = [
        ./darwin/system.nix
        ./darwin/secret.nix
        #some modules
        agenix.darwinModules.default
        home-manager.darwinModules.home-manager
        {
          home-manager.users.parsifa1.imports = [
            nix-index-database.hmModules.nix-index
            ../modules
          ];
        }
      ];

    }
  );
  flake.nixosConfigurations.nixos = withSystem "x86_64-linux" (
    { pkgs, inputs', ... }:
    nixpkgs.lib.nixosSystem {
      inherit (pkgs) system;
      specialArgs = { inherit inputs inputs' pkgs; };
      modules = [
        ./nixos/system.nix
        ./nixos/secret.nix
        ./nixos/service.nix
        ./nixos/wsl.nix
        # some modules
        nixos-wsl.nixosModules.wsl
        agenix.nixosModules.default
        home-manager.nixosModules.home-manager
        {
          home-manager.users.parsifa1.imports = [
            nix-index-database.hmModules.nix-index
            ../modules
          ];
        }
      ];
    }
  );
}
