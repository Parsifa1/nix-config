{ lib, ... }:
let
  path = ../../store;
  removeSubnix = lib.removeSuffix ".nix";
  files = lib.filterAttrs (n: t: n != "lang" && n != "default.nix") (builtins.readDir path);
  Modules = lib.mapAttrsToList (
    name: _: mkPkgModule (removeSubnix name) (import (path + "/${name}"))
  ) files;
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
  imports = Modules;
}
