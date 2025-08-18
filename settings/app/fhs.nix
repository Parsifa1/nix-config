{ pkgs, ... }:
let
  base = pkgs.appimageTools.defaultFhsEnvArgs;
in
{
  home.packages = [
    (pkgs.buildFHSEnv (
      base
      // {
        name = "fhs";
        targetPkgs =
          pkgs:
          (base.targetPkgs pkgs)
          ++ (with pkgs; [
            pkg-config
            ncurses
          ]);
        profile = "export FHS=1";
        runScript = "fish";
        extraOutputsToInstall = [ "dev" ];
      }
    ))
  ];
}
