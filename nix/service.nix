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
    nix-daemon.environment = {
      https_proxy = "socks5h://localhost:7890";
      http_proxy = "socks5h://localhost:7890";
    };
    systemd-resolved.enable = false;
    systemd-udevd.enable = false;
    firewall.enable = false;
  };
}
