{ inputs, ... }:
with inputs;
let
  args = {
    inherit inputs self;
    channels = {
      inherit nixpkgs;
    };
  };
in
{
  nixosConfigurations.nixos = nixpkgs.lib.nixosSystem rec {
    system = "x86_64-linux";
    specialArgs = args // system;
    modules = [
      #其他配置文件
      ./nixpkgs.nix
      ./nixos/wsl.nix
      ./nixos/system.nix
      ./nixos/secret.nix
      ./nixos/service.nix
      #一些模块
      nixos-wsl.nixosModules.wsl
      agenix.nixosModules.default
      home-manager.nixosModules.home-manager
      { home-manager.extraSpecialArgs = specialArgs; }
    ];
  };
  darwinConfigurations.AldricdeMacBook-Air = darwin.lib.darwinSystem rec {
    system = "aarch64-darwin";
    specialArgs = args // system;
    modules = [
      ./nixpkgs.nix
      ./darwin/system.nix
      ./darwin/secret.nix
      #一些模块
      agenix.darwinModules.default
      home-manager.darwinModules.home-manager
      { home-manager.extraSpecialArgs = specialArgs; }
    ];

  };

}
