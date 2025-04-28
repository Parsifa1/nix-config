{ pkgs, ... }:
{
  home.packages = with pkgs; [
    typescript
    eslint
    nodejs
    pnpm
    bun
  ];
}
