{ pkgs, inputs, ... }:
{
  #临时使用软件包
  environment.systemPackages = with pkgs; [
    zig
    nixd
    gcc14
    gnupg
    rustup
    agenix
  ];

  fonts.packages = with pkgs; [
    ibm-plex
    noto-fonts
    lxgw-wenkai
    cloudtide.fonts
    noto-fonts-cjk-serif
    noto-fonts-cjk-sans
    source-han-serif
  ];

  environment = {
    variables.FONTCONFIG_FILE = "${pkgs.makeFontsConf {
      fontDirectories = [ "/Library/Fonts" ];
    }}";
    etc."nix/inputs/nixpkgs".source = "${inputs.nixpkgs}";
  };

  security.pam.services.sudo_local.touchIdAuth = true;
  programs.gnupg.agent.enable = true;
  programs.fish.enable = true;
  system = {
    startup.chime = false;
    defaults.dock.autohide = true;
    stateVersion = 5;
  };
}
