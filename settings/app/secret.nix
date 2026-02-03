{ config, ... }:
let
  home = config.homePath;
in
{
  sops.secrets = {
    gemini-key = { };
    github-token = { };
    sshconfig.sopsFile = ../../secrets/sshconfig.yaml;
    wakatime = {
      path = "${home}/.local/share/wakatime/.wakatime.cfg";
      sopsFile = ../../secrets/wakatime.yaml;
    };
  };
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    age.sshKeyPaths = [ "${home}/.ssh/id_ed25519" ];
  };
}
