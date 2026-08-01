{ inputs, ... }:
with inputs;
{
  flake.modules = {
    # utils
    nixCommon = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      use-xdg-base-directories = true;
      substituters = [
        "https://cache.nixos.org"
        "https://cloudtide.cachix.org"
        "https://nix-community.cachix.org"
        "https://yazi.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cloudtide.cachix.org-1:9NZ1Mah2+u8cd/CmVffFV23z5uFNpZSrhfgTt5fuN/4="
        "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
      ];
    };
    nixpkgs.imports = [ ./nixpkgs.nix ];
    homeUtils.imports = [
      ./utils.nix
      self.configModules.home
    ];
    nixUtils.imports = [
      ./utils.nix
      ./nixpkgs.nix
      self.configModules.nixos
    ];
  };
  imports = [ ./settings.nix ];
}
