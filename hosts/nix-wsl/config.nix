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
    gcc15
    zig
    clang-tools_19
    cmake
    gnumake
    openssh
    websocat
    unzip
    nix-init
    nix-output-monitor
    dconf
  ];

  nixosConfig = {
    fonts.enable = true;
    secret.enable = true;
    nixconf.enable = true;
    userinfo.enable = true;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${username} = {
      imports = [
        ./home.nix
        inputs.self.homeModules.default
      ];
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
        nss
        nspr
        (pkgs.runCommand "steamrun-lib" { } ''
          mkdir $out;
          ln -s ${pkgs.steam-run.fhsenv}/usr/lib64 $out/lib
        '')
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

  security.sudo.wheelNeedsPassword = false;
  environment.variables.DOCKER_CONFIG = "$HOME/.config/docker";
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
