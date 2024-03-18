{ pkgs, ... }:
let
  unstable-packages = with pkgs.unstable; [
    fastfetch
    ripgrep
    eza
    bat
    fzf
    fd
    which
    tree
    nix-output-monitor
    btop
    starship
    yazi
    unzip
    zoxide
    lazygit
    dust
    duf
    atuin
    git-credential-manager
  ];

  stable-packages = with pkgs; [
    # language servers
    nodePackages.typescript-language-server
    yaml-language-server
    lua-language-server
    clang-tools
    nil
    ruff
    ruff-lsp
    marksman
    nodePackages.prettier
    rust-analyzer
    nodePackages."@astrojs/language-server"
    python311Packages.autopep8
    pkgs.nodePackages.vscode-langservers-extracted
    vscode-extensions.ms-pyright.pyright
    tailwindcss-language-server
    taplo
    # language formmater
    nixfmt
    stylua
  ];
in
{
  home.username = "parsifa1";
  home.homeDirectory = "/home/parsifa1";
  home.packages = stable-packages ++ unstable-packages;

  programs.atuin = {
    enable = true;
  };

  programs.starship = {
    enable = true;
    settings = {
      aws.disabled = true;
      gcloud.disabled = true;
      hostname.disabled = true;
    };
  };

  programs.git = {
    enable = true;
    userName = "parsifa1";
    userEmail = "li.aldric@gmail.com";
    package = pkgs.gitFull;
    extraConfig = {
      user.signingkey = "99B21766F86301CA";
      http.proxy = "localhost:7891";
      credential.helper = "store";
      core.editor = "nvim";
      credential.credentialStore = "cache";
      commit.gpgsign = true;
    };
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -U fish_greeting

      clear
      dbus-launch true

      export DISPLAY=":0"
      export WAYLAND_DISPLAY=wayland-0    #fix wayland

      if test -d "/mnt/c/Windows/System32/"
        export PATH="$PATH:/mnt/c/Windows/System32/"
      end
       
      # set fzf config
      export FZF_DEFAULT_COMMAND="fd -H -I --exclude={.git,.idea,.vscode,.sass-cache,node_modules,build,.vscode-server,.virtualenvs} --type f"
      export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --color=bg+:,bg:,gutter:-1,spinner:#f5e0dc,hl:#f38ba8 --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

      #set yazi wrapper
      function ya
          set tmp (mktemp -t "yazi-cwd.XXXXX")
          yazi $argv --cwd-file="$tmp"
          if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
              cd -- "$cwd"
          end
          rm -f -- "$tmp"
      end

      function set_panetitle
        set -gx panetitle "❄️ Nix"
        echo -n (printf "\033]1337;SetUserVar=panetitle=%s\007" (echo -n $panetitle | base64))
      end
      set_panetitle
    '';
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
  };

  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}
