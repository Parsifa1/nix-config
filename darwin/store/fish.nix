{ lib, pkgs, ... }:
let
  EDITOR = "nvim";
  PNPM_HOME = "/Users/parsifa1/.local/share/pnpm";
  LIBRARY_PATH = lib.makeLibraryPath [ pkgs.libiconv ]; # for neovim blink.cmp lib
  FZF_DEFAULT_COMMAND = "fd -H -I -E '{.astro,.git,.kube,.idea,.vscode,.sass-cache,node_modules,build,.vscode-server,.virtualenvs,target}' --type f --strip-cwd-prefix";
  FZF_DEFAULT_OPTS = "--height 40% --layout=reverse --color=bg+:,bg:,gutter:-1,spinner:#f5e0dc,hl:#f38ba8 --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8";
in
{
  home.sessionVariables = {
    inherit
      EDITOR
      PNPM_HOME
      LIBRARY_PATH
      FZF_DEFAULT_COMMAND
      FZF_DEFAULT_OPTS
      ;
    PATH = "$PATH:${PNPM_HOME}";
  };
  programs.fish = {
    enable = true;
    shellInitLast = ''
      set -U fish_greeting
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
    shellAliases = {
      v = "nvim";
      vi = "nvim";
      lg = "lazygit";
      fa = "fastfetch";
      cls = "clear";
      py = "python";
      zf = "z \$(fd --type d --hidden . 2>/dev/null | fzf)";
      ghostty = "/Applications/Ghostty.app/Contents/MacOS/ghostty";
      ls = "eza --icons --group-directories-first --sort=extension -F";
      vf = "set -l file (fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'); and test -n \"\$file\"; and vi \"\$file\"";
    };
  };
}