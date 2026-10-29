{ config, ... }:
{
  services = {
    beszel.agent = {
      enable = true;
      openFirewall = true;
      environmentFile = config.sops.templates."beszel.env".path;
    };
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
    keep-alive = {
      enable = true;
      description = "keep wsl alive";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "/mnt/c/Windows/System32/waitfor.exe keepAlive";
      };
    };

  };
}
