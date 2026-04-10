{ config, pkgs, ... }:
let
  wrap = config.wrapWithNixLd;
  bun = wrap pkgs.bun "${pkgs.bun}/bin/bun";
  bunx = wrap pkgs.bun "${pkgs.bun}/bin/bunx";
in
{
  home.packages = with pkgs; [
    typescript
    nodejs_24
    corepack_24
    eslint
    bun
    bunx
  ];
  home.sessionVariables = {
    NODE_REPL_HISTORY = "$HOME/.local/share/node_repl_history";
    NPM_CONFIG_USERCONFIG = "$HOME/.config/npm/npmrc";
    NPM_CONFIG_PREFIX = "$HOME/.local/share/npm";
    PNPM_HOME = "$HOME/.local/share/pnpm";
    npm_config_cache = "$HOME/.cache/npm";
  };
}
