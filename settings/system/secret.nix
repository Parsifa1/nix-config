{ config, ... }:
let
  home = config.homePath;
  secret = "beszel-${host}";
  host = config.networking.hostName;
in
{
  sops.secrets = {
    github-token = { };
    beszel-key = { };
    beszel-url = { };
    ${secret} = { };
  };
  sops.templates."beszel.env" = {
    mode = "0444";
    content = ''
      PORT=45876
      TOKEN="${config.sops.placeholder.${secret}}"
      KEY="${config.sops.placeholder.beszel-key}"
      HUB_URL="${config.sops.placeholder.beszel-url}"
    '';
  };
  sops.templates.nixconf-gh = {
    owner = config.username;
    content = ''
      access-tokens = github.com=${config.sops.placeholder.github-token}
    '';
  };
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    age.sshKeyPaths = [ "${home}/.ssh/id_ed25519" ];
  };
}
