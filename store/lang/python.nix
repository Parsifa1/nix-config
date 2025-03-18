{ pkgs, ... }:
{
  home.packages = with pkgs; [
    python311
    pixi
    uv
  ];
}
