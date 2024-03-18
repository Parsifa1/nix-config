{...}: {
  programs.fish = {
    enable = true;
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
