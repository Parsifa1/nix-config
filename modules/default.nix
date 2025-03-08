{ inputs, ... }:
with inputs;
{
  flake = {
    flakeModules = {
      # username
      username = {
        username = "parsifa1";
        imports = [ ./options/username.nix ];
      };
      # utils
      utils = {
        imports = [
          ./options/langs.nix
          ./options/packages.nix
          self.flakeModules.username
        ];
      };
    };
    nixosModules = {
      nixos = {
        imports = [
          ./options/nixpkgs.nix
          ../hosts/nixos/config.nix
          self.flakeModules.username
          nixos-wsl.nixosModules.wsl
          agenix.nixosModules.default
          home-manager.nixosModules.home-manager
        ];
      };
      darwin = {
        imports = [
          ./options/nixpkgs.nix
          ../hosts/darwin/config.nix
          self.flakeModules.username
          agenix.darwinModules.default
          home-manager.darwinModules.home-manager
        ];
      };
    };
    homeModules = {
      nixos = {
        imports = [
          self.flakeModules.utils
          ../hosts/nixos/home.nix
          agenix.homeManagerModules.default
          nix-index-database.hmModules.nix-index
        ];
      };
      darwin = {
        imports = [
          self.flakeModules.utils
          ../hosts/darwin/home.nix
          agenix.homeManagerModules.default
          nix-index-database.hmModules.nix-index
        ];
      };
      debian = {
        imports = [
          self.flakeModules.utils
          ../hosts/debian/config.nix
          agenix.homeManagerModules.default
        ];
      };
    };
  };
}
