{ config, pkgs, ... }:
let
  PATH = config.genPath [
    "/home/parsifa1/.local/state/nix/profile/bin"
    "/nix/var/nix/profiles/default/bin"
    "/home/parsifa1/.local/bin"
    "/home/parsifa1/.local/share/pnpm"
    "/usr/local/bin"
    "/usr/bin"
    "/bin"
    "/snap/bin"
  ];
in
{
  home.sessionVariables = {
    inherit PATH;
    EDITOR = "nvim";
    GPG_TTY = "$(tty)";
    NH_FLAKE = "$HOME/Desktop/nix";
    PNPM_HOME = "$HOME/.local/share/pnpm";
    DOCKER_CONFIG = "$HOME/.config/docker";
    WAKATIME_HOME = "$HOME/.local/share/wakatime";
    FZF_DEFAULT_COMMAND = "fd -H -I -E '{.astro,.git,.kube,.idea,.vscode,.sass-cache,node_modules,build,.vscode-server,.virtualenvs,target}' --type f --strip-cwd-prefix";
    FZF_DEFAULT_OPTS = "--height 40% --layout=reverse --color=bg+:,bg:,gutter:-1,spinner:#f5e0dc,hl:#f38ba8 --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8";
  };
  programs.fish = {
    enable = true;
    loginShellInit = ''
      clear
      set -U fish_greeting
    '';
    shellInitLast = ''
      if not string match -q -- $PNPM_HOME $PATH
         set -ga PATH "$PNPM_HOME"
      end
    '';
    binds."ctrl-s".command = "edit_command_buffer";
    shellAliases = {
      y = "yy";
      v = "nvim";
      vi = "nvim";
      lg = "lazygit";
      lzd = "lazydocker";
      fa = "fastfetch";
      cls = "clear";
      py = "python";
      ls = "eza --icons --group-directories-first --sort=extension -F";
      vf = "set -l file (fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'); and test -n \"\$file\"; and vi \"\$file\"";
      zf = "z \$(fd --type d --hidden . 2>/dev/null | fzf)";
    };
  };
  home.packages = with pkgs; [ just ];
}
