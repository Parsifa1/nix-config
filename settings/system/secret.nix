{ config, ... }:
let
  home = config.homePath;
in
{
  sops.secrets.github-token = { };
  sops.templates.nixconf-gh = {
    owner = config.username;
    content = ''
      access-tokens = ${config.sops.placeholder.github-token}
    '';
  };
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    age.sshKeyPaths = [ "${home}/.ssh/id_ed25519" ];
  };
}
