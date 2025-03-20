{ lib, ... }:
let
  # Common functions
  configPath = ../../system;
  # langPath = ../../system/lang;
  removeSubnix = lib.removeSuffix ".nix";
  # langFiles = builtins.readDir langPath;
  sysfiles = lib.filterAttrs (n: t: t == "regular") (builtins.readDir configPath);
  # Module generators
  mkConfigModule =
    name: moduleFunc:
    args@{ config, pkgs, ... }:
    let
      cfg = config.nixosConfig.${name}.enable;
    in
    {
      config = lib.mkIf cfg (moduleFunc {
        inherit config pkgs;
        inherit (args) inputs lib;
      });
      options.nixosConfig.${name} = {
        enable = lib.mkEnableOption "${name}";
      };
    };
  # mkLangModule =
  #   name: moduleFunc:
  #   args@{ config, pkgs, ... }:
  #   let
  #     cfg = config.nixosConfig.lang.${name}.enable;
  #   in
  #   {
  #     config = lib.mkIf cfg (moduleFunc {
  #       inherit config pkgs;
  #       inherit (args) inputs lib;
  #     });
  #     options.nixosConfig.lang.${name} = {
  #       enable = lib.mkEnableOption "${name}";
  #     };
  #   };
  configModules = lib.mapAttrsToList (
    name: _: mkConfigModule (removeSubnix name) (import (configPath + "/${name}"))
  ) sysfiles;
  # langModules = lib.mapAttrsToList (
  #   name: _: mkLangModule (removeSubnix name) (import (langPath + "/${name}"))
  # ) langFiles;
in
{
  imports = configModules;
  # ++ langModules;
}
