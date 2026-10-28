{ pkgs, ... }:
{
  # launchd.daemons = {
  #   qsign = {
  #     command = "${pkgs.cloudtide.qsign}/bin/unidbg-fetch-qsign --basePath=${pkgs.cloudtide.qsign}/txlib/9.0.25";
  #     path = [
  #       "${pkgs.openjdk}/bin"
  #       "/usr/bin"
  #     ];
  #     serviceConfig = {
  #       EnvironmentVariables.JAVA_HOME = "${pkgs.openjdk}";
  #       KeepAlive = true;
  #       RunAtLoad = true;
  #     };
  #   };
  # };
}
