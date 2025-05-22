{ pkgs, ... }:
{
  home.packages = with pkgs; [
    typescript
    nodejs_24
    eslint
    pnpm
    bun
  ];
}
