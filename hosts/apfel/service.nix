{ config, pkgs, ... }:
{
  launchd.daemons = {
    beszel-agent = {
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
    ac-nosleep = {
      script = ''
        lid_sleep() {
          c=$(ioreg -r -n IOPMrootDomain -d1 | tr -d '"')
          [ "''${c#*AppleClamshellState = Yes}" != "$c" ] &&
          [ "''${c#*AppleClamshellCausesSleep = Yes}" != "$c" ]
        }
        echo "$(date '+%F %T') ac-nosleep started pid=$$"
        while :; do
          case $(pmset -g ps) in *"AC Power"*) want=1 ;; *) want=0 ;; esac
          cur=$(pmset -g | awk '/SleepDisabled/{print $2}')
          if [ "$want" != "$cur" ] && pmset -a disablesleep "$want"; then
            echo "$(date '+%F %T') disablesleep=$want (was $cur)"
            if [ "$want" = 0 ] && sleep 2 && lid_sleep; then
              echo "$(date '+%F %T') lid closed on battery, sleeping now"
              pmset sleepnow
            fi
          fi
          sleep 3
        done
      '';
      serviceConfig = {
        KeepAlive = true;
        RunAtLoad = true;
        ProcessType = "Background";
        StandardOutPath = "/var/log/ac-nosleep.log";
        StandardErrorPath = "/var/log/ac-nosleep.log";
      };
    };
  };
}
