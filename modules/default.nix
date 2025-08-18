{ inputs, ... }:
with inputs;
{
  flake.flakeModules = {
    # utils
    nixpkgs.imports = [
      ./options/nixpkgs.nix
    ];
    homeUtils.imports = [
      ./options/username.nix
    ];
    nixUtils.imports = [
      ./options/nixpkgs.nix
      ./options/username.nix
    ];
  };
  imports = [ ./options/settings.nix ];
  flake.nixosModules = {
    nix-wsl = {
      imports = [
        self.configModules.nixos
        self.flakeModules.nixUtils
        nixos-wsl.nixosModules.wsl
        agenix.nixosModules.default
        home-manager.nixosModules.home-manager
      ];
    };
    apfel = {
      imports = [
        self.configModules.nixos
        self.flakeModules.nixUtils
        agenix.darwinModules.default
        home-manager.darwinModules.home-manager
      ];
    };
  };
  flake.homeModules = {
    nix-wsl = {
      imports = [
        self.configModules.home
        self.flakeModules.homeUtils
        agenix.homeManagerModules.default
        nix-index-database.homeModules.nix-index
      ];
    };
    apfel = {
      imports = [
        self.configModules.home
        self.flakeModules.homeUtils
        agenix.homeManagerModules.default
        nix-index-database.homeModules.nix-index
      ];
    };
    debian = {
      imports = [
        self.configModules.home
        self.flakeModules.nixpkgs
        self.flakeModules.homeUtils
        agenix.homeManagerModules.default
      ];
    };
  };
}
