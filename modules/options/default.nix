{ inputs, ... }:
with inputs;
{
  flake.flakeModules = {
    # utils
    nixpkgs.imports = [ ./nixpkgs.nix ];
    homeUtils.imports = [
      ./username.nix
      self.configModules.home
    ];
    nixUtils.imports = [
      ./nixpkgs.nix
      ./username.nix
      self.configModules.nixos
    ];
  };
  imports = [ ./settings.nix ];
}
