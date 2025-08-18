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

  # Module generators for Home-Manager packages
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

  # Module generators for NixOS system config
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
