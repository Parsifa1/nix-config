{ pkgs, ... }:
{
  home.sessionVariables = {
    DISPLAY = ":0";
    EDITOR = "nvim";
    # GALLIUM_DRIVER = "d3d12";
    XDG_SESSION_TYPE = "wayland";
    WAYLAND_DISPLAY = "wayland-0";
    NH_FLAKE = "/home/parsifa1/nix/";
    # MESA_D3D12_DEFAULT_ADAPTER_NAME = "Nvidia";
    PNPM_HOME = "/home/parsifa1/.local/share/pnpm";
    PATH = "$PATH:$HOME/.cargo/bin:/usr/lib/wsl/lib:/bin";
    LD_LIBRARY_PATH = "$LD_LIBRARY_PATH:/run/opengl-driver/lib";
    FZF_DEFAULT_COMMAND = "fd -H -I -E '{.astro,.git,.kube,.idea,.vscode,.sass-cache,node_modules,build,.vscode-server,.virtualenvs,target}' --type f --strip-cwd-prefix";
    FZF_DEFAULT_OPTS = "--height 40% --layout=reverse --color=bg+:,bg:,gutter:-1,spinner:#f5e0dc,hl:#f38ba8 --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8";
  };
  programs.fish = {
    enable = true;
    loginShellInit = ''
      clear
      set -U fish_greeting
      # 输入法
      fcitx5 --disable=wayland --verbose=\*=0 -d
    '';
    shellInitLast = ''
      if not string match -q -- $PNPM_HOME $PATH
        set -gx PATH "$PNPM_HOME" $PATH
      end
      # if test -d "/mnt/c/Windows/system32/WindowsPowerShell/v1.0"
      #     set -gx PATH $PATH /mnt/c/Windows/system32/WindowsPowerShell/v1.0
      # end
      # if test -d "/mnt/c/Windows/System32/"
      #     set -gx PATH $PATH /mnt/c/Windows/System32/
      # end
      # if test -d "/mnt/e/Program Files/Scoop/shims"
      #     set -gx PATH $PATH /mnt/e/Program\ Files/Scoop/shims
      # end
    '';
    shellAliases = {
      y = "yy";
      v = "nvim";
      vi = "nvim";
      lg = "lazygit";
      fa = "fastfetch";
      cls = "clear";
      py = "python";
      wsl = "/mnt/c/Windows/System32/wsl.exe";
      zf = "z \$(fd --type d --hidden . 2>/dev/null | fzf)";
      ls = "eza --icons --group-directories-first --sort=extension -F";
      pwsh = "/mnt/c/Users/Parsifal/AppData/Local/Microsoft/WindowsApps/pwsh.exe";
      vf = "set -l file (fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'); and test -n \"\$file\"; and vi \"\$file\"";
    };
  };
  home.packages = with pkgs; [ just ];
}
