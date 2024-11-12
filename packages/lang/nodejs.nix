{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nodejs
    pnpm
    bun
  ];
}
