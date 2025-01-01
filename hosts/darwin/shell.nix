{ ... }:
let
  EDITOR = "nvim";
  LOCAL = "$HOME/.local/bin";
  NH_FLAKE = "$HOME/.config/nix";
  CARGO_HOME = "$HOME/.cargo/bin";
  ADD_PATH = builtins.concatStringsSep ":";
  PNPM_HOME = "$HOME/.local/share/pnpm/bin";
  FZF_DEFAULT_COMMAND = "fd -H -I -E '{.astro,.git,.kube,.idea,.vscode,.sass-cache,node_modules,build,.vscode-server,.virtualenvs,target}' --type f --strip-cwd-prefix";
  FZF_DEFAULT_OPTS = "--height 40% --layout=reverse --color=bg+:,bg:,gutter:-1,spinner:#f5e0dc,hl:#f38ba8 --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8";
in
{
  home.sessionVariables = {
    inherit
      EDITOR
      NH_FLAKE
      PNPM_HOME
      FZF_DEFAULT_OPTS
      FZF_DEFAULT_COMMAND
      ;
    PATH = ADD_PATH [
      LOCAL
      "$PATH"
      PNPM_HOME
      CARGO_HOME
    ];
  };
  programs.fish = {
    enable = true;
    loginShellInit = ''
      unlink $HOME/.local/bin/cc
      ln -s /usr/bin/clang ~/.local/bin/cc
    '';
    shellInitLast = ''
      set -U fish_greeting
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
    interactiveShellInit = ''
      if test "$TERM_PROGRAM" = ghostty
        if test -n "$GHOSTTY_RESOURCES_DIR"
          source $GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish
        end
        if test -n "$GHOSTTY_BIN_DIR" && not contains "$GHOSTTY_BIN_DIR" $PATH
          set -p PATH "$GHOSTTY_BIN_DIR"
        end
      end
    '';
    shellAliases = {
      y = "yy";
      v = "nvim";
      vi = "nvim";
      cls = "clear";
      py = "python";
      lg = "lazygit";
      fa = "fastfetch";
      zf = "z \$(fd --type d --hidden . 3>/dev/null | fzf)";
      ls = "eza --icons --group-directories-first --sort=extension -F";
      vf = "set -l file (fzf --preview 'bat --style=numbers --color=always --line-range :501 {}'); and test -n \"\$file\"; and vi \"\$file\"";
    };
  };
}
