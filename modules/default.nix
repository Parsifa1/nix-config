{ inputs, ... }:
with inputs;
{
  flake.flakeModules = {
    # utils
    homeUtils.imports = [
      ./options/store.nix
      ./options/username.nix
    ];
    nixUtils.imports = [
      ./options/system.nix
      ./options/nixpkgs.nix
      ./options/username.nix
    ];
  };
  flake.nixosModules = {
    nixos = {
      imports = [
        ../hosts/nixos/config.nix
        self.flakeModules.nixUtils
        nixos-wsl.nixosModules.wsl
        agenix.nixosModules.default
        home-manager.nixosModules.home-manager
      ];
    };
    darwin = {
      imports = [
        ../hosts/darwin/config.nix
        self.flakeModules.nixUtils
        agenix.darwinModules.default
        home-manager.darwinModules.home-manager
      ];
    };
  };
  flake.homeModules = {
    nixos = {
      imports = [
        ../hosts/nixos/home.nix
        self.flakeModules.homeUtils
        agenix.homeManagerModules.default
        nix-index-database.hmModules.nix-index
      ];
    };
    darwin = {
      imports = [
        ../hosts/darwin/home.nix
        self.flakeModules.homeUtils
        agenix.homeManagerModules.default
        nix-index-database.hmModules.nix-index
      ];
    };
    debian = {
      imports = [
        ./options/nixpkgs.nix
        ../hosts/debian/config.nix
        self.flakeModules.homeUtils
        agenix.homeManagerModules.default
      ];
    };
  };
}
