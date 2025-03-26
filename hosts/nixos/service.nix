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
    network-mirrored = {
      enable = true;
      description = "network-mirrored";
      wants = [ "network-pre.target" ];
      wantedBy = [ "multi-user.target" ];
      before = [
        "network-pre.target"
        "shutdown.target"
      ];
      serviceConfig = {
        User = "root";
        ExecStart = [
          ''
            /bin/sh -ec '\
            [ -x bin/wslinfo ] && [ "$(bin/wslinfo --networking-mode)" = "mirrored" ] || exit 0;\
            POSTROUTING=$(${pkgs.nftables}/bin/nft list chain ip nat WSLPOSTROUTING | sed -En "s/^.*(oif .* sport 1-65535 .* counter).*(masquerade to :[0-9-]+).*$/add rule ip6 nat WSLPOSTROUTING \\1 \\2 comment mirrored;/p");\
              echo "\
              add chain   ip nat WSLPREROUTING { type nat hook prerouting priority dstnat - 1; policy accept; };\
              insert rule ip nat WSLPREROUTING iif loopback0  ip daddr 127.0.0.1 counter dnat to 127.0.0.1 comment mirrored;\
              add table ip6 filter;\
              add chain ip6 filter WSLOUTPUT {type filter hook output priority filter; policy accept;};\
              add rule  ip6 filter WSLOUTPUT counter meta mark set 0x00000001 comment mirrored;\
              add table ip6 nat;\
              add chain ip6 nat WSLPOSTROUTING {type nat hook postrouting priority srcnat - 1; policy accept;};\
              $POSTROUTING"|${pkgs.nftables}/bin/nft -f -\
              '
          ''
        ];

        ExecStop = [
          ''
            /bin/sh -ec '\
            [ -x /usr/bin/wslinfo ] && [ "$(/usr/bin/wslinfo --networking-mode)" = "mirrored" ] || exit 0;\
            for chain in "ip nat WSLPREROUTING" "ip6 filter WSLOUTPUT" "ip6 nat WSLPOSTROUTING";\
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
