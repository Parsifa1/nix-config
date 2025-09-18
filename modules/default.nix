{ inputs, ... }:
with inputs;
{
  flake.nixosModules = {
    nix-wsl = {
      imports = [
        self.flakeModules.nixUtils
        nixos-wsl.nixosModules.wsl
        # agenix.nixosModules.default
        sops-nix.nixosModules.sops
        home-manager.nixosModules.home-manager
      ];
    };
    apfel = {
      imports = [
        self.flakeModules.nixUtils
        # agenix.darwinModules.default
        sops-nix.darwinModules.sops
        home-manager.darwinModules.home-manager
      ];
    };
  };
  flake.homeModules = {
    default = {
      imports = [
        self.flakeModules.homeUtils
        # agenix.homeManagerModules.default
        sops-nix.homeManagerModules.sops
        nix-index-database.homeModules.nix-index
      ];
    };
    debian = {
      imports = [
        self.flakeModules.nixpkgs
        self.flakeModules.homeUtils
        sops-nix.homeManagerModules.sops
        # agenix.homeManagerModules.default
      ];
    };
  };
  imports = [ ./options ];
}
