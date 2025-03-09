{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    delta
    wget
    curl
    gnupg
    pinentry-gnome3
    gcc14
    zig
    clang-tools_18
    cmake
    gnumake
    openssh
    websocat
    unzip
    rustup
    nixd
    nix-init
    nix-output-monitor
    devenv
    dconf
    agenix
  ];

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      icu
      gmp
      glibc
      openssl
      stdenv.cc.cc
    ];
  };

  programs.gnupg.agent = {
    enable = true;
    settings = {
      max-cache-ttl = 604800000;
      default-cache-ttl = 604800000;
      allow-preset-passphrase = "";
      no-allow-external-cache = "";
    };
  };

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      ibm-plex
      noto-fonts
      lxgw-wenkai
      cloudtide.fonts
      noto-fonts-cjk-serif
      noto-fonts-cjk-sans
      source-han-serif
    ];
    fontconfig = {
      defaultFonts = {
        serif = [ "Noto Sans" ];
        sansSerif = [ "Noto Serif" ];
        monospace = [ "Iosevka Cloudtide" ];
      };
    };
  };

  environment.etc."nix/inputs/nixpkgs".source = "${inputs.nixpkgs}";
  age.identityPaths = [ "$HOME/.ssh/id_rsa" ];
  security.sudo.wheelNeedsPassword = false;
  virtualisation.docker.enable = true;
  system.stateVersion = "23.11";
  programs.fish.enable = true;
}
