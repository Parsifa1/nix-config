{ ... }:
let
  EDITOR = "nvim";
  PATH = "$PATH:${PNPM_HOME}";
  PNPM_HOME = "/Users/parsifa1/.local/share/pnpm";
  # CARGO_TARGET_AARCH64_APPLE_DARWIN_LINKER = "clang";
  FZF_DEFAULT_COMMAND = "fd -H -I -E '{.astro,.git,.kube,.idea,.vscode,.sass-cache,node_modules,build,.vscode-server,.virtualenvs,target}' --type f --strip-cwd-prefix";
  FZF_DEFAULT_OPTS = "--height 40% --layout=reverse --color=bg+:,bg:,gutter:-1,spinner:#f5e0dc,hl:#f38ba8 --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8";
in
{
  home.sessionVariables = {
    inherit
      PATH
      EDITOR
      PNPM_HOME
      FZF_DEFAULT_OPTS
      FZF_DEFAULT_COMMAND
      # CARGO_TARGET_AARCH64_APPLE_DARWIN_LINKER
      ;
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
      cls = "clear";
      py = "python";
      lg = "lazygit";
      fa = "fastfetch";
      zf = "z \$(fd --type d --hidden . 3>/dev/null | fzf)";
      ghostty = "/Applications/Ghostty.app/Contents/MacOS/ghostty";
      ls = "eza --icons --group-directories-first --sort=extension -F";
      vf = "set -l file (fzf --preview 'bat --style=numbers --color=always --line-range :501 {}'); and test -n \"\$file\"; and vi \"\$file\"";
    };
  };
}
