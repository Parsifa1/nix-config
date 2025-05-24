{
  pkgs,
  config,
  inputs,
  ...
}:
let
  username = config.username;
in
{
  environment.systemPackages = with pkgs; [
    gh
    delta
    wget
    curl
    gnupg
    pinentry-gnome3
    gcc14
    zig
    clang-tools_19
    cmake
    gnumake
    openssh
    websocat
    unzip
    nix-init
    nix-output-monitor
    devenv
    dconf
    agenix
  ];

  nixosConfig = {
    userinfo.enable = true;
    nixconf.enable = true;
    fonts.enable = true;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${username} = {
      imports = [ inputs.self.homeModules.nixos ];
    };
  };

  users = {
    mutableUsers = false;
    users.${username} = {
      shell = pkgs.fish;
      isNormalUser = true;
      hashedPassword = "$y$j9T$fdy82j7goIaaecK3SEUKE0$JqPx5WkZ0OMRbXVB/d2dQIA/c7dSV3BXUAV7vlBcVOA";
      extraGroups = [
        "networkmanager"
        "docker"
        "wheel"
      ];
    };
  };

  fonts = {
    enableDefaultPackages = true;
    fontconfig = {
      defaultFonts = {
        serif = [ "Noto Sans" ];
        sansSerif = [ "Noto Serif" ];
        monospace = [ "Iosevka Cloudtide" ];
      };
    };
  };

  programs = {
    fish.enable = true;
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        icu
        gmp
        glibc
        openssl
        stdenv.cc.cc
      ];
    };
    gnupg.agent = {
      enable = true;
      settings = {
        max-cache-ttl = 604800000;
        default-cache-ttl = 604800000;
        allow-preset-passphrase = "";
        no-allow-external-cache = "";
      };
    };
  };

  age.identityPaths = [ "$HOME/.ssh/id_rsa" ];
  security.sudo.wheelNeedsPassword = false;
  virtualisation = {
    docker.enable = true;
    podman.enable = true;
  };
  system.stateVersion = "23.11";

  imports = [
    ./wsl.nix
    ./service.nix
  ];
}
