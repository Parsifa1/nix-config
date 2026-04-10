{
  config,
  lib,
  pkgs,
  ...
}:
let
  # utility variable:
  username = "parsifa1";
  server = false;
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
  wrapWithNixLd =
    pkg: path:
    if pkgs.stdenv.hostPlatform.isLinux then
      pkgs.writeShellScriptBin (baseNameOf path) ''
        export LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH
        exec ${path} "$@"
      ''
    else
      pkg;
in
genUtils {
  inherit
    genPath
    username
    homePath
    server
    wrapWithNixLd
    ;
}
