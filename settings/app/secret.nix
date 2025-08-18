{ ... }:
{
  age.secrets = {
    wakatime = rec {
      name = ".wakatime.cfg";
      path = "$HOME/${name}";
      file = ../../secrets/wakatime.age;
      mode = "444";
    };
    ssh-config = rec {
      name = "ssh-config-agenix";
      path = "$HOME/.ssh/includes/${name}";
      file = ../../secrets/sshconfig.age;
      mode = "444";
    };
    gemini = rec {
      name = ".gemini.key";
      path = "$HOME/.config/secret/${name}";
      file = ../../secrets/gemini.age;
    };
    github-token = rec {
      name = ".github.key";
      path = "$HOME/.config/secret/${name}";
      file = ../../secrets/github.age;
    };
  };
}
