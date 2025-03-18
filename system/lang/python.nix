{ pkgs, ... }:
let
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
in
{
  environment.systemPackages = with pkgs; [
    python3_11
    pixi
    uvFHS
  ];
}
