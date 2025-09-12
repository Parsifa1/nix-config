{ config, ... }:
{
  age = config.genSecrets {
    gemini = ".gemini.key";
    sshconfig = "ssh-config-agenix";
    wakatime = rec {
      name = ".wakatime.cfg";
      path = "$HOME/.local/share/wakatime/${name}";
    };
  };
}
