{ config, lib, ... }:
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
        hmHpath = config.home.homeDirectory;
        nixHpath = config.users.users.${config.username}.home;
        homePath = if config ? home then hmHpath else nixHpath;
        args = if builtins.isString fileName then { name = fileName; } else fileName;
        args' = args // {
          mode = args.mode or "400";
          owner = args.owner or username;
          file = args.file or ../../secrets/${ageName}.age;
          path = args.path or (homePath + "/.config/secret/${args.name}");
        };
      in
      (if config ? home then { } else { owner = args'.owner; })
      // {
        name = args'.name;
        path = args'.path;
        file = args'.file;
        mode = args'.mode;
      }
    ) secretAttrs;
  };
  genPath = lib.concatStringsSep ":";
in
genUtils {
  inherit genPath genSecrets username;
}
