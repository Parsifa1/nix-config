{inputs, ...}:
with inputs; let
  nixpkgsWithOverlays = import ./overlay.nix {inherit inputs;};
  argDefaults = {
    inherit inputs self nix-index-database alejandra;
    channels = {inherit nixpkgs nixpkgs-unstable;};
  };
in {
  nixosConfigurations.nixos = nixpkgs.lib.nixosSystem rec {
    system = "x86_64-linux";
    specialArgs = argDefaults // {inherit system;};
    modules = [
      #其他配置文件
      ./nix/wsl.nix
      ./nix/system.nix
      #一些模块
      nixos-wsl.nixosModules.wsl
      nix-ld.nixosModules.nix-ld
      home-manager.nixosModules.home-manager
      # 杂项配置
      {
        nixpkgs = nixpkgsWithOverlays;
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.parsifa1 = import ./nix/home.nix;
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
}
