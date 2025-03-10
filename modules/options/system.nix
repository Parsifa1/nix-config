{ lib, ... }:
let
  configPath = ../../system;
  removeSubnix = lib.removeSuffix ".nix";
  files = lib.filterAttrs (n: t: t == "regular") (builtins.readDir configPath);
  # Module generators
  mkConfigModule =
    name: moduleFunc:
    args@{ config, pkgs, ... }:
    let
      cfg = config.nixosConfig.${name}.enable;
    in
    {
      options.nixosConfig.${name} = {
        enable = lib.mkEnableOption "${name}";
      };
      config = lib.mkIf cfg (moduleFunc {
        inherit config pkgs;
        inherit (args) inputs lib;
      });
    };
  configModules = lib.mapAttrsToList (
    name: _: mkConfigModule (removeSubnix name) (import (configPath + "/${name}"))
  ) files;
in
{
  imports = configModules;
}
