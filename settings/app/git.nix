{
  cfg,
  config,
  pkgs,
  ...
}:
{
  programs.git = {
    enable = true;
    package = pkgs.git;
    signing.format = "openpgp";
    settings = {
      user = {
        name = "Parsifa1";
        email = "li.aldric@gmail.com";
        signingkey = "99B21766F86301CA";
      };
      core.editor = "nvim";
      credential.helper = cfg.credentialHelper or "store --file $HOME/.config/git/credentials";
      # close gpgsign on server
      commit.gpgsign = cfg.gpgSign or true;
    };
    ignores = [ ".DS_Store" ];
  };
  programs.fish.shellInit = ''
    export GITHUB_ACCESS_TOKEN="$(cat ${config.sops.secrets.github-token.path})"
    export GITHUB_TOKEN="$(cat ${config.sops.secrets.github-token.path})"
  '';
}
