{ config, pkgs, ... }:
{
  launchd.daemons.beszel-agent = {
    script = ''
      set -a
      source "${config.sops.templates."beszel.env".path}"
      set +a
      exec ${pkgs.beszel}/bin/beszel-agent
    '';
    serviceConfig = {
      KeepAlive = true;
      RunAtLoad = true;
      StandardOutPath = "/var/log/beszel-agent.log";
      StandardErrorPath = "/var/log/beszel-agent.log";
    };
  };
}
