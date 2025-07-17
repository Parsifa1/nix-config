{ lib, ... }:
let
  PATH = builtins.concatStringsSep ":" [
    "/etc/profiles/per-user/$USER/bin" # NIX_PATH
    "/run/current-system/sw/bin"
    "/nix/var/nix/profiles/default/bin"
    "/opt/homebrew/opt/llvm@20/bin" # LLVM_PATH
    "$HOME/.local/share/pnpm/" # PNPM_HOME
    "$HOME/.cargo/bin" # CARGO_HOME
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
    PNPM_HOME = "$HOME/.local/share/pnpm";
    FZF_DEFAULT_COMMAND = "fd -H -I -E '{.astro,.git,.kube,.idea,.vscode,.sass-cache,node_modules,build,.vscode-server,.virtualenvs,target}' --type f --strip-cwd-prefix";
    FZF_DEFAULT_OPTS = "--height 40% --layout=reverse --color=bg+:,bg:,gutter:-1,spinner:#f5e0dc,hl:#f38ba8 --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8";
  };
  programs.fish = {
    enable = true;
    loginShellInit = lib.readFile ./.config.fish;
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
