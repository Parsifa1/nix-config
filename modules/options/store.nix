{ lib, ... }:
let
  # Common functions
  pkgPath = ../../store;
  langPath = ../../store/lang;
  removeSubnix = lib.removeSuffix ".nix";
  langFiles = builtins.readDir langPath;
  pkgFiles = lib.filterAttrs (n: t: n != "lang") (builtins.readDir pkgPath);
  # Module generators
  mkPkgModule =
    name: moduleFunc:
    { config, pkgs, ... }:
    let
      cfg = config.userPackages.${name}.enable;
    in
    {
      config = lib.mkIf cfg (moduleFunc {
        inherit pkgs config lib;
      });
      options.userPackages.${name} = {
        enable = lib.mkEnableOption "${name}";
      };
    };
  mkLangModule =
    name: moduleFunc:
    { config, pkgs, ... }:
    let
      cfg = config.userPackages.lang.${name}.enable;
    in
    {
      config = lib.mkIf cfg (moduleFunc {
        inherit pkgs lib config;
      });
      options.userPackages.lang.${name} = {
        enable = lib.mkEnableOption "${name}";
      };
    };
  # Generate regular package modules
  pkgModules = lib.mapAttrsToList (
    name: _: mkPkgModule (removeSubnix name) (import (pkgPath + "/${name}"))
  ) pkgFiles;
  # Generate language package modules
  langModules = lib.mapAttrsToList (
    name: _: mkLangModule (removeSubnix name) (import (langPath + "/${name}"))
  ) langFiles;
in
{
  imports = pkgModules ++ langModules;
}
