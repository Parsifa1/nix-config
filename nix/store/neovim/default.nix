{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    package = pkgs.neovim;
    # extraLuaPackages = ps: [ps.magick];
  };

  home.packages = with pkgs; [luajitPackages.luarocks sqlite.out];
  home.sessionVariables = {LIBSQLITE = "${pkgs.sqlite.out}/lib/libsqlite3.so";};
}
