{...}: {
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
  systemd.services = {
    "serial-getty@ttyS0".enable = false;
    "serial-getty@hvc0".enable = false;
    "getty@tty1".enable = false;
    "autovt@".enable = false;
    systemd-resolved.enable = false;
    systemd-udevd.enable = false;
    firewall.enable = false;
    nix-daemon.environment = {
      https_proxy = "http://localhost:7890";
      http_proxy = "http://localhost:7890";
    };
    keep-alive = {
      enable = true;
      description = "keep wsl alive";
      wantedBy = ["multi-user.target"];
      serviceConfig = {
        ExecStartPre = "/mnt/c/Windows/System32/waitfor.exe /si MakeDistroAlive";
        ExecStart = "/mnt/c/Windows/System32/waitfor.exe MakeDistroAlive";
      };
    };
  };
}
