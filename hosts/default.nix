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
        ./darwin/service.nix
        #some modules
        agenix.darwinModules.default
        home-manager.darwinModules.home-manager
        {
          home-manager = {
            extraSpecialArgs = { inherit inputs inputs' pkgs; };
            users.parsifa1.imports = [
              agenix.homeManagerModules.default
              nix-index-database.hmModules.nix-index
              ../modules
            ];
          };
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
        ./nixos/service.nix
        ./nixos/wsl.nix
        # some modules
        nixos-wsl.nixosModules.wsl
        agenix.nixosModules.default
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            extraSpecialArgs = { inherit inputs inputs' pkgs; };
            users.parsifa1.imports = [
              agenix.homeManagerModules.default
              nix-index-database.hmModules.nix-index
              ../modules
            ];
          };
        }
      ];
    }
  );
  flake.homeConfigurations."parsifa1" = withSystem "x86_64-linux" (
    { pkgs, ... }:
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ../modules
        ./debain/home.nix
        agenix.homeManagerModules.default
      ];
    }
  );

}
