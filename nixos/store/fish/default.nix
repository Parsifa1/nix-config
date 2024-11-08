{ pkgs, ... }:
{
  home.sessionVariables = {
    EDITOR = "nvim";
    TERM = "wezterm";
    DISPLAY = ":0";
    DIRENV_LOG_FORMAT = ""; # close direnv log
    WAYLAND_DISPLAY = "wayland-0";
    XDG_SESSION_TYPE = "wayland";
    FLAKE = "/home/parsifa1/nixos/";
    PNPM_HOME = "/home/parsifa1/.local/share/pnpm";
    PATH = "$PATH:$HOME/.cargo/bin:/usr/lib/wsl/lib:/bin";
    LD_LIBRARY_PATH = "$LD_LIBRARY_PATH:/run/opengl-driver/lib";
    MESA_D3D12_DEFAULT_ADAPTER_NAME = "Nvidia";
    FZF_DEFAULT_COMMAND = "fd -H -I -E '{.astro,.git,.kube,.idea,.vscode,.sass-cache,node_modules,build,.vscode-server,.virtualenvs,target}' --type f --strip-cwd-prefix";
    FZF_DEFAULT_OPTS = "--height 40% --layout=reverse --color=bg+:,bg:,gutter:-1,spinner:#f5e0dc,hl:#f38ba8 --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8";
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
    };
    interactiveShellInit = builtins.readFile ./config.fish;
  };
  home.packages = with pkgs; [ just ];
}
