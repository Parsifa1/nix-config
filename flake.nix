{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    alejandra = {
      url = "github:kamadorueda/alejandra/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    inputs:
    with inputs;
    let
      nixpkgsWithOverlays = with inputs; rec {
        config = {
          allowUnfree = true;
        };
        overlays = [
          nur.overlay
          (_final: prev: {
            unstable = import nixpkgs-unstable {
              inherit (prev) system;
              inherit config;
            };
          })
        ];
      };
      argDefaults = {
        pkg-neovim = import nixpkgs {
          system = "x86_64-linux";
          overlays = [ inputs.neovim-nightly-overlay.overlay ];
        };
        inherit
          inputs
          self
          nix-index-database
          alejandra
          ;
        channels = {
          inherit nixpkgs nixpkgs-unstable;
        };
      };
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = argDefaults;
        modules = [
          #其他配置文件
          ./config/wsl.nix
          ./config/system.nix
          #一些模块
          nixos-wsl.nixosModules.wsl
          nix-ld.nixosModules.nix-ld
          home-manager.nixosModules.home-manager
          # 杂项配置
          {
            nixpkgs = nixpkgsWithOverlays;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.parsifa1 = import ./config/home.nix;
            home-manager.extraSpecialArgs = specialArgs;
            nix.settings.auto-optimise-store = true;
            nix.gc = {
              automatic = true;
              dates = "weekly";
              options = "--delete-older-than 1w";
            };
          }
        ];
      };
    };
}
