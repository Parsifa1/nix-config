{ withSystem, inputs, ... }:
with inputs;
{
  flake.darwinConfigurations.AldricdeMacBook-Air = withSystem "aarch64-darwin" (
    { pkgs, inputs', ... }:
    let
    in
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
            ];
          };
        }
      ];

    }
  );
  flake.nixosConfigurations.nixos = withSystem "x86_64-linux" (
    { inputs', ... }:
    nixpkgs.lib.nixosSystem rec {
      specialArgs = { inherit inputs inputs' system; };
      system = "x86_64-linux";
      modules = [
        ../nixpkgs.nix
        ./nixos/wsl.nix
        ./nixos/system.nix
        ./nixos/service.nix
        # some modules
        nixos-wsl.nixosModules.wsl
        agenix.nixosModules.default
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            extraSpecialArgs = { inherit inputs inputs' system; };
            users.parsifa1.imports = [
              agenix.homeManagerModules.default
              nix-index-database.hmModules.nix-index
            ];
          };
        }
      ];
    }
  );
  flake.homeConfigurations."parsifa1" = withSystem "x86_64-linux" (
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
        ../modules
        ./debain/home.nix
        agenix.homeManagerModules.default
      ];
    }
  );

}
