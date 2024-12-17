{ lib, ... }:
let
  removeSubnix = lib.removeSuffix ".nix";
  files = lib.filterAttrs (n: t: t == "regular" && n != "default.nix") (builtins.readDir ./.);
  Modules = lib.mapAttrsToList (
    name: _: mkLangModule (removeSubnix name) (import (./. + "/${name}"))
  ) files;

  langModules =
    let
      inherit files;
      languages = lib.mapAttrs' (
        name: _:
        lib.nameValuePair (removeSubnix name) (
          lib.mkOption {
            type = lib.types.submodule {
              options = {
                enable = lib.mkEnableOption "${removeSubnix name} toolchain";
              };
            };
            default = { };
            description = "${removeSubnix name} language configuration";
          }
        )
      ) files;
    in
    languages;
  mkLangModule =
    name: moduleFunc:
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      cfg = config.userPackages.lang.${name}.enable;
    in
    {
      config = lib.mkIf cfg (moduleFunc {
        inherit pkgs lib config;
      });
    };
in
{
  options.userPackages.lang = langModules;

  imports = Modules;
}
