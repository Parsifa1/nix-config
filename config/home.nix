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
    gnupg
    nix-output-monitor
    btop
    starship
    yazi
    unzip
    zoxide
    lazygit
    dust
    duf
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

    # language formmater
    nixfmt
  ];
in
{
  home.username = "parsifa1";
  home.homeDirectory = "/home/parsifa1";
  home.packages = stable-packages ++ unstable-packages;

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
    extraConfig = {
      http.proxy = "localhost:7891";
    };
  };
  
  programs.zoxide.enable = true;

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -U fish_greeting

      #set starship
      starship init fish | source

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