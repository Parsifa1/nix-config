{pkgs, ...}: {
  home.packages = with pkgs; [clang-tools_18];
}
