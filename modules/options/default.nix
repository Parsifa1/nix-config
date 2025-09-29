{ inputs, ... }:
with inputs;
{
  flake.modules = {
    # utils
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
