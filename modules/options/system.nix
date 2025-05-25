{ lib, ... }:
let
  # Common functions
  configPath = ../../system;
  removeSubnix = lib.removeSuffix ".nix";
  sysfiles = lib.filterAttrs (n: t: t == "directory" || (t == "regular" && lib.hasSuffix ".nix" n)) (
    builtins.readDir configPath
  );
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
  configModules = lib.mapAttrsToList (
    name: _: mkConfigModule (removeSubnix name) (import (configPath + "/${name}"))
  ) sysfiles;
in
{
  imports = configModules;
}
