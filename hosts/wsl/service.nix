{ config, ... }:
{
  services = {
    beszel.agent = {
      enable = true;
      openFirewall = true;
      environmentFile = config.sops.templates."beszel.env".path;
    };
    cloudflared = {
      enable = true;
      tunnels."58198be8-b31e-4405-9908-81f85fb972a4" = {
        credentialsFile = "/home/parsifa1/.config/cloudflared/58198be8-b31e-4405-9908-81f85fb972a4.json";
        ingress."hr.cloudti.de".service = "http://localhost:7317";
        default = "http_status:404";
      };
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
