{pkgs, ...}: {
  home.sessionVariables = {
    FZF_DEFAULT_COMMAND = "fd -H -I --exclude={.git,.idea,.vscode,.sass-cache,node_modules,build,.vscode-server,.virtualenvs} --type f";
    FZF_DEFAULT_OPTS = "--height 40% --layout=reverse --color=bg+:,bg:,gutter:-1,spinner:#f5e0dc,hl:#f38ba8 --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8";
    EDITOR = "nvim";
    DISPLAY = ":0";
    DIRENV_LOG_FORMAT = ""; # close direnv log
    FLAKE = "/home/parsifa1/nixos/";
    WAYLAND_DISPLAY = "wayland-0";
    PATH = "$HOME/.cargo/bin:$PATH";
  };

  programs.fish = {
    enable = true;
    functions = {
      set_panetitle = ''
        set -gx panetitle "❄️ Nix"
        echo -n (printf "\033]1337;SetUserVar=panetitle=%s\007" (echo -n $panetitle | base64))
      '';
    };
    shellInitLast = "set_panetitle ";
    shellAliases = {
      v = "nvim";
      vi = "nvim";
      fa = "fastfetch";
      cls = "clear";
      py = "python";
      ls = "exa --icons -F";
      vf = "set -l file (fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'); and test -n \"\$file\"; and vi \"\$file\"";
      zf = "z \$(fd --type d --hidden . 2>/dev/null | fzf)";
    };
    interactiveShellInit = builtins.readFile ./config.fish;
  };
}
