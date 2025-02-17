{ pkgs, ... }:
{
  home.packages = with pkgs; [
    typescript
    nodejs
    pnpm
    bun
  ];
}
