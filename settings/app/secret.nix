{ config, ... }:
{
  age = config.genSecrets {
    gemini = ".gemini.key";
    github = ".github.key";
    wakatime = rec {
      name = ".wakatime.cfg";
      path = "$HOME/${name}";
    };
    sshconfig = rec {
      name = "ssh-config-agenix";
      path = "$HOME/.ssh/includes/${name}";
    };
  };
}
