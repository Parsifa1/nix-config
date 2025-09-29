{ config, lib, ... }:
let
  # utility variable:
  username = "parsifa1";
  homePath = if config ? home then config.home.homeDirectory else config.users.users.${username}.home;
  # utility function:
  genUtils = utilsAttrs: {
    options = builtins.mapAttrs (
      _: value:
      lib.mkOption {
        type = lib.types.anything;
        default = value;
      }
    ) utilsAttrs;
  };
  genPath = lib.concatStringsSep ":";
in
genUtils {
  inherit genPath username homePath;
}
