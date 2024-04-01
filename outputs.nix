{inputs, ...}:
with inputs; let
  nixpkgsWithOverlays = import ./overlay.nix {inherit inputs;};
  argDefaults = {
    inherit inputs self nix-index-database;
    channels = {inherit nixpkgs;};
  };
in {
  nixosConfigurations.nixos = nixpkgs.lib.nixosSystem rec {
    system = "x86_64-linux";
    specialArgs = argDefaults // {inherit system;};
    modules = [
      #其他配置文件
      ./nix/wsl.nix
      ./nix/system.nix
      ./nix/service.nix
      #一些模块
      nixos-wsl.nixosModules.wsl
      home-manager.nixosModules.home-manager
      # 杂项配置
      {
        nixpkgs = nixpkgsWithOverlays;
        nix = {
          settings = {
            auto-optimise-store = true;
            use-xdg-base-directories = true;
          };
          gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 1w";
          };
        };
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.parsifa1 = import ./nix/home.nix;
          extraSpecialArgs = specialArgs;
        };
      }
    ];
  };
}
