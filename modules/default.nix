{ inputs, ... }:
with inputs;
{
  flake.nixosModules.wsl = {
    imports = [
      self.modules.nixUtils
      rex.nixosModules.default
      nixos-wsl.nixosModules.wsl
      sops-nix.nixosModules.sops
      home-manager.nixosModules.home-manager
    ];
  };
  flake.darwinModules.apfel = {
    imports = [
      self.modules.nixUtils
      sops-nix.darwinModules.sops
      home-manager.darwinModules.home-manager
    ];
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
