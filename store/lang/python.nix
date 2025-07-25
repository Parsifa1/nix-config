{ pkgs, ... }:
let
  isDarwin = pkgs.stdenv.isDarwin;
  python3_11 = pkgs.writeShellScriptBin "python" ''
    export LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH
    exec ${pkgs.python311}/bin/python "$@"
  '';
  uvFHS = pkgs.buildFHSEnv {
    name = "uv";
    runScript = "uv";
    targetPkgs =
      pkgs: with pkgs; [
        uv
        zlib
        stdenv.cc.cc
      ];
  };
  uvxFHS = pkgs.buildFHSEnv {
    name = "uvx";
    runScript = "uvx";
    targetPkgs =
      pkgs: with pkgs; [
        uv
        zlib
        stdenv.cc.cc
      ];
  };
in
{
  home.packages =
    if isDarwin then
      with pkgs;
      [
        python311
        pixi
        uv
      ]
    else
      [
        python3_11
        pkgs.pixi
        uvFHS
        uvxFHS
      ];
}
