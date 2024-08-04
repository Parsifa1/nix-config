{pkgs, ...}: {
  services = {
    pcscd.enable = true;
    xserver.enable = true;
    ollama = {
      enable = true;
      package = pkgs.ollama;
      acceleration = "cuda";
      environmentVariables = {
        OLLAMA_LLM_LIBRARY = "cuda";
        LD_LIBRARY_PATH = "run/opengl-driver/lib";
      };
    };
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
    network-mirrored = {
      enable = true;
      description = "network-mirrored";
      wants = ["network-pre.target"];
      wantedBy = ["multi-user.target"];
      before = ["network-pre.target" "shutdown.target"];
      serviceConfig = {
        User = "root";
        ExecStart = [
          ''
            /bin/sh -ec '\
            [ -x /usr/bin/wslinfo ] && [ "$(/usr/bin/wslinfo --networking-mode)" = "mirrored" ] || exit 0;\
            echo "\
            add chain   ip nat WSLPREROUTING { type nat hook prerouting priority dstnat - 1; policy accept; };\
            insert rule ip nat WSLPREROUTING iif loopback0  ip daddr 127.0.0.1 counter dnat to 127.0.0.1 comment mirrored;\
            "|${pkgs.nftables}/bin/nft -f -\
            '
          ''
        ];

        ExecStop = [
          ''
            /bin/sh -ec '\
              [ -x /usr/bin/wslinfo ] && [ "$(/usr/bin/wslinfo --networking-mode)" = "mirrored" ] || exit 0;\
              for chain in "ip nat WSLPREROUTING";\
              do\
                handle=$(${pkgs.nftables}/bin/nft -a list chain $chain | sed -En "s/^.*comment \\"mirrored\\" # handle ([0-9]+)$/\\1/p");\
                for n in $handle; do echo "delete rule $chain handle $n"; done;\
              done|${pkgs.nftables}/bin/nft -f -\
            '
          ''
        ];
        RemainAfterExit = "yes";
      };
    };
  };
}
