{pkgs, ...}: {
  programs.fish.enable = true;
  users.mutableUsers = false;
  security.sudo.wheelNeedsPassword = false;

  users.users.parsifa1 = {
    isNormalUser = true;
    hashedPassword = "$y$j9T$fdy82j7goIaaecK3SEUKE0$JqPx5WkZ0OMRbXVB/d2dQIA/c7dSV3BXUAV7vlBcVOA";
    shell = pkgs.fish;
    extraGroups = ["networkmanager" "wheel" "docker"];
    openssh.authorizedKeys.keys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCoYJIrhUQGPbm2xzV9Rd6H6vfGeGC2Okr4yHdIxyLJgZTvbY6F9/HUKuIOo/EpZkNs+YXrxw6WVbMFMRhdgYLHbaWxlWmd5VqA+2msLw/Xj1KtObCJp3bwYqvIv6O6tzCc7KuQf+kY3MZLKCxMRV6Mv6AzdeD4rsc78V9XKN4VOT+meHXGfP8/Di42FRNratyQQKiKZh+Pcz8wW+kYq4n+8PkYLkIzpboAfvp2Kmbv8ElkspCKEpmlIXsDX+3Ara3zsY+5j7rfuh0U2c+/g9m33EwhtQ6YTGB6UDjQRoa4bu/e3V6LJb77QuSZK4E6oGAiTgASP12Ns5oQkTTtwF36JYOrAYpGoiCsoAo1zDPHS1gDIJVq+AoUZ2WF1qW0s/rGOMEw3EoBvz5UQ1LmqaJ3uo4lnEkGyVYpeu4aMizDtL1DvRMJNhgyB2v37OoNiiva3sxCINBAlc0n4CebFUvYWd5xhS6EHfcKbQ/wL9udUKTMuZoR3DBIm5depm3F+ks= parsifal@LAPTOP-ALDRIC"];
  };

  nix.settings = {
    trusted-users = ["parsifa1"];
    substituters = [
      "https://mirror.sjtu.edu.cn/nix-channels/store"
      # "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];
  };

  environment.systemPackages = with pkgs; [
    fish
    git
    neovim
    wget
    curl
    gnupg
    pinentry-gnome3
    gcc
    rustup
    cmake
    gnumake
    nodejs
    openssh
    rocmPackages.llvm.clang
    python311
    gnome.gnome-calculator
    nodePackages_latest.pnpm
    websocat
    nix-init
    dconf
  ];

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      cloudtide.fonts
      lxgw-wenkai
      ibm-plex
    ];
    fontconfig = {
      defaultFonts = {
        serif = ["LXGW WenKai"];
        sansSerif = ["LXGW WenKai"];
        monospace = ["IosevkaCloudtide"];
      };
    };
  };

  services = {
    pcscd.enable = true;
    xserver.enable = true;
    openssh = {
      enable = true;
      ports = [14514];
      settings = {
        ClientAliveInterval = 60;
        ClientAliveCountMax = 3;
      };
      extraConfig = "AcceptEnv TERM_PROGRAM_VERSION WEZTERM_REMOTE_PANE TERM COLORTERM TERM_PROGRAM WSLENV";
    };
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

  virtualisation.docker.enable = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
}
