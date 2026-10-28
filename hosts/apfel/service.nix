{ pkgs, ... }:
{
  # AWDL races the radio away from en0 on this 2.4GHz link; macOS re-enables
  # it via AirDrop/BonBonjour, so a watchdog keeps forcing it down.
  launchd.daemons.awdl-watchdog = {
    command = pkgs.writeShellScript "awdl-watchdog" ''
      while true; do
        if ifconfig awdl0 2>/dev/null | grep -q "<UP"; then
          ifconfig awdl0 down
        fi
        sleep 1
      done
    '';
    serviceConfig = {
      KeepAlive = true;
      RunAtLoad = true;
    };
  };
}
