{pkgs, ...}: {
  home.sessionVariables = {
    FZF_DEFAULT_COMMAND = "fd -H -I --exclude={.git,.idea,.vscode,.sass-cache,node_modules,build,.vscode-server,.virtualenvs} --type f";
    FZF_DEFAULT_OPTS = "--height 40% --layout=reverse --color=bg+:,bg:,gutter:-1,spinner:#f5e0dc,hl:#f38ba8 --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8";
    PATH = "$PATH:$HOME/.cargo/bin:/usr/lib/wsl/lib/";
    LD_LIBRARY_PATH = "$LD_LIBRARY_PATH:/run/opengl-driver/lib";
    PNPM_HOME = "/home/parsifa1/.local/share/pnpm";
    FLAKE = "/home/parsifa1/nixos/";
    WAYLAND_DISPLAY = "wayland-0";
    EDITOR = "nvim";
    DISPLAY = ":0";
    DIRENV_LOG_FORMAT = ""; # close direnv log
    TERM = "wezterm";
  };
  programs.fish = {
    enable = true;
    shellInitLast = ''
      rm /run/user/1000/wayland-0.lock && rm /run/user/1000/wayland-0
      ln -s /mnt/wslg/runtime-dir/wayland-0* /run/user/1000/
    '';
    shellAliases = {
      v = "nvim";
      vi = "nvim";
      lg = "lazygit";
      fa = "fastfetch";
      cls = "clear";
      py = "python";
      ls = "eza --icons --group-directories-first --sort=extension -F";
      vf = "set -l file (fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'); and test -n \"\$file\"; and vi \"\$file\"";
      zf = "z \$(fd --type d --hidden . 2>/dev/null | fzf)";
      # nvidia-smi = "/usr/lib/wsl/lib/nvidia-smi";
    };
    interactiveShellInit = builtins.readFile ./config.fish;
  };
  home.packages = with pkgs; [just];
}
