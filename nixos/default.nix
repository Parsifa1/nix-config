{ withSystem, inputs, ... }:
with inputs;
{
  flake.nixosConfigurations.nixos = withSystem "x86_64-linux" (
    { pkgs, inputs', ... }:
    nixpkgs.lib.nixosSystem {
      inherit (pkgs) system;
      specialArgs = { inherit inputs inputs' pkgs; };
      modules = [
        ./system.nix
        ./secret.nix
        ./service.nix
        ./wsl.nix
        # some modules
        nixos-wsl.nixosModules.wsl
        agenix.nixosModules.default
        home-manager.nixosModules.home-manager
      ];
    }
  );
}
