{ config, ... }:
let
  home = config.homePath;
in
{
  sops.secrets = {
    github-token = { };
    beszel-key = { };
    beszel-token = { };
    beszel-url = { };
  };
  sops.templates."beszel.env" = {
    mode = "0444";
    content = ''
      PORT=45876
      KEY="${config.sops.placeholder.beszel-key}"
      TOKEN="${config.sops.placeholder.beszel-token}"
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
