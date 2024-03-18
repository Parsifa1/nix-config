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
    # language formmater
    nixfmt
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

      export DISPLAY=":0"
      export WAYLAND_DISPLAY=wayland-0    #fix wayland

      #set starship
      starship init fish | source

      if test -d "/mnt/c/Windows/System32/"
        export PATH="$PATH:/mnt/c/Windows/System32/"
      end

      function set_panetitle
        set -gx panetitle "❄️ Nix"
        echo -n (printf "\033]1337;SetUserVar=panetitle=%s\007" (echo -n $panetitle | base64))
      end
      set_panetitle

      clear
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
