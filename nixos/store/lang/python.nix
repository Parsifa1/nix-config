{pkgs, ...}: {
  home.packages = with pkgs; [python311 uv];
}
