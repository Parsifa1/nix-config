{ pkgs, ... }:
{
  programs.zellij = {
    enable = true;
    package = pkgs.zellij;

    # Raw KDL — avoids nix→KDL conversion bugs with complex keybinds
    extraConfig = builtins.readFile ./config.kdl;
    themes.custom = builtins.readFile ./theme.kdl;
    layouts.compact = builtins.readFile ./compact.kdl;
  };
  # Auto-rename zellij tab to cwd basename
  programs.fish.interactiveShellInit = ''
    function _zellij_tab_rename --on-variable PWD
        if set -q ZELLIJ
            set -l tab_name (string replace $HOME "~" $PWD)
            set tab_name (basename $tab_name)
            command zellij action rename-tab $tab_name 2>/dev/null &
        end
    end
    if set -q ZELLIJ
        _zellij_tab_rename
    end
  '';
}
