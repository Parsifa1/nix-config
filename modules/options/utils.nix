{ lib, ... }:
let
  # utility variable:
  username = "parsifa1";
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
  genSecrets = secretAttrs: {
    secrets = builtins.mapAttrs (
      ageName: fileName:
      let
        config = if builtins.isString fileName then { name = fileName; } else fileName;
        config' = config // {
          file = config.file or ../../secrets/${ageName}.age;
          path = config.path or "$HOME/.config/secret/${config.name}";
          mode = config.mode or "400";
        };
      in
      {
        name = config'.name;
        path = config'.path;
        file = config'.file;
        mode = config'.mode;
      }
    ) secretAttrs;
  };
  genPath = lib.concatStringsSep ":";
in
genUtils {
  inherit genPath genSecrets username;
}
