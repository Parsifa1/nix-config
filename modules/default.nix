{ inputs, ... }:
with inputs;
{
  flake.nixosModules = {
    nix-wsl = {
      imports = [
        self.flakeModules.nixUtils
        nixos-wsl.nixosModules.wsl
        agenix.nixosModules.default
        home-manager.nixosModules.home-manager
      ];
    };
    apfel = {
      imports = [
        self.flakeModules.nixUtils
        agenix.darwinModules.default
        home-manager.darwinModules.home-manager
      ];
    };
  };
  flake.homeModules = {
    nix-wsl = {
      imports = [
        self.flakeModules.homeUtils
        agenix.homeManagerModules.default
        nix-index-database.homeModules.nix-index
      ];
    };
    apfel = {
      imports = [
        self.flakeModules.homeUtils
        agenix.homeManagerModules.default
        nix-index-database.homeModules.nix-index
      ];
    };
    debian = {
      imports = [
        self.flakeModules.nixpkgs
        self.flakeModules.homeUtils
        agenix.homeManagerModules.default
      ];
    };
  };
  imports = [ ./options ];
}
