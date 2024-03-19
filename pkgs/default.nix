{pkgs}: {
  win32yank = pkgs.callPackage ./packages/win32yank.nix {};
  tinymist = pkgs.callPackage ./packages/tinymist {};
  # delance = pkgs.callPackage ./packages/delance.nix  {};
}
