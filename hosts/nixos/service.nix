{ pkgs, ... }:
{
  services = {
    xserver = {
      enable = true;
      displayManager.lightdm.enable = false;
    };
    openssh = {
      enable = true;
      ports = [ 11451 ];
      settings = {
        ClientAliveInterval = 60;
        ClientAliveCountMax = 3;
      };
      extraConfig = "AcceptEnv TERM_PROGRAM_VERSION WEZTERM_REMOTE_PANE TERM COLORTERM TERM_PROGRAM WSLENV";
    };
  };

  systemd.tmpfiles.rules = [
    "L+ /run/user/1000/wayland-0 0700 - - - /mnt/wslg/runtime-dir/wayland-0"
  ];

  systemd.services = {
    nix-daemon.environment = {
      https_proxy = "http://localhost:7890";
      http_proxy = "http://localhost:7890";
    };
    keep-alive = {
      enable = true;
      description = "keep wsl alive";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "/mnt/c/Windows/System32/waitfor.exe MakeDistroAlive";
      };
    };
    wslg-fix = {
      enable = true;
      description = "fix wslg";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = [
          "${pkgs.coreutils}/bin/chmod 0777 /mnt/wslg/runtime-dir"
          "${pkgs.coreutils}/bin/chmod 0666 /mnt/wslg/runtime-dir/wayland-0.lock"
        ];
      };
    };
  };
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    # fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      fcitx5-rime
      fcitx5-gtk
      fcitx5-lua
      rime-data
    ];
  };
}
