{ ... }:
{
  age.secrets = {
    wakatime = {
      path = "$HOME";
      name = ".wakatime.cfg";
      file = ../secrets/wakatime.age;
      mode = "444";
    };
    ssh-config = {
      name = "ssh-config-agenix";
      path = "$HOME/.ssh/includes";
      file = ../secrets/sshconfig.age;
      mode = "444";
    };
  };
}
