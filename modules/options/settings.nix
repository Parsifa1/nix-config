{ lib, ... }:
let
  # Common functions
  pkgPath = ../../settings/app;
  langPath = ../../settings/lang;
  configPath = ../../settings/system;
  removeSubnix = lib.removeSuffix ".nix";

  # File listings
  langFiles = lib.filterAttrs (n: t: lib.hasSuffix ".nix" n) (builtins.readDir langPath);
  pkgFiles = lib.filterAttrs (n: t: t == "directory" || (t == "regular" && lib.hasSuffix ".nix" n)) (
    builtins.readDir pkgPath
  );
  sysfiles = lib.filterAttrs (n: t: t == "directory" || (t == "regular" && lib.hasSuffix ".nix" n)) (
    builtins.readDir configPath
  );

  # Module generators. moduleFunc's return attrset IS the config.
  # cfg is the freeform userPackages.<name> attrset — modules read
  # parameters per-key as `cfg.<param> or <default>` (per-key select
  # avoids eval recursion; don't enumerate cfg's keys).
  mkPkgModule =
    /*nixfmt:disable*/
    name: moduleFunc:
    { osConfig, config, pkgs, ... }:
    let
      cfg = config.userPackages.${name};
    in
    {
      options.userPackages.${name} = lib.mkOption {
        type = lib.types.submodule {
          freeformType = lib.types.anything;
          options.enable = lib.mkEnableOption "${name}";
        };
        default = { };
      };
      config = lib.mkIf cfg.enable (moduleFunc {
        inherit pkgs config osConfig lib cfg;
      });
    };
  mkLangModule =
    name: moduleFunc:
    { config, pkgs, ... }:
    let
      cfg = config.userPackages.lang.${name};
    in
    {
      options.userPackages.lang.${name} = lib.mkOption {
        type = lib.types.submodule {
          freeformType = lib.types.anything;
          options.enable = lib.mkEnableOption "${name}";
        };
        default = { };
      };
      config = lib.mkIf cfg.enable (moduleFunc {
        inherit pkgs lib config cfg;
      });
    };
    /*nixfmt:enable*/

  # Module generators for NixOS system config
  mkConfigModule =
    name: moduleFunc:
    args@{ config, pkgs, ... }:
    let
      cfg = config.nixosConfig.${name};
    in
    {
      options.nixosConfig.${name} = lib.mkOption {
        type = lib.types.submodule {
          freeformType = lib.types.anything;
          options.enable = lib.mkEnableOption "${name}";
        };
        default = { };
      };
      config = lib.mkIf cfg.enable (moduleFunc {
        inherit config pkgs cfg;
        inherit (args) inputs lib;
      });
    };

  # Generate all individual modules
  pkgModules = lib.mapAttrsToList (
    name: _: mkPkgModule (removeSubnix name) (import (pkgPath + "/${name}"))
  ) pkgFiles;

  langModules = lib.mapAttrsToList (
    name: _: mkLangModule (removeSubnix name) (import (langPath + "/${name}"))
  ) langFiles;

  configModules = lib.mapAttrsToList (
    name: _: mkConfigModule (removeSubnix name) (import (configPath + "/${name}"))
  ) sysfiles;
in
{
  config = {
    flake.configModules = {
      home = _: { imports = pkgModules ++ langModules; };
      nixos = _: { imports = configModules; };
    };
  };
}
