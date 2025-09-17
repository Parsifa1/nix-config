{ inputs, ... }:
with inputs;
{
  flake.nixosModules = {
    nix-wsl = {
      imports = [
        self.modules.nixUtils
        nixos-wsl.nixosModules.wsl
        agenix.nixosModules.default
        home-manager.nixosModules.home-manager
      ];
    };
    apfel = {
      imports = [
        self.modules.nixUtils
        agenix.darwinModules.default
        home-manager.darwinModules.home-manager
      ];
    };
  };
  flake.homeModules = {
    default = {
      imports = [
        self.modules.homeUtils
        agenix.homeManagerModules.default
        nix-index-database.homeModules.nix-index
      ];
    };
    debian = {
      imports = [
        self.modules.nixpkgs
        self.modules.homeUtils
        agenix.homeManagerModules.default
      ];
    };
  };
  imports = [ ./options ];
}
