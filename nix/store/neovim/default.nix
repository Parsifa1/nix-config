{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    package = pkgs.neovim;
    extraLuaPackages = ps: [ps.magick];
  };
  home.packages = with pkgs; [luajit imagemagick luajitPackages.luarocks];
}
