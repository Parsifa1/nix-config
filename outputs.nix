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
      ./nix/wsl.nix
      ./nix/system.nix
      ./nix/service.nix
      #一些模块
      nixos-wsl.nixosModules.wsl
      home-manager.nixosModules.home-manager
      # 杂项配置
      { home-manager.extraSpecialArgs = specialArgs; }
    ];
  };
}
