{ pkgs, ... }:
{
  home.packages = with pkgs; [
    typescript
    nodejs_24
    corepack_24
    eslint
    bun
  ];
  home.sessionVariables = {
    NPM_CONFIG_USERCONFIG = "$HOME/.config/npm/npmrc";
    NPM_CONFIG_PREFIX = "$HOME/.local/share/npm";
    PNPM_HOME = "$HOME/.local/share/pnpm";
    NPM_CONFIG_CACHE = "$HOME/.cache/npm";
  };
}
