{ config, ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    # default ssh config
    matchBlocks."*" = {
      forwardAgent = false;
      addKeysToAgent = "no";
      compression = false;
      serverAliveInterval = 0;
      serverAliveCountMax = 3;
      hashKnownHosts = false;
      userKnownHostsFile = "~/.ssh/known_hosts";
      controlMaster = "no";
      controlPath = "~/.ssh/master-%r@%n:%p";
      controlPersist = "no";
    };
    includes = [
      "includes/${config.age.secrets.sshconfig.name}"
    ];
  };
}
