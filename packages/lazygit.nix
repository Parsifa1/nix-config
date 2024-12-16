{...}: {
  programs.lazygit = {
    enable = true;
    settings = {
      notARepository = "skip";
      gui.nerdFontsVersion = "3";
      git.paging = {
        colorArg = "always";
        pager = "delta --dark --paging=never";
      };
    };
  };
}
