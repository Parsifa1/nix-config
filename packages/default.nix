{ lib, ... }:
let

  files = lib.filterAttrs (n: t: n != "lang" && n != "default.nix") (builtins.readDir ./.);

  Modules = lib.mapAttrsToList (
    name: _: mkPkgModule (lib.removeSuffix ".nix" name) (import (./. + "/${name}"))
  ) files;

  removeSubnix = lib.removeSuffix ".nix";

  pkgModule =
    let
      inherit files;
      pkg = lib.mapAttrs' (
        name: _:
        lib.nameValuePair (removeSubnix name) (
          lib.mkOption {
            type = lib.types.submodule {
              options = {
                enable = lib.mkEnableOption "${removeSubnix name}";
              };
            };
            default = { };
            description = "${removeSubnix name} configuration";
          }
        )
      ) files;
    in
    pkg;

  mkPkgModule =
    name: moduleFunc:
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      cfg = config.userPackages.${name}.enable;
    in
    {
      config = lib.mkIf cfg (moduleFunc {
        inherit pkgs lib config;
      });
    };
in
{
  options.userPackages = pkgModule;
  imports = [ ./lang ] ++ Modules;
}
