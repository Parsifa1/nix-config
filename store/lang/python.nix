{ pkgs, ... }:
let
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
  python3_11 = pkgs.writeShellScriptBin "python" ''
    export LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH
    exec ${pkgs.python311}/bin/python "$@"
  '';
  uvFHS = uvBuilder "uv";
  uvxFHS = uvBuilder "uvx";
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
