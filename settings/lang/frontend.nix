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
    NODE_REPL_HISTORY = "$HOME/.local/share/node_repl_history";
    NPM_CONFIG_USERCONFIG = "$HOME/.config/npm/npmrc";
    NPM_CONFIG_PREFIX = "$HOME/.local/share/npm";
    PNPM_HOME = "$HOME/.local/share/pnpm";
    npm_config_cache = "$HOME/.cache/npm";
  };
}
