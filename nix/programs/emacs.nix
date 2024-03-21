{pkgs, ...}: {
  emacs = {
    enable = true;
    package = pkgs.emacs-git.override {withGTK3 = true;};

    extraPackages = epkgs: [
      pkgs.librime
      pkgs.noto-fonts-color-emoji
      pkgs.tdlib
      pkgs.pkg-config-unwrapped
    ];
  };
}
