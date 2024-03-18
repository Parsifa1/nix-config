{...}: {
  programs.fish = {
    enable = true;
    functions = {
      set_panetitle = ''
        set -gx panetitle "❄️ nix"
        echo -n (printf "\033]1337;setuservar=panetitle=%s\007" (echo -n $panetitle | base64))
      '';
    };
    interactiveShellInit = builtins.readFile ./config.fish;
    shellAliases = {
      v = "nvim";
      vi = "nvim";
      fa = "fastfetch";
      cls = "clear";
      py = "python";
      ls = "exa --icons -f";
      vf = "set -l file (fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'); and test -n \"\$file\"; and vi \"\$file\"";
      zf = "z \$(fd --type d --hidden . 2>/dev/null | fzf)";
    };
  };
}
