{ config, pkgs, ... }:
let
  wrap = config.wrapWithNixLd;
  isDarwin = pkgs.stdenv.isDarwin;
  uvBuilder =
    name:
    pkgs.buildFHSEnv {
      inherit name;
      runScript = name;
      targetPkgs =
        pkgs: with pkgs; [
          uv
          zlib
          stdenv.cc.cc
        ];
    };
  python3_13 = wrap pkgs.python313 "${pkgs.python313}/bin/python";
  uvFHS = uvBuilder "uv";
  uvxFHS = uvBuilder "uvx";
in
{
  home.packages =
    if isDarwin then
      with pkgs;
      [
        python313
        pixi
        uv
      ]
    else
      [
        python3_13
        pkgs.pixi
        uvFHS
        uvxFHS
      ];
  home.sessionVariables = {
    PYTHON_HISTORY = "$HOME/.local/state/python/history";
    PYTHONPYCACHEPREFIX = "$HOME/.cache/python";
    PYTHONUSERBASE = "$HOME/.local/share/python";
    MPLCONFIGDIR = "$HOME/.local/share/matplotlib"; # for matplotlib
  };

}
