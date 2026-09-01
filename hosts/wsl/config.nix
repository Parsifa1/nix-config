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
    zig
    wget
    curl
    delta
    gnupg
    gcc15
    cmake
    dconf
    unzip
    gnumake
    openssh
    websocat
    nix-init
    e2fsprogs
    clang-tools
    pinentry-gnome3
    nix-output-monitor
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
      extraGroups = [ "wheel" ];
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
        (
          let
            fhs = buildFHSEnv {
              name = "nix-ld-lib";
              multiPkgs = appimageTools.defaultFhsEnvArgs.multiPkgs;
              runScript = "true";
            };
          in
          runCommand "nix-ld-lib" { } "mkdir $out; ln -s ${fhs.passthru.fhsenv}/usr/lib64 $out/lib"
        )
        icu
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

  networking.hosts = {
    "127.0.1.1" = [
      "nixos"
      "cloudtide"
    ];
    "192.168.193.31" = [ "apfel" ];
  };

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
    };
  };

  security.sudo.wheelNeedsPassword = false;
  system.stateVersion = "23.11";

  imports = [
    ./wsl.nix
    ./service.nix
  ];
}
