{ config, lib, ... }:
let
  PATH = config.genPath [
    "/etc/profiles/per-user/$USER/bin" # NIX_PATH
    "/run/current-system/sw/bin"
    "/opt/homebrew/opt/llvm@20/bin" # LLVM_PATH
    "/usr/local/bin" # NATIVE
    "/usr/bin"
    "/bin"
    "/usr/sbin"
    "/sbin"
  ];
in
{
  home.sessionVariables = {
    inherit PATH;
    EDITOR = "nvim";
    NH_FLAKE = "$HOME/.config/nix";
    WAKATIME_HOME = "$HOME/.local/share/wakatime";
    FZF_DEFAULT_COMMAND = "fd -H -I -E '{.astro,.git,.kube,.idea,.vscode,.sass-cache,node_modules,build,.vscode-server,.virtualenvs,target}' --type f --strip-cwd-prefix";
    FZF_DEFAULT_OPTS = "--height 40% --gutter ' ' --layout=reverse --color=bg+:,bg:,spinner:#f5e0dc,hl:#f38ba8 --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8";
  };
  home.sessionPath = [
    "$CARGO_HOME/bin"
    "$HOME/.local/bin"
  ];
  programs.fish = {
    enable = true;
    loginShellInit = lib.readFile ./.config.fish;
    binds."ctrl-s".command = "edit_command_buffer";
    shellAliases = {
      y = "yy";
      v = "nvim";
      vi = "nvim";
      cls = "clear";
      py = "python";
      lg = "lazygit";
      fa = "fastfetch";
      zf = "z \$(fd --type d --hidden . 3>/dev/null | fzf)";
      ls = "eza --icons --group-directories-first --sort=extension -F -I='.DS_Store'";
      vf = "set -l file (fzf --preview 'bat --style=numbers --color=always --line-range :501 {}'); and test -n \"\$file\"; and vi \"\$file\"";
    };
  };
}
