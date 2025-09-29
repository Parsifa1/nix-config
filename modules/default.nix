{ inputs, ... }:
with inputs;
{
  flake.nixosModules = {
    nix-wsl = {
      imports = [
        self.modules.nixUtils
        nixos-wsl.nixosModules.wsl
        sops-nix.nixosModules.sops
        home-manager.nixosModules.home-manager
      ];
    };
    apfel = {
      imports = [
        self.modules.nixUtils
        sops-nix.darwinModules.sops
        home-manager.darwinModules.home-manager
      ];
    };
  };
  flake.homeModules = {
    default = {
      imports = [
        self.modules.homeUtils
        sops-nix.homeManagerModules.sops
        nix-index-database.homeModules.nix-index
      ];
    };
    debian = {
      imports = [
        self.modules.nixpkgs
        self.modules.homeUtils
        sops-nix.homeManagerModules.sops
      ];
    };
  };
  imports = [ ./options ];
}
