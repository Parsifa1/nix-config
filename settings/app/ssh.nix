{ config, ... }:
{
  programs.ssh = {
    enable = true;
    includes = [
      "includes/${config.age.secrets.ssh-config.name}"
    ];
  };
}
