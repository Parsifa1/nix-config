{ inputs, ... }:
with inputs;
let
  args = {
    inherit
      inputs
      self
      nix-index-database
      nixpkgs-master
      ;
    channels = {
      inherit nixpkgs;
    };
  };
in
{
  nixosConfigurations.nixos = nixpkgs.lib.nixosSystem rec {
    system = "x86_64-linux";
    specialArgs = args // {
      inherit system;
    };
    modules = [
      #其他配置文件
      ./nixpkgs.nix
      ./nixos/wsl.nix
      ./nixos/system.nix
      ./nixos/service.nix
      #一些模块
      nixos-wsl.nixosModules.wsl
      home-manager.nixosModules.home-manager
      # 杂项配置
      { home-manager.extraSpecialArgs = specialArgs; }
    ];
  };
  darwinConfigurations."AldricdeMacBook-Air" = darwin.lib.darwinSystem rec {
    system = "aarch64-darwin";
    modules = [
      ./darwin/system.nix
      home-manager.darwinModules.home-manager
      {
        home-manager.extraSpecialArgs = args // {
          inherit system;
        };
      }
    ];

  };

}
