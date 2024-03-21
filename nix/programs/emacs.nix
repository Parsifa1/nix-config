{pkgs, ...}: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs29-pgtk;
    extraPackages = epkgs: [
      pkgs.librime
      pkgs.noto-fonts-color-emoji
      pkgs.tdlib
      pkgs.pkg-config-unwrapped
    ];
  };
}
