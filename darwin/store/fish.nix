{ ... }:
{
  home.sessionVariables = {
    EDITOR = "nvim";
    DIRENV_LOG_FORMAT = "\\033[2mdirenv: %s\\033[0m";
    PNPM_HOME = "/Users/parsifa1/.local/share/pnpm";
    FZF_DEFAULT_COMMAND = "fd -H -I -E '{.astro,.git,.kube,.idea,.vscode,.sass-cache,node_modules,build,.vscode-server,.virtualenvs,target}' --type f --strip-cwd-prefix";
    FZF_DEFAULT_OPTS = "--height 40% --layout=reverse --color=bg+:,bg:,gutter:-1,spinner:#f5e0dc,hl:#f38ba8 --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8";
  };
  programs.fish = {
    enable = true;
    shellInitLast = ''
      set -U fish_greeting
      if not string match -q -- $PNPM_HOME $PATH
        set -gx PATH "$PNPM_HOME" $PATH
      end
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
