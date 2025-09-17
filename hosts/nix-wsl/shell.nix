{ config, pkgs, ... }:
let
  PATH = config.genPath [
    "/run/wrappers/bin"
    "/etc/profiles/per-user/parsifa1/bin"
    "/run/current-system/sw/bin"
    "bin"
  ];
in
{
  home.sessionVariables = {
    inherit PATH;
    DISPLAY = ":0";
    EDITOR = "nvim";
    GIT_ASKPASS = "";
    # GALLIUM_DRIVER = "d3d12";
    XDG_SESSION_TYPE = "wayland";
    WAYLAND_DISPLAY = "wayland-0";
    NH_FLAKE = "$HOME/.config/nix";
    # MESA_D3D12_DEFAULT_ADAPTER_NAME = "Nvidia";
    WAKATIME_HOME = "$HOME/.local/share/wakatime";
    LD_LIBRARY_PATH = "$LD_LIBRARY_PATH:/run/opengl-driver/lib";
    FZF_DEFAULT_COMMAND = "fd -H -I -E '{.astro,.git,.kube,.idea,.vscode,.sass-cache,node_modules,build,.vscode-server,.virtualenvs,target}' --type f --strip-cwd-prefix";
    FZF_DEFAULT_OPTS = "--height 40% --layout=reverse --color=bg+:,bg:,gutter:-1,spinner:#f5e0dc,hl:#f38ba8 --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8";

  };
  home.sessionPath = [
    "$CARGO_HOME/bin"
    "$HOME/.local/bin"
  ];
  programs.fish = {
    enable = true;
    loginShellInit = ''
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
