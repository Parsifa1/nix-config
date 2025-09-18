{ config, ... }:
let
  home = config.homePath;
in
{
  sops.secrets.github-token = { };
  sops.templates = {
    nixconf-gh = {
      owner = config.username;
      content = ''
        access-tokens = ${config.sops.placeholder.github-token}
      '';
    };
  };
  sops.age.sshKeyFile = "${home}/.ssh/id_ed25519";
  sops.gnupg.sshKeyPaths = [ ];
  sops.defaultSopsFile = ../../secrets/secrets.yaml;
}
